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

local ViewportModelM = require(RepStorage.NewModules.Client.Services.ViewportModel)

warn("[SKIN ADDER]: LOADING...")

function SkinAdder:AddToViewportFrame(data,vpf,itemType,modelStuffOnly)
	local DisplayWepModelsDir = game:GetService("ReplicatedStorage"):WaitForChild("Storage"):WaitForChild("DisplayWepModels")
	local model = RepStorage.Storage.DisplayWepModels:FindFirstChild(data.ItemName)
	local isExotic = data.Rarity == "exotic"

	model = RepStorage.Storage.SkinVariants[data.SkinClass]:FindFirstChild("chainsaw_ripper")

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

		vpfModel = ViewportModelM.new(vpf, camera)
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
