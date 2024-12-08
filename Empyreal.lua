local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/xsx.lua"))()

local ClientHWID = tostring(game:GetService("RbxAnalyticsService"):GetClientId())

local HWIDS = loadstring(game:HttpGet("https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/EmpyrealHWIDS.lua"))()

local ACTUALHWIDS = HWIDS.KEYHWID()

if not shared.key then
	local Notif = library:InitNotifications()
	local LoadingXSX = Notif:Notify("shared.key is nil.", 3, "error")
	return warn("[EMPYREAL]: shared.key is nil")
end

if ACTUALHWIDS[ClientHWID] == nil then
	local Notif = library:InitNotifications()
	local LoadingXSX = Notif:Notify("invalid hwid client.", 3, "error")
	return warn("[EMPYREAL]: invalid hwid client")
end

if ACTUALHWIDS[ClientHWID] ~= nil and ACTUALHWIDS[ClientHWID] ~= shared.key then
	local Notif = library:InitNotifications()
	local LoadingXSX = Notif:Notify("valid hwid but wrong key.", 3, "error")
	return warn("[EMPYREAL]: valid hwid but wrong key")
end

local SilentAim = loadstring(game:HttpGet("https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/GamesUniteSilentAim.lua"))()

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

--// VARIABLES \\--

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

_G.EnabledCustomViewmodel = false
_G.EnabledCustomGunViewmodel = false
_G.ViewmodelColor = workspace.Camera.Viewmodels.c_arms.LeftHand.Color
_G.ViewmodelGunColor = Color3.fromRGB(0, 255, 255)
_G.ViewmodelRainbow = false
_G.LastViewmodelColor = _G.ViewmodelColor
_G.LastViewmodelGunColor = _G.ViewmodelGunColor
_G.ViewmodelMaterial = "Plastic"

local SPEED = 0.1
local i = 0

--// SILENT AIM SHIT \\--

_G.SilentAimEnabled = false
_G.WallCheck = false
_G.HeadChance = 100
_G.HitChance = 100
_G.HitPart = "Torso"
_G.UseFOV = false
_G.CircleRadius = 200
_G.CircleFilled = false
_G.CircleColor = Color3.fromRGB(255, 255, 255)
_G.CircleVisible = false
_G.CircleTransparency = 0.5
_G.CircleSides = 64
_G.CircleThickness = 1
_G.CircleRainbow = false
_G.LastCircleColor = _G.CircleColor

--// FUNCTIONS \\--

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

		if _G.CircleRainbow then
			_G.CircleColor = Color3.fromHSV(i,1,1)
		else
			_G.CircleColor = _G.LastCircleColor
		end

		if _G.ViewmodelRainbow then
			_G.ViewmodelColor = Color3.fromHSV(i,1,1)
		else
			_G.ViewmodelColor = _G.LastViewmodelColor
		end

		if _G.EnabledCustomViewmodel then
			workspace.Camera.Viewmodels.c_arms.LeftHand.Color = _G.ViewmodelColor
			workspace.Camera.Viewmodels.c_arms.RightHand.Color = _G.ViewmodelColor

			workspace.Camera.Viewmodels.c_arms.LeftHand.Material = Enum.Material[_G.ViewmodelMaterial]
			workspace.Camera.Viewmodels.c_arms.RightHand.Material = Enum.Material[_G.ViewmodelMaterial]

			if _G.EnabledCustomGunViewmodel then
				for _, v in pairs(workspace.Camera.Viewmodels:GetDescendants()) do
					if v:IsA("BasePart") and v.Parent.Name ~= "c_arms" then
						if v:FindFirstChildOfClass("SurfaceAppearance") then
							v:FindFirstChildOfClass("SurfaceAppearance"):Destroy()
						end

						v.Material = Enum.Material.ForceField
						v.Color = _G.ViewmodelGunColor
					end
				end
			else
				for _, v in pairs(workspace.Camera.Viewmodels:GetDescendants()) do
					if v:IsA("BasePart") and v.Parent.Name ~= "c_arms" then
						v.Material = Enum.Material.Plastic
					end
				end
			end
		else
			workspace.Camera.Viewmodels.c_arms.LeftHand.Color = workspace.Camera.Viewmodels.c_arms.RootPart.Color
			workspace.Camera.Viewmodels.c_arms.RightHand.Color = workspace.Camera.Viewmodels.c_arms.RootPart.Color

			workspace.Camera.Viewmodels.c_arms.LeftHand.Material = Enum.Material.Plastic
			workspace.Camera.Viewmodels.c_arms.RightHand.Material = Enum.Material.Plastic

			for _, v in pairs(workspace.Camera.Viewmodels:GetDescendants()) do
				if v:IsA("BasePart") and v.Parent.Name ~= "c_arms" then
					v.Material = Enum.Material.Plastic
				end
			end
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

--// INIT TABS \\--
local CombatTab = Init:NewTab("Combat")
local VisualsTab = Init:NewTab("Visuals")
local LocalPlayerTab = Init:NewTab("LocalPlayer")
local SettingsTab = Init:NewTab("Settings")

--// SETTINGS \\--

local ChangeKeybind = SettingsTab:NewKeybind("Open/Close", Enum.KeyCode.Insert, function(key)
	Init:UpdateKeybind(Enum.KeyCode[key])
end)

--// DEVELOPER \\--

if library.rank == "developer" then
	_G.SelectedHWID = ""
	
	local DeveloperTab = Init:NewTab("Developer")

	local KeyGenerator = DeveloperTab:NewButton("Generate Key", function()
		Notif:Notify("Generating key, please be patient.", 3, "information")

		task.wait(3.5)

		setclipboard(HWIDS.generateKey())
		Notif:Notify("Key generated, the key has been pasted in your clipboard.", 3, "success") -- notification, alert, error, success, information
	end)
	
	DeveloperTab:NewSeperator()
	
	local HWIDChecker = DeveloperTab:NewTextbox("HWID CHECKER", "", "PUT HWID IN", "all", "medium", true, false, function(val)
		_G.SelectedHWID = val
	end)
	
	local KeyCheck = DeveloperTab:NewButton("CHECK", function()
		Notif:Notify("tracking key, please be patient.", 3, "information")

		task.wait(3.5)
		
		if ACTUALHWIDS[_G.SelectedHWID] == nil then
			Notif:Notify("key not found, invalid hwid.", 3, "error")
			return
		end
		
		setclipboard(ACTUALHWIDS[_G.SelectedHWID])
		Notif:Notify("Key found ["..ACTUALHWIDS[_G.SelectedHWID].."], the key has been pasted in your clipboard.", 3, "success") -- notification, alert, error, success, information
	end)
	
	local SillyText = DeveloperTab:NewLabel("Hello, "..string.upper(library:GetUsername()).."!", "center")
end

--// LOCALPLAYER \\--

local ViewmodelSection = LocalPlayerTab:NewSection("Viewmodel")

local EnablecustomViewmodel = LocalPlayerTab:NewToggle("Custom Viewmodel", false, function(value)
	local vers = value and "on" or "off"

	if vers == "on" then
		_G.EnabledCustomViewmodel = true
	else
		_G.EnabledCustomViewmodel = false
	end
end)

local WarningText = LocalPlayerTab:NewLabel("WARNING: THE BUTTON BELOW IS IRREVERTABLE", "left")

local EnablecustomGunViewmodel = LocalPlayerTab:NewButton("Custom GunViewmodel", function()
	_G.EnabledCustomGunViewmodel = true
end)

local EnableViewmodelRainbow = LocalPlayerTab:NewToggle("Rainbow", false, function(value)
	local vers = value and "on" or "off"

	if vers == "on" then
		_G.ViewmodelRainbow = true
	else
		_G.ViewmodelRainbow = false
	end
end)

local ViewmodelGunColorSelector = LocalPlayerTab:NewTextbox("Gun Color", "", "0,255,255", "all", "small", true, false, function(val)
	local Numbers = string.split(val, ",")

	_G.ViewmodelGunColor = Color3.fromRGB(Numbers[1], Numbers[2], Numbers[3])
	_G.LastViewmodelGunColor = Color3.fromRGB(Numbers[1], Numbers[2], Numbers[3])
end)

local ViewmodelColorSelector = LocalPlayerTab:NewTextbox("Color", "", "0,255,255", "all", "small", true, false, function(val)
	local Numbers = string.split(val, ",")

	_G.ViewmodelColor = Color3.fromRGB(Numbers[1], Numbers[2], Numbers[3])
	_G.LastViewmodelColor = Color3.fromRGB(Numbers[1], Numbers[2], Numbers[3])
end)

local MaterialSelectorViewmodel = LocalPlayerTab:NewSelector("Material", "Plastic", {"Plastic", "ForceField", "Neon", "Wood", "Metal", "Marble"}, function(d)
	_G.ViewmodelMaterial = d
end)

LocalPlayerTab:NewSeperator()

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

local RainbowEnabledT = LocalPlayerTab:NewToggle("Rainbow", false, function(value)
	local vers = value and "on" or "off"

	if vers == "on" then
		_G.ThirdPersonRainbow = true
	else
		_G.ThirdPersonRainbow = false
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

--// COMBAT TAB \\--

local FovSettingFunctions = CombatTab:NewSection("FOV Settings")

local EnableVisibleFOV = CombatTab:NewToggle("Visible", false, function(value)
	local vers = value and "on" or "off"

	if vers == "on" then
		_G.CircleVisible = true
	else
		_G.CircleVisible = false
	end
end)

local FovSettingColor = CombatTab:NewTextbox("Color", "", "255,255,255", "all", "small", true, false, function(val)
	local Numbers = string.split(val, ",")

	_G.CircleColor = Color3.fromRGB(Numbers[1], Numbers[2], Numbers[3])
	_G.LastCircleColor = Color3.fromRGB(Numbers[1], Numbers[2], Numbers[3])
end)

local EnableRainbowFOV = CombatTab:NewToggle("Rainbow", false, function(value)
	local vers = value and "on" or "off"

	if vers == "on" then
		_G.CircleRainbow = true
	else
		_G.CircleRainbow = false
	end
end)

local EnableFilledFOV = CombatTab:NewToggle("Filled", false, function(value)
	local vers = value and "on" or "off"

	if vers == "on" then
		_G.CircleFilled = true
	else
		_G.CircleFilled = false
	end
end)

local FOVRadius = CombatTab:NewSlider("Radius", "", true, "/", {min = 1, max = 1000, default = 200}, function(value)
	_G.CircleRadius = value
end)

local FOVThickness = CombatTab:NewSlider("Thickness", "", true, "/", {min = 1, max = 3, default = 1}, function(value)
	_G.CircleThickness = value
end)

local FOVTransparency = CombatTab:NewSlider("Transparency", "", true, "/", {min = 1, max = 0, default = 0}, function(value)
	_G.CircleThickness = value
end)

CombatTab:NewSeperator()

local SilentAimSection = CombatTab:NewSection("SilentAim")

local EnableSilentAim = CombatTab:NewToggle("Enable", false, function(value)
	local vers = value and "on" or "off"

	if vers == "on" then
		_G.SilentAimEnabled = true
	else
		_G.SilentAimEnabled = false
	end
end)

local EnableWallCheck = CombatTab:NewToggle("Wall Check", false, function(value)
	local vers = value and "on" or "off"

	if vers == "on" then
		_G.WallCheck = true
	else
		_G.WallCheck = false
	end
end)

local EnableFOVSilent = CombatTab:NewToggle("Use FOV", false, function(value)
	local vers = value and "on" or "off"

	if vers == "on" then
		_G.UseFOV = true
	else
		_G.UseFOV = false
	end
end)

local SilentAimHitChance = CombatTab:NewSlider("Hit Chance", "", true, "/", {min = 1, max = 100, default = 20}, function(value)
	_G.HitChance = value
end)

local SilentAimHeadChance = CombatTab:NewSlider("Head Chance", "", true, "/", {min = 1, max = 100, default = 20}, function(value)
	_G.HeadChance = value
end)

local SilentAimHitPart = CombatTab:NewSelector("Hit Part", "Head", {"Head", "LeftFoot", "LeftHand", "RightFoot", "RightHand", "UpperTorso"}, function(d)
	_G.HitPart = d
end)


--// END \\--

local FinishedLoading = Notif:Notify("Loaded empyreal", 4, "success")
