_G.Empyreal = function(typeS, theme, gameID)
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

		library.title = "Empyreal [GUTP]"

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

			_G.Empyreal("theme", "white", game.GameId)
		end)

		local RedTheme = SettingsTab:NewButton("Red", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)

			Connection = nil

			_G.Empyreal("theme", "red", game.GameId)
		end)

		local GreenTheme = SettingsTab:NewButton("Green", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)

			Connection = nil

			_G.Empyreal("theme", "green", game.GameId)
		end)

		local BlueTheme = SettingsTab:NewButton("Blue", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)

			Connection = nil

			_G.Empyreal("theme", "blue", game.GameId)
		end)

		local OrangeTheme = SettingsTab:NewButton("Orange", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)

			Connection = nil

			_G.Empyreal("theme", "orange", game.GameId)
		end)

		local YellowTheme = SettingsTab:NewButton("Yellow", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)

			Connection = nil

			_G.Empyreal("theme", "yellow", game.GameId)
		end)

		local PurpleTheme = SettingsTab:NewButton("Purple", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)

			Connection = nil

			_G.Empyreal("theme", "purple", game.GameId)
		end)

		local PinkTheme = SettingsTab:NewButton("Pink", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)

			Connection = nil

			_G.Empyreal("theme", "pink", game.GameId)
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
		
		local Character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
		
		library.title = "Empyreal [CRIMINALITY]"
		
		library:Introduction()
		wait(1)
		local Init = library:Init()
		
		--// INIT TABS \\--
		
		local SkinsTab = Init:NewTab("Skins [CLIENT]")
		local SettingsTab = Init:NewTab("Settings")
		
		--// SETTINGS TAB \\--
		
		local WarningText5 = SettingsTab:NewLabel("⚠️ [ MORE WILL COME BE PATIENT ] ⚠️", "center")
		
		local Restarting = false
		
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
			
			Restarting = true
			
			_G.Empyreal("theme", "white", game.GameId)
		end)

		local RedTheme = SettingsTab:NewButton("Red", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)
			
			Restarting = true
			
			_G.Empyreal("theme", "red", game.GameId)
		end)

		local GreenTheme = SettingsTab:NewButton("Green", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)
			
			Restarting = true
			
			_G.Empyreal("theme", "green", game.GameId)
		end)

		local BlueTheme = SettingsTab:NewButton("Blue", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)
			
			Restarting = true
			
			_G.Empyreal("theme", "blue", game.GameId)
		end)

		local OrangeTheme = SettingsTab:NewButton("Orange", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)
			
			Restarting = true
			
			_G.Empyreal("theme", "orange", game.GameId)
		end)

		local YellowTheme = SettingsTab:NewButton("Yellow", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)
			
			Restarting = true
			
			_G.Empyreal("theme", "yellow", game.GameId)
		end)

		local PurpleTheme = SettingsTab:NewButton("Purple", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)
			
			Restarting = true
			
			Restarting = true
			
			_G.Empyreal("theme", "purple", game.GameId)
		end)

		local PinkTheme = SettingsTab:NewButton("Pink", function()
			Notif:Notify("Reloading the script, please be patient.", 3, "information")

			task.wait(3.5)
			
			Restarting = true
			
			_G.Empyreal("theme", "pink", game.GameId)
		end)
		
		--// SKINS TAB \\--
		
		local player = game.Players.LocalPlayer
		local Character = player.Character or player.CharacterAdded:Wait()
		
		local SerialNumber = 0
		local KillsNumber = 0
		local Killtrack = false
		local Souvenir = false
		local TradeLocked = false
		
		local SerialNumberF = SkinsTab:NewTextbox("Serial", "", "0", "all", "small", true, false, function(val)
			SerialNumber = tonumber(val)
		end)
		
		local KillsNumberF = SkinsTab:NewTextbox("Killtrack Kill Count", "", "0", "all", "small", true, false, function(val)
			KillsNumber = tonumber(val)
		end)
		
		local TradeLockedF = SkinsTab:NewToggle("TradeLocked", false, function(value)
			local vers = value and "on" or "off"

			if vers == "on" then
				TradeLocked = true
			else
				TradeLocked = false
			end
		end)
		
		local KilltrackF = SkinsTab:NewToggle("Killtrack", false, function(value)
			local vers = value and "on" or "off"

			if vers == "on" then
				Killtrack = true
			else
				Killtrack = false
			end
		end)
		
		local SouvenirF = SkinsTab:NewToggle("Souvenir", false, function(value)
			local vers = value and "on" or "off"

			if vers == "on" then
				Souvenir = true
			else
				Souvenir = false
			end
		end)
		
		SkinsTab:NewSeperator()
		
		local chainsaw_ripper = SkinsTab:NewButton("chainsaw_ripper", function()
			local SkinAdder = loadstring((syn and syn.request or request)({Url="https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/SkinAdderLIB.lua",Method="GET"}).Body)()

			local ToolName = "Chainsaw"

			local Beretta = SkinAdder:CreateSkin("Chainsaw", "RIPPER", "limited", TradeLocked, Killtrack, KillsNumber, Souvenir, SerialNumber, {
				TextureID = 15177796575,
				SkinClass = "Melees",
				CustomModel = "chainsaw_ripper",
				MeleeVariant = false,
				_FixedMagThing = false
			})
			
			
			
			local function createModel()
				--[[ MADE BY JAHI AND FATAL ]]--


				local guh = Character["Chainsaw"].WeaponHandle.WeaponHandle2
				local Tool = Character["Chainsaw"]
				local TweenService = game:GetService("TweenService")

				--[[ TEXTURES/MESHES ]]--

				if Tool:GetAttribute("Goldified") then
					return
				end

				Tool:SetAttribute("Goldified", true)


				local Directory = game:GetService("ReplicatedStorage"):WaitForChild("Storage"):WaitForChild("SkinVariants")
				local Replicated = Directory.Melees.chainsaw_ripper:Clone()
				local Handle = Character.Chainsaw:WaitForChild("WeaponHandle")

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

				for _,Part in pairs(Character:GetChildren()) do
					if Part:IsA("Tool") then
						if Part:FindFirstChild("Melee") then
							local Config = require(Part.Config)
							if Part.Name == "Chainsaw" then
								Config.StaminaUsage = 15
								Config.AttackSlowDown.Amount = -15
							end
							if Part ~= nil then
								Character.Humanoid:UnequipTools()
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
			
			local function onCharacterAdded(newCharacter)
				Character = newCharacter

				local Tool = Character:FindFirstChild(ToolName)
				if Tool and On then
					print("Character respawned, reapplying model")
					createModel()
				end
			end

			player.CharacterAdded:Connect(onCharacterAdded)

			Beretta.Changed:Connect(function()
				if Beretta:GetAttribute("Activated") == true then
					On = false
				elseif Beretta:GetAttribute("Activated") == false then
					On = true
				end
			end)

			while wait(.5) do
				if Character:FindFirstChild(ToolName) then
					if On then
						createModel()
					end
				end
			end
			
			local function onCharacterAdded(newCharacter)
				Character = newCharacter

				local Tool = Character:FindFirstChild(ToolName)
				if Tool and On then
					print("Character respawned, reapplying model")
					createModel()
				end
			end

			player.CharacterAdded:Connect(onCharacterAdded)

			Beretta.Changed:Connect(function()
				if Beretta:GetAttribute("Activated") == true then
					On = false
				elseif Beretta:GetAttribute("Activated") == false then
					On = true
				end
			end)

			while wait(.5) do
				if Character:FindFirstChild(ToolName) then
					if On then
						createModel()
					end
				end
			end
		end)
		
		local beretta_gold = SkinsTab:NewButton("beretta_gold", function()
			local SkinAdder = loadstring((syn and syn.request or request)({Url="https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/SkinAdderLIB.lua",Method="GET"}).Body)()

			local ToolName = "Beretta"

			local Beretta = SkinAdder:CreateSkin("Beretta", "Golden Beretta", "limited", TradeLocked, Killtrack, KillsNumber, Souvenir, SerialNumber, {
				TextureID = 15039167103,
				SkinClass = "Guns",
				MeleeVariant = false,
				_FixedMagThing = false
			})

			

			local function createModel()
				--███╗░░░███╗░█████╗░██████╗░███████╗  ██████╗░██╗░░░██╗  ██╗░░██╗██╗░░░██╗░░░
				--████╗░████║██╔══██╗██╔══██╗██╔════╝  ██╔══██╗╚██╗░██╔╝  ██║░░██║██║░░░██║░░░
				--██╔████╔██║███████║██║░░██║█████╗░░  ██████╦╝░╚████╔╝░  ███████║╚██╗░██╔╝░░░
				--██║╚██╔╝██║██╔══██║██║░░██║██╔══╝░░  ██╔══██╗░░╚██╔╝░░  ██╔══██║░╚████╔╝░██╗
				--██║░╚═╝░██║██║░░██║██████╔╝███████╗  ██████╦╝░░░██║░░░  ██║░░██║░░╚██╔╝░░╚█║
				--╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═════╝░╚══════╝  ╚═════╝░░░░╚═╝░░░  ╚═╝░░╚═╝░░░╚═╝░░░░╚╝

				--░░░░░██╗░█████╗░██╗░░██╗██╗░░░  ███████╗░█████╗░████████╗░█████╗░██╗░░░░░
				--░░░░░██║██╔══██╗██║░░██║██║░░░  ██╔════╝██╔══██╗╚══██╔══╝██╔══██╗██║░░░░░
				--░░░░░██║███████║███████║██║░░░  █████╗░░███████║░░░██║░░░███████║██║░░░░░
				--██╗░░██║██╔══██║██╔══██║██║██╗  ██╔══╝░░██╔══██║░░░██║░░░██╔══██║██║░░░░░
				--╚█████╔╝██║░░██║██║░░██║██║╚█║  ██║░░░░░██║░░██║░░░██║░░░██║░░██║███████╗
				--░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░╚╝  ╚═╝░░░░░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚══════╝


				local guh = Character["Beretta"].WeaponHandle.Parts
				local fx = Character["Beretta"].WeaponHandle

				local gui = player.PlayerGui.GunGUI.Frame.Main.Title

				local Tool = player.Character["Beretta"]

				local gold = Enum.Material.Neon


				--███╗░░░███╗░█████╗░██╗███╗░░██╗
				--████╗░████║██╔══██╗██║████╗░██║
				--██╔████╔██║███████║██║██╔██╗██║
				--██║╚██╔╝██║██╔══██║██║██║╚████║
				--██║░╚═╝░██║██║░░██║██║██║░╚███║
				--╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝╚═╝░░╚══╝


				if Tool:GetAttribute("Goldified") then
					return
				end

				Tool:SetAttribute("Goldified", true)
				Tool.ToolTip = "G-Beretta"


				--░██████╗███████╗██╗░░██╗
				--██╔════╝██╔════╝╚██╗██╔╝
				--╚█████╗░█████╗░░░╚███╔╝░
				--░╚═══██╗██╔══╝░░░██╔██╗░
				--██████╔╝██║░░░░░██╔╝╚██╗
				--╚═════╝░╚═╝░░░░░╚═╝░░╚═╝


				local fs2 = Instance.new("Sound")
				fs2.Name = "FFireSoundTWO"
				fs2.SoundId = "rbxassetid://1210852193"
				fs2.PlaybackSpeed = 1.5
				fs2.Volume = 0.5
				fs2.Parent = fx.Muzzle

				fx.Muzzle.FireSound1:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound1.IsPlaying == true then
						fs2:Play()
					end
				end)

				fx.Muzzle.FireSound2:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound2.IsPlaying == true then
						fs2:Play()
					end
				end)

				fx.Muzzle.FireSound3:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound3.IsPlaying == true then
						fs2:Play()
					end
				end)

				--███████╗██╗░░██╗
				--██╔════╝╚██╗██╔╝
				--█████╗░░░╚███╔╝░
				--██╔══╝░░░██╔██╗░
				--██║░░░░░██╔╝╚██╗
				--╚═╝░░░░░╚═╝░░╚═╝


				local c1 = Instance.new("ChorusSoundEffect")
				c1.Depth = 1
				c1.Mix = 1
				c1.Priority = 1
				c1.Rate = 0.25

				local c2 = Instance.new("ChorusSoundEffect")
				c2.Depth = 1
				c2.Mix = 1
				c2.Priority = 1
				c2.Rate = 0.25

				local c3 = Instance.new("ChorusSoundEffect")
				c3.Depth = 1
				c3.Mix = 1
				c3.Priority = 1
				c3.Rate = 0.25

				local c4 = Instance.new("ChorusSoundEffect")
				local c5 = Instance.new("ChorusSoundEffect")
				local c6 = Instance.new("ChorusSoundEffect")
				local c7 = Instance.new("ChorusSoundEffect")
				local c8 = Instance.new("ChorusSoundEffect")
				local c9 = Instance.new("ChorusSoundEffect")
				local c10 = Instance.new("ChorusSoundEffect")
				local c11 = Instance.new("ChorusSoundEffect")

				c1.Name = "Chorus1"
				c1.Parent = fx.Muzzle.FireSound1

				c2.Name = "Chorus2"
				c2.Parent = fx.Muzzle.FireSound2

				c3.Name = "Chorus3"
				c3.Parent = fx.Muzzle.FireSound3

				c4.Name = "Chorus4"
				c4.Parent = fx.ReloadA.MagIn

				c5.Name = "Chorus5"
				c5.Parent = fx.ReloadA.MagOut

				c6.Name = "Chorus6"
				c6.Parent = fx.ReloadA.SlideBack

				c7.Name = "Chorus7"
				c7.Parent = fx.ReloadA.SlideIn

				c8.Name = "Chorus8"
				c8.Parent = fx.TriggerA.Empty

				c9.Name = "Chorus9"
				c9.Parent = fx.TriggerA.EquipSound

				c10.Name = "Chorus10"
				c10.Parent = fx.ReloadA.MagHit

				c11.Name = "Chorus11"
				c11.Parent = fx.TriggerA.FireModeSwitch


				--████████╗███████╗██╗░░██╗████████╗██╗░░░██╗██████╗░███████╗░██████╗
				--╚══██╔══╝██╔════╝╚██╗██╔╝╚══██╔══╝██║░░░██║██╔══██╗██╔════╝██╔════╝
				--░░░██║░░░█████╗░░░╚███╔╝░░░░██║░░░██║░░░██║██████╔╝█████╗░░╚█████╗░
				--░░░██║░░░██╔══╝░░░██╔██╗░░░░██║░░░██║░░░██║██╔══██╗██╔══╝░░░╚═══██╗
				--░░░██║░░░███████╗██╔╝╚██╗░░░██║░░░╚██████╔╝██║░░██║███████╗██████╔╝
				--░░░╚═╝░░░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░░╚═════╝░╚═╝░░╚═╝╚══════╝╚═════╝░


				local function destroySurfaceAppearance(object)
					local surfaceAppearance = object:FindFirstChildOfClass("SurfaceAppearance")
					if surfaceAppearance then
						surfaceAppearance:Destroy()
						print("SurfaceAppearance destroyed for", object.Name)
					else
						print("No SurfaceAppearance found for", object.Name)
					end
				end

				destroySurfaceAppearance(guh.HandlePart.Base)
				destroySurfaceAppearance(guh.MagPart)
				destroySurfaceAppearance(guh.HandlePart.HammerPart)
				destroySurfaceAppearance(guh.HandlePart.Slide.SlidePart)

				local cmap = "rbxassetid://15071881699"
				local mmap = "rbxassetid://15071881490"
				local nmap = "rbxassetid://15071881251"
				local rmap = "rbxassetid://15071880826"

				local sa1 = Instance.new("SurfaceAppearance")
				sa1.Name = "CustomAppearance1"
				sa1.ColorMap = cmap
				sa1.MetalnessMap = mmap
				sa1.NormalMap = nmap
				sa1.RoughnessMap = rmap

				local sa2 = Instance.new("SurfaceAppearance")
				sa2.Name = "CustomAppearance2"
				sa2.ColorMap = cmap
				sa2.MetalnessMap = mmap
				sa2.NormalMap = nmap
				sa2.RoughnessMap = rmap

				local sa3 = Instance.new("SurfaceAppearance")
				sa3.Name = "CustomAppearance3"
				sa3.ColorMap = cmap
				sa3.MetalnessMap = mmap
				sa3.NormalMap = nmap
				sa3.RoughnessMap = rmap

				local sa4 = Instance.new("SurfaceAppearance")
				sa4.Name = "CustomAppearance4"
				sa4.ColorMap = cmap
				sa4.MetalnessMap = mmap
				sa4.NormalMap = nmap
				sa4.RoughnessMap = rmap

				sa1.Parent = guh.MagPart
				sa2.Parent = guh.HandlePart.Base
				sa3.Parent = guh.HandlePart.HammerPart
				sa4.Parent = guh.HandlePart.Slide.SlidePart

				guh.MagPart.BulletPart.TextureID = ""
				guh.MagPart.BulletPart.Color = Color3.fromRGB(255, 230, 0)
				guh.MagPart.BulletPart.Material = gold


				--██╗░░░██╗███████╗██╗░░██╗
				--██║░░░██║██╔════╝╚██╗██╔╝
				--╚██╗░██╔╝█████╗░░░╚███╔╝░
				--░╚████╔╝░██╔══╝░░░██╔██╗░
				--░░╚██╔╝░░██║░░░░░██╔╝╚██╗
				--░░░╚═╝░░░╚═╝░░░░░╚═╝░░╚═╝


				local vfx = game.Players.LocalPlayer.Character["Beretta"].WeaponHandle.Muzzle

				if vfx["Barrel smoke"] then
					vfx["Barrel smoke"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Barrel smoke"].Brightness = 15
					vfx["Barrel smoke"].LightEmission = 1
				end

				if vfx["FlashEmitter"] then
					vfx["FlashEmitter"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["FlashEmitter"].Brightness = 15
					vfx["FlashEmitter"].LightEmission = 1
				end

				if vfx["Gas"] then
					vfx["Gas"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Gas"].Brightness = 15
					vfx["Gas"].LightEmission = 1
				end

				if vfx["Gas2"] then
					vfx["Gas2"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Gas2"].Brightness = 15
					vfx["Gas2"].LightEmission = 1
				end

				if vfx["Lens flare"] then
					vfx["Lens flare"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Lens flare"].Brightness = 15
					vfx["Lens flare"].LightEmission = 1
				end

				if vfx["Muzzle Flash 1"] then
					vfx["Muzzle Flash 1"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Muzzle Flash 1"].Brightness = 15
					vfx["Muzzle Flash 1"].LightEmission = 1
				end

				if vfx["SmokeEmitter"] then
					vfx["SmokeEmitter"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["SmokeEmitter"].Brightness = 15
					vfx["SmokeEmitter"].LightEmission = 1
				end

				if vfx["Sparkles"] then
					vfx["Sparkles"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Sparkles"].Brightness = 15
					vfx["Sparkles"].LightEmission = 1
				end

				while wait() do
					if Character:FindFirstChild("Beretta") then
						local gui = player.PlayerGui.GunGUI.Frame.Main.Title
						gui.Text = "Beretta"
					end    
				end
			end

			local On = false

			local function onCharacterAdded(newCharacter)
				Character = newCharacter

				local Tool = Character:FindFirstChild(ToolName)
				if Tool and On then
					print("Character respawned, reapplying model")
					createModel()
				end
			end

			player.CharacterAdded:Connect(onCharacterAdded)

			Beretta.Changed:Connect(function()
				if Beretta:GetAttribute("Activated") == true then
					On = false
				elseif Beretta:GetAttribute("Activated") == false then
					On = true
				end
			end)

			while wait(.5) do
				if Character:FindFirstChild(ToolName) then
					if On then
						createModel()
					end
				end
			end

			local function onCharacterAdded(newCharacter)
				Character = newCharacter

				local Tool = Character:FindFirstChild(ToolName)
				if Tool and On then
					print("Character respawned, reapplying model")
					createModel()
				end
			end

			player.CharacterAdded:Connect(onCharacterAdded)

			Beretta.Changed:Connect(function()
				if Beretta:GetAttribute("Activated") == true then
					On = false
				elseif Beretta:GetAttribute("Activated") == false then
					On = true
				end
			end)

			while wait(.5) do
				if Character:FindFirstChild(ToolName) then
					if On then
						createModel()
					end
				end
			end
		end)
		
		local deagle_gold = SkinsTab:NewButton("deagle_gold", function()
			local SkinAdder = loadstring((syn and syn.request or request)({Url="https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/SkinAdderLIB.lua",Method="GET"}).Body)()

			local ToolName = "Deagle"

			local Beretta = SkinAdder:CreateSkin("Deagle", "Golden Deagle", "limited", TradeLocked, Killtrack, KillsNumber, Souvenir, SerialNumber, {
				TextureID = 9422471620,
				SkinClass = "Guns",
				MeleeVariant = false,
				_FixedMagThing = false
			})

			local function createModel()
				--███╗░░░███╗░█████╗░██████╗░███████╗  ██████╗░██╗░░░██╗  ██╗░░██╗██╗░░░██╗░░░
				--████╗░████║██╔══██╗██╔══██╗██╔════╝  ██╔══██╗╚██╗░██╔╝  ██║░░██║██║░░░██║░░░
				--██╔████╔██║███████║██║░░██║█████╗░░  ██████╦╝░╚████╔╝░  ███████║╚██╗░██╔╝░░░
				--██║╚██╔╝██║██╔══██║██║░░██║██╔══╝░░  ██╔══██╗░░╚██╔╝░░  ██╔══██║░╚████╔╝░██╗
				--██║░╚═╝░██║██║░░██║██████╔╝███████╗  ██████╦╝░░░██║░░░  ██║░░██║░░╚██╔╝░░╚█║
				--╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═════╝░╚══════╝  ╚═════╝░░░░╚═╝░░░  ╚═╝░░╚═╝░░░╚═╝░░░░╚╝

				--░░░░░██╗░█████╗░██╗░░██╗██╗░░░  ███████╗░█████╗░████████╗░█████╗░██╗░░░░░
				--░░░░░██║██╔══██╗██║░░██║██║░░░  ██╔════╝██╔══██╗╚══██╔══╝██╔══██╗██║░░░░░
				--░░░░░██║███████║███████║██║░░░  █████╗░░███████║░░░██║░░░███████║██║░░░░░
				--██╗░░██║██╔══██║██╔══██║██║██╗  ██╔══╝░░██╔══██║░░░██║░░░██╔══██║██║░░░░░
				--╚█████╔╝██║░░██║██║░░██║██║╚█║  ██║░░░░░██║░░██║░░░██║░░░██║░░██║███████╗
				--░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░╚╝  ╚═╝░░░░░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚══════╝


				local guh = Character["Deagle"].WeaponHandle.Parts
				local fx = Character["Deagle"].WeaponHandle

				local gui = player.PlayerGui.GunGUI.Frame.Main.Title

				local Tool = player.Character["Deagle"]

				local gold = Enum.Material.Neon


				--███╗░░░███╗░█████╗░██╗███╗░░██╗
				--████╗░████║██╔══██╗██║████╗░██║
				--██╔████╔██║███████║██║██╔██╗██║
				--██║╚██╔╝██║██╔══██║██║██║╚████║
				--██║░╚═╝░██║██║░░██║██║██║░╚███║
				--╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝╚═╝░░╚══╝


				if Tool:GetAttribute("Goldified") then
					return
				end

				Tool:SetAttribute("Goldified", true)
				Tool.ToolTip = "G-Deagle"


				--░██████╗███████╗██╗░░██╗
				--██╔════╝██╔════╝╚██╗██╔╝
				--╚█████╗░█████╗░░░╚███╔╝░
				--░╚═══██╗██╔══╝░░░██╔██╗░
				--██████╔╝██║░░░░░██╔╝╚██╗
				--╚═════╝░╚═╝░░░░░╚═╝░░╚═╝


				local fs2 = Instance.new("Sound")
				fs2.Name = "FFireSoundTWO"
				fs2.SoundId = "rbxassetid://1210852193"
				fs2.PlaybackSpeed = 1.5
				fs2.Volume = 1.15
				fs2.Parent = fx.Muzzle

				fx.Muzzle.FireSound1:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound1.IsPlaying == true then
						fs2:Play()
					end
				end)

				fx.Muzzle.FireSound2:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound2.IsPlaying == true then
						fs2:Play()
					end
				end)

				fx.Muzzle.FireSound3:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound3.IsPlaying == true then
						fs2:Play()
					end
				end)

				local ching = Instance.new("Sound")
				ching.Name = "Ching"
				ching.SoundId = "rbxassetid://4509234222"
				ching.Volume = 0.35
				ching.Parent = fx.ReloadA

				local eq = Instance.new("EqualizerSoundEffect")
				eq.HighGain = -2
				eq.LowGain = 10
				eq.MidGain = 0
				eq.Priority = 0
				eq.Parent = fx.ReloadA.Ching


				--███████╗░██████╗░██╗░░░██╗██╗██████╗░
				--██╔════╝██╔═══██╗██║░░░██║██║██╔══██╗
				--█████╗░░██║██╗██║██║░░░██║██║██████╔╝
				--██╔══╝░░╚██████╔╝██║░░░██║██║██╔═══╝░
				--███████╗░╚═██╔═╝░╚██████╔╝██║██║░░░░░
				--╚══════╝░░░╚═╝░░░░╚═════╝░╚═╝╚═╝░░░░░


				Tool.Equipped:Connect(function()

					task.wait(0.545)

					ching:Play()
				end)


				--██████╗░███████╗██╗░░░░░░█████╗░░█████╗░██████╗░
				--██╔══██╗██╔════╝██║░░░░░██╔══██╗██╔══██╗██╔══██╗
				--██████╔╝█████╗░░██║░░░░░██║░░██║███████║██║░░██║
				--██╔══██╗██╔══╝░░██║░░░░░██║░░██║██╔══██║██║░░██║
				--██║░░██║███████╗███████╗╚█████╔╝██║░░██║██████╔╝
				--╚═╝░░╚═╝╚══════╝╚══════╝░╚════╝░╚═╝░░╚═╝╚═════╝░


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

					if input.KeyCode == Enum.KeyCode.R then
						if Tool.Values.Ammo.Value == 7 then
							return
						end

						if Tool.Values.StoredAmmo.Value == 0 then
							return
						end

						if ching.IsPlaying == true then
							return
						end     
						task.wait(2.8)

						if ching.IsPlaying == true then
							return
						end   

						ching:Play()     
					end
				end)


				--███████╗██╗░░██╗
				--██╔════╝╚██╗██╔╝
				--█████╗░░░╚███╔╝░
				--██╔══╝░░░██╔██╗░
				--██║░░░░░██╔╝╚██╗
				--╚═╝░░░░░╚═╝░░╚═╝


				local c1 = Instance.new("ChorusSoundEffect")
				c1.Depth = 1
				c1.Mix = 1
				c1.Priority = 1
				c1.Rate = 0.25

				local c2 = Instance.new("ChorusSoundEffect")
				c2.Depth = 1
				c2.Mix = 1
				c2.Priority = 1
				c2.Rate = 0.25

				local c3 = Instance.new("ChorusSoundEffect")
				c3.Depth = 1
				c3.Mix = 1
				c3.Priority = 1
				c3.Rate = 0.25

				local c4 = Instance.new("ChorusSoundEffect")
				local c5 = Instance.new("ChorusSoundEffect")
				local c6 = Instance.new("ChorusSoundEffect")
				local c7 = Instance.new("ChorusSoundEffect")
				local c8 = Instance.new("ChorusSoundEffect")
				local c9 = Instance.new("ChorusSoundEffect")

				c1.Name = "Chorus1"
				c1.Parent = fx.Muzzle.FireSound1

				c2.Name = "Chorus2"
				c2.Parent = fx.Muzzle.FireSound2

				c3.Name = "Chorus3"
				c3.Parent = fx.Muzzle.FireSound3

				c4.Name = "Chorus4"
				c4.Parent = fx.ReloadA.MagIn

				c5.Name = "Chorus5"
				c5.Parent = fx.ReloadA.MagOut

				c6.Name = "Chorus6"
				c6.Parent = fx.ReloadA.SlideBack

				c7.Name = "Chorus7"
				c7.Parent = fx.ReloadA.SlideIn

				c8.Name = "Chorus8"
				c8.Parent = fx.TriggerA.Empty

				c9.Name = "Chorus9"
				c9.Parent = fx.TriggerA.EquipSound


				--████████╗███████╗██╗░░██╗████████╗██╗░░░██╗██████╗░███████╗░██████╗
				--╚══██╔══╝██╔════╝╚██╗██╔╝╚══██╔══╝██║░░░██║██╔══██╗██╔════╝██╔════╝
				--░░░██║░░░█████╗░░░╚███╔╝░░░░██║░░░██║░░░██║██████╔╝█████╗░░╚█████╗░
				--░░░██║░░░██╔══╝░░░██╔██╗░░░░██║░░░██║░░░██║██╔══██╗██╔══╝░░░╚═══██╗
				--░░░██║░░░███████╗██╔╝╚██╗░░░██║░░░╚██████╔╝██║░░██║███████╗██████╔╝
				--░░░╚═╝░░░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░░╚═════╝░╚═╝░░╚═╝╚══════╝╚═════╝░


				local function destroySurfaceAppearance(object)
					local surfaceAppearance = object:FindFirstChildOfClass("SurfaceAppearance")
					if surfaceAppearance then
						surfaceAppearance:Destroy()
						print("SurfaceAppearance destroyed for", object.Name)
					else
						print("No SurfaceAppearance found for", object.Name)
					end
				end

				destroySurfaceAppearance(guh.HandlePart.Base)
				destroySurfaceAppearance(guh.MagPart)
				destroySurfaceAppearance(guh.HandlePart.Hammer.HammerPart)
				destroySurfaceAppearance(guh.HandlePart.Slide.SlidePart)

				local cmap = "rbxassetid://9422465914"
				local mmap = "rbxassetid://9422467019"
				local nmap = "rbxassetid://9368506864"
				local rmap = "rbxassetid://9422469052"

				local sa1 = Instance.new("SurfaceAppearance")
				sa1.Name = "CustomAppearance1"
				sa1.ColorMap = cmap
				sa1.MetalnessMap = mmap
				sa1.NormalMap = nmap
				sa1.RoughnessMap = rmap

				local sa2 = Instance.new("SurfaceAppearance")
				sa2.Name = "CustomAppearance2"
				sa2.ColorMap = cmap
				sa2.MetalnessMap = mmap
				sa2.NormalMap = nmap
				sa2.RoughnessMap = rmap

				local sa3 = Instance.new("SurfaceAppearance")
				sa3.Name = "CustomAppearance3"
				sa3.ColorMap = cmap
				sa3.MetalnessMap = mmap
				sa3.NormalMap = nmap
				sa3.RoughnessMap = rmap

				local sa4 = Instance.new("SurfaceAppearance")
				sa4.Name = "CustomAppearance4"
				sa4.ColorMap = cmap
				sa4.MetalnessMap = mmap
				sa4.NormalMap = nmap
				sa4.RoughnessMap = rmap

				sa1.Parent = guh.MagPart
				sa2.Parent = guh.HandlePart.Base
				sa3.Parent = guh.HandlePart.Hammer.HammerPart
				sa4.Parent = guh.HandlePart.Slide.SlidePart

				guh.MagPart.BulletPart.TextureID = ""
				guh.MagPart.BulletPart.Color = Color3.fromRGB(255, 230, 0)
				guh.MagPart.BulletPart.Material = gold


				--██╗░░░██╗███████╗██╗░░██╗
				--██║░░░██║██╔════╝╚██╗██╔╝
				--╚██╗░██╔╝█████╗░░░╚███╔╝░
				--░╚████╔╝░██╔══╝░░░██╔██╗░
				--░░╚██╔╝░░██║░░░░░██╔╝╚██╗
				--░░░╚═╝░░░╚═╝░░░░░╚═╝░░╚═╝


				local vfx = game.Players.LocalPlayer.Character["Deagle"].WeaponHandle.Muzzle

				if vfx["Barrel smoke"] then
					vfx["Barrel smoke"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Barrel smoke"].Brightness = 15
					vfx["Barrel smoke"].LightEmission = 1
				end

				if vfx["FlashEmitter"] then
					vfx["FlashEmitter"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["FlashEmitter"].Brightness = 15
					vfx["FlashEmitter"].LightEmission = 1
				end

				if vfx["Gas"] then
					vfx["Gas"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Gas"].Brightness = 15
					vfx["Gas"].LightEmission = 1
				end

				if vfx["Gas2"] then
					vfx["Gas2"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Gas2"].Brightness = 15
					vfx["Gas2"].LightEmission = 1
				end

				if vfx["Lens flare"] then
					vfx["Lens flare"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Lens flare"].Brightness = 15
					vfx["Lens flare"].LightEmission = 1
				end

				if vfx["Muzzle Flash 1"] then
					vfx["Muzzle Flash 1"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Muzzle Flash 1"].Brightness = 15
					vfx["Muzzle Flash 1"].LightEmission = 1
				end

				if vfx["Muzzle Flash 2"] then
					vfx["Muzzle Flash 2"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Muzzle Flash 2"].Brightness = 15
					vfx["Muzzle Flash 2"].LightEmission = 1
				end


				if vfx["SmokeEmitter"] then
					vfx["SmokeEmitter"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["SmokeEmitter"].Brightness = 15
					vfx["SmokeEmitter"].LightEmission = 1
				end

				if vfx["Sparkles"] then
					vfx["Sparkles"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Sparkles"].Brightness = 15
					vfx["Sparkles"].LightEmission = 1
				end

				if vfx["Sparkles3"] then
					vfx["Sparkles3"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Sparkles3"].Brightness = 15
					vfx["Sparkles3"].LightEmission = 1
				end

				while wait() do
					if game.Players.LocalPlayer.Character:FindFirstChild("Deagle") then
						local gui = player.PlayerGui.GunGUI.Frame.Main.Title
						gui.Text = "Deagle"
					end    
				end
			end

			local On = false

			local function onCharacterAdded(newCharacter)
				Character = newCharacter

				local Tool = Character:FindFirstChild(ToolName)
				if Tool and On then
					print("Character respawned, reapplying model")
					createModel()
				end
			end

			player.CharacterAdded:Connect(onCharacterAdded)

			Beretta.Changed:Connect(function()
				if Beretta:GetAttribute("Activated") == true then
					On = false
				elseif Beretta:GetAttribute("Activated") == false then
					On = true
				end
			end)

			while wait(.5) do
				if Character:FindFirstChild(ToolName) then
					if On then
						createModel()
					end
				end
			end

			local function onCharacterAdded(newCharacter)
				Character = newCharacter

				local Tool = Character:FindFirstChild(ToolName)
				if Tool and On then
					print("Character respawned, reapplying model")
					createModel()
				end
			end

			player.CharacterAdded:Connect(onCharacterAdded)

			Beretta.Changed:Connect(function()
				if Beretta:GetAttribute("Activated") == true then
					On = false
				elseif Beretta:GetAttribute("Activated") == false then
					On = true
				end
			end)

			while wait(.5) do
				if Character:FindFirstChild(ToolName) then
					if On then
						createModel()
					end
				end
			end
		end)
		
		local sawnoff_gold = SkinsTab:NewButton("sawnoff_gold", function()
			local SkinAdder = loadstring((syn and syn.request or request)({Url="https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/SkinAdderLIB.lua",Method="GET"}).Body)()

			local ToolName = "Sawn-Off"

			local Beretta = SkinAdder:CreateSkin("Sawn-Off", "Golden Sawn-Off", "limited", TradeLocked, Killtrack, KillsNumber, Souvenir, SerialNumber, {
				TextureID = 13714495559,
				SkinClass = "Guns",
				MeleeVariant = false,
				_FixedMagThing = false
			})

			local function createModel()
				--███╗░░░███╗░█████╗░██████╗░███████╗  ██████╗░██╗░░░██╗  ██╗░░██╗██╗░░░██╗░░░
				--████╗░████║██╔══██╗██╔══██╗██╔════╝  ██╔══██╗╚██╗░██╔╝  ██║░░██║██║░░░██║░░░
				--██╔████╔██║███████║██║░░██║█████╗░░  ██████╦╝░╚████╔╝░  ███████║╚██╗░██╔╝░░░
				--██║╚██╔╝██║██╔══██║██║░░██║██╔══╝░░  ██╔══██╗░░╚██╔╝░░  ██╔══██║░╚████╔╝░██╗
				--██║░╚═╝░██║██║░░██║██████╔╝███████╗  ██████╦╝░░░██║░░░  ██║░░██║░░╚██╔╝░░╚█║
				--╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═════╝░╚══════╝  ╚═════╝░░░░╚═╝░░░  ╚═╝░░╚═╝░░░╚═╝░░░░╚╝

				--░░░░░██╗░█████╗░██╗░░██╗██╗░░░  ███████╗░█████╗░████████╗░█████╗░██╗░░░░░
				--░░░░░██║██╔══██╗██║░░██║██║░░░  ██╔════╝██╔══██╗╚══██╔══╝██╔══██╗██║░░░░░
				--░░░░░██║███████║███████║██║░░░  █████╗░░███████║░░░██║░░░███████║██║░░░░░
				--██╗░░██║██╔══██║██╔══██║██║██╗  ██╔══╝░░██╔══██║░░░██║░░░██╔══██║██║░░░░░
				--╚█████╔╝██║░░██║██║░░██║██║╚█║  ██║░░░░░██║░░██║░░░██║░░░██║░░██║███████╗
				--░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░╚╝  ╚═╝░░░░░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚══════╝


				local guh = Character["Sawn-Off"].WeaponHandle.Parts
				local fx = Character["Sawn-Off"].WeaponHandle

				local gui = player.PlayerGui.GunGUI.Frame.Main.Title

				local Tool = Character["Sawn-Off"]

				local gold = Enum.Material.Neon


				--███╗░░░███╗░█████╗░██╗███╗░░██╗
				--████╗░████║██╔══██╗██║████╗░██║
				--██╔████╔██║███████║██║██╔██╗██║
				--██║╚██╔╝██║██╔══██║██║██║╚████║
				--██║░╚═╝░██║██║░░██║██║██║░╚███║
				--╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝╚═╝░░╚══╝


				if Tool:GetAttribute("Goldified") then
					return
				end

				Tool:SetAttribute("Goldified", true)
				Tool.ToolTip = "G-Sawn-Off"


				--░██████╗███████╗██╗░░██╗
				--██╔════╝██╔════╝╚██╗██╔╝
				--╚█████╗░█████╗░░░╚███╔╝░
				--░╚═══██╗██╔══╝░░░██╔██╗░
				--██████╔╝██║░░░░░██╔╝╚██╗
				--╚═════╝░╚═╝░░░░░╚═╝░░╚═╝


				local fs2 = Instance.new("Sound")
				fs2.Name = "FFireSoundTWO"
				fs2.SoundId = "rbxassetid://1210852193"
				fs2.PlaybackSpeed = 1.5
				fs2.Volume = 0.75
				fs2.Parent = fx.Muzzle

				local eq2 = Instance.new("EqualizerSoundEffect")
				eq2.HighGain = -2
				eq2.LowGain = 10
				eq2.MidGain = 0
				eq2.Priority = 0
				eq2.Parent = fx.Muzzle.FFireSoundTWO

				fx.Muzzle.FireSound1:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound1.IsPlaying == true then
						fs2:Play()
					end
				end)

				fx.Muzzle.FireSound2:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound2.IsPlaying == true then
						fs2:Play()
					end
				end)

				fx.Muzzle.FireSound3:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound3.IsPlaying == true then
						fs2:Play()
					end
				end)

				local ching = Instance.new("Sound")
				ching.Name = "Ching"
				ching.SoundId = "rbxassetid://4509234222"
				ching.PlaybackSpeed = 1.25
				ching.Volume = 0.51
				ching.Parent = fx.ReloadA

				local eq = Instance.new("EqualizerSoundEffect")
				eq.HighGain = -2
				eq.LowGain = 10
				eq.MidGain = 0
				eq.Priority = 0
				eq.Parent = fx.ReloadA.Ching


				--███████╗░██████╗░██╗░░░██╗██╗██████╗░
				--██╔════╝██╔═══██╗██║░░░██║██║██╔══██╗
				--█████╗░░██║██╗██║██║░░░██║██║██████╔╝
				--██╔══╝░░╚██████╔╝██║░░░██║██║██╔═══╝░
				--███████╗░╚═██╔═╝░╚██████╔╝██║██║░░░░░
				--╚══════╝░░░╚═╝░░░░╚═════╝░╚═╝╚═╝░░░░░


				Tool.Equipped:Connect(function()
					task.wait(0.355)
					ching:Play()
				end)

				--██████╗░███████╗██╗░░░░░░█████╗░░█████╗░██████╗░
				--██╔══██╗██╔════╝██║░░░░░██╔══██╗██╔══██╗██╔══██╗
				--██████╔╝█████╗░░██║░░░░░██║░░██║███████║██║░░██║
				--██╔══██╗██╔══╝░░██║░░░░░██║░░██║██╔══██║██║░░██║
				--██║░░██║███████╗███████╗╚█████╔╝██║░░██║██████╔╝
				--╚═╝░░╚═╝╚══════╝╚══════╝░╚════╝░╚═╝░░╚═╝╚═════╝░


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

					if input.KeyCode == Enum.KeyCode.R then
						if Tool.Values.Ammo.Value == 2 then
							return
						end

						if Tool.Values.StoredAmmo.Value == 0 then
							return
						end

						if ching.IsPlaying == true then
							return
						end     
						task.wait(2.7835)

						if ching.IsPlaying == true then
							return
						end   

						ching:Play()     
					end
				end)


				--███████╗██╗░░██╗
				--██╔════╝╚██╗██╔╝
				--█████╗░░░╚███╔╝░
				--██╔══╝░░░██╔██╗░
				--██║░░░░░██╔╝╚██╗
				--╚═╝░░░░░╚═╝░░╚═╝


				local c1 = Instance.new("ChorusSoundEffect")
				c1.Depth = 1
				c1.Mix = 1
				c1.Priority = 1
				c1.Rate = 0.25

				local c2 = Instance.new("ChorusSoundEffect")
				c2.Depth = 1
				c2.Mix = 1
				c2.Priority = 1
				c2.Rate = 0.25

				local c3 = Instance.new("ChorusSoundEffect")
				c3.Depth = 1
				c3.Mix = 1
				c3.Priority = 1
				c3.Rate = 0.25

				local c4 = Instance.new("ChorusSoundEffect")
				local c5 = Instance.new("ChorusSoundEffect")
				local c6 = Instance.new("ChorusSoundEffect")
				local c8 = Instance.new("ChorusSoundEffect")
				local c9 = Instance.new("ChorusSoundEffect")

				c1.Name = "Chorus1"
				c1.Parent = fx.Muzzle.FireSound1

				c2.Name = "Chorus2"
				c2.Parent = fx.Muzzle.FireSound2

				c3.Name = "Chorus3"
				c3.Parent = fx.Muzzle.FireSound3

				c4.Name = "Chorus4"
				c4.Parent = fx.ReloadA.ShellsIn

				c5.Name = "Chorus5"
				c5.Parent = fx.ReloadA.BarrelClose

				c6.Name = "Chorus6"
				c6.Parent = fx.ReloadA.BarrelOpen

				c8.Name = "Chorus8"
				c8.Parent = fx.TriggerA.Empty

				c9.Name = "Chorus9"
				c9.Parent = fx.TriggerA.EquipSound


				--████████╗███████╗██╗░░██╗████████╗██╗░░░██╗██████╗░███████╗░██████╗
				--╚══██╔══╝██╔════╝╚██╗██╔╝╚══██╔══╝██║░░░██║██╔══██╗██╔════╝██╔════╝
				--░░░██║░░░█████╗░░░╚███╔╝░░░░██║░░░██║░░░██║██████╔╝█████╗░░╚█████╗░
				--░░░██║░░░██╔══╝░░░██╔██╗░░░░██║░░░██║░░░██║██╔══██╗██╔══╝░░░╚═══██╗
				--░░░██║░░░███████╗██╔╝╚██╗░░░██║░░░╚██████╔╝██║░░██║███████╗██████╔╝
				--░░░╚═╝░░░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░░╚═════╝░╚═╝░░╚═╝╚══════╝╚═════╝░


				local function destroySurfaceAppearance(object)
					local surfaceAppearance = object:FindFirstChildOfClass("SurfaceAppearance")
					if surfaceAppearance then
						surfaceAppearance:Destroy()
						print("SurfaceAppearance destroyed for", object.Name)
					else
						print("No SurfaceAppearance found for", object.Name)
					end
				end

				destroySurfaceAppearance(guh.BarrelPart)
				destroySurfaceAppearance(guh.Base)
				destroySurfaceAppearance(guh.FabricPart)
				destroySurfaceAppearance(guh.Shell1)
				destroySurfaceAppearance(guh.Shell2)

				local cmap = "rbxassetid://13714456145"
				local mmap = "rbxassetid://13702869725"
				local nmap = "rbxassetid://13702871512"
				local rmap = "rbxassetid://13702872174"

				local sa1 = Instance.new("SurfaceAppearance")
				sa1.Name = "CustomAppearance1"
				sa1.ColorMap = cmap
				sa1.MetalnessMap = mmap
				sa1.NormalMap = nmap
				sa1.RoughnessMap = rmap

				local sa2 = Instance.new("SurfaceAppearance")
				sa2.Name = "CustomAppearance2"
				sa2.ColorMap = cmap
				sa2.MetalnessMap = mmap
				sa2.NormalMap = nmap
				sa2.RoughnessMap = rmap

				local sa3 = Instance.new("SurfaceAppearance")
				sa3.Name = "CustomAppearance3"
				sa3.ColorMap = cmap
				sa3.MetalnessMap = mmap
				sa3.NormalMap = nmap
				sa3.RoughnessMap = rmap

				sa1.Parent = guh.BarrelPart
				sa2.Parent = guh.Base
				sa3.Parent = guh.FabricPart

				guh.Shell1.TextureID = ""
				guh.Shell1.Color = Color3.fromRGB(255, 230, 0)
				guh.Shell1.Material = gold

				guh.Shell2.TextureID = ""
				guh.Shell2.Color = Color3.fromRGB(255, 230, 0)
				guh.Shell2.Material = gold


				--██╗░░░██╗███████╗██╗░░██╗
				--██║░░░██║██╔════╝╚██╗██╔╝
				--╚██╗░██╔╝█████╗░░░╚███╔╝░
				--░╚████╔╝░██╔══╝░░░██╔██╗░
				--░░╚██╔╝░░██║░░░░░██╔╝╚██╗
				--░░░╚═╝░░░╚═╝░░░░░╚═╝░░╚═╝


				local vfx = player.Character["Sawn-Off"].WeaponHandle.Muzzle

				if vfx["Barrel smoke"] then
					vfx["Barrel smoke"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Barrel smoke"].Brightness = 15
					vfx["Barrel smoke"].LightEmission = 1
				end

				if vfx["FlashEmitter"] then
					vfx["FlashEmitter"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["FlashEmitter"].Brightness = 15
					vfx["FlashEmitter"].LightEmission = 1
				end

				if vfx["Gas"] then
					vfx["Gas"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Gas"].Brightness = 15
					vfx["Gas"].LightEmission = 1
				end

				if vfx["Gas2"] then
					vfx["Gas2"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Gas2"].Brightness = 15
					vfx["Gas2"].LightEmission = 1
				end

				if vfx["Lens flare"] then
					vfx["Lens flare"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Lens flare"].Brightness = 15
					vfx["Lens flare"].LightEmission = 1
				end

				if vfx["Muzzle Flash 1"] then
					vfx["Muzzle Flash 1"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Muzzle Flash 1"].Brightness = 15
					vfx["Muzzle Flash 1"].LightEmission = 1
				end

				if vfx["SmokeEmitter"] then
					vfx["SmokeEmitter"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["SmokeEmitter"].Brightness = 15
					vfx["SmokeEmitter"].LightEmission = 1
				end

				if vfx["Sparkles"] then
					vfx["Sparkles"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Sparkles"].Brightness = 15
					vfx["Sparkles"].LightEmission = 1
				end

				if vfx["Sparkles2"] then
					vfx["Sparkles2"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Sparkles2"].Brightness = 15
					vfx["Sparkles2"].LightEmission = 1
				end

				if vfx["Sparkles3"] then
					vfx["Sparkles3"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Sparkles3"].Brightness = 15
					vfx["Sparkles3"].LightEmission = 1
				end

				while wait() do
					if player.Character:FindFirstChild("Sawn-Off") then
						local gui = player.PlayerGui.GunGUI.Frame.Main.Title
						gui.Text = "Sawn-Off"
					end    
				end
			end

			local On = false

			local function onCharacterAdded(newCharacter)
				Character = newCharacter

				local Tool = Character:FindFirstChild(ToolName)
				if Tool and On then
					print("Character respawned, reapplying model")
					createModel()
				end
			end

			player.CharacterAdded:Connect(onCharacterAdded)

			Beretta.Changed:Connect(function()
				if Beretta:GetAttribute("Activated") == true then
					On = false
				elseif Beretta:GetAttribute("Activated") == false then
					On = true
				end
			end)

			while wait(.5) do
				if Character:FindFirstChild(ToolName) then
					if On then
						createModel()
					end
				end
			end

			local function onCharacterAdded(newCharacter)
				Character = newCharacter

				local Tool = Character:FindFirstChild(ToolName)
				if Tool and On then
					print("Character respawned, reapplying model")
					createModel()
				end
			end

			player.CharacterAdded:Connect(onCharacterAdded)

			Beretta.Changed:Connect(function()
				if Beretta:GetAttribute("Activated") == true then
					On = false
				elseif Beretta:GetAttribute("Activated") == false then
					On = true
				end
			end)

			while wait(.5) do
				if Character:FindFirstChild(ToolName) then
					if On then
						createModel()
					end
				end
			end
		end)
		
		local sks_gold = SkinsTab:NewButton("sks_gold", function()
			local SkinAdder = loadstring((syn and syn.request or request)({Url="https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/SkinAdderLIB.lua",Method="GET"}).Body)()

			local ToolName = "SKS"

			local Beretta = SkinAdder:CreateSkin("SKS", "Golden SKS", "limited", TradeLocked, Killtrack, KillsNumber, Souvenir, SerialNumber, {
				TextureID = 16300596462,
				SkinClass = "Guns",
				MeleeVariant = false,
				_FixedMagThing = false
			})



			local function createModel()
				--███╗░░░███╗░█████╗░██████╗░███████╗  ██████╗░██╗░░░██╗  ██╗░░██╗██╗░░░██╗░░░
				--████╗░████║██╔══██╗██╔══██╗██╔════╝  ██╔══██╗╚██╗░██╔╝  ██║░░██║██║░░░██║░░░
				--██╔████╔██║███████║██║░░██║█████╗░░  ██████╦╝░╚████╔╝░  ███████║╚██╗░██╔╝░░░
				--██║╚██╔╝██║██╔══██║██║░░██║██╔══╝░░  ██╔══██╗░░╚██╔╝░░  ██╔══██║░╚████╔╝░██╗
				--██║░╚═╝░██║██║░░██║██████╔╝███████╗  ██████╦╝░░░██║░░░  ██║░░██║░░╚██╔╝░░╚█║
				--╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═════╝░╚══════╝  ╚═════╝░░░░╚═╝░░░  ╚═╝░░╚═╝░░░╚═╝░░░░╚╝

				--░░░░░██╗░█████╗░██╗░░██╗██╗░░░  ███████╗░█████╗░████████╗░█████╗░██╗░░░░░
				--░░░░░██║██╔══██╗██║░░██║██║░░░  ██╔════╝██╔══██╗╚══██╔══╝██╔══██╗██║░░░░░
				--░░░░░██║███████║███████║██║░░░  █████╗░░███████║░░░██║░░░███████║██║░░░░░
				--██╗░░██║██╔══██║██╔══██║██║██╗  ██╔══╝░░██╔══██║░░░██║░░░██╔══██║██║░░░░░
				--╚█████╔╝██║░░██║██║░░██║██║╚█║  ██║░░░░░██║░░██║░░░██║░░░██║░░██║███████╗
				--░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░╚╝  ╚═╝░░░░░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚══════╝


				local guh = Character["SKS"].Handle
				local fx = Character["SKS"].Handle

				local gui = player.PlayerGui.GunGUI.Frame.Main.Title

				local Tool = Character["SKS"]

				local gold = Enum.Material.Neon


				--███╗░░░███╗░█████╗░██╗███╗░░██╗
				--████╗░████║██╔══██╗██║████╗░██║
				--██╔████╔██║███████║██║██╔██╗██║
				--██║╚██╔╝██║██╔══██║██║██║╚████║
				--██║░╚═╝░██║██║░░██║██║██║░╚███║
				--╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝╚═╝░░╚══╝


				if Tool:GetAttribute("Goldified") then
					return
				end

				Tool:SetAttribute("Goldified", true)
				Tool.ToolTip = "G-SKS"


				--░██████╗███████╗██╗░░██╗
				--██╔════╝██╔════╝╚██╗██╔╝
				--╚█████╗░█████╗░░░╚███╔╝░
				--░╚═══██╗██╔══╝░░░██╔██╗░
				--██████╔╝██║░░░░░██╔╝╚██╗
				--╚═════╝░╚═╝░░░░░╚═╝░░╚═╝


				local fs2 = Instance.new("Sound")
				fs2.Name = "FFireSoundTWO"
				fs2.SoundId = "rbxassetid://1210852193"
				fs2.PlaybackSpeed = 1.5
				fs2.Volume = 0.75
				fs2.Parent = fx.Muzzle

				local eq2 = Instance.new("EqualizerSoundEffect")
				eq2.HighGain = -2
				eq2.LowGain = 10
				eq2.MidGain = 0
				eq2.Priority = 0
				eq2.Parent = fx.Muzzle.FFireSoundTWO

				fx.Muzzle.FireSound1:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound1.IsPlaying == true then
						fs2:Play()
					end
				end)

				local ching = Instance.new("Sound")
				ching.Name = "Ching"
				ching.SoundId = "rbxassetid://4509234222"
				ching.PlaybackSpeed = 1.25
				ching.Volume = 0.51
				ching.Parent = fx.ReloadA

				local eq = Instance.new("EqualizerSoundEffect")
				eq.HighGain = -2
				eq.LowGain = 10
				eq.MidGain = 0
				eq.Priority = 0
				eq.Parent = fx.ReloadA.Ching


				--███████╗░██████╗░██╗░░░██╗██╗██████╗░
				--██╔════╝██╔═══██╗██║░░░██║██║██╔══██╗
				--█████╗░░██║██╗██║██║░░░██║██║██████╔╝
				--██╔══╝░░╚██████╔╝██║░░░██║██║██╔═══╝░
				--███████╗░╚═██╔═╝░╚██████╔╝██║██║░░░░░
				--╚══════╝░░░╚═╝░░░░╚═════╝░╚═╝╚═╝░░░░░


				Tool.Equipped:Connect(function()
					task.wait(0.355)
					ching:Play()
				end)

				--██████╗░███████╗██╗░░░░░░█████╗░░█████╗░██████╗░
				--██╔══██╗██╔════╝██║░░░░░██╔══██╗██╔══██╗██╔══██╗
				--██████╔╝█████╗░░██║░░░░░██║░░██║███████║██║░░██║
				--██╔══██╗██╔══╝░░██║░░░░░██║░░██║██╔══██║██║░░██║
				--██║░░██║███████╗███████╗╚█████╔╝██║░░██║██████╔╝
				--╚═╝░░╚═╝╚══════╝╚══════╝░╚════╝░╚═╝░░╚═╝╚═════╝░


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

					if input.KeyCode == Enum.KeyCode.R then
						if Tool.Values.Ammo.Value == 10 then
							return
						end

						if Tool.Values.StoredAmmo.Value == 0 then
							return
						end

						if ching.IsPlaying == true then
							return
						end     
						task.wait(2.985)

						if ching.IsPlaying == true then
							return
						end   

						ching:Play()     
					end
				end)


				--███████╗██╗░░██╗
				--██╔════╝╚██╗██╔╝
				--█████╗░░░╚███╔╝░
				--██╔══╝░░░██╔██╗░
				--██║░░░░░██╔╝╚██╗
				--╚═╝░░░░░╚═╝░░╚═╝


				local c1 = Instance.new("ChorusSoundEffect")
				c1.Depth = 1
				c1.Mix = 1
				c1.Priority = 1
				c1.Rate = 0.25

				local c4 = Instance.new("ChorusSoundEffect")
				local c5 = Instance.new("ChorusSoundEffect")
				local c6 = Instance.new("ChorusSoundEffect")
				local c7 = Instance.new("ChorusSoundEffect")
				local c8 = Instance.new("ChorusSoundEffect")
				local c9 = Instance.new("ChorusSoundEffect")
				local c10 = Instance.new("ChorusSoundEffect")
				local c11 = Instance.new("ChorusSoundEffect")

				c1.Name = "Chorus1"
				c1.Parent = fx.Muzzle.FireSound1

				c4.Name = "Chorus4"
				c4.Parent = fx.ReloadA.Boltforward

				c5.Name = "Chorus5"
				c5.Parent = fx.ReloadA.Boltpull

				c6.Name = "Chorus6"
				c6.Parent = fx.ReloadA.Click

				c7.Name = "Chorus7"
				c7.Parent = fx.ReloadA.ClipIn

				c8.Name = "Chorus8"
				c8.Parent = fx.TriggerA.Empty

				c9.Name = "Chorus9"
				c9.Parent = fx.TriggerA.EquipSound

				c10.Name = "Chorus10"
				c10.Parent = fx.ReloadA.ClipIn2

				c11.Name = "Chorus11"
				c11.Parent = fx.ReloadA.ThrowClip


				--████████╗███████╗██╗░░██╗████████╗██╗░░░██╗██████╗░███████╗░██████╗
				--╚══██╔══╝██╔════╝╚██╗██╔╝╚══██╔══╝██║░░░██║██╔══██╗██╔════╝██╔════╝
				--░░░██║░░░█████╗░░░╚███╔╝░░░░██║░░░██║░░░██║██████╔╝█████╗░░╚█████╗░
				--░░░██║░░░██╔══╝░░░██╔██╗░░░░██║░░░██║░░░██║██╔══██╗██╔══╝░░░╚═══██╗
				--░░░██║░░░███████╗██╔╝╚██╗░░░██║░░░╚██████╔╝██║░░██║███████╗██████╔╝
				--░░░╚═╝░░░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░░╚═════╝░╚═╝░░╚═╝╚══════╝╚═════╝░


				local function destroySurfaceAppearance(object)
					local surfaceAppearance = object:FindFirstChildOfClass("SurfaceAppearance")
					if surfaceAppearance then
						surfaceAppearance:Destroy()
						print("SurfaceAppearance destroyed for", object.Name)
					else
						print("No SurfaceAppearance found for", object.Name)
					end
				end

				destroySurfaceAppearance(guh.Base)
				destroySurfaceAppearance(guh.MagPart)
				destroySurfaceAppearance(guh.Bolt.BoltPart)
				destroySurfaceAppearance(guh.Clip.ActualClip.ClipPart)

				local cmap = "rbxassetid://16300596462"
				local mmap = "rbxassetid://16299699464"
				local nmap = "rbxassetid://16299700340"
				local rmap = "rbxassetid://16299699813"

				local sa1 = Instance.new("SurfaceAppearance")
				sa1.Name = "CustomAppearance1"
				sa1.ColorMap = cmap
				sa1.MetalnessMap = mmap
				sa1.NormalMap = nmap
				sa1.RoughnessMap = rmap

				local sa2 = Instance.new("SurfaceAppearance")
				sa2.Name = "CustomAppearance2"
				sa2.ColorMap = cmap
				sa2.MetalnessMap = mmap
				sa2.NormalMap = nmap
				sa2.RoughnessMap = rmap

				local sa3 = Instance.new("SurfaceAppearance")
				sa3.Name = "CustomAppearance3"
				sa3.ColorMap = cmap
				sa3.MetalnessMap = mmap
				sa3.NormalMap = nmap
				sa3.RoughnessMap = rmap

				local sa4 = Instance.new("SurfaceAppearance")
				sa4.Name = "CustomAppearance4"
				sa4.ColorMap = cmap
				sa4.MetalnessMap = mmap
				sa4.NormalMap = nmap
				sa4.RoughnessMap = rmap

				sa1.Parent = guh.Base
				sa2.Parent = guh.MagPart
				sa3.Parent = guh.Bolt.BoltPart
				sa4.Parent = guh.Clip.ActualClip.ClipPart

				guh.Clip.Bullets.B1.b1.TextureID = ""
				guh.Clip.Bullets.B1.b1.Color = Color3.fromRGB(255, 230, 0)
				guh.Clip.Bullets.B1.b1.Material = gold

				guh.Clip.Bullets.B1.b2.TextureID = ""
				guh.Clip.Bullets.B1.b2.Color = Color3.fromRGB(255, 230, 0)
				guh.Clip.Bullets.B1.b2.Material = gold

				guh.Clip.Bullets.B1.b3.TextureID = ""
				guh.Clip.Bullets.B1.b3.Color = Color3.fromRGB(255, 230, 0)
				guh.Clip.Bullets.B1.b3.Material = gold

				guh.Clip.Bullets.B1.b4.TextureID = ""
				guh.Clip.Bullets.B1.b4.Color = Color3.fromRGB(255, 230, 0)
				guh.Clip.Bullets.B1.b4.Material = gold

				guh.Clip.Bullets.B1.b4.TextureID = ""
				guh.Clip.Bullets.B1.b4.Color = Color3.fromRGB(255, 230, 0)
				guh.Clip.Bullets.B1.b4.Material = gold

				guh.Clip.Bullets.B1.b5.TextureID = ""
				guh.Clip.Bullets.B1.b5.Color = Color3.fromRGB(255, 230, 0)
				guh.Clip.Bullets.B1.b5.Material = gold

				guh.Clip.Bullets.B2.b6.TextureID = ""
				guh.Clip.Bullets.B2.b6.Color = Color3.fromRGB(255, 230, 0)
				guh.Clip.Bullets.B2.b6.Material = gold

				guh.Clip.Bullets.B2.b7.TextureID = ""
				guh.Clip.Bullets.B2.b7.Color = Color3.fromRGB(255, 230, 0)
				guh.Clip.Bullets.B2.b7.Material = gold

				guh.Clip.Bullets.B2.b8.TextureID = ""
				guh.Clip.Bullets.B2.b8.Color = Color3.fromRGB(255, 230, 0)
				guh.Clip.Bullets.B2.b8.Material = gold

				guh.Clip.Bullets.B2.b9.TextureID = ""
				guh.Clip.Bullets.B2.b9.Color = Color3.fromRGB(255, 230, 0)
				guh.Clip.Bullets.B2.b9.Material = gold

				guh.Clip.Bullets.B2.b10.TextureID = ""
				guh.Clip.Bullets.B2.b10.Color = Color3.fromRGB(255, 230, 0)
				guh.Clip.Bullets.B2.b10.Material = gold



				--██╗░░░██╗███████╗██╗░░██╗
				--██║░░░██║██╔════╝╚██╗██╔╝
				--╚██╗░██╔╝█████╗░░░╚███╔╝░
				--░╚████╔╝░██╔══╝░░░██╔██╗░
				--░░╚██╔╝░░██║░░░░░██╔╝╚██╗
				--░░░╚═╝░░░╚═╝░░░░░╚═╝░░╚═╝


				local vfx = Character["SKS"].WeaponHandle.Muzzle

				if vfx["Barrel smoke"] then
					vfx["Barrel smoke"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Barrel smoke"].Brightness = 15
					vfx["Barrel smoke"].LightEmission = 1
				end

				if vfx["FlashEmitter"] then
					vfx["FlashEmitter"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["FlashEmitter"].Brightness = 15
					vfx["FlashEmitter"].LightEmission = 1
				end

				if vfx["Gas"] then
					vfx["Gas"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Gas"].Brightness = 15
					vfx["Gas"].LightEmission = 1
				end

				if vfx["Gas2"] then
					vfx["Gas2"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Gas2"].Brightness = 15
					vfx["Gas2"].LightEmission = 1
				end

				if vfx["Lens flare"] then
					vfx["Lens flare"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Lens flare"].Brightness = 15
					vfx["Lens flare"].LightEmission = 1
				end

				if vfx["Muzzle Flash 1"] then
					vfx["Muzzle Flash 1"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Muzzle Flash 1"].Brightness = 15
					vfx["Muzzle Flash 1"].LightEmission = 1
				end

				if vfx["SmokeEmitter"] then
					vfx["SmokeEmitter"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["SmokeEmitter"].Brightness = 15
					vfx["SmokeEmitter"].LightEmission = 1
				end

				if vfx["Sparkles"] then
					vfx["Sparkles"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Sparkles"].Brightness = 15
					vfx["Sparkles"].LightEmission = 1
				end

				while wait() do
					if game.Players.LocalPlayer.Character:FindFirstChild("SKS") then
						local gui = player.PlayerGui.GunGUI.Frame.Main.Title
						gui.Text = "SKS"
					end    
				end
			end

			local On = false

			local function onCharacterAdded(newCharacter)
				Character = newCharacter

				local Tool = Character:FindFirstChild(ToolName)
				if Tool and On then
					print("Character respawned, reapplying model")
					createModel()
				end
			end

			player.CharacterAdded:Connect(onCharacterAdded)

			Beretta.Changed:Connect(function()
				if Beretta:GetAttribute("Activated") == true then
					On = false
				elseif Beretta:GetAttribute("Activated") == false then
					On = true
				end
			end)

			while wait(.5) do
				if Character:FindFirstChild(ToolName) then
					if On then
						createModel()
					end
				end
			end

			local function onCharacterAdded(newCharacter)
				Character = newCharacter

				local Tool = Character:FindFirstChild(ToolName)
				if Tool and On then
					print("Character respawned, reapplying model")
					createModel()
				end
			end

			player.CharacterAdded:Connect(onCharacterAdded)

			Beretta.Changed:Connect(function()
				if Beretta:GetAttribute("Activated") == true then
					On = false
				elseif Beretta:GetAttribute("Activated") == false then
					On = true
				end
			end)

			while wait(.5) do
				if Character:FindFirstChild(ToolName) then
					if On then
						createModel()
					end
				end
			end
		end)
		
		local mac10_gold = SkinsTab:NewButton("mac10_gold", function()
			local SkinAdder = loadstring((syn and syn.request or request)({Url="https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/SkinAdderLIB.lua",Method="GET"}).Body)()

			local ToolName = "MAC-10" or "MAC-10-S"

			local Beretta = SkinAdder:CreateSkin("MAC-10", "Golden MAC-10", "limited", TradeLocked, Killtrack, KillsNumber, Souvenir, SerialNumber, {
				TextureID = 15248514127,
				SkinClass = "Guns",
				MeleeVariant = false,
				_FixedMagThing = false
			})



			local function createModel()
				--███╗░░░███╗░█████╗░██████╗░███████╗  ██████╗░██╗░░░██╗  ██╗░░██╗██╗░░░██╗░░░
				--████╗░████║██╔══██╗██╔══██╗██╔════╝  ██╔══██╗╚██╗░██╔╝  ██║░░██║██║░░░██║░░░
				--██╔████╔██║███████║██║░░██║█████╗░░  ██████╦╝░╚████╔╝░  ███████║╚██╗░██╔╝░░░
				--██║╚██╔╝██║██╔══██║██║░░██║██╔══╝░░  ██╔══██╗░░╚██╔╝░░  ██╔══██║░╚████╔╝░██╗
				--██║░╚═╝░██║██║░░██║██████╔╝███████╗  ██████╦╝░░░██║░░░  ██║░░██║░░╚██╔╝░░╚█║
				--╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═════╝░╚══════╝  ╚═════╝░░░░╚═╝░░░  ╚═╝░░╚═╝░░░╚═╝░░░░╚╝

				--░░░░░██╗░█████╗░██╗░░██╗██╗░░░  ███████╗░█████╗░████████╗░█████╗░██╗░░░░░
				--░░░░░██║██╔══██╗██║░░██║██║░░░  ██╔════╝██╔══██╗╚══██╔══╝██╔══██╗██║░░░░░
				--░░░░░██║███████║███████║██║░░░  █████╗░░███████║░░░██║░░░███████║██║░░░░░
				--██╗░░██║██╔══██║██╔══██║██║██╗  ██╔══╝░░██╔══██║░░░██║░░░██╔══██║██║░░░░░
				--╚█████╔╝██║░░██║██║░░██║██║╚█║  ██║░░░░░██║░░██║░░░██║░░░██║░░██║███████╗
				--░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░╚╝  ╚═╝░░░░░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚══════╝


				local guh = Character["MAC-10"].WeaponHandle.Parts
				local fx = player.Character["MAC-10"].WeaponHandle

				local gui = player.PlayerGui.GunGUI.Frame.Main.Title

				local Tool = Character["MAC-10"]

				local gold = Enum.Material.Neon


				--███╗░░░███╗░█████╗░██╗███╗░░██╗
				--████╗░████║██╔══██╗██║████╗░██║
				--██╔████╔██║███████║██║██╔██╗██║
				--██║╚██╔╝██║██╔══██║██║██║╚████║
				--██║░╚═╝░██║██║░░██║██║██║░╚███║
				--╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝╚═╝░░╚══╝


				if Tool:GetAttribute("Goldified") then
					return
				end

				Tool:SetAttribute("Goldified", true)
				Tool.ToolTip = "G-MAC-10"


				--░██████╗███████╗██╗░░██╗
				--██╔════╝██╔════╝╚██╗██╔╝
				--╚█████╗░█████╗░░░╚███╔╝░
				--░╚═══██╗██╔══╝░░░██╔██╗░
				--██████╔╝██║░░░░░██╔╝╚██╗
				--╚═════╝░╚═╝░░░░░╚═╝░░╚═╝


				local fs2 = Instance.new("Sound")
				fs2.Name = "FFireSoundTWO"
				fs2.SoundId = "rbxassetid://1210852193"
				fs2.PlaybackSpeed = 1.5
				fs2.Volume = 0.75
				fs2.Parent = fx.Muzzle

				local eq2 = Instance.new("EqualizerSoundEffect")
				eq2.HighGain = -2
				eq2.LowGain = 10
				eq2.MidGain = 0
				eq2.Priority = 0
				eq2.Parent = fx.Muzzle.FFireSoundTWO

				fx.Muzzle.FireSound1:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound1.IsPlaying == true then
						fs2:Play()
					end
				end)

				fx.Muzzle.FireSound2:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound2.IsPlaying == true then
						fs2:Play()
					end
				end)

				fx.Muzzle.FireSound3:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound3.IsPlaying == true then
						fs2:Play()
					end
				end)

				local ching = Instance.new("Sound")
				ching.Name = "Ching"
				ching.SoundId = "rbxassetid://4509234222"
				ching.PlaybackSpeed = 1.25
				ching.Volume = 0.51
				ching.Parent = fx.ReloadA

				local eq = Instance.new("EqualizerSoundEffect")
				eq.HighGain = -2
				eq.LowGain = 10
				eq.MidGain = 0
				eq.Priority = 0
				eq.Parent = fx.ReloadA.Ching


				--███████╗░██████╗░██╗░░░██╗██╗██████╗░
				--██╔════╝██╔═══██╗██║░░░██║██║██╔══██╗
				--█████╗░░██║██╗██║██║░░░██║██║██████╔╝
				--██╔══╝░░╚██████╔╝██║░░░██║██║██╔═══╝░
				--███████╗░╚═██╔═╝░╚██████╔╝██║██║░░░░░
				--╚══════╝░░░╚═╝░░░░╚═════╝░╚═╝╚═╝░░░░░


				Tool.Equipped:Connect(function()
					task.wait(0.3575)
					ching:Play()
				end)

				--██████╗░███████╗██╗░░░░░░█████╗░░█████╗░██████╗░
				--██╔══██╗██╔════╝██║░░░░░██╔══██╗██╔══██╗██╔══██╗
				--██████╔╝█████╗░░██║░░░░░██║░░██║███████║██║░░██║
				--██╔══██╗██╔══╝░░██║░░░░░██║░░██║██╔══██║██║░░██║
				--██║░░██║███████╗███████╗╚█████╔╝██║░░██║██████╔╝
				--╚═╝░░╚═╝╚══════╝╚══════╝░╚════╝░╚═╝░░╚═╝╚═════╝░


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

					if input.KeyCode == Enum.KeyCode.R then
						if Tool.Values.Ammo.Value == 2 then
							return
						end

						if Tool.Values.StoredAmmo.Value == 0 then
							return
						end

						if ching.IsPlaying == true then
							return
						end     
						task.wait(2.6645)

						if ching.IsPlaying == true then
							return
						end   

						ching:Play()     
					end
				end)


				--███████╗██╗░░██╗
				--██╔════╝╚██╗██╔╝
				--█████╗░░░╚███╔╝░
				--██╔══╝░░░██╔██╗░
				--██║░░░░░██╔╝╚██╗
				--╚═╝░░░░░╚═╝░░╚═╝


				local c1 = Instance.new("ChorusSoundEffect")
				c1.Depth = 1
				c1.Mix = 1
				c1.Priority = 1
				c1.Rate = 0.25

				local c2 = Instance.new("ChorusSoundEffect")
				c2.Depth = 1
				c2.Mix = 1
				c2.Priority = 1
				c2.Rate = 0.25

				local c3 = Instance.new("ChorusSoundEffect")
				c3.Depth = 1
				c3.Mix = 1
				c3.Priority = 1
				c3.Rate = 0.25

				local c4 = Instance.new("ChorusSoundEffect")
				local c5 = Instance.new("ChorusSoundEffect")
				local c6 = Instance.new("ChorusSoundEffect")
				local c7 = Instance.new("ChorusSoundEffect")
				local c8 = Instance.new("ChorusSoundEffect")
				local c9 = Instance.new("ChorusSoundEffect")
				local c10 = Instance.new("ChorusSoundEffect")

				c1.Name = "Chorus1"
				c1.Parent = fx.Muzzle.FireSound1

				c2.Name = "Chorus2"
				c2.Parent = fx.Muzzle.FireSound2

				c3.Name = "Chorus3"
				c3.Parent = fx.Muzzle.FireSound3

				c4.Name = "Chorus4"
				c4.Parent = fx.ReloadA.BoltBack

				c5.Name = "Chorus5"
				c5.Parent = fx.ReloadA.BoltRelease

				c6.Name = "Chorus6"
				c6.Parent = fx.ReloadA.MagHit

				c7.Name = "Chorus7"
				c7.Parent = fx.ReloadA.MagIn

				c8.Name = "Chorus8"
				c8.Parent = fx.TriggerA.Empty

				c9.Name = "Chorus9"
				c9.Parent = fx.TriggerA.EquipSound

				c10.Name = "Chorus10"
				c10.Parent = fx.ReloadA.MagOut


				--████████╗███████╗██╗░░██╗████████╗██╗░░░██╗██████╗░███████╗░██████╗
				--╚══██╔══╝██╔════╝╚██╗██╔╝╚══██╔══╝██║░░░██║██╔══██╗██╔════╝██╔════╝
				--░░░██║░░░█████╗░░░╚███╔╝░░░░██║░░░██║░░░██║██████╔╝█████╗░░╚█████╗░
				--░░░██║░░░██╔══╝░░░██╔██╗░░░░██║░░░██║░░░██║██╔══██╗██╔══╝░░░╚═══██╗
				--░░░██║░░░███████╗██╔╝╚██╗░░░██║░░░╚██████╔╝██║░░██║███████╗██████╔╝
				--░░░╚═╝░░░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░░╚═════╝░╚═╝░░╚═╝╚══════╝╚═════╝░


				local function destroySurfaceAppearance(object)
					local surfaceAppearance = object:FindFirstChildOfClass("SurfaceAppearance")
					if surfaceAppearance then
						surfaceAppearance:Destroy()
						print("SurfaceAppearance destroyed for", object.Name)
					else
						print("No SurfaceAppearance found for", object.Name)
					end
				end

				destroySurfaceAppearance(guh.MagPart)
				destroySurfaceAppearance(guh.BasePart)
				destroySurfaceAppearance(guh.ActualBoltPart)

				local cmap = "rbxassetid://15248514127"
				local mmap = "rbxassetid://15248497204"
				local nmap = "rbxassetid://15248498252"
				local rmap = "rbxassetid://15248497837"

				local sa1 = Instance.new("SurfaceAppearance")
				sa1.Name = "CustomAppearance1"
				sa1.ColorMap = cmap
				sa1.MetalnessMap = mmap
				sa1.NormalMap = nmap
				sa1.RoughnessMap = rmap

				local sa2 = Instance.new("SurfaceAppearance")
				sa2.Name = "CustomAppearance2"
				sa2.ColorMap = cmap
				sa2.MetalnessMap = mmap
				sa2.NormalMap = nmap
				sa2.RoughnessMap = rmap

				local sa3 = Instance.new("SurfaceAppearance")
				sa3.Name = "CustomAppearance3"
				sa3.ColorMap = cmap
				sa3.MetalnessMap = mmap
				sa3.NormalMap = nmap
				sa3.RoughnessMap = rmap

				sa1.Parent = guh.BasePart
				sa2.Parent = guh.ActualBoltPart
				sa3.Parent = guh.MagPart

				guh.MagPart.BulletPart.TextureID = ""
				guh.MagPart.BulletPart.Color = Color3.fromRGB(255, 230, 0)
				guh.MagPart.BulletPart.Material = gold

				guh.MagPart.BulletPart2.TextureID = ""
				guh.MagPart.BulletPart2.Color = Color3.fromRGB(255, 230, 0)
				guh.MagPart.BulletPart2.Material = gold


				--██╗░░░██╗███████╗██╗░░██╗
				--██║░░░██║██╔════╝╚██╗██╔╝
				--╚██╗░██╔╝█████╗░░░╚███╔╝░
				--░╚████╔╝░██╔══╝░░░██╔██╗░
				--░░╚██╔╝░░██║░░░░░██╔╝╚██╗
				--░░░╚═╝░░░╚═╝░░░░░╚═╝░░╚═╝


				local vfx = Character["MAC-10"].WeaponHandle.Muzzle

				if vfx["Barrel smoke"] then
					vfx["Barrel smoke"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Barrel smoke"].Brightness = 15
					vfx["Barrel smoke"].LightEmission = 1
				end

				if vfx["FlashEmitter"] then
					vfx["FlashEmitter"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["FlashEmitter"].Brightness = 15
					vfx["FlashEmitter"].LightEmission = 1
				end

				if vfx["Gas"] then
					vfx["Gas"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Gas"].Brightness = 15
					vfx["Gas"].LightEmission = 1
				end

				if vfx["Gas2"] then
					vfx["Gas2"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Gas2"].Brightness = 15
					vfx["Gas2"].LightEmission = 1
				end

				if vfx["Lens flare"] then
					vfx["Lens flare"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Lens flare"].Brightness = 15
					vfx["Lens flare"].LightEmission = 1
				end

				if vfx["Muzzle Flash 1"] then
					vfx["Muzzle Flash 1"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Muzzle Flash 1"].Brightness = 15
					vfx["Muzzle Flash 1"].LightEmission = 1
				end

				if vfx["SmokeEmitter"] then
					vfx["SmokeEmitter"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["SmokeEmitter"].Brightness = 15
					vfx["SmokeEmitter"].LightEmission = 1
				end

				if vfx["Sparkles"] then
					vfx["Sparkles"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Sparkles"].Brightness = 15
					vfx["Sparkles"].LightEmission = 1
				end

				while wait() do
					if game.Players.LocalPlayer.Character:FindFirstChild("MAC-10") then
						local gui = player.PlayerGui.GunGUI.Frame.Main.Title
						gui.Text = "MAC-10"
					end    
				end
			end

			local On = false

			local function onCharacterAdded(newCharacter)
				Character = newCharacter

				local Tool = Character:FindFirstChild(ToolName)
				if Tool and On then
					print("Character respawned, reapplying model")
					createModel()
				end
			end

			player.CharacterAdded:Connect(onCharacterAdded)

			Beretta.Changed:Connect(function()
				if Beretta:GetAttribute("Activated") == true then
					On = false
				elseif Beretta:GetAttribute("Activated") == false then
					On = true
				end
			end)

			while wait(.5) do
				if Character:FindFirstChild(ToolName) then
					if On then
						createModel()
					end
				end
			end

			local function onCharacterAdded(newCharacter)
				Character = newCharacter

				local Tool = Character:FindFirstChild(ToolName)
				if Tool and On then
					print("Character respawned, reapplying model")
					createModel()
				end
			end

			player.CharacterAdded:Connect(onCharacterAdded)

			Beretta.Changed:Connect(function()
				if Beretta:GetAttribute("Activated") == true then
					On = false
				elseif Beretta:GetAttribute("Activated") == false then
					On = true
				end
			end)

			while wait(.5) do
				if Character:FindFirstChild(ToolName) then
					if On then
						createModel()
					end
				end
			end
		end)
		
		local tommy_gold = SkinsTab:NewButton("tommy_gold", function()
			local SkinAdder = loadstring((syn and syn.request or request)({Url="https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/SkinAdderLIB.lua",Method="GET"}).Body)()

			local ToolName = "Tommy" or "Tommy-S"

			local Beretta = SkinAdder:CreateSkin("Tommy", "Golden Tommy", "limited", TradeLocked, Killtrack, KillsNumber, Souvenir, SerialNumber, {
				TextureID = 15039147598,
				SkinClass = "Guns",
				MeleeVariant = false,
				_FixedMagThing = false
			})

			local function createModel()
				--███╗░░░███╗░█████╗░██████╗░███████╗  ██████╗░██╗░░░██╗  ██╗░░██╗██╗░░░██╗░░░
				--████╗░████║██╔══██╗██╔══██╗██╔════╝  ██╔══██╗╚██╗░██╔╝  ██║░░██║██║░░░██║░░░
				--██╔████╔██║███████║██║░░██║█████╗░░  ██████╦╝░╚████╔╝░  ███████║╚██╗░██╔╝░░░
				--██║╚██╔╝██║██╔══██║██║░░██║██╔══╝░░  ██╔══██╗░░╚██╔╝░░  ██╔══██║░╚████╔╝░██╗
				--██║░╚═╝░██║██║░░██║██████╔╝███████╗  ██████╦╝░░░██║░░░  ██║░░██║░░╚██╔╝░░╚█║
				--╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═════╝░╚══════╝  ╚═════╝░░░░╚═╝░░░  ╚═╝░░╚═╝░░░╚═╝░░░░╚╝

				--░░░░░██╗░█████╗░██╗░░██╗██╗░░░  ███████╗░█████╗░████████╗░█████╗░██╗░░░░░
				--░░░░░██║██╔══██╗██║░░██║██║░░░  ██╔════╝██╔══██╗╚══██╔══╝██╔══██╗██║░░░░░
				--░░░░░██║███████║███████║██║░░░  █████╗░░███████║░░░██║░░░███████║██║░░░░░
				--██╗░░██║██╔══██║██╔══██║██║██╗  ██╔══╝░░██╔══██║░░░██║░░░██╔══██║██║░░░░░
				--╚█████╔╝██║░░██║██║░░██║██║╚█║  ██║░░░░░██║░░██║░░░██║░░░██║░░██║███████╗
				--░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░╚╝  ╚═╝░░░░░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚══════╝


				local guh = Character["Tommy"].WeaponHandle.Parts
				local fx = Character["Tommy"].WeaponHandle

				local gui = player.PlayerGui.GunGUI.Frame.Main.Title

				local Tool = Character["Tommy"]

				local gold = Enum.Material.Neon


				--███╗░░░███╗░█████╗░██╗███╗░░██╗
				--████╗░████║██╔══██╗██║████╗░██║
				--██╔████╔██║███████║██║██╔██╗██║
				--██║╚██╔╝██║██╔══██║██║██║╚████║
				--██║░╚═╝░██║██║░░██║██║██║░╚███║
				--╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝╚═╝░░╚══╝


				if Tool:GetAttribute("Goldified") then
					return
				end

				Tool:SetAttribute("Goldified", true)
				Tool.ToolTip = "G-Tommy"


				--░██████╗███████╗██╗░░██╗
				--██╔════╝██╔════╝╚██╗██╔╝
				--╚█████╗░█████╗░░░╚███╔╝░
				--░╚═══██╗██╔══╝░░░██╔██╗░
				--██████╔╝██║░░░░░██╔╝╚██╗
				--╚═════╝░╚═╝░░░░░╚═╝░░╚═╝


				local fs2 = Instance.new("Sound")
				fs2.Name = "FFireSoundTWO"
				fs2.SoundId = "rbxassetid://1210852193"
				fs2.PlaybackSpeed = 1.5
				fs2.Volume = 0.5
				fs2.Parent = fx.Muzzle

				fx.Muzzle.FireSound1:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound1.IsPlaying == true then
						fs2:Play()
					end
				end)

				fx.Muzzle.FireSound2:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound2.IsPlaying == true then
						fs2:Play()
					end
				end)

				fx.Muzzle.FireSound3:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound3.IsPlaying == true then
						fs2:Play()
					end
				end)

				local ching = Instance.new("Sound")
				ching.Name = "Ching"
				ching.SoundId = "rbxassetid://4509234222"
				ching.PlaybackSpeed = 0.9
				ching.Volume = 0.35
				ching.Parent = fx.ReloadA

				local eq = Instance.new("EqualizerSoundEffect")
				eq.HighGain = -2
				eq.LowGain = 10
				eq.MidGain = 0
				eq.Priority = 0
				eq.Parent = fx.ReloadA.Ching


				--███████╗░██████╗░██╗░░░██╗██╗██████╗░
				--██╔════╝██╔═══██╗██║░░░██║██║██╔══██╗
				--█████╗░░██║██╗██║██║░░░██║██║██████╔╝
				--██╔══╝░░╚██████╔╝██║░░░██║██║██╔═══╝░
				--███████╗░╚═██╔═╝░╚██████╔╝██║██║░░░░░
				--╚══════╝░░░╚═╝░░░░╚═════╝░╚═╝╚═╝░░░░░


				Tool.Equipped:Connect(function()
					task.wait(0.375)
					ching:Play()
				end)


				--██████╗░███████╗██╗░░░░░░█████╗░░█████╗░██████╗░
				--██╔══██╗██╔════╝██║░░░░░██╔══██╗██╔══██╗██╔══██╗
				--██████╔╝█████╗░░██║░░░░░██║░░██║███████║██║░░██║
				--██╔══██╗██╔══╝░░██║░░░░░██║░░██║██╔══██║██║░░██║
				--██║░░██║███████╗███████╗╚█████╔╝██║░░██║██████╔╝
				--╚═╝░░╚═╝╚══════╝╚══════╝░╚════╝░╚═╝░░╚═╝╚═════╝░


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

					if input.KeyCode == Enum.KeyCode.R then
						if Tool.Values.Ammo.Value == 50 then
							return
						end

						if Tool.Values.StoredAmmo.Value == 0 then
							return
						end

						if ching.IsPlaying == true then
							return
						end     
						task.wait(3.7155)

						if ching.IsPlaying == true then
							return
						end   

						ching:Play()     
					end
				end)


				--███████╗██╗░░██╗
				--██╔════╝╚██╗██╔╝
				--█████╗░░░╚███╔╝░
				--██╔══╝░░░██╔██╗░
				--██║░░░░░██╔╝╚██╗
				--╚═╝░░░░░╚═╝░░╚═╝


				local c1 = Instance.new("ChorusSoundEffect")
				c1.Depth = 1
				c1.Mix = 1
				c1.Priority = 1
				c1.Rate = 0.25

				local c2 = Instance.new("ChorusSoundEffect")
				c2.Depth = 1
				c2.Mix = 1
				c2.Priority = 1
				c2.Rate = 0.25

				local c3 = Instance.new("ChorusSoundEffect")
				c3.Depth = 1
				c3.Mix = 1
				c3.Priority = 1
				c3.Rate = 0.25

				local c4 = Instance.new("ChorusSoundEffect")
				local c5 = Instance.new("ChorusSoundEffect")
				local c6 = Instance.new("ChorusSoundEffect")
				local c7 = Instance.new("ChorusSoundEffect")
				local c8 = Instance.new("ChorusSoundEffect")
				local c9 = Instance.new("ChorusSoundEffect")
				local c10 = Instance.new("ChorusSoundEffect")
				local c11 = Instance.new("ChorusSoundEffect")

				c1.Name = "Chorus1"
				c1.Parent = fx.Muzzle.FireSound1

				c2.Name = "Chorus2"
				c2.Parent = fx.Muzzle.FireSound2

				c3.Name = "Chorus3"
				c3.Parent = fx.Muzzle.FireSound3

				c4.Name = "Chorus4"
				c4.Parent = fx.ReloadA.MagIn

				c5.Name = "Chorus5"
				c5.Parent = fx.ReloadA.MagOut

				c6.Name = "Chorus6"
				c6.Parent = fx.ReloadA.BoltBack

				c7.Name = "Chorus7"
				c7.Parent = fx.ReloadA.BoltRelease

				c8.Name = "Chorus8"
				c8.Parent = fx.TriggerA.Empty

				c9.Name = "Chorus9"
				c9.Parent = fx.TriggerA.EquipSound

				c10.Name = "Chorus10"
				c10.Parent = fx.ReloadA.BoltHit

				c11.Name = "Chorus11"
				c11.Parent = fx.TriggerA.FireModeSwitch


				--████████╗███████╗██╗░░██╗████████╗██╗░░░██╗██████╗░███████╗░██████╗
				--╚══██╔══╝██╔════╝╚██╗██╔╝╚══██╔══╝██║░░░██║██╔══██╗██╔════╝██╔════╝
				--░░░██║░░░█████╗░░░╚███╔╝░░░░██║░░░██║░░░██║██████╔╝█████╗░░╚█████╗░
				--░░░██║░░░██╔══╝░░░██╔██╗░░░░██║░░░██║░░░██║██╔══██╗██╔══╝░░░╚═══██╗
				--░░░██║░░░███████╗██╔╝╚██╗░░░██║░░░╚██████╔╝██║░░██║███████╗██████╔╝
				--░░░╚═╝░░░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░░╚═════╝░╚═╝░░╚═╝╚══════╝╚═════╝░


				local function destroySurfaceAppearance(object)
					local surfaceAppearance = object:FindFirstChildOfClass("SurfaceAppearance")
					if surfaceAppearance then
						surfaceAppearance:Destroy()
						print("SurfaceAppearance destroyed for", object.Name)
					else
						print("No SurfaceAppearance found for", object.Name)
					end
				end

				destroySurfaceAppearance(guh.BasePart)
				destroySurfaceAppearance(guh.MagPart)
				destroySurfaceAppearance(guh.BoltPart)

				local cmap = "rbxassetid://15039147920"
				local mmap = "rbxassetid://15039147721"
				local nmap = "rbxassetid://15039147363"
				local rmap = "rbxassetid://15039147120"

				local sa1 = Instance.new("SurfaceAppearance")
				sa1.Name = "CustomAppearance1"
				sa1.ColorMap = cmap
				sa1.MetalnessMap = mmap
				sa1.NormalMap = nmap
				sa1.RoughnessMap = rmap

				local sa2 = Instance.new("SurfaceAppearance")
				sa2.Name = "CustomAppearance2"
				sa2.ColorMap = cmap
				sa2.MetalnessMap = mmap
				sa2.NormalMap = nmap
				sa2.RoughnessMap = rmap

				local sa3 = Instance.new("SurfaceAppearance")
				sa3.Name = "CustomAppearance3"
				sa3.ColorMap = cmap
				sa3.MetalnessMap = mmap
				sa3.NormalMap = nmap
				sa3.RoughnessMap = rmap

				sa1.Parent = guh.MagPart
				sa2.Parent = guh.BasePart
				sa3.Parent = guh.MagPart

				guh.MagPart.BulletPart.TextureID = ""
				guh.MagPart.BulletPart.Color = Color3.fromRGB(255, 230, 0)
				guh.MagPart.BulletPart.Material = gold


				--██╗░░░██╗███████╗██╗░░██╗
				--██║░░░██║██╔════╝╚██╗██╔╝
				--╚██╗░██╔╝█████╗░░░╚███╔╝░
				--░╚████╔╝░██╔══╝░░░██╔██╗░
				--░░╚██╔╝░░██║░░░░░██╔╝╚██╗
				--░░░╚═╝░░░╚═╝░░░░░╚═╝░░╚═╝


				local vfx = Character["Tommy"].WeaponHandle.Muzzle

				if vfx["Barrel smoke"] then
					vfx["Barrel smoke"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Barrel smoke"].Brightness = 15
					vfx["Barrel smoke"].LightEmission = 1
				end

				if vfx["FlashEmitter"] then
					vfx["FlashEmitter"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["FlashEmitter"].Brightness = 15
					vfx["FlashEmitter"].LightEmission = 1
				end

				if vfx["Gas"] then
					vfx["Gas"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Gas"].Brightness = 15
					vfx["Gas"].LightEmission = 1
				end

				if vfx["Gas2"] then
					vfx["Gas2"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Gas2"].Brightness = 15
					vfx["Gas2"].LightEmission = 1
				end

				if vfx["Lens flare"] then
					vfx["Lens flare"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Lens flare"].Brightness = 15
					vfx["Lens flare"].LightEmission = 1
				end

				if vfx["Muzzle Flash 1"] then
					vfx["Muzzle Flash 1"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Muzzle Flash 1"].Brightness = 15
					vfx["Muzzle Flash 1"].LightEmission = 1
				end

				if vfx["SmokeEmitter"] then
					vfx["SmokeEmitter"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["SmokeEmitter"].Brightness = 15
					vfx["SmokeEmitter"].LightEmission = 1
				end

				if vfx["Sparkles"] then
					vfx["Sparkles"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Sparkles"].Brightness = 15
					vfx["Sparkles"].LightEmission = 1
				end

				while wait() do
					if Character:FindFirstChild("Tommy") then
						local gui = player.PlayerGui.GunGUI.Frame.Main.Title
						gui.Text = "Tommy"
					end    
				end
			end

			local On = false

			local function onCharacterAdded(newCharacter)
				Character = newCharacter

				local Tool = Character:FindFirstChild(ToolName)
				if Tool and On then
					print("Character respawned, reapplying model")
					createModel()
				end
			end

			player.CharacterAdded:Connect(onCharacterAdded)

			Beretta.Changed:Connect(function()
				if Beretta:GetAttribute("Activated") == true then
					On = false
				elseif Beretta:GetAttribute("Activated") == false then
					On = true
				end
			end)

			while wait(.5) do
				if Character:FindFirstChild(ToolName) then
					if On then
						createModel()
					end
				end
			end

			local function onCharacterAdded(newCharacter)
				Character = newCharacter

				local Tool = Character:FindFirstChild(ToolName)
				if Tool and On then
					print("Character respawned, reapplying model")
					createModel()
				end
			end

			player.CharacterAdded:Connect(onCharacterAdded)

			Beretta.Changed:Connect(function()
				if Beretta:GetAttribute("Activated") == true then
					On = false
				elseif Beretta:GetAttribute("Activated") == false then
					On = true
				end
			end)

			while wait(.5) do
				if Character:FindFirstChild(ToolName) then
					if On then
						createModel()
					end
				end
			end
		end)
		
		local akm_gildedfury = SkinsTab:NewButton("akm_gildedfury", function()
			local SkinAdder = loadstring((syn and syn.request or request)({Url="https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/SkinAdderLIB.lua",Method="GET"}).Body)()

			local ToolName = "AKM"

			local Beretta = SkinAdder:CreateSkin("AKM", "Gilded Fury", "limited", TradeLocked, Killtrack, KillsNumber, Souvenir, SerialNumber, {
				TextureID = 15282807876,
				SkinClass = "Guns",
				MeleeVariant = false,
				_FixedMagThing = false
			})



			local function createModel()
				--███╗░░░███╗░█████╗░██████╗░███████╗  ██████╗░██╗░░░██╗  ██╗░░██╗██╗░░░██╗░░░
				--████╗░████║██╔══██╗██╔══██╗██╔════╝  ██╔══██╗╚██╗░██╔╝  ██║░░██║██║░░░██║░░░
				--██╔████╔██║███████║██║░░██║█████╗░░  ██████╦╝░╚████╔╝░  ███████║╚██╗░██╔╝░░░
				--██║╚██╔╝██║██╔══██║██║░░██║██╔══╝░░  ██╔══██╗░░╚██╔╝░░  ██╔══██║░╚████╔╝░██╗
				--██║░╚═╝░██║██║░░██║██████╔╝███████╗  ██████╦╝░░░██║░░░  ██║░░██║░░╚██╔╝░░╚█║
				--╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═════╝░╚══════╝  ╚═════╝░░░░╚═╝░░░  ╚═╝░░╚═╝░░░╚═╝░░░░╚╝

				--░░░░░██╗░█████╗░██╗░░██╗██╗░░░  ███████╗░█████╗░████████╗░█████╗░██╗░░░░░
				--░░░░░██║██╔══██╗██║░░██║██║░░░  ██╔════╝██╔══██╗╚══██╔══╝██╔══██╗██║░░░░░
				--░░░░░██║███████║███████║██║░░░  █████╗░░███████║░░░██║░░░███████║██║░░░░░
				--██╗░░██║██╔══██║██╔══██║██║██╗  ██╔══╝░░██╔══██║░░░██║░░░██╔══██║██║░░░░░
				--╚█████╔╝██║░░██║██║░░██║██║╚█║  ██║░░░░░██║░░██║░░░██║░░░██║░░██║███████╗
				--░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░╚╝  ╚═╝░░░░░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚══════╝


				local guh = Character["AKM"].WeaponHandle.Parts
				local fx = Character["AKM"].WeaponHandle

				local gui = player.PlayerGui.GunGUI.Frame.Main.Title

				local Tool = Character["AKM"]

				local gold = Enum.Material.Neon


				--███╗░░░███╗░█████╗░██╗███╗░░██╗
				--████╗░████║██╔══██╗██║████╗░██║
				--██╔████╔██║███████║██║██╔██╗██║
				--██║╚██╔╝██║██╔══██║██║██║╚████║
				--██║░╚═╝░██║██║░░██║██║██║░╚███║
				--╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝╚═╝░░╚══╝


				if Tool:GetAttribute("Goldified") then
					return
				end

				Tool:SetAttribute("Goldified", true)
				Tool.ToolTip = "G-AKM"


				--░██████╗███████╗██╗░░██╗
				--██╔════╝██╔════╝╚██╗██╔╝
				--╚█████╗░█████╗░░░╚███╔╝░
				--░╚═══██╗██╔══╝░░░██╔██╗░
				--██████╔╝██║░░░░░██╔╝╚██╗
				--╚═════╝░╚═╝░░░░░╚═╝░░╚═╝


				local fs2 = Instance.new("Sound")
				fs2.Name = "FFireSoundTWO"
				fs2.SoundId = "rbxassetid://1210852193"
				fs2.PlaybackSpeed = 1.5
				fs2.Volume = 0.65
				fs2.Parent = fx.Muzzle

				fx.Muzzle.FireSound1:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound1.IsPlaying == true then
						fs2:Play()
					end
				end)

				fx.Muzzle.FireSound2:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound2.IsPlaying == true then
						fs2:Play()
					end
				end)

				fx.Muzzle.FireSound3:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound3.IsPlaying == true then
						fs2:Play()
					end
				end)

				local ching = Instance.new("Sound")
				ching.Name = "Ching"
				ching.SoundId = "rbxassetid://3295472928"
				ching.PlaybackSpeed = 1
				ching.Volume = 0.65
				ching.Parent = fx.ReloadA

				local eq = Instance.new("EqualizerSoundEffect")
				eq.HighGain = -2
				eq.LowGain = 10
				eq.MidGain = 0
				eq.Priority = 0
				eq.Parent = fx.ReloadA.Ching


				--███████╗░██████╗░██╗░░░██╗██╗██████╗░
				--██╔════╝██╔═══██╗██║░░░██║██║██╔══██╗
				--█████╗░░██║██╗██║██║░░░██║██║██████╔╝
				--██╔══╝░░╚██████╔╝██║░░░██║██║██╔═══╝░
				--███████╗░╚═██╔═╝░╚██████╔╝██║██║░░░░░
				--╚══════╝░░░╚═╝░░░░╚═════╝░╚═╝╚═╝░░░░░


				Tool.Equipped:Connect(function()
					task.wait(0.5)
					ching:Play()
				end)


				--██████╗░███████╗██╗░░░░░░█████╗░░█████╗░██████╗░
				--██╔══██╗██╔════╝██║░░░░░██╔══██╗██╔══██╗██╔══██╗
				--██████╔╝█████╗░░██║░░░░░██║░░██║███████║██║░░██║
				--██╔══██╗██╔══╝░░██║░░░░░██║░░██║██╔══██║██║░░██║
				--██║░░██║███████╗███████╗╚█████╔╝██║░░██║██████╔╝
				--╚═╝░░╚═╝╚══════╝╚══════╝░╚════╝░╚═╝░░╚═╝╚═════╝░


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

					if input.KeyCode == Enum.KeyCode.R then
						if Tool.Values.Ammo.Value == 30 then
							return
						end

						if Tool.Values.StoredAmmo.Value == 0 then
							return
						end

						if ching.IsPlaying == true then
							return
						end     
						task.wait(3.425)

						if ching.IsPlaying == true then
							return
						end   

						ching:Play()     
					end
				end)


				--███████╗██╗░░██╗
				--██╔════╝╚██╗██╔╝
				--█████╗░░░╚███╔╝░
				--██╔══╝░░░██╔██╗░
				--██║░░░░░██╔╝╚██╗
				--╚═╝░░░░░╚═╝░░╚═╝


				local c1 = Instance.new("ChorusSoundEffect")
				c1.Depth = 1
				c1.Mix = 1
				c1.Priority = 1
				c1.Rate = 0.25

				local c2 = Instance.new("ChorusSoundEffect")
				c2.Depth = 1
				c2.Mix = 1
				c2.Priority = 1
				c2.Rate = 0.25

				local c3 = Instance.new("ChorusSoundEffect")
				c3.Depth = 1
				c3.Mix = 1
				c3.Priority = 1
				c3.Rate = 0.25

				local c4 = Instance.new("ChorusSoundEffect")
				local c5 = Instance.new("ChorusSoundEffect")
				local c6 = Instance.new("ChorusSoundEffect")
				local c7 = Instance.new("ChorusSoundEffect")
				local c8 = Instance.new("ChorusSoundEffect")
				local c9 = Instance.new("ChorusSoundEffect")
				local c10 = Instance.new("ChorusSoundEffect")
				local c11 = Instance.new("ChorusSoundEffect")

				c1.Name = "Chorus1"
				c1.Parent = fx.Muzzle.FireSound1

				c2.Name = "Chorus2"
				c2.Parent = fx.Muzzle.FireSound2

				c3.Name = "Chorus3"
				c3.Parent = fx.Muzzle.FireSound3

				c4.Name = "Chorus4"
				c4.Parent = fx.ReloadA.MagIn

				c5.Name = "Chorus5"
				c5.Parent = fx.ReloadA.MagOut

				c6.Name = "Chorus6"
				c6.Parent = fx.ReloadA.BoltBack

				c7.Name = "Chorus7"
				c7.Parent = fx.ReloadA.BoltRelease

				c8.Name = "Chorus8"
				c8.Parent = fx.TriggerA.Empty

				c9.Name = "Chorus9"
				c9.Parent = fx.TriggerA.EquipSound

				c10.Name = "Chorus10"
				c10.Parent = fx.ReloadA.MagHit

				c11.Name = "Chorus11"
				c11.Parent = fx.TriggerA.FireModeSwitch


				--████████╗███████╗██╗░░██╗████████╗██╗░░░██╗██████╗░███████╗░██████╗
				--╚══██╔══╝██╔════╝╚██╗██╔╝╚══██╔══╝██║░░░██║██╔══██╗██╔════╝██╔════╝
				--░░░██║░░░█████╗░░░╚███╔╝░░░░██║░░░██║░░░██║██████╔╝█████╗░░╚█████╗░
				--░░░██║░░░██╔══╝░░░██╔██╗░░░░██║░░░██║░░░██║██╔══██╗██╔══╝░░░╚═══██╗
				--░░░██║░░░███████╗██╔╝╚██╗░░░██║░░░╚██████╔╝██║░░██║███████╗██████╔╝
				--░░░╚═╝░░░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░░╚═════╝░╚═╝░░╚═╝╚══════╝╚═════╝░


				local function destroySurfaceAppearance(object)
					local surfaceAppearance = object:FindFirstChildOfClass("SurfaceAppearance")
					if surfaceAppearance then
						surfaceAppearance:Destroy()
						print("SurfaceAppearance destroyed for", object.Name)
					else
						print("No SurfaceAppearance found for", object.Name)
					end
				end

				destroySurfaceAppearance(guh.BasePart)
				destroySurfaceAppearance(guh.MagPart)
				destroySurfaceAppearance(guh.MagPart2)
				destroySurfaceAppearance(guh.BoltPart)
				destroySurfaceAppearance(guh.SightPart)
				destroySurfaceAppearance(guh.LaserPart)

				local cmap = "rbxassetid://15282807876"
				local mmap = "rbxassetid://15282804808"
				local nmap = "rbxassetid://15282804930"
				local rmap = "rbxassetid://15282805071"

				local sa1 = Instance.new("SurfaceAppearance")
				sa1.Name = "CustomAppearance1"
				sa1.ColorMap = cmap
				sa1.MetalnessMap = mmap
				sa1.NormalMap = nmap
				sa1.RoughnessMap = rmap

				local sa2 = Instance.new("SurfaceAppearance")
				sa2.Name = "CustomAppearance2"
				sa2.ColorMap = cmap
				sa2.MetalnessMap = mmap
				sa2.NormalMap = nmap
				sa2.RoughnessMap = rmap

				local sa3 = Instance.new("SurfaceAppearance")
				sa3.Name = "CustomAppearance3"
				sa3.ColorMap = cmap
				sa3.MetalnessMap = mmap
				sa3.NormalMap = nmap
				sa3.RoughnessMap = rmap

				local sa4 = Instance.new("SurfaceAppearance")
				sa4.Name = "CustomAppearance3"
				sa4.ColorMap = cmap
				sa4.MetalnessMap = mmap
				sa4.NormalMap = nmap
				sa4.RoughnessMap = rmap

				local sa5 = Instance.new("SurfaceAppearance")
				sa5.Name = "CustomAppearance3"
				sa5.ColorMap = cmap
				sa5.MetalnessMap = mmap
				sa5.NormalMap = nmap
				sa5.RoughnessMap = rmap

				local sa6 = Instance.new("SurfaceAppearance")
				sa6.Name = "CustomAppearance3"
				sa6.ColorMap = cmap
				sa6.MetalnessMap = mmap
				sa6.NormalMap = nmap
				sa6.RoughnessMap = rmap

				local sa7 = Instance.new("SurfaceAppearance")
				sa7.Name = "CustomAppearance3"
				sa7.ColorMap = cmap
				sa7.MetalnessMap = mmap
				sa7.NormalMap = nmap
				sa7.RoughnessMap = rmap

				sa1.Parent = guh.MagPart
				sa2.Parent = guh.BasePart
				sa3.Parent = guh.MagPart
				sa4.Parent = guh.MagPart2
				sa7.Parent = guh.BoltPart
				sa5.Parent = guh.SightPart
				sa6.Parent = guh.LaserPart

				guh.MagPart.BulletPart1A.TextureID = ""
				guh.MagPart.BulletPart1A.Color = Color3.fromRGB(255,170,0)
				guh.MagPart.BulletPart1A.Material = gold

				guh.MagPart.BulletPart1B.TextureID = ""
				guh.MagPart.BulletPart1B.Color = Color3.fromRGB(255,170,0)
				guh.MagPart.BulletPart1B.Material = gold

				guh.MagPart.CasingPart1A.TextureID = ""
				guh.MagPart.CasingPart1A.Color = Color3.fromRGB(255,170,0)
				guh.MagPart.CasingPart1A.Material = gold

				guh.MagPart.CasingPart1B.TextureID = ""
				guh.MagPart.CasingPart1B.Color = Color3.fromRGB(255,170,0)
				guh.MagPart.CasingPart1B.Material = gold

				guh.MagPart2.BulletPart1A.TextureID = ""
				guh.MagPart2.BulletPart1A.Color = Color3.fromRGB(255,170,0)
				guh.MagPart2.BulletPart1A.Material = gold

				guh.MagPart2.BulletPart1B.TextureID = ""
				guh.MagPart2.BulletPart1B.Color = Color3.fromRGB(255,170,0)
				guh.MagPart2.BulletPart1B.Material = gold

				guh.MagPart2.CasingPart1A.TextureID = ""
				guh.MagPart2.CasingPart1A.Color = Color3.fromRGB(255,170,0)
				guh.MagPart2.CasingPart1A.Material = gold

				guh.MagPart2.CasingPart1B.TextureID = ""
				guh.MagPart2.CasingPart1B.Color = Color3.fromRGB(255,170,0)
				guh.MagPart2.CasingPart1B.Material = gold


				--██╗░░░██╗███████╗██╗░░██╗
				--██║░░░██║██╔════╝╚██╗██╔╝
				--╚██╗░██╔╝█████╗░░░╚███╔╝░
				--░╚████╔╝░██╔══╝░░░██╔██╗░
				--░░╚██╔╝░░██║░░░░░██╔╝╚██╗
				--░░░╚═╝░░░╚═╝░░░░░╚═╝░░╚═╝


				local vfx = Character["AKM"].WeaponHandle.Muzzle

				if vfx["Barrel smoke"] then
					vfx["Barrel smoke"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Barrel smoke"].Brightness = 15
					vfx["Barrel smoke"].LightEmission = 1
				end

				if vfx["FlashEmitter"] then
					vfx["FlashEmitter"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["FlashEmitter"].Brightness = 15
					vfx["FlashEmitter"].LightEmission = 1
				end

				if vfx["Gas"] then
					vfx["Gas"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Gas"].Brightness = 15
					vfx["Gas"].LightEmission = 1
				end

				if vfx["Gas2"] then
					vfx["Gas2"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Gas2"].Brightness = 15
					vfx["Gas2"].LightEmission = 1
				end

				if vfx["Lens flare"] then
					vfx["Lens flare"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Lens flare"].Brightness = 15
					vfx["Lens flare"].LightEmission = 1
				end

				if vfx["Muzzle Flash 1"] then
					vfx["Muzzle Flash 1"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Muzzle Flash 1"].Brightness = 15
					vfx["Muzzle Flash 1"].LightEmission = 1
				end

				if vfx["SmokeEmitter"] then
					vfx["SmokeEmitter"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["SmokeEmitter"].Brightness = 15
					vfx["SmokeEmitter"].LightEmission = 1
				end

				if vfx["Sparkles"] then
					vfx["Sparkles"].Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,170,0));
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,0));
					}
					vfx["Sparkles"].Brightness = 15
					vfx["Sparkles"].LightEmission = 1
				end
			end

			local On = false

			local function onCharacterAdded(newCharacter)
				Character = newCharacter

				local Tool = Character:FindFirstChild(ToolName)
				if Tool and On then
					print("Character respawned, reapplying model")
					createModel()
				end
			end

			player.CharacterAdded:Connect(onCharacterAdded)

			Beretta.Changed:Connect(function()
				if Beretta:GetAttribute("Activated") == true then
					On = false
				elseif Beretta:GetAttribute("Activated") == false then
					On = true
				end
			end)

			while wait(.5) do
				if Character:FindFirstChild(ToolName) then
					if On then
						createModel()
					end
				end
			end

			local function onCharacterAdded(newCharacter)
				Character = newCharacter

				local Tool = Character:FindFirstChild(ToolName)
				if Tool and On then
					print("Character respawned, reapplying model")
					createModel()
				end
			end

			player.CharacterAdded:Connect(onCharacterAdded)

			Beretta.Changed:Connect(function()
				if Beretta:GetAttribute("Activated") == true then
					On = false
				elseif Beretta:GetAttribute("Activated") == false then
					On = true
				end
			end)

			while wait(.5) do
				if Character:FindFirstChild(ToolName) then
					if On then
						createModel()
					end
				end
			end
		end)
		
		local inferno_magnum = SkinsTab:NewButton("magnum_inferno", function()
			local SkinAdder = loadstring((syn and syn.request or request)({Url="https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/SkinAdderLIB.lua",Method="GET"}).Body)()

			local ToolName = "Magnum"

			local Beretta = SkinAdder:CreateSkin("Magnum", "Inferno", "limited", TradeLocked, Killtrack, KillsNumber, Souvenir, SerialNumber, {
				TextureID = 13565659313,
				SkinClass = "Guns",
				MeleeVariant = false,
				_FixedMagThing = false
			})



			local function createModel()
				--███╗░░░███╗░█████╗░██████╗░███████╗  ██████╗░██╗░░░██╗  ██╗░░██╗██╗░░░██╗░░░
				--████╗░████║██╔══██╗██╔══██╗██╔════╝  ██╔══██╗╚██╗░██╔╝  ██║░░██║██║░░░██║░░░
				--██╔████╔██║███████║██║░░██║█████╗░░  ██████╦╝░╚████╔╝░  ███████║╚██╗░██╔╝░░░
				--██║╚██╔╝██║██╔══██║██║░░██║██╔══╝░░  ██╔══██╗░░╚██╔╝░░  ██╔══██║░╚████╔╝░██╗
				--██║░╚═╝░██║██║░░██║██████╔╝███████╗  ██████╦╝░░░██║░░░  ██║░░██║░░╚██╔╝░░╚█║
				--╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═════╝░╚══════╝  ╚═════╝░░░░╚═╝░░░  ╚═╝░░╚═╝░░░╚═╝░░░░╚╝

				--░░░░░██╗░█████╗░██╗░░██╗██╗░░░  ███████╗░█████╗░████████╗░█████╗░██╗░░░░░
				--░░░░░██║██╔══██╗██║░░██║██║░░░  ██╔════╝██╔══██╗╚══██╔══╝██╔══██╗██║░░░░░
				--░░░░░██║███████║███████║██║░░░  █████╗░░███████║░░░██║░░░███████║██║░░░░░
				--██╗░░██║██╔══██║██╔══██║██║██╗  ██╔══╝░░██╔══██║░░░██║░░░██╔══██║██║░░░░░
				--╚█████╔╝██║░░██║██║░░██║██║╚█║  ██║░░░░░██║░░██║░░░██║░░░██║░░██║███████╗
				--░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░╚╝  ╚═╝░░░░░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚══════╝


				local guh = Character["Magnum"].WeaponHandle.Parts
				local fx = Character["Magnum"].WeaponHandle

				local gui = player.PlayerGui.GunGUI.Frame.Main.Title

				local Tool = player.Character["Magnum"]

				local gold = Enum.Material.Neon

				local v = Character["Magnum"].WeaponHandle.Parts.HandlePart.Base

				local TweenService = game:GetService("TweenService")

				local bullets = guh.BulletsRealPart
				bullets.Color = Color3.fromRGB(147, 85, 52)

				local goal = {}
				goal.Color = Color3.fromRGB(49, 49, 49)

				local tweenInfo = TweenInfo.new(0.1)

				local tween = TweenService:Create(bullets, tweenInfo, goal)


				--███╗░░░███╗░█████╗░██╗███╗░░██╗
				--████╗░████║██╔══██╗██║████╗░██║
				--██╔████╔██║███████║██║██╔██╗██║
				--██║╚██╔╝██║██╔══██║██║██║╚████║
				--██║░╚═╝░██║██║░░██║██║██║░╚███║
				--╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝╚═╝░░╚══╝


				if Tool:GetAttribute("Goldified") then
					return
				end

				Tool:SetAttribute("Goldified", true)
				Tool.ToolTip = "Magnum"


				--░██████╗███████╗██╗░░██╗
				--██╔════╝██╔════╝╚██╗██╔╝
				--╚█████╗░█████╗░░░╚███╔╝░
				--░╚═══██╗██╔══╝░░░██╔██╗░
				--██████╔╝██║░░░░░██╔╝╚██╗
				--╚═════╝░╚═╝░░░░░╚═╝░░╚═╝


				local fs2 = Instance.new("Sound")
				fs2.Name = "FFireSoundTWO"
				fs2.SoundId = "rbxassetid://7578785210"
				fs2.PlaybackSpeed = 1.5
				fs2.Volume = 0.4
				fs2.Parent = fx.Muzzle

				local eq = Instance.new("EqualizerSoundEffect")
				eq.HighGain = -2
				eq.LowGain = 10
				eq.MidGain = 0
				eq.Priority = 0
				eq.Parent = fs2

				fx.Muzzle.FireSound1:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound1.IsPlaying == true then
						fs2:Play()
					end
				end)

				fx.Muzzle.FireSound2:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound2.IsPlaying == true then
						fs2:Play()
					end
				end)

				fx.Muzzle.FireSound3:GetPropertyChangedSignal("IsPlaying"):Connect(function()
					if fx.Muzzle.FireSound3.IsPlaying == true then
						fs2:Play()
					end
				end)

				local ching = Instance.new("Sound")
				ching.Name = "Ching"
				ching.SoundId = "rbxassetid://7102029389"
				ching.Volume = 1
				ching.Parent = fx.ReloadA


				--██████╗░███████╗██╗░░░░░░█████╗░░█████╗░██████╗░
				--██╔══██╗██╔════╝██║░░░░░██╔══██╗██╔══██╗██╔══██╗
				--██████╔╝█████╗░░██║░░░░░██║░░██║███████║██║░░██║
				--██╔══██╗██╔══╝░░██║░░░░░██║░░██║██╔══██║██║░░██║
				--██║░░██║███████╗███████╗╚█████╔╝██║░░██║██████╔╝
				--╚═╝░░╚═╝╚══════╝╚══════╝░╚════╝░╚═╝░░╚═╝╚═════╝░

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

					if input.KeyCode == Enum.KeyCode.R then
						if Tool.Values.Ammo.Value == 6 then
							return
						end

						if Tool.Values.StoredAmmo.Value == 0 then
							return
						end

						if ching.IsPlaying == true then
							return
						end 

						task.spawn(function()
							guh.BulletsRealPart.Color = Color3.fromRGB(188, 111, 66)
							task.wait(1.22658)

							if ching.IsPlaying == true then
								return
							end   

							ching:Play()
							task.wait(0.4)
							guh.BulletsRealPart.Color = Color3.fromRGB(188, 111, 66)
						end)

						task.wait(1.12658)

						tween:Play()
					end
				end)


				--███████╗██╗░░██╗
				--██╔════╝╚██╗██╔╝
				--█████╗░░░╚███╔╝░
				--██╔══╝░░░██╔██╗░
				--██║░░░░░██╔╝╚██╗
				--╚═╝░░░░░╚═╝░░╚═╝


				local c1 = Instance.new("ChorusSoundEffect")
				c1.Depth = 1
				c1.Mix = 1
				c1.Priority = 1
				c1.Rate = 0.25

				local c2 = Instance.new("ChorusSoundEffect")
				c2.Depth = 1
				c2.Mix = 1
				c2.Priority = 1
				c2.Rate = 0.25

				local c3 = Instance.new("ChorusSoundEffect")
				c3.Depth = 1
				c3.Mix = 1
				c3.Priority = 1
				c3.Rate = 0.25

				local c4 = Instance.new("ChorusSoundEffect")
				local c5 = Instance.new("ChorusSoundEffect")
				local c6 = Instance.new("ChorusSoundEffect")
				local c7 = Instance.new("ChorusSoundEffect")
				local c8 = Instance.new("ChorusSoundEffect")
				local c9 = Instance.new("ChorusSoundEffect")

				local c10 = Instance.new("ChorusSoundEffect")
				local c11 = Instance.new("ChorusSoundEffect")

				c1.Name = "Chorus1"
				c1.Parent = fx.Muzzle.FireSound1

				c2.Name = "Chorus2"
				c2.Parent = fx.Muzzle.FireSound2

				c3.Name = "Chorus3"
				c3.Parent = fx.Muzzle.FireSound3

				c4.Name = "Chorus4"
				c4.Parent = fx.ReloadA.CylClose

				c5.Name = "Chorus5"
				c5.Parent = fx.ReloadA.CylOpen

				c6.Name = "Chorus6"
				c6.Parent = fx.ReloadA.ShellsIn

				c7.Name = "Chorus7"
				c7.Parent = fx.ReloadA.ShellsOut

				c8.Name = "Chorus8"
				c8.Parent = fx.TriggerA.Empty

				c9.Name = "Chorus9"
				c9.Parent = fx.TriggerA.EquipSound

				c10.Name = "Chorus10"
				c10.Parent = fx.TriggerA.ChargeDown

				c11.Name = "Chorus11"
				c11.Parent = fx.TriggerA.ChargeUp


				--████████╗███████╗██╗░░██╗████████╗██╗░░░██╗██████╗░███████╗░██████╗
				--╚══██╔══╝██╔════╝╚██╗██╔╝╚══██╔══╝██║░░░██║██╔══██╗██╔════╝██╔════╝
				--░░░██║░░░█████╗░░░╚███╔╝░░░░██║░░░██║░░░██║██████╔╝█████╗░░╚█████╗░
				--░░░██║░░░██╔══╝░░░██╔██╗░░░░██║░░░██║░░░██║██╔══██╗██╔══╝░░░╚═══██╗
				--░░░██║░░░███████╗██╔╝╚██╗░░░██║░░░╚██████╔╝██║░░██║███████╗██████╔╝
				--░░░╚═╝░░░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░░╚═════╝░╚═╝░░╚═╝╚══════╝╚═════╝░


				local function destroySurfaceAppearance(object)
					local surfaceAppearance = object:FindFirstChildOfClass("SurfaceAppearance")
					if surfaceAppearance then
						surfaceAppearance:Destroy()
						print("SurfaceAppearance destroyed for", object.Name)
					else
						print("No SurfaceAppearance found for", object.Name)
					end
				end

				destroySurfaceAppearance(guh.HandlePart.Base)
				destroySurfaceAppearance(guh.BulletsRealPart)
				destroySurfaceAppearance(guh.Thing.ThingPart.DrumPart.DrumPartPart)
				destroySurfaceAppearance(Tool.MagazineHandle.SpeedLoader.BulletsFake.BulletsFakePart)

				local cmap = "rbxassetid://13565647644"
				local mmap = "rbxassetid://13565650923"
				local nmap = "rbxassetid://13565652460"
				local rmap = "rbxassetid://13565654437"

				--local sa1 = Instance.new("SurfaceAppearance")
				--sa1.Name = "CustomAppearance1"
				--sa1.ColorMap = cmap
				--sa1.MetalnessMap = mmap
				--sa1.NormalMap = nmap
				--sa1.RoughnessMap = rmap

				local sa2 = Instance.new("SurfaceAppearance")
				sa2.Name = "CustomAppearance2"
				sa2.ColorMap = cmap
				sa2.MetalnessMap = mmap
				sa2.NormalMap = nmap
				sa2.RoughnessMap = rmap

				local sa3 = Instance.new("SurfaceAppearance")
				sa3.Name = "CustomAppearance3"
				sa3.ColorMap = cmap
				sa3.MetalnessMap = mmap
				sa3.NormalMap = nmap
				sa3.RoughnessMap = rmap

				local sa4 = Instance.new("SurfaceAppearance")
				sa4.Name = "CustomAppearance4"
				sa4.ColorMap = cmap
				sa4.MetalnessMap = mmap
				sa4.NormalMap = nmap
				sa4.RoughnessMap = rmap

				sa2.Parent = guh.Hammer.HammerPart
				sa3.Parent = guh.Thing.ThingPart.DrumPart.DrumPartPart
				sa4.Parent = guh.HandlePart.Base

				v.L1.Color = Color3.fromRGB(167, 106, 1)
				v.L2.Color = Color3.fromRGB(167, 106, 1)
				v.L3.Color = Color3.fromRGB(167, 106, 1)
				v.L4.Color = Color3.fromRGB(167, 106, 1)

				guh.BulletsRealPart.TextureID = ""
				guh.BulletsRealPart.Color = Color3.fromRGB(188, 111, 66)
				guh.BulletsRealPart.Material = gold

				Tool.MagazineHandle.SpeedLoader.BulletsFake.BulletsFakePart.TextureID = ""
				Tool.MagazineHandle.SpeedLoader.BulletsFake.BulletsFakePart.Color = Color3.fromRGB(188, 111, 66)
				Tool.MagazineHandle.SpeedLoader.BulletsFake.BulletsFakePart.Material = gold
			end

			local On = false

			local function onCharacterAdded(newCharacter)
				Character = newCharacter

				local Tool = Character:FindFirstChild(ToolName)
				if Tool and On then
					print("Character respawned, reapplying model")
					createModel()
				end
			end

			player.CharacterAdded:Connect(onCharacterAdded)

			Beretta.Changed:Connect(function()
				if Beretta:GetAttribute("Activated") == true then
					On = false
				elseif Beretta:GetAttribute("Activated") == false then
					On = true
				end
			end)

			while wait(.5) do
				if Character:FindFirstChild(ToolName) then
					if On then
						createModel()
					end
				end
			end

			local function onCharacterAdded(newCharacter)
				Character = newCharacter

				local Tool = Character:FindFirstChild(ToolName)
				if Tool and On then
					print("Character respawned, reapplying model")
					createModel()
				end
			end

			player.CharacterAdded:Connect(onCharacterAdded)

			Beretta.Changed:Connect(function()
				if Beretta:GetAttribute("Activated") == true then
					On = false
				elseif Beretta:GetAttribute("Activated") == false then
					On = true
				end
			end)

			while wait(.5) do
				if Character:FindFirstChild(ToolName) then
					if On then
						createModel()
					end
				end
			end
		end)
	else
		local Notif = library:InitNotifications()
		Notif:Notify("EMPYREAL COULDN'T LOAD REASON: INVALID GAME ID [PLEASE JOIN A GAME THAT EMPYREAL SUPPORTS]", 5, "error") -- notification, alert, error, success, information
	end
end

if tostring(game:GetService("RbxAnalyticsService"):GetClientId()) == "22546EE2-F5D6-4271-8575-67299BEA5DCF" then
	_G.Empyreal("theme", "blue", game.GameId)
else
	_G.Empyreal(nil, nil, game.GameId)
end
