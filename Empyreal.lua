_G.Empyreal = function(gameID, typeS, theme)
	local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/xsx.lua"))()

	if theme == nil then
		_G.UILibColor = Color3.fromRGB(255, 255, 255)
		_G.SliderUILibColor = Color3.fromRGB(229, 229, 229)
	end

	if typeS == "theme" then
		local Notif = library:InitNotifications()
		local LoadingXSX = Notif:Notify("theme successfully applied.", 3, "success")

		if theme == "white" then
			_G.UILibColor = Color3.fromRGB(255, 255, 255)
			_G.SliderUILibColor = Color3.fromRGB(229, 229, 229)
		elseif theme == "red" then
			_G.UILibColor = Color3.fromRGB(255, 66, 69)
			_G.SliderUILibColor = Color3.fromRGB(195, 50, 53)
		elseif theme == "green" then
			_G.UILibColor = Color3.fromRGB(70, 255, 122)
			_G.SliderUILibColor = Color3.fromRGB(55, 200, 94)
		elseif theme == "blue" then
			_G.UILibColor = Color3.fromRGB(108, 103, 255)
			_G.SliderUILibColor = Color3.fromRGB(86, 84, 207)
		elseif theme == "orange" then
			_G.UILibColor = Color3.fromRGB(255, 175, 47)
			_G.SliderUILibColor = Color3.fromRGB(209, 141, 39)
		elseif theme == "yellow" then
			_G.UILibColor = Color3.fromRGB(255, 240, 69)
			_G.SliderUILibColor = Color3.fromRGB(194, 182, 52)
		elseif theme == "purple" then
			_G.UILibColor = Color3.fromRGB(169, 108, 255)
			_G.SliderUILibColor = Color3.fromRGB(145, 94, 221)
		elseif theme == "pink" then
			_G.UILibColor = Color3.fromRGB(255, 65, 255)
			_G.SliderUILibColor = Color3.fromRGB(213, 54, 213)
		elseif theme == "developer" then
			_G.UILibColor = Color3.fromRGB(90, 255, 186)
			_G.SliderUILibColor = Color3.fromRGB(67, 191, 137)
		elseif theme == "black" then
			_G.UILibColor = Color3.fromRGB(0, 0, 0)
			_G.SliderUILibColor = Color3.fromRGB(22, 22, 22)
		end
	end

	local ClientHWID = tostring(game:GetService("RbxAnalyticsService"):GetClientId())

	local HWIDS = loadstring(game:HttpGet("https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/EmpyrealHWIDS.lua"))()

	local ACTUALHWIDS = HWIDS.KEYHWID()

	if not shared.key then
		local Notif = library:InitNotifications()
		local LoadingXSX = Notif:Notify("shared.key is nil.", 4, "error")
		return warn("[EMPYREAL]: shared.key is nil")
	end

	for HWID, Keys in pairs(ACTUALHWIDS) do
		if Keys == shared.key and HWID ~= ClientHWID then
			local Notif = library:InitNotifications()
			local LoadingXSX = Notif:Notify("valid key but wrong hwid, your lucky i wont hwid lock you, now say sorry.",4, "error")
			return warn("[EMPYREAL]: valid key but wrong hwid [your lucky i wont hwid lock you, now say sorry].")
		end
	end

	if ACTUALHWIDS[ClientHWID] == nil then
		local Notif = library:InitNotifications()
		local LoadingXSX = Notif:Notify("unknown {hwid/HardWareID}.", 4, "error")
		return warn("[EMPYREAL]: invalid hwid client")
	end

	if ACTUALHWIDS[ClientHWID] ~= nil and ACTUALHWIDS[ClientHWID] ~= shared.key then
		local Notif = library:InitNotifications()
		local LoadingXSX = Notif:Notify("valid hwid but wrong key.", 4, "error")
		return warn("[EMPYREAL]: valid hwid but wrong key")
	end
	
	if gameID == 992334288 then
		local SilentAim = loadstring(game:HttpGet("https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/GamesUniteSilentAim.lua"))()
		local Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/GamesUniteAimbot.lua"))()

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
		Notif:Notify("Successfully loaded [GUTP] with HWID {"..tostring(ClientHWID).."}", 2, "success") -- notification, alert, error, success, information
		Notif:Notify("IT IS RECOMMENDED TO NOT USE ANY FEATURES BEFORE CHANGING THEMES", 2, "information")
		task.wait(0.5)
		Notif:Notify("Loading empyreal, please be patient.", 3, "information") -- notification, alert, error, success, information

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

		_G.HighlightESP = false

		_G.ESPHighlighColor = Color3.fromRGB(255,255,255)
		_G.ESPHighlightRainbow = false
		_G.ESPHighlightLastColor = _G.ESPHighlighColor

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

		--// AIMBOT SHIT \\--

		_G.AimbotEnabled = false
		_G.AimPart = "Head"
		_G.AimKeybind = Enum.UserInputType.MouseButton2
		_G.AimbotWallCheck = true

		local Connection = nil

		--// FUNCTIONS \\--

		local function ToggleThirdPerson()
			Connection = RunService.RenderStepped:Connect(function(delta)

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

				if _G.ESPHighlightRainbow then
					_G.ESPHighlighColor = Color3.fromHSV(i,1,1)
				else
					_G.ESPHighlighColor = _G.ESPHighlightLastColor
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

				if _G.HighlightESP then
					for _, v in pairs(game.Workspace.Playermodels:GetChildren()) do
						if v.Name == tostring(game.Players.LocalPlayer.UserId) then
							if _G.ESPLocal then
								if v:FindFirstChild("Highlight") then
									v.Highlight.Enabled = true
									v.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
									v.Highlight.OutlineColor = _G.ESPHighlighColor
									v.Highlight.FillTransparency = 1
									v.Highlight.OutlineTransparency = 0
								end
							else
								if v:FindFirstChild("Highlight") then
									v.Highlight.Enabled = false
									v.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
									v.Highlight.FillTransparency = 1
									v.Highlight.OutlineColor = _G.ESPHighlighColor
									v.Highlight.OutlineTransparency = 0
								end
							end
						else
							if v:FindFirstChild("Highlight") then
								v.Highlight.Enabled = true
								v.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
								v.Highlight.FillTransparency = 1
								v.Highlight.OutlineColor = _G.ESPHighlighColor
								v.Highlight.OutlineTransparency = 0
							end
						end
					end
				else
					for _, v in pairs(game.Workspace.Playermodels:GetChildren()) do
						if v:FindFirstChild("Highlight") then
							v.Highlight.Enabled = false
							v.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
							v.Highlight.FillTransparency = 1
							v.Highlight.OutlineColor = _G.ESPHighlighColor
							v.Highlight.OutlineTransparency = 0
						end	
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

		local WarningText5 = SettingsTab:NewLabel("⚠️ [ MORE WILL COME BE PATIENT ] ⚠️", "center")

		Init:UpdateKeybind(Enum.KeyCode.Insert)

		local ChangeKeybind = SettingsTab:NewKeybind("Open/Close", Enum.KeyCode.Insert, function(key)
			Init:UpdateKeybind(Enum.KeyCode[key])
		end)

		SettingsTab:NewSeperator()

		local WarningText6 = SettingsTab:NewLabel("[ THE CONTENT BELOW WILL RELOAD THE ENTIRE SCRIPT ]", "center")

		local ThemesText = SettingsTab:NewLabel("THEMES", "left")

		local WhiteTheme = SettingsTab:NewButton("White { Default }", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)

			Connection = nil

			_G.Empyreal("theme", "white")
		end)

		local RedTheme = SettingsTab:NewButton("Red", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)

			Connection = nil

			_G.Empyreal("theme", "red")
		end)

		local GreenTheme = SettingsTab:NewButton("Green", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)

			Connection = nil

			_G.Empyreal("theme", "green")
		end)

		local BlueTheme = SettingsTab:NewButton("Blue", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)

			Connection = nil

			_G.Empyreal("theme", "blue")
		end)

		local OrangeTheme = SettingsTab:NewButton("Orange", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)

			Connection = nil

			_G.Empyreal("theme", "orange")
		end)

		local YellowTheme = SettingsTab:NewButton("Yellow", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)

			Connection = nil

			_G.Empyreal("theme", "yellow")
		end)

		local PurpleTheme = SettingsTab:NewButton("Purple", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)

			Connection = nil

			_G.Empyreal("theme", "purple")
		end)

		local PinkTheme = SettingsTab:NewButton("Pink", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)

			Connection = nil

			_G.Empyreal("theme", "pink")
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

			DeveloperTab:NewSeperator()

			local DeveloperTheme = DeveloperTab:NewButton("Developer [THEME]", function()
				Notif:Notify("Reloading the script, please be patient.", 3, "information")

				task.wait(3.5)

				Connection = nil

				_G.Empyreal("theme", "developer")
			end)

			local BlackTheme = DeveloperTab:NewButton("Black [THEME]", function()
				Notif:Notify("Reloading the script, please be patient.", 3, "information")

				task.wait(3.5)

				Connection = nil

				_G.Empyreal("theme", "black")
			end)

			DeveloperTab:NewSeperator()

			local SillyText = DeveloperTab:NewLabel("Hello, "..string.upper(library:GetUsername()).."!", "center")
		end

		--// VISUALS \\--

		local WarningText2 = VisualsTab:NewLabel("⚠️ [ MORE WILL COME BE PATIENT ] ⚠️", "center")

		local ESPSECTION = VisualsTab:NewSection("ESP")

		local EnableESP = VisualsTab:NewToggle("Highlight ESP", false, function(value)
			local vers = value and "on" or "off"

			if vers == "on" then
				_G.HighlightESP = true
			else
				_G.HighlightESP = false
			end
		end)

		local EnableESPLocal = VisualsTab:NewToggle("Local", false, function(value)
			local vers = value and "on" or "off"

			if vers == "on" then
				_G.ESPLocal = true
			else
				_G.ESPLocal = false
			end
		end)

		local EnableESPRainbow = VisualsTab:NewToggle("Rainbow Highlight", false, function(value)
			local vers = value and "on" or "off"

			if vers == "on" then
				_G.ESPHighlightRainbow = true
			else
				_G.ESPHighlightRainbow = false
			end
		end)

		local VisualHighlightColor = VisualsTab:NewTextbox("Highlight Color", "", "255,255,255", "all", "small", true, false, function(val)
			local Numbers = string.split(val, ",")

			_G.ESPHighlighColor = Color3.fromRGB(Numbers[1], Numbers[2], Numbers[3])
			_G.ESPHighlightLastColor = Color3.fromRGB(Numbers[1], Numbers[2], Numbers[3])
		end)

		--// LOCALPLAYER \\--

		local WarningText3 = LocalPlayerTab:NewLabel("⚠️ [ MORE WILL COME BE PATIENT ] ⚠️", "center")

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

		local WarningText4 = CombatTab:NewLabel("⚠️ [ MORE WILL COME BE PATIENT ] ⚠️", "center")

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

		local AimlockSection = CombatTab:NewSection("Aimlock")

		local EnableAimlock = CombatTab:NewToggle("Enable", false, function(value)
			local vers = value and "on" or "off"

			if vers == "on" then
				_G.AimbotEnabled = true
			else
				_G.AimbotEnabled = false
			end
		end)

		local EnableAimlockWallCheck = CombatTab:NewToggle("Wall Check", false, function(value)
			local vers = value and "on" or "off"

			if vers == "on" then
				_G.AimbotWallCheck = true
			else
				_G.AimbotWallCheck = false
			end
		end)

		local AimlockKeybind = CombatTab:NewTextbox("Aimlock Keybind", "", "MouseButton2", "all", "small", true, false, function(val)
			if Enum.KeyCode[val] == nil and Enum.UserInputType[val] == nil then
				return
			end

			if Enum.KeyCode[val] ~= nil then
				_G.AimKeybind = Enum.KeyCode[val]
			elseif Enum.UserInputType[val] ~= nil then
				_G.AimKeybind = Enum.UserInputType[val]
			end
		end)

		local AimlockLockPart = CombatTab:NewSelector("Lock Part", "Head", {"Head", "LeftFoot", "LeftHand", "RightFoot", "RightHand", "UpperTorso"}, function(d)
			_G.AimPart = d
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
		end):AddKeybind(nil)

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
	elseif gameID == 1494262959 then
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
		Notif:Notify("Successfully loaded [CRIMINALITY] with HWID {"..tostring(ClientHWID).."}", 2, "success") -- notification, alert, error, success, information
		Notif:Notify("IT IS RECOMMENDED TO NOT USE ANY FEATURES BEFORE CHANGING THEMES", 2, "information")
		task.wait(0.5)
		Notif:Notify("Loading empyreal, please be patient.", 3, "information") -- notification, alert, error, success, information

		library.title = "Empyreal"
		
		library:Introduction()
		wait(1)
		local Init = library:Init()
		
		--// INIT TABS \\--
		
		local SkinsTab = Init:NewTab("Skins [CLIENT]")
		
		local chainsaw_ripper = SkinsTab:NewButton("chainsaw_ripper", function()
			local SkinAdder = loadstring((syn and syn.request or request)({Url="https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/SkinAdderLIB.lua",Method="GET"}).Body)()

			local ToolName = "Chainsaw"

			local Beretta = SkinAdder:CreateSkin("Chainsaw", "RIPPER 2", "exotic", false, true, 7, false, 46, {
				TextureID = 13714495559,
				SkinClass = "Guns",
				CustomModel = "chainsaw_ripper",
				MeleeVariant = false,
				_FixedMagThing = false
			})

			local function createModel()
				--[[ MADE BY JAHI AND FATAL ]]--


				local guh = game.Players.LocalPlayer.Character["Chainsaw"].WeaponHandle.WeaponHandle2
				local Tool = game.Players.LocalPlayer.Character["Chainsaw"]
				local TweenService = game:GetService("TweenService")

				--[[ TEXTURES/MESHES ]]--

				if Tool:GetAttribute("Goldified") then
					return
				end

				Tool:SetAttribute("Goldified", true)


				local Directory = game:GetService("ReplicatedStorage"):WaitForChild("Storage"):WaitForChild("SkinVariants")
				local Replicated = Directory.Melees.chainsaw_ripper:Clone()
				local Handle = workspace.Characters["L3ARNT"].Chainsaw:WaitForChild("WeaponHandle")

				for _, v in pairs(Replicated.WeaponHandle:GetChildren()) do

					if Handle:FindFirstChild(v.Name) then
						Handle:FindFirstChild(v.Name):Destroy()
					end

					if v:IsA("Motor6D") then
						v.Part0 = Handle
					end

					if v:IsA("BasePart") then
						v.Anchored = false
					end

					v.Parent = Handle
				end

				for _,v in pairs(Handle:GetDescendants()) do
					if v:IsA("BasePart") then
						v.Anchored = false
					end
				end

				Replicated:Destroy()

				local PA_1 = Handle.WeaponHandle2:WaitForChild("EyeParts")["PA_1"]
				local PB_1 = Handle.WeaponHandle2.EyeParts["PB_1"]

				local PA_2 = Handle.WeaponHandle2.EyeParts["PA_2"]
				local PB_2 = Handle.WeaponHandle2.EyeParts["PB_2"]

				local PL = Instance.new("PointLight")
				PL.Color = Color3.fromRGB(255, 48, 48)
				PL.Brightness = 0
				PL.Shadows = true
				PL.Range = 7
				PL.Name = "RipperLight"
				PL.Parent = Handle.WeaponHandle2

				local eyea = PA_1 and PB_1
				eyea.Transparency = 1

				local eyeb = PA_2 and PB_2
				eyeb.Transparency = 1

				local goal = {}
				goal.Transparency = 0

				local goal2 = {}
				goal2.Transparency = 0

				local tween = TweenService:Create(eyea, TweenInfo.new(0.5), {Transparency = 0})
				local tween2 = TweenService:Create(eyeb, TweenInfo.new(0.5), {Transparency = 0})

				local goal3 = {}
				goal3.Transparency = 1

				local goal4 = {}
				goal4.Transparency = 1

				local vtween = TweenService:Create(eyea, TweenInfo.new(0.5), {Transparency = 1})
				local vtween2 = TweenService:Create(eyeb, TweenInfo.new(0.5), {Transparency = 1})


				--[[ SFX ]]--


				local equip = Instance.new("Sound")
				equip.Name = "Equip2"
				equip.SoundId = "rbxassetid://7578785210"
				equip.PlaybackSpeed = 1
				equip.Volume = 0.4
				equip.Parent = guh

				local lunge = Instance.new("Sound")
				lunge.Name = "Lunge2"
				lunge.SoundId = "rbxassetid://7578785210"
				lunge.PlaybackSpeed = 1
				lunge.Volume = 0.4
				lunge.Parent = guh

				local finish = Instance.new("Sound")
				finish.Name = "Finish2"
				finish.SoundId = "rbxassetid://7578785210"
				finish.PlaybackSpeed = 1
				finish.Volume = 0.7
				finish.Parent = guh


				--[[ Equip ]]--


				Tool.Equipped:Connect(function()
					task.wait(0.05)
					equip:Play()
				end)


				--[[ Swing/Lunge ]]--


				local Equipped = false

				Tool.Equipped:Connect(function()
					Equipped = true
				end)

				Tool.Unequipped:Connect(function()
					Equipped = false
				end)

				game.UserInputService.InputBegan:Connect(function(input, gp)
					if gp then
						return
					end	

					if not Equipped then
						return
					end

					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if Tool.Values.Slashing1 == true then
							return
						end

						if lunge.IsPlaying == true then
							return
						end 

						task.spawn(function()
							PA_1.Transparency = 1
							PA_2.Transparency = 1
							PB_1.Transparency = 1
							PB_2.Transparency = 1

							if lunge.IsPlaying == true then
								return
							end 

							lunge:Play()
						end)

						task.wait(0.1)

						game:GetService("TweenService"):Create(PL, TweenInfo.new(0.3), {
							Brightness = 3
						}):Play()

						tween:Play()
						tween2:Play()
						task.wait(2.5)
						vtween:Play()
						vtween2:Play()

						game:GetService("TweenService"):Create(PL, TweenInfo.new(0.3), {
							Brightness = 0
						}):Play()

						lunge:Stop()
					end
				end)


				--[[ FINISHER ]]--

				Tool.Equipped:Connect(function()
					Equipped = true
				end)

				Tool.Unequipped:Connect(function()
					Equipped = false
				end)

				game.UserInputService.InputBegan:Connect(function(input, fp)
					if fp then
						return
					end	

					if not Equipped then
						return
					end

					if input.KeyCode == Enum.KeyCode.F then
						if Tool.Values.Executing == true then
							return
						end

						if finish.IsPlaying == true then
							return
						end 

						task.spawn(function()

							if finish.IsPlaying == true then
								return
							end 

							task.wait(1)

							finish:Play()

							task.wait(1)

							finish:Stop()
						end)
					end
				end)

				for _,Part in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if Part:IsA("Tool") then
						if Part:FindFirstChild("Melee") then
							local Config = require(Part.Config)
							if Part.Name == "Chainsaw" then
								Config.StaminaUsage = 15
								Config.AttackSlowDown.Amount = -15
							end
							if Part ~= nil then
								game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
								Part.Client.Disabled = true
								Part.PassClient.Disabled = true
								Part.Client.Disabled = false
								Part.PassClient.Disabled = false
							end
						end
					end
				end
			end

			local On = false

			Beretta.Changed:Connect(function()
				if Beretta:GetAttribute("Activated") == true then
					On = true
				elseif Beretta:GetAttribute("Activated") == false then
					On = false
				end
			end)

			game.Players.LocalPlayer.Character.ChildAdded:Connect(function(Object)
				if Object:IsA("Tool") and Object.Name == ToolName and On then
					createModel()
				end
			end)
		end)
	else
		local Notif = library:InitNotifications()
		Notif:Notify("EMPYREAL COULDN'T LOAD REASON: INVALID GAME ID [PLEASE JOIN A GAME THAT EMPYREAL SUPPORTS]", 5, "error") -- notification, alert, error, success, information
	end
end

_G.Empyreal(game.GameId)
