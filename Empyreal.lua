local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/xsx.lua"))()

local ClientHWID = tostring(game:GetService("RbxAnalyticsService"):GetClientId())

local HWIDS = loadstring(game:HttpGet("https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/EmpyrealHWIDS.lua"))()

local ACTUALHWIDS = HWIDS.KEYHWID()

if not shared.key then
	return warn("[EMPYREAL]: shared.key is nil")
end

if ACTUALHWIDS[ClientHWID] == nil then
	return warn("[EMPYREAL]: invalid hwid client")
end

if ACTUALHWIDS[ClientHWID] ~= nil and ACTUALHWIDS[ClientHWID] ~= shared.key then
	return warn("[EMPYREAL]: valid hwid but wrong key")
end

local RunService = game:GetService("RunService")
local Camera = game.Workspace.CurrentCamera

if table.find(HWIDS.getDevelopers(), library:GetUsername()) then
	library.rank = "developer"
else
	library.rank = "buyer"
end

local Wm = library:Watermark("empyreal | v0.1-A | " .. library:GetUsername() .. " | rank: " .. library.rank)
local FpsWm = Wm:AddWatermark("fps: " .. library.fps)
coroutine.wrap(function()
	while wait(.75) do
		FpsWm:Text("fps: " .. library.fps)
	end
end)()


local Notif = library:InitNotifications()

for i = 5,0,-1 do 
	task.wait(0.05)
	local LoadingXSX = Notif:Notify("Loading empyreal, please be patient.", 3, "information") -- notification, alert, error, success, information
end 

library.title = "Empyreal"

_G.CameraOffset = Vector3.new(0, 0, 0)

_G.EnabledThirdPerson = false
_G.EnabledForceField = false

_G.ThirdPersonMaterial = "Plastic"

local Character = game.Workspace.Playermodels[tostring(game.Players.LocalPlayer.UserId)]

for _, v in pairs(game.Workspace.Playermodels[tostring(game.Players.LocalPlayer.UserId)]:GetChildren()) do
	if v:IsA("BasePart") then
		v:SetAttribute("OriginalColor", v.Color)
	end
end

_G.ThirdPersonColor = Character.UpperTorso.Color
_G.ThirdPersonRainbow = false

_G.LastRainbowColor = _G.ThirdPersonColor

local SPEED = 0.1
local i = 0

local function ToggleThirdPerson()
	RunService.RenderStepped:Connect(function(delta)
		
		i = (i + delta*SPEED) % 1
		
		for _, v in pairs(game.Workspace.Playermodels[tostring(game.Players.LocalPlayer.UserId)]:GetChildren()) do
			if v:IsA("BasePart") then
				if _G.EnabledThirdPerson then
					v.LocalTransparencyModifier = 0

					if _G.EnabledForceField then
						v.Color = _G.ThirdPersonColor
						v.Material = Enum.Material[_G.ThirdPersonMaterial]
					else
						v.Color = v:GetAttribute("OriginalColor")
						v.Material = Enum.Material.Plastic
					end   
				else
					v.LocalTransparencyModifier = 1
				end   
			end
		end
		
		if _G.ThirdPersonRainbow then
			_G.ThirdPersonColor = Color3.fromHSV(i,1,1)
		else
			_G.ThirdPersonColor = _G.LastRainbowColor
		end

		for _, v in pairs(game.Workspace.Playermodels[tostring(game.Players.LocalPlayer.UserId)]:GetChildren()) do
			if v:IsA("BasePart") then

			end
		end

		local cameraCFrame = Camera.CFrame
		Camera.CFrame = cameraCFrame * CFrame.new(_G.CameraOffset)
	end)
end

ToggleThirdPerson()

library:Introduction()
wait(1)
local Init = library:Init()

local LocalPlayerTab = Init:NewTab("LocalPlayer")

local ThirdPersonSection = LocalPlayerTab:NewSection("ThirdPerson")

local EnableThirdPerson = LocalPlayerTab:NewToggle("Enable", false, function(value)
	local vers = value and "on" or "off"

	if vers == "on" then
		_G.CameraOffset = Vector3.new(0, 1, 4)

		for _, viewmodels in pairs(game.Workspace.CurrentCamera:GetDescendants()) do
			if viewmodels:IsA("BasePart") then
				viewmodels:SetAttribute("OriginalTransparency", viewmodels.Transparency)
				viewmodels.Transparency = 1
			end
		end

		_G.EnabledThirdPerson = true
	else
		_G.CameraOffset = Vector3.new(0, 0, 0)
		_G.EnabledThirdPerson = false

		for _, viewmodels in pairs(game.Workspace.CurrentCamera:GetDescendants()) do
			if viewmodels:IsA("BasePart") then
				viewmodels.Transparency = viewmodels:GetAttribute("OriginalTransparency")
			end
		end
	end
end)

local EnableForcefield = LocalPlayerTab:NewToggle("Custom Playermodel", false, function(value)
	local vers = value and "on" or "off"

	if vers == "on" then
		_G.EnabledForceField = true
	else
		_G.EnabledForceField = false
	end
end)

local TColorSelector = LocalPlayerTab:NewTextbox("Color", "", "0,255,0", "all", "small", true, false, function(val)
	local Numbers = string.split(val, ",")
	
	_G.ThirdPersonColor = Color3.fromRGB(Numbers[1], Numbers[2], Numbers[3])
	_G.LastRainbowColor = Color3.fromRGB(Numbers[1], Numbers[2], Numbers[3])
end)

local MaterialSelector = LocalPlayerTab:NewSelector("Material", "Plastic", {"Plastic", "ForceField", "Neon", "Wood", "Metal", "Marble"}, function(d)
	_G.ThirdPersonMaterial = d
end)

local FinishedLoading = Notif:Notify("Loaded empyreal", 4, "success")
