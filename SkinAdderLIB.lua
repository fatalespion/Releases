local SkinAdder = {
	Credits = "This was made by fatal_espion or .__fatal ez",

	RarityColors = {
		["common"] = Color3.fromRGB(165, 255, 186);
		["uncommon"] = Color3.fromRGB(53, 194, 255);
		["rare"] = Color3.fromRGB(217, 2, 255);
		["legendary"] = Color3.fromRGB(255, 25, 0);
		["exotic"] = Color3.fromRGB(255, 135, 0);
		["limited"] = Color3.fromRGB(255, 234, 3);
	}
}

local LoadChecks = {
	["FUNCTIONS"] = false,
}

local Player = game.Players.LocalPlayer
local RepStorage = game:GetService("ReplicatedStorage")

local uiSoundsF = RepStorage:WaitForChild("Storage"):WaitForChild("UISounds")

local NewModules = RepStorage:FindFirstChild("NewModules")
local SkinsModule = NewModules:FindFirstChild("Client").Services.Interface.Modules.Skins

local CoreGui = Player.PlayerGui:WaitForChild("CoreGUI", 999)

warn("[SKIN ADDER]: LOADING...")

local BLOCK = {0, 1, 2, 3, 4, 5, 6, 7}
local WEDGE = {0, 1, 3, 4, 5, 7}
local CORNER_WEDGE = {0, 1, 4, 5, 6}

-- Class

SkinAdder.__index = SkinAdder
SkinAdder.ClassName = "ViewportModel"

local function getIndices(part)
	if part:IsA("WedgePart") then
		return WEDGE
	elseif part:IsA("CornerWedgePart") then
		return CORNER_WEDGE
	end
	return BLOCK
end

local function getCorners(cf, size2, indices)
	local corners = {}
	for _, i in pairs(indices) do
		corners[i + 1] = cf * (size2 * Vector3.new(
			2 * (math.floor(i / 4) % 2) - 1,
			2 * (math.floor(i / 2) % 2) - 1,
			2 * (i % 2) - 1
			))
	end
	return corners
end

local function getModelPointCloud(model)
	local points = {}
	for _, part in pairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			local indices = getIndices(part)
			local corners = getCorners(part.CFrame, part.Size / 2, indices)
			for _, wp in pairs(corners) do
				table.insert(points, wp)
			end
		end
	end
	return points
end

local function viewProjectionEdgeHits(cloud, axis, depth, tanFov2)
	local max, min = -math.huge, math.huge

	for _, lp in pairs(cloud) do
		local distance = depth - lp.Z
		local halfSpan = tanFov2 * distance

		local a = lp[axis] + halfSpan
		local b = lp[axis] - halfSpan

		max = math.max(max, a, b)
		min = math.min(min, a, b)
	end

	return max, min
end

function SkinAdder.new(vpf, camera)
	local self = setmetatable({}, SkinAdder)

	self.Model = nil
	self.ViewportFrame = vpf
	self.Camera = camera

	self._points = {}
	self._modelCFrame = CFrame.new()
	self._modelSize = Vector3.new()
	self._modelRadius = 0

	self._viewport = {}

	self:Calibrate()

	return self
end

function SkinAdder:SetModel(model)
	self.Model = model

	local cf, size = model:GetBoundingBox()

	self._points = getModelPointCloud(model)
	self._modelCFrame = cf
	self._modelSize = size	
	self._modelRadius = size.Magnitude / 2
end

function SkinAdder:Calibrate()
	local viewport = {}
	local size = self.ViewportFrame.AbsoluteSize

	viewport.aspect = size.X / size.Y

	viewport.yFov2 = math.rad(self.Camera.FieldOfView / 2)
	viewport.tanyFov2 = math.tan(viewport.yFov2)

	viewport.xFov2 = math.atan(viewport.tanyFov2 * viewport.aspect)
	viewport.tanxFov2 = math.tan(viewport.xFov2)

	viewport.cFov2 = math.atan(viewport.tanyFov2 * math.min(1, viewport.aspect))
	viewport.sincFov2 = math.sin(viewport.cFov2)

	self._viewport = viewport
end

function SkinAdder:GetFitDistance(focusPosition)
	local displacement = focusPosition and  (focusPosition - self._modelCFrame.Position).Magnitude or 0
	local radius = self._modelRadius + displacement

	return radius / self._viewport.sincFov2
end

function SkinAdder:GetMinimumFitCFrame(orientation)
	if not self.Model then
		return CFrame.new()
	end

	local rotation = orientation - orientation.Position
	local rInverse = rotation:Inverse()

	local wcloud = self._points
	local cloud = {rInverse * wcloud[1]}
	local furthest = cloud[1].Z

	for i = 2, #wcloud do
		local lp = rInverse * wcloud[i]
		furthest = math.min(furthest, lp.Z)
		cloud[i] = lp
	end

	local hMax, hMin = viewProjectionEdgeHits(cloud, "X", furthest, self._viewport.tanxFov2)
	local vMax, vMin = viewProjectionEdgeHits(cloud, "Y", furthest, self._viewport.tanyFov2)

	local distance = math.max(
		((hMax - hMin) / 2) / self._viewport.tanxFov2,
		((vMax - vMin) / 2) / self._viewport.tanyFov2
	)

	return orientation * CFrame.new(
		(hMax + hMin) / 2,
		(vMax + vMin) / 2,
		furthest + distance
	)
end

function SkinAdder:AddToViewportFrame(data,vpf,itemType,modelStuffOnly)
	local DisplayWepModelsDir = game:GetService("ReplicatedStorage"):WaitForChild("Storage"):WaitForChild("DisplayWepModels")
	local model = RepStorage.Storage.DisplayWepModels:FindFirstChild(data.ItemName)
	local isExotic = data.Rarity == "exotic"

	if data.CustomModel then
		model = RepStorage.Storage.SkinVariants[data.SkinClass]:FindFirstChild(data.CustomModel)
	end

	if data.MeleeVariant then
		model = RepStorage.Storage.DisplayWepModels:FindFirstChild(data.MeleeVariant)
	end

	if model then
		model = model:Clone()

		local camera = Instance.new("Camera")
		camera.Parent = vpf

		if data.TextureID then

			if model and itemType ~= "case" and data.Killtrack then
				local KTM = require(game:GetService("ReplicatedStorage").NewModules.Shared.Extensions.AddKillTrackModel)(model,Player,nil,true)
				task.wait()
				local Handle = model:FindFirstChild("WeaponHandle") or model:FindFirstChild("Handle")
				KTM:PivotTo(Handle.KilltrackPlacementAttachment.WorldCFrame)
			end

			if data.SkinClass == "Melees" then
				for i,v in pairs(model:GetDescendants()) do
					if v:IsA("MeshPart") and not v:FindFirstChild("IgnoreTX") then
						v.TextureID = "rbxassetid://" .. tostring(data.TextureID)
					end
				end
			else
				for i,v in pairs(model:GetDescendants()) do
					if v:IsA("MeshPart") and v:GetAttribute("SATP") then
						v.TextureID = "rbxassetid://" .. tostring(data.TextureID)
					end

					if data._FixedMagThing then
						if v.Name == "MagPart" then
							v.Transparency = 1
						elseif v.Name == "FixedMagPart" then
							v.Transparency = 0
						end
					end
				end
			end
		end

		model.Parent = vpf
		vpf.CurrentCamera = camera

		if modelStuffOnly then
			return model,camera
		end

		local customLightDirection = model:GetAttribute("CustomLightDirection")
		if customLightDirection then 
			vpf.LightDirection = customLightDirection
		end

		local vpfModel,cf,size

		vpfModel = SkinAdder.new(vpf, camera)
		cf, size = model:GetBoundingBox()
		vpfModel:SetModel(model)

		local fov = 32
		local fovOffset = model:GetAttribute("FOVOffset")
		if fovOffset then
			fov += fovOffset
			print(fov)
		end
		camera.FieldOfView = fov

		--if data.SkinClass == "Melees" then
		--	fov += 11
		--end

		local distance = vpfModel:GetFitDistance(cf.Position)

		local fovOffset2 = model:GetAttribute("FOVOffset_SKIN")
		if fovOffset2 then
			fov += fovOffset2
			print(fov.." 2")
		end
		camera.FieldOfView = fov

		local orientation = (not model:GetAttribute("NoDefaultOrientation") and CFrame.Angles(0,math.rad(-90),0)) or CFrame.Angles(0,0,0)

		local offsetCFrame
		offsetCFrame = model:GetAttribute("OffsetCFrame")
		if offsetCFrame then
			orientation *= offsetCFrame
		end
		local offsetCFrame2 = model:GetAttribute("OffsetCFrame_SKIN")
		if offsetCFrame2 then
			local oo = orientation
			orientation *= offsetCFrame2
			print("yes")
		end

		camera.CFrame = CFrame.new(cf.Position) * orientation * CFrame.new(0, 0, distance)
		--camera.CFrame = CFrame.new(cf.Position) * orientation * CFrame.new(0, 0, distance)

		return model,camera
	end
end

function SkinAdder:GenerateName()
	local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
	local key = ""
	for i = 1, 20 do
		local randomIndex = math.random(1, #chars)
		key = key .. chars:sub(randomIndex, randomIndex)
	end
	return key
end

function SkinAdder:CreateSkin(weaponName, skinName, rarity, tradeLocked, killTrack, kills, souvenir, serial, data)
	if not serial then
		serial = "N/A"
	else
		serial = "#"..serial
	end

	local Template = SkinsModule.Assets.SkinTemplate:Clone()
	Template.Name = "SK-FAKESKIN-"..SkinAdder:GenerateName()
	Template.ItemType.Text = weaponName
	Template.SkinName.Text = skinName
	Template.Serial.Visible = true
	Template.Serial.Text = tostring(serial)
	Template.RarityBand.BackgroundColor3 = SkinAdder.RarityColors[rarity]

	local vpf = Template.ViewportFrame

	vpf.LightColor = Color3.fromRGB(350,350,350)

	if tradeLocked then
		Template.TradeLockedIcon.Visible = true
	end

	if killTrack then
		Template.KilltrackIcon.Visible = true
		Template.Kills.Text = "KOs: "..tostring(kills)
	end

	if souvenir then
		Template.SouvenirIcon.Visible = true
	end

	local T1 = nil
	local T2 = nil

	Template.KilltrackIcon.MouseEnter:Connect(function()
		pcall(function()
			T1:Cancel()
		end)
		pcall(function()
			T2:Cancel()
		end)

		T1 = game:GetService("TweenService"):Create(Template.KilltrackIcon, TweenInfo.new(0.25), {
			ImageTransparency = 1
		})
		T2 = game:GetService("TweenService"):Create(Template.Kills, TweenInfo.new(0.25), {
			TextTransparency = 0 ; TextStrokeTransparency = 0.5
		})

		T1:Play()
		T2:Play()
	end)

	Template.KilltrackIcon.MouseLeave:Connect(function()
		pcall(function()
			T1:Cancel()
		end)
		pcall(function()
			T2:Cancel()
		end)

		T1 = game:GetService("TweenService"):Create(Template.KilltrackIcon, TweenInfo.new(0.25), {
			ImageTransparency = 0
		})
		T2 = game:GetService("TweenService"):Create(Template.Kills, TweenInfo.new(0.25), {
			TextTransparency = 1 ; TextStrokeTransparency = 1
		})

		T1:Play()
		T2:Play()
	end)

	Template.Hover.MouseLeave:Connect(function()
		if Template.BlackOverlay.Visible == true then return end
		Template.BackgroundColor3 = Color3.fromRGB(154, 154, 154);
		Template.ButtonsFrame.SellButton.Visible = false
	end)

	Template.ButtonsFrame.SellButton.Visible = false

	Template.ButtonsFrame.SellButton.MouseEnter:Connect(function()
		uiSoundsF.hover:Play()
	end)

	Template:SetAttribute("Activated", true)

	Template.Hover.MouseButton1Click:Connect(function()
		uiSoundsF.click:Play()

		if Template:GetAttribute("Activated") == true then
			Template:SetAttribute("Activated", false)
			Template.UIStroke.Enabled = true
			Template.UIStroke.Color = Color3.new(1,1,1)
			Template.UIStroke.Thickness = 2
		elseif Template:GetAttribute("Activated") == false then
			Template:SetAttribute("Activated", true)

			Template.UIStroke.Enabled = false
		end
	end)

	Template.Hover.MouseEnter:Connect(function()
		if Template.BlackOverlay.Visible == true then return end
		uiSoundsF.hover:Play()
		Template.BackgroundColor3 = Color3.fromRGB(180, 180, 180);

		Template.ButtonsFrame.SellButton.Visible = true
	end)

	Template.Parent = CoreGui.SkinsFrame.MainFrame.SkinsFrame.ListFrame.Frame.GunsFrame

	local typ = "skin"

	data.ItemName = weaponName
	data.Killtrack = killTrack
	data.Rarity = rarity

	SkinAdder:AddToViewportFrame(data,vpf,typ)

	return Template
end

LoadChecks.FUNCTIONS = true

repeat task.wait()
	warn("[SKIN ADDER]: LOADED")
	warn("[SKIN ADDER]: "..SkinAdder.Credits)
until LoadChecks.FUNCTIONS

return SkinAdder
