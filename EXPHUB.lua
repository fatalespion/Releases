local HWID = game:GetService("RbxAnalyticsService"):GetClientId();

qNVAKkuwxNpqruLjSRHg = true

if qNVAKkuwxNpqruLjSRHg == true then
	if game.PlaceId == 12552538292  then
		print("[NEBULA HUB]: Loading")

		if shared.key ~= "hG8LdA7sQWEr" then
			print("⛔ [NEBULA HUB]: Auth Failed [INVALID KEY]")
			return
		end

		print("[NEBULA HUB]: Passed Auth")

		local repo = 'https://raw.githubusercontent.com/'

		local Library = loadstring(game:HttpGet(repo .. 'fatalespion/Releases/main/Lino.lua'))()
		local ThemeManager = loadstring(game:HttpGet(repo .. 'fatalespion/Releases/main/ThemeManager'))()
		local SaveManager = loadstring(game:HttpGet(repo .. 'violin-suzutsuki/LinoriaLib/main/addons/SaveManager.lua'))()
		local Window = Library:CreateWindow({
			Title = 'NEBULA HUB | Game: Pressure | BETA',
			Center = true,
			AutoShow = true,
			TabPadding = 8,
			MenuFadeTime = 0.2
		})


		local Tabs = {
			Visual = Window:AddTab('Visual'),
			Teleportation = Window:AddTab('Teleportation  & Movement'),
			Misc = Window:AddTab('Miscellaneous'),
			['HUD'] = Window:AddTab('Settings'),
		}

		local LeftVisualGroupBox = Tabs.Visual:AddLeftGroupbox('ESP')

		local waterLeftLootGroupBox = Tabs.HUD:AddRightGroupbox('WATERMARK')

		_G.ESPEnabled = false
		_G.ESPShowTracers = true
		_G.ESPShowBox = true
		_G.ESPShowName = false
		_G.ESPShowDistance = false
		_G.ESPTracerColor = Color3.fromRGB(255,65,65)
		_G.ESPBoxColor = Color3.fromRGB(255,65,65)
		_G.ESPKeycardColor = Color3.fromRGB(81, 141, 179)
		_G.ESPLootColor = Color3.fromRGB(229, 187, 21)
		_G.ESPKeycard = false
		_G.ESPLoot = false

		local Noclip = nil
		local Clip = nil

		function noclip()
			Clip = false
			local function Nocl()
				if Clip == false and game.Players.LocalPlayer.Character ~= nil then
					for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
						if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
							v.CanCollide = false
						end
					end
				end
				wait(0.21)
			end
			Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
		end

		function clip()
			if Noclip then Noclip:Disconnect() end
			Clip = true
		end

		local Camera = workspace.CurrentCamera

		local CurrencyNames = {
			"5Currency",
			"10Currency",
			"15Currency",
			"20Currency",
			"25Currency",
			"50Currency",
			"100Currency",
			"200Currency",
		}

		local function StartESP()
			local lplr = game.Players.LocalPlayer
			local camera = game:GetService("Workspace").CurrentCamera
			local CurrentCamera = workspace.CurrentCamera
			local worldtoViewportPoint = CurrentCamera.WorldToViewportPoint

			local HeadOff = Vector3.new(0, 0.5, 0)
			local LegOff = Vector3.new(0,3,0)

			for i,v in pairs(game.Workspace.Rooms:GetDescendants()) do
				if v:GetAttribute("SpawnAfter") then
					v.ChildAdded:Connect(function()
						if v ~= nil and v:FindFirstChild("ProxyPart") and v:IsA("Model") and table.find(CurrencyNames, v.Name) or v ~= nil and v.Name == "SpawnKeycard" then
							local Tracer = Drawing.new("Line")

							Tracer.Visible = false

							Tracer.Thickness = 1
							Tracer.Transparency = 1

							local TypeText = Drawing.new("Text")
							TypeText.Visible = false
							TypeText.Center = true
							TypeText.Outline = true
							TypeText.Font = 2
							TypeText.Size = 13
							TypeText.Text = "Type"

							function lineesp()
								game:GetService("RunService").RenderStepped:Connect(function()
									if v ~= nil and v:FindFirstChild("ProxyPart") and v:IsA("Model") and table.find(CurrencyNames, v.Name) then

										local Vector, OnScreen = camera:WorldToViewportPoint(v.ProxyPart.Position)

										if _G.ESPEnabled and _G.ESPLoot then
											if OnScreen then
												Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
												Tracer.To = Vector2.new(Vector.X, Vector.Y)
												TypeText.Position = Vector2.new(Vector.X, Vector.Y - 10)
												TypeText.Text = v.Name
												TypeText.Color = _G.ESPLootColor
												Tracer.Color = _G.ESPLootColor

												if v ~= nil then
													Tracer.Visible = true
													TypeText.Visible = true
												else
													Tracer.Visible = false
													TypeText.Visible = false
												end

												if not _G.ESPShowTracers  then
													Tracer.Visible = false
												end

												if not _G.ESPShowName then
													TypeText.Visible = false
												end
											else
												TypeText.Visible = false
												Tracer.Visible = false
											end
										else
											TypeText.Visible = false
											Tracer.Visible = false
										end
									elseif v ~= nil and v.Name == "SpawnKeycard" then
										local Vector, OnScreen = camera:WorldToViewportPoint(v.Position)

										if _G.ESPEnabled and _G.ESPKeycard then
											if OnScreen then
												Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
												Tracer.To = Vector2.new(Vector.X, Vector.Y)
												TypeText.Position = Vector2.new(Vector.X, Vector.Y - 10)
												TypeText.Text = "Keycard"
												TypeText.Color = _G.ESPKeycardColor
												Tracer.Color = _G.ESPKeycardColor

												if v ~= nil then
													Tracer.Visible = true
													TypeText.Visible = true
												else
													Tracer.Visible = false
													TypeText.Visible = false
												end

												if not _G.ESPShowTracers  then
													Tracer.Visible = false
												end

												if not _G.ESPShowName then
													TypeText.Visible = false
												end
											else
												TypeText.Visible = false
												Tracer.Visible = false
											end
										else
											TypeText.Visible = false
											Tracer.Visible = false
										end
									else
										TypeText.Visible = false
										Tracer.Visible = false
									end
								end)
							end

							task.spawn(function()
								coroutine.wrap(lineesp)()
							end)
						end
					end)
				end
				if v ~= nil and v:FindFirstChild("ProxyPart") and v:IsA("Model") and table.find(CurrencyNames, v.Name) or v ~= nil and v.Name == "SpawnKeycard" then
					local Tracer = Drawing.new("Line")

					Tracer.Visible = false

					Tracer.Thickness = 1
					Tracer.Transparency = 1

					local TypeText = Drawing.new("Text")
					TypeText.Visible = false
					TypeText.Center = true
					TypeText.Outline = true
					TypeText.Font = 2
					TypeText.Size = 13
					TypeText.Text = "Type"

					function lineesp()
						game:GetService("RunService").RenderStepped:Connect(function()
							if v ~= nil and v:FindFirstChild("ProxyPart") and v:IsA("Model") and table.find(CurrencyNames, v.Name) then

								local Vector, OnScreen = camera:WorldToViewportPoint(v.ProxyPart.Position)

								if _G.ESPEnabled and _G.ESPLoot then
									if OnScreen then
										Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
										Tracer.To = Vector2.new(Vector.X, Vector.Y)
										TypeText.Position = Vector2.new(Vector.X, Vector.Y - 10)
										TypeText.Text = v.Name
										TypeText.Color = _G.ESPLootColor
										Tracer.Color = _G.ESPLootColor

										if v ~= nil then
											Tracer.Visible = true
											TypeText.Visible = true
										else
											Tracer.Visible = false
											TypeText.Visible = false
										end

										if not _G.ESPShowTracers  then
											Tracer.Visible = false
										end

										if not _G.ESPShowName then
											TypeText.Visible = false
										end
									else
										TypeText.Visible = false
										Tracer.Visible = false
									end
								else
									TypeText.Visible = false
									Tracer.Visible = false
								end
							elseif v ~= nil and v.Name == "SpawnKeycard" then
								local Vector, OnScreen = camera:WorldToViewportPoint(v.Position)

								if _G.ESPEnabled and _G.ESPKeycard then
									if OnScreen then
										Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
										Tracer.To = Vector2.new(Vector.X, Vector.Y)
										TypeText.Position = Vector2.new(Vector.X, Vector.Y - 10)
										TypeText.Text = "Keycard"
										TypeText.Color = _G.ESPKeycardColor
										Tracer.Color = _G.ESPKeycardColor

										if v ~= nil then
											Tracer.Visible = true
											TypeText.Visible = true
										else
											Tracer.Visible = false
											TypeText.Visible = false
										end

										if not _G.ESPShowTracers  then
											Tracer.Visible = false
										end

										if not _G.ESPShowName then
											TypeText.Visible = false
										end
									else
										TypeText.Visible = false
										Tracer.Visible = false
									end
								else
									TypeText.Visible = false
									Tracer.Visible = false
								end
							else
								TypeText.Visible = false
								Tracer.Visible = false
							end
						end)
					end

					task.spawn(function()
						coroutine.wrap(lineesp)()
					end)
				end
			end

			game.Workspace.Rooms.ChildAdded:Connect(function(b)
				b.ChildAdded:Connect(function()
					for i,v in pairs(b:GetDescendants()) do
						if v ~= nil and v:FindFirstChild("ProxyPart") and v:IsA("Model") and table.find(CurrencyNames, v.Name) or v ~= nil and v.Name == "SpawnKeycard"  then
							local Tracer = Drawing.new("Line")
							Tracer.Visible = false

							Tracer.Thickness = 1
							Tracer.Transparency = 1

							local TypeText = Drawing.new("Text")
							TypeText.Visible = false
							TypeText.Center = true
							TypeText.Outline = true
							TypeText.Font = 2
							TypeText.Size = 13
							TypeText.Text = "Type"

							function lineesp()
								game:GetService("RunService").RenderStepped:Connect(function()
									if v ~= nil and v:FindFirstChild("ProxyPart") and v:IsA("Model") and table.find(CurrencyNames, v.Name) then
										local Vector, OnScreen = camera:WorldToViewportPoint(v.ProxyPart.Position)

										if _G.ESPEnabled and _G.ESPLoot then
											if OnScreen then
												Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
												Tracer.To = Vector2.new(Vector.X, Vector.Y)
												TypeText.Position = Vector2.new(Vector.X, Vector.Y - 10)
												TypeText.Text = v.Name
												TypeText.Color = _G.ESPLootColor
												Tracer.Color = _G.ESPLootColor

												if v ~= nil then
													Tracer.Visible = true
													TypeText.Visible = true
												else
													Tracer.Visible = false
													TypeText.Visible = false
												end

												if not _G.ESPShowTracers  then
													Tracer.Visible = false
												end

												if not _G.ESPShowName then
													TypeText.Visible = false
												end
											else
												TypeText.Visible = false
												Tracer.Visible = false
											end
										else
											TypeText.Visible = false
											Tracer.Visible = false
										end
									elseif v ~= nil and v.Name == "SpawnKeycard" then
										local Vector, OnScreen = camera:WorldToViewportPoint(v.Position)

										if _G.ESPEnabled and _G.ESPKeycard then
											if OnScreen then
												Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
												Tracer.To = Vector2.new(Vector.X, Vector.Y)
												TypeText.Position = Vector2.new(Vector.X, Vector.Y - 10)
												TypeText.Text = "Keycard"
												TypeText.Color = _G.ESPKeycardColor
												Tracer.Color = _G.ESPKeycardColor

												if v ~= nil then
													Tracer.Visible = true
													TypeText.Visible = true
												else
													Tracer.Visible = false
													TypeText.Visible = false
												end

												if not _G.ESPShowTracers  then
													Tracer.Visible = false
												end

												if not _G.ESPShowName then
													TypeText.Visible = false
												end
											else
												TypeText.Visible = false
												Tracer.Visible = false
											end
										else
											TypeText.Visible = false
											Tracer.Visible = false
										end
									else
										TypeText.Visible = false
										Tracer.Visible = false
									end
								end)
							end

							task.spawn(function()
								coroutine.wrap(lineesp)()
							end)
						end
					end
				end)
			end)
		end	

		StartESP()

		LeftVisualGroupBox:AddToggle('EnabledESP', {
			Text = 'Enable',
			Default = false, -- Default value (true / false)
			Tooltip = 'Enable the esp', -- Information shown when you hover over the toggle

			Callback = function(Value)
				_G.ESPEnabled = Value           
			end
		})

		LeftVisualGroupBox:AddToggle('ShowTracers', {
			Text = 'Show Tracers',
			Default = true, -- Default value (true / false)
			Tooltip = 'Shows the tracers', -- Information shown when you hover over the toggle

			Callback = function(Value)
				_G.ESPShowTracers = Value
			end
		})

		LeftVisualGroupBox:AddToggle('ShowBox', {
			Text = 'Show Boxes',
			Default = true, -- Default value (true / false)
			Tooltip = 'Shows the boxes', -- Information shown when you hover over the toggle

			Callback = function(Value)
				_G.ESPShowBox = Value
			end
		})

		LeftVisualGroupBox:AddToggle('ShowDistance', {
			Text = 'Show Distance',
			Default = false, -- Default value (true / false)
			Tooltip = 'Shows the distance between you and the player.', -- Information shown when you hover over the toggle

			Callback = function(Value)
				_G.ESPShowDistance = Value
			end
		})

		LeftVisualGroupBox:AddToggle('ShowName', {
			Text = 'Show Names',
			Default = false, -- Default value (true / false)
			Tooltip = 'Shows the name of the player kinda like [Nametags].', -- Information shown when you hover over the toggle

			Callback = function(Value)
				_G.ESPShowName = Value
			end
		})

		LeftVisualGroupBox:AddToggle('ESPLoot', {
			Text = 'Show Loot',
			Default = false, -- Default value (true / false)
			Tooltip = 'Shows all of the loot around you', -- Information shown when you hover over the toggle

			Callback = function(Value)
				_G.ESPLoot = Value
			end
		})

		LeftVisualGroupBox:AddToggle('ESPKeycard', {
			Text = 'Show Keycards',
			Default = false, -- Default value (true / false)
			Tooltip = 'Shows all of the keycards around you', -- Information shown when you hover over the toggle

			Callback = function(Value)
				_G.ESPKeycard = Value
			end
		})

		LeftVisualGroupBox:AddDivider()

		LeftVisualGroupBox:AddLabel('Tracer Color'):AddColorPicker('ESPColorPicker', {
			Default = Color3.fromRGB(255,65,65), -- Bright green
			Title = 'Tracer Color', -- Optional. Allows you to have a custom color picker title (when you open it)
			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

			Callback = function(Value)
				_G.ESPTracerColor = Value
			end
		})

		LeftVisualGroupBox:AddLabel('Box Color'):AddColorPicker('ESPBoxColorPicker', {
			Default = Color3.fromRGB(255,65,65), -- Bright green
			Title = 'Box Color', -- Optional. Allows you to have a custom color picker title (when you open it)
			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

			Callback = function(Value)
				_G.ESPBoxColor = Value
			end
		})

		LeftVisualGroupBox:AddDivider()

		LeftVisualGroupBox:AddLabel('Loot Color'):AddColorPicker('ESPLootColorPicker', {
			Default = Color3.fromRGB(229, 187, 21), -- Bright green
			Title = 'Loot Color', -- Optional. Allows you to have a custom color picker title (when you open it)
			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

			Callback = function(Value)
				_G.ESPLootColor = Value
			end
		})

		LeftVisualGroupBox:AddLabel('Keycard Color'):AddColorPicker('ESPKeycardColorPicker', {
			Default = Color3.fromRGB(81, 141, 179), -- Bright green
			Title = 'Keycard Color', -- Optional. Allows you to have a custom color picker title (when you open it)
			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

			Callback = function(Value)
				_G.ESPKeycardColor = Value
			end
		})

		Library:SetWatermarkVisibility(true)

		waterLeftLootGroupBox:AddToggle('Watermark', {
			Text = 'Watermark',
			Default = true,
			Tooltip = 'removes or shows the watermark',
			Callback = function(Value)
				Library:SetWatermarkVisibility(Value)
			end
		})

		local FrameTimer = tick()
		local FrameCounter = 0
		local FPS = 60

		local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
			FrameCounter += 1

			if (tick() - FrameTimer) >= 1 then
				FPS = FrameCounter
				FrameTimer = tick()
				FrameCounter = 0
			end

			Library:SetWatermark(('NEBULA HUB | %s fps | %s ms | %s '):format(
				math.floor(FPS),
				math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue()),
				game.Players.LocalPlayer.Name
				))
		end)

		Library.KeybindFrame.Visible = false

		Library:OnUnload(function()
			WatermarkConnection:Disconnect()

			print('Unloaded!')
			Library.Unloaded = true
		end)


		local MenuGroup = Tabs['HUD']:AddLeftGroupbox('Menu')

		MenuGroup:AddButton('Unload', function() Library:Unload() end)

		ThemeManager:SetLibrary(Library)
		SaveManager:SetLibrary(Library)

		SaveManager:IgnoreThemeSettings()

		ThemeManager:SetFolder('EXPHUB')
		SaveManager:SetFolder('EXPHUB'..game.PlaceId)

		SaveManager:BuildConfigSection(Tabs['HUD'])

		ThemeManager:ApplyToTab(Tabs['HUD'])

		SaveManager:LoadAutoloadConfig()

		print("[NEBULA HUB]: Loaded👍")
	else
		print("[NEBULA HUB]: Loading")

		if shared.key ~= "hG8LdA7sQWEr" then
			print("[NEBULA HUB]: Auth Failed [INVALID KEY]")
			return
		end

		print("[NEBULA HUB]: Passed Auth")

		local repo = 'https://raw.githubusercontent.com/'

		local Library = loadstring(game:HttpGet(repo .. 'fatalespion/Releases/main/Lino.lua'))()
		local ThemeManager = loadstring(game:HttpGet(repo .. 'fatalespion/Releases/main/ThemeManager'))()
		local SaveManager = loadstring(game:HttpGet(repo .. 'violin-suzutsuki/LinoriaLib/main/addons/SaveManager.lua'))()
		local AimbotLoadString = loadstring(game:HttpGet("https://raw.githubusercontent.com/fatalespion/Releases/main/Aimbot"))()
		local KillAuraLoadString = loadstring(game:HttpGet("https://raw.githubusercontent.com/fatalespion/Releases/main/KillAura.lua"))()
		local Window = Library:CreateWindow({
			Title = 'NEBULA HUB | Game: Blackout | BETA',
			Center = true,
			AutoShow = true,
			TabPadding = 8,
			MenuFadeTime = 0.2
		})


		local Tabs = {
			Combat = Window:AddTab('Combat'),
			Visual = Window:AddTab('Visual'),
			Teleportation = Window:AddTab('Teleportation'),
			Misc = Window:AddTab('Miscellaneous'),
			['HUD'] = Window:AddTab('Settings'),
		}

		local AvailbleRemotes = {}

		for i,v in pairs(game.ReplicatedStorage:GetDescendants()) do
			if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") or v:IsA("BindableEvent") then
				table.insert(AvailbleRemotes, v.Name)
			end     
		end  

		local LeftVisualGroupBox = Tabs.Visual:AddLeftGroupbox('ESP')
		local ChamsRightVisualGroupBox = Tabs.Visual:AddRightGroupbox('CHAMS')
		local GunsLeftVisualGroupBox = Tabs.Visual:AddLeftGroupbox('GUN MODS')
		local CrosshairRightVisualGroupBox = Tabs.Visual:AddRightGroupbox('CROSSHAIR')
		local TracerLeftVisualGroupBox = Tabs.Visual:AddLeftGroupbox('TRACER')
		local OthersLeftVisualGroupBox = Tabs.Visual:AddRightGroupbox('OTHERS')

		local HitsoundLeftMiscGroupBox = Tabs.Misc:AddLeftGroupbox('HITSOUNDS')
		local StaffLeftMiscGroupBox = Tabs.Misc:AddRightGroupbox('NOTIFICATION')
		local FarmRightMiscGroupBox = Tabs.Misc:AddRightGroupbox('AUTOFARM')

		local AimbotLeftCombatGroupBox = Tabs.Combat:AddLeftGroupbox('CAMLOCK')
		local KillAuraLeftCombatGroupBox = Tabs.Combat:AddRightGroupbox('MELEE KILL AURA')
		
		local MoveLeftMoveGroupBox = Tabs.Combat:AddRightGroupbox('MOVEMENT')

		local LootLeftLootGroupBox = Tabs.Misc:AddRightGroupbox('LOOT')

		local waterLeftLootGroupBox = Tabs.HUD:AddRightGroupbox('WATERMARK')

		local HasGun = false

		_G.ESPTeamCheck = false
		_G.ESPEnabled = false
		_G.ESPLocal = false
		_G.ESPShowTracers = true
		_G.ESPHealthBar = false
		_G.ESPShowBox = true
		_G.ESPShowName = false
		_G.ESPShowDistance = false
		_G.ESPShowTool = false
		_G.ESPTracerColor = Color3.fromRGB(255,65,65)
		_G.ESPBoxColor = Color3.fromRGB(255,65,65)
		_G.ESPDeathBagColor = Color3.fromRGB(179, 42, 44)
		_G.ESPDropBagColor = Color3.fromRGB(68, 179, 55)
		_G.ESPNpcBagColor = Color3.fromRGB(45, 179, 163)
		_G.ESPDeathBag = false
		_G.ESPNpcBag = false
		_G.ESPDropBag = false

		_G.CHAMSEnemyColor = Color3.fromRGB(255, 84, 87)
		_G.CHAMSTeamColor = Color3.fromRGB(103, 89, 179)
		_G.CHAMSEnabled = false
		_G.CHAMSShowTeams = true

		_G.TurnRainbowEnabled = false

		_G.DefaultCursor = "9373275104"
		_G.CustomCursor = "9373275104"

		_G.StaffMethod = "get notified"

		_G.Spinbot = false

		_G.RestockAutoFarm = false
		
		_G.AuraAliveCheck = false
		_G.AuraWallCheck = false
		_G.AuraEnabled = false
		_G.AuraRange = 20
		_G.AuraBlacklistPlayers = {} 
		_G.AuraFriendsBlacklist = false
		_G.AuraLockPart = "Head"

		AimbotSettings = {
			DeveloperSettings = {
				UpdateMode = "RenderStepped",
				TeamCheckOption = "TeamColor",
				RainbowSpeed = 1 -- Bigger = Slower
			},

			Settings = {
				Enabled = false,

				TeamCheck = false,
				AliveCheck = true,
				WallCheck = false,

				OffsetToMoveDirection = false,
				OffsetIncrement = 15, -- Min: 1; Max: 30

				Sensitivity = 0, -- Animation length (in seconds) before fully locking onto target
				Sensitivity2 = 3, -- mousemoverel Sensitivity

				LockMode = 1, -- 1 = CFrame; 2 = mousemoverel
				LockPart = "Head", -- Body part to lock on

				TriggerKey = Enum.UserInputType.MouseButton2,
				Toggle = false
			},

			FOVSettings = {
				Enabled = false,
				Visible = false,

				Radius = 90, -- Field Of View
				NumSides = 60,

				Thickness = 1,
				Transparency = 1,
				Filled = false,

				RainbowColor = false,
				RainbowOutlineColor = false,
				Color = Color3.fromRGB(255, 255, 255),
				OutlineColor = Color3.fromRGB(0, 0, 0),
				LockedColor = Color3.fromRGB(255, 150, 150)
			}
		}

		_G.AimbotEnabled = false
		_G.TeamCheck = false
		_G.AimPart = "Head"
		_G.Sensitivity = 0

		_G.AliveCheck = false
		_G.WallCheck = false

		_G.PlayerTrack = true
		_G.NPCTrack = false

		_G.BlacklistedPlayers = {}
		_G.FriendsBlacklist = true
		_G.AimKeybind = Enum.UserInputType.MouseButton2

		_G.CircleVisible = false
		_G.CircleRadius = 90
		_G.CircleSides = 60
		_G.CircleThickness = 1
		_G.CircleFilled = false
		_G.CircleColor = Color3.fromRGB(255, 255, 255)
		_G.OriginalCircleColor = Color3.fromRGB(255, 255, 255)

		local ESPLines = {}

		local Camera = workspace.CurrentCamera

		local i = 0

		local RainbowColor = Color3.fromRGB(0,0,0)

		local RunService = game:GetService("RunService")
		local SPEED = 0.1

		local initialSize = UDim2.new(0, 11, 0, 11) 

		local PixelSize = 0

		RunService.RenderStepped:Connect(function(delta)
			RainbowColor = Color3.fromHSV(i,1,1)
			i = (i + delta*SPEED) % 1
		end)

		local playerS = game.Players.LocalPlayer
		local mouse = playerS:GetMouse()

		local function updateImageSize(Image)
			Image.Size = UDim2.new(0, _G.CrossX, 0, _G.CrossY)
		end

		local Noclip = nil
		local Clip = nil

		function noclip()
			Clip = false
			local function Nocl()
				if Clip == false and game.Players.LocalPlayer.Character ~= nil then
					for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
						if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
							v.CanCollide = false
						end
					end
				end
				wait(0.21)
			end
			Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
		end

		function clip()
			if Noclip then Noclip:Disconnect() end
			Clip = true
		end
		
		local plr = game.Players.LocalPlayer

		_G.Speed = 0

		local Speed = function()
			if _G.SpeedEnabled then

				if true then
					plr.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + plr.Character.Humanoid.MoveDirection * _G.Speed/100
				end
			end
		end

		RunService.Heartbeat:Connect(function()
			Speed()
		end)


		local function ToggleRainbowFOV()
			task.spawn(function()
				repeat task.wait() 
					_G.CircleColor = RainbowColor
					task.wait()
				until _G.RainbowFov == false

				_G.CircleColor = _G.OriginalCircleColor
			end)
		end

		function create(instance, instanceStats, parent, player)
			local newinstance = Instance.new(instance)
			local lplr = game.Players.LocalPlayer

			if newinstance then
				if newinstance.Name == "Highlight" then
					newinstance.DepthMode = instanceStats.DepthMode
					newinstance.Name = instanceStats.Name
					newinstance.FillTransparency = instanceStats.FillTransparency
					newinstance.OutlineTransparency = instanceStats.OutlineTransparency
					newinstance.Parent = parent
					newinstance.Enabled = false

					task.spawn(function()
						while wait() do
							if newinstance ~= nil then

								if _G.CHAMSShowTeams then
									if player.TeamColor == lplr.TeamColor then
										newinstance.FillColor = _G.CHAMSTeamColor
										newinstance.Enabled = false
									else
										newinstance.FillColor = _G.CHAMSEnemyColor
									end
								elseif not _G.CHAMSShowTeams then
									if player.TeamColor == lplr.TeamColor then
										if player.TeamColor == nil then
											newinstance.Enabled = true
											newinstance.FillColor = _G.CHAMSEnemyColor
										else
											newinstance.Enabled = false
										end
									else
										newinstance.Enabled = true
										newinstance.FillColor = _G.CHAMSEnemyColor
									end
								end


								if _G.CHAMSEnabled then
									newinstance.Enabled = true
								else
									newinstance.Enabled = false
								end
							end
						end
					end)
				end
			end
		end

		local RunService = game:GetService("RunService")
		local Players = game:GetService("Players")

		local characterPI = game.Players.LocalPlayer.Character
		local humanoidMove = characterPI:WaitForChild("Humanoid").MoveDirection
		local rootPart = characterPI:WaitForChild("HumanoidRootPart")

		local turnAmount = 0
		local tiltSpeed = 5

		local function UpdateTilt()
			local tiltAngle = math.rad(turnAmount) * tiltSpeed
			rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, tiltAngle, 0)
		end

		local FarmBroker = workspace.NPCs.Other:FindFirstChild("Broker")

		local vim = game:GetService('VirtualInputManager')

		input = {
			hold = function(key, time)
				vim:SendKeyEvent(true, key, false, game)
				task.wait(time)
				vim:SendKeyEvent(false, key, false, game)
			end,
			press = function(key)
				vim:SendKeyEvent(true, key, false, game)
				task.wait(0.005)
				vim:SendKeyEvent(false, key, false, game)
			end,
			holdMouse = function(button, time, x, y)
				vim:SendMouseButtonEvent(x, y, button.Value, true, game, 0)
				task.wait(time)
				vim:SendMouseButtonEvent(x, y, button.Value, false, game, 0)
			end,
			pressMouse = function(button, x, y)
				vim:SendMouseButtonEvent(x, y, button.Value, true, game, 0)
				task.wait(0.005)
				vim:SendMouseButtonEvent(x, y, button.Value, false, game, 0)
			end
		}

		local function getButtonPosition(button)
			local absolutePosition = button.AbsolutePosition
			local x = absolutePosition.X
			local y = absolutePosition.Y
			return x, y
		end

		local function GrabCash()
			local Terminal = workspace.Terminals.Terminal
			game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = Terminal.CFrame
			task.wait(0.8)
			input.press(Enum.KeyCode.E)
			task.wait(0.5)

			local MainX,MainY = getButtonPosition(game.Players.LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("MainGui").Stash.MainFrame.TopBar.Tabs.Currency)
			local Main3X,Main3Y = getButtonPosition(game.Players.LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("MainGui").Stash.MainFrame.Tabs.Currency.Transfer.Withdraw)
			local Main4X,Main4Y = getButtonPosition(game.Players.LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("MainGui").Stash.MainFrame.TopBar.Close)

			input.pressMouse(Enum.UserInputType.MouseButton1, MainX + 100, MainY + 100)
			game.Players.LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("MainGui").Stash.MainFrame.Tabs.Currency.Transfer.AmountFrame.Amount.Text = "500"
			task.wait(2)
			input.pressMouse(Enum.UserInputType.MouseButton1, Main3X + 100, Main3Y + 100)
			task.wait(0.05)
			input.pressMouse(Enum.UserInputType.MouseButton1, Main4X + 30, Main4Y + 70)
		end

		local IsAvaible = true

		local function RestockAutoFarm()
			if not _G.RestockAutoFarm then
				return
			end

			if not IsAvaible then
				return
			end

			if game.Players.LocalPlayer:FindFirstChild("PlayerGui"):GetAttribute("Cash") < 500 then
				print("⛔ [NEBULA HUB]: You do not have > 500 cash to start this mission")
				return
			end

			if game.Players.LocalPlayer.Character then
				game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = FarmBroker.HumanoidRootPart.CFrame

				task.wait(0.8)
				input.press(Enum.KeyCode.E)
				task.wait(2)
				input.press(Enum.KeyCode.One)

				local MainX,MainY
				local Main2X,Main2Y = getButtonPosition(game.Players.LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("MainGui").Tasks.MainFrame.PreviewFrame.StartTask)

				for i,v in pairs(game.Players.LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("MainGui").Tasks.MainFrame.TaskList.List:GetDescendants()) do
					if v:IsA("TextLabel") and v.Text == "RESTOCKING" then
						MainX,MainY = getButtonPosition(v.Parent)
						IsAvaible = true
					end
				end

				if not IsAvaible then
					task.spawn(function()
						game.Players.LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("MainGui").Tasks.Visible = false
						task.wait(260)
						RestockAutoFarm()
					end)
					return
				end

				input.pressMouse(Enum.UserInputType.MouseButton1, MainX + 100, MainY + 100)
				task.wait(0.2)
				input.pressMouse(Enum.UserInputType.MouseButton1, Main2X + 100, Main2Y + 100)
				task.wait(0.8)
				if not game.Workspace.Debris.Nav:FindFirstChild("Destination") then
					task.wait(120) --
					RestockAutoFarm()
				else
					game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = game.Workspace.Debris.Nav.Destination.CFrame
					task.wait(1)
					GrabCash()
					task.wait(4)
					RestockAutoFarm()
				end	
			end
		end

		local function OnRenderStep()
			if _G.Spinbot then
				local moveDirection = humanoidMove + Vector3.new(1,0,1)
				local moveRotation = math.atan2(moveDirection.X, moveDirection.Z)
				turnAmount = math.deg(moveRotation)

				game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
					humanoidMove = character:WaitForChild("Humanoid").MoveDirection
					rootPart = character:WaitForChild("HumanoidRootPart")
				end)

				UpdateTilt()
			end
		end

		RunService.RenderStepped:Connect(OnRenderStep)

		function StartCHAMS()
			local lplr = game.Players.LocalPlayer


			local ChamsStats = {
				Name = "Chams",
				DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
				FillTransparency = 0,
				OutlineTransparency = 1,
			}

			for i,v in pairs(game.Players:GetChildren()) do
				if v.Character ~= nil and v ~= lplr then
					create("Highlight", ChamsStats, v.Character, v)

					v.CharacterAdded:Connect(function()
						create("Highlight", ChamsStats, v.Character, v)
					end)
				end
			end

			game.Players.PlayerAdded:Connect(function(v)
				if v.Character ~= nil and v ~= lplr then
					create("Highlight", ChamsStats, v.Character, v)
				end

				v.CharacterAdded:Connect(function()
					if v.Character ~= nil and v ~= lplr then
						create("Highlight", ChamsStats, v.Character, v)
					end
				end)
			end)
		end

		StartCHAMS()

		local Settings = {
			BulletTracers = false,
			BulletTraceMeterial = "ForceField",
			BulletTracersColor = Color3.new(255, 0, 0),
		}

		local Tracer = function(begin, endpos)
			local tracer = Instance.new("Part")
			tracer.Anchored = true
			tracer.CanCollide = false
			tracer.Material = Settings.BulletTraceMeterial
			tracer.Color = Settings.BulletTracersColor
			tracer.Size = Vector3.new(0.1, 0.1, (begin - endpos).Magnitude)
			tracer.CFrame = CFrame.new(begin, endpos) * CFrame.new(0, 0, -tracer.Size.Z / 2)
			tracer.Parent = workspace
			game.Debris:AddItem(tracer, 0.1)
		end

		game.Players.LocalPlayer.Character.ChildAdded:Connect(function(model)
			if model.Name == "ServerGunModel" then
				HasGun = true

				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui") then
					if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").FollowMouse:FindFirstChild("NewCustomCursor") then
						game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").FollowMouse.NewCustomCursor.Visible = false
					end
				end
			end
		end)

		game.Players.LocalPlayer.Character.ChildRemoved:Connect(function(model)
			if model.Name == "ServerGunModel" then
				HasGun = false
				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui") then
					if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").FollowMouse:FindFirstChild("NewCustomCursor") then
						game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").FollowMouse.NewCustomCursor.Visible = true
					end
				end
			end
		end)

		local function TurnRainbow()
			if _G.TurnRainbowEnabled then
				workspace.CurrentCamera.ChildAdded:Connect(function(model)
					if model.Name == "ViewModel" then
						if workspace.CurrentCamera:FindFirstChild("ViewModel") then
							for i,v in pairs(workspace.CurrentCamera:FindFirstChild("ViewModel"):GetDescendants()) do
								if v:IsA("MeshPart") then
									if v:FindFirstChildWhichIsA("SurfaceAppearance") then
										v:FindFirstChildWhichIsA("SurfaceAppearance"):Destroy()
									end


									RunService.RenderStepped:Connect(function(delta)
										v.Color = RainbowColor

									end)

									v.Material = Enum.Material.ForceField
								end    
							end    
						end
					end
				end)

				game.Players.LocalPlayer.Character.ChildAdded:Connect(function(model)
					if model.Name == "ServerGunModel" or model.Name == "ServerMeleeModel" then
						if game.Players.LocalPlayer.Character:FindFirstChild("ServerGunModel") then
							task.wait(0.1)


							for i,v in pairs(game.Players.LocalPlayer.Character:FindFirstChild("ServerGunModel"):GetChildren()) do
								if v:IsA("MeshPart") then
									if v:FindFirstChildWhichIsA("SurfaceAppearance") then
										v:FindFirstChildWhichIsA("SurfaceAppearance"):Destroy()
									end


									RunService.RenderStepped:Connect(function(delta)
										v.Color = RainbowColor
									end)

									v.Material = Enum.Material.ForceField
								end 
							end 
						end	

						if game.Players.LocalPlayer.Character:FindFirstChild("ServerMeleeModel") then
							task.wait(0.1)
							for i,v in pairs(game.Players.LocalPlayer.Character:FindFirstChild("ServerMeleeModel"):GetChildren()) do
								if v:IsA("MeshPart") then
									if v:FindFirstChildWhichIsA("SurfaceAppearance") then
										v:FindFirstChildWhichIsA("SurfaceAppearance"):Destroy()
									end


									RunService.RenderStepped:Connect(function(delta)
										v.Color = RainbowColor
									end)

									v.Material = Enum.Material.ForceField
								end 
							end 
						end	
					end
				end)


				if workspace.CurrentCamera:FindFirstChild("ViewModel") then
					for i,v in pairs(workspace.CurrentCamera:FindFirstChild("ViewModel"):GetDescendants()) do
						if v:IsA("MeshPart") then
							if v:FindFirstChildWhichIsA("SurfaceAppearance") then
								v:FindFirstChildWhichIsA("SurfaceAppearance"):Destroy()
							end


							RunService.RenderStepped:Connect(function(delta)
								v.Color = RainbowColor

							end)

							v.Material = Enum.Material.ForceField
						end    
					end    
				end

				if game.Players.LocalPlayer.Character:FindFirstChild("ServerGunModel") then
					for i,v in pairs(game.Players.LocalPlayer.Character:FindFirstChild("ServerGunModel"):GetChildren()) do
						if v:IsA("MeshPart") then
							if v:FindFirstChildWhichIsA("SurfaceAppearance") then
								v:FindFirstChildWhichIsA("SurfaceAppearance"):Destroy()
							end


							RunService.RenderStepped:Connect(function(delta)
								v.Color = RainbowColor

							end)

							v.Material = Enum.Material.ForceField
						end    
					end 
				end

				if game.Players.LocalPlayer.Character:FindFirstChild("Left Arm") then
					game.Players.LocalPlayer.Character:FindFirstChild("Left Arm").Material = Enum.Material.ForceField


					RunService.RenderStepped:Connect(function(delta)
						if game.Players.LocalPlayer.Character:FindFirstChild("Left Arm") then
							game.Players.LocalPlayer.Character:FindFirstChild("Left Arm").Color = RainbowColor
							game.Players.LocalPlayer.Character:FindFirstChild("Left Arm").Material = Enum.Material.ForceField
						end
					end)
				end

				if game.Players.LocalPlayer.Character:FindFirstChild("Right Arm") then
					game.Players.LocalPlayer.Character:FindFirstChild("Right Arm").Material = Enum.Material.ForceField


					RunService.RenderStepped:Connect(function(delta)
						if game.Players.LocalPlayer.Character:FindFirstChild("Right Arm") then
							game.Players.LocalPlayer.Character:FindFirstChild("Right Arm").Color = RainbowColor
							game.Players.LocalPlayer.Character:FindFirstChild("Right Arm").Material = Enum.Material.ForceField
						end
					end)
				end
			end
		end

		local function StartESP()
			local lplr = game.Players.LocalPlayer
			local camera = game:GetService("Workspace").CurrentCamera
			local CurrentCamera = workspace.CurrentCamera
			local worldtoViewportPoint = CurrentCamera.WorldToViewportPoint

			local HeadOff = Vector3.new(0, 0.5, 0)
			local LegOff = Vector3.new(0,3,0)

			for i,v in pairs(game.Workspace.Debris.Loot:GetChildren()) do
				if game.Workspace.Debris.Loot:FindFirstChild(v.Name) then
					local Tracer = Drawing.new("Line")
					Tracer.Visible = false

					Tracer.Thickness = 1
					Tracer.Transparency = 1

					local TypeText = Drawing.new("Text")
					TypeText.Visible = false
					TypeText.Center = true
					TypeText.Outline = true
					TypeText.Font = 2
					TypeText.Size = 13
					TypeText.Text = "Type"

					function lineesp()
						game:GetService("RunService").RenderStepped:Connect(function()
							if game.Workspace.Debris.Loot:FindFirstChild(v.Name) then
								if v.Name == "DroneLoot" then
									return
								end

								local Vector, OnScreen = camera:WorldToViewportPoint(v.Position)

								if _G.ESPEnabled then
									if OnScreen then
										Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
										Tracer.To = Vector2.new(Vector.X, Vector.Y)
										TypeText.Position = Vector2.new(Vector.X, Vector.Y - 10)

										if v.Color == Color3.fromRGB(255,63,63) then
											if _G.ESPDeathBag == true then
												TypeText.Text = "Death Bag"
												TypeText.Color = _G.ESPDeathBagColor
												TypeText.Visible = true
												Tracer.Color = _G.ESPDeathBagColor
												Tracer.Visible = true
											else
												TypeText.Visible = false
												Tracer.Visible = false
											end
										elseif v.Color == Color3.fromRGB(0,127,255) then
											if v.Name == "DeathBag" then
												if _G.ESPNpcBag == true then
													TypeText.Text = "NPC Death Bag"
													TypeText.Color = _G.ESPNpcBagColor
													TypeText.Visible = true
													Tracer.Color = _G.ESPNpcBagColor
													Tracer.Visible = true
												else
													TypeText.Visible = false
													Tracer.Visible = false
												end
											elseif v.Name == "DuffelBag" then
												if _G.ESPDropBag == true then
													TypeText.Text = "Drop Bag"
													TypeText.Color = _G.ESPDropBagColor
													TypeText.Visible = true
													Tracer.Color = _G.ESPDropBagColor
													Tracer.Visible = true
												else
													TypeText.Visible = false
													Tracer.Visible = false
												end
											end
										end

										if not _G.ESPShowTracers  then
											TypeText.Visible = false
											Tracer.Visible = false
										end

										v.Destroying:Connect(function()
											TypeText.Visible = false
											Tracer.Visible = false
										end)
									else
										TypeText.Visible = false
										Tracer.Visible = false
									end
								else
									TypeText.Visible = false
									Tracer.Visible = false
								end
							else
								TypeText.Visible = false
								Tracer.Visible = false
							end
						end)
					end

					task.spawn(function()
						coroutine.wrap(lineesp)()
					end)
				end
			end

			game.Workspace.Debris.Loot.ChildAdded:Connect(function(v)
				if game.Workspace.Debris.Loot:FindFirstChild(v.Name) then
					local Tracer = Drawing.new("Line")
					Tracer.Visible = false

					Tracer.Thickness = 1
					Tracer.Transparency = 1

					local TypeText = Drawing.new("Text")
					TypeText.Visible = false
					TypeText.Center = true
					TypeText.Outline = true
					TypeText.Font = 2
					TypeText.Size = 13
					TypeText.Text = "Type"

					function lineesp()
						game:GetService("RunService").RenderStepped:Connect(function()
							if game.Workspace.Debris.Loot:FindFirstChild(v.Name) then
								local Vector, OnScreen = camera:WorldToViewportPoint(v.Position)

								if _G.ESPEnabled then
									if OnScreen then
										Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
										Tracer.To = Vector2.new(Vector.X, Vector.Y)
										TypeText.Position = Vector2.new(Vector.X, Vector.Y - 10)

										if v.Color == Color3.fromRGB(255,63,63) then
											if _G.ESPDeathBag == true then
												TypeText.Text = "Death Bag"
												TypeText.Color = _G.ESPDeathBagColor
												TypeText.Visible = true
												Tracer.Color = _G.ESPDeathBagColor
												Tracer.Visible = true
											else
												TypeText.Visible = false
												Tracer.Visible = false
											end
										elseif v.Color == Color3.fromRGB(0,127,255) then
											if v.Name == "DeathBag" then
												if _G.ESPNpcBag == true then
													TypeText.Text = "NPC Death Bag"
													TypeText.Color = _G.ESPNpcBagColor
													TypeText.Visible = true
													Tracer.Color = _G.ESPNpcBagColor
													Tracer.Visible = true
												else
													TypeText.Visible = false
													Tracer.Visible = false
												end
											elseif v.Name == "DuffelBag" then
												if _G.ESPDropBag == true then
													TypeText.Text = "Drop Bag"
													TypeText.Color = _G.ESPDropBagColor
													TypeText.Visible = true
													Tracer.Color = _G.ESPDropBagColor
													Tracer.Visible = true
												else
													TypeText.Visible = false
													Tracer.Visible = false
												end
											end
										end

										if not _G.ESPShowTracers  then
											TypeText.Visible = false
											Tracer.Visible = false
										end

										v.Destroying:Connect(function()
											TypeText.Visible = false
											Tracer.Visible = false
										end)
									else
										TypeText.Visible = false
										Tracer.Visible = false
									end
								else
									TypeText.Visible = false
									Tracer.Visible = false
								end
							else
								TypeText.Visible = false
								Tracer.Visible = false
							end
						end)
					end

					task.spawn(function()
						coroutine.wrap(lineesp)()
					end)
				end
			end)

			for i,v in pairs(game.Players:GetChildren()) do
				if v.Character ~= nil and v.Character:WaitForChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
					local Tracer = Drawing.new("Line")
					Tracer.Visible = false

					Tracer.Thickness = 1
					Tracer.Transparency = 1

					local BoxOutline = Drawing.new("Square")
					BoxOutline.Visible = false
					BoxOutline.Color = Color3.new(0,0,0)
					BoxOutline.Thickness = 3
					BoxOutline.Transparency = 1
					BoxOutline.Filled = false

					local Box = Drawing.new("Square")
					Box.Visible = false
					Box.Thickness = 1
					Box.Transparency = 1
					Box.Filled = false

					local HealthBarOutline = Drawing.new("Square")
					HealthBarOutline.Visible = false
					HealthBarOutline.Color = Color3.new(0,0,0)
					HealthBarOutline.Thickness = 1.5
					HealthBarOutline.Transparency = 1
					HealthBarOutline.Filled = false

					local HealthBar = Drawing.new("Square")
					HealthBar.Visible = false
					HealthBar.Thickness = 1
					HealthBar.Transparency = 1
					HealthBar.Filled = true

					local ItemName = Drawing.new("Text")
					ItemName.Visible = false
					ItemName.Center = true
					ItemName.Outline = true
					ItemName.Font = 2
					ItemName.Size = 13
					ItemName.Text = "Item"

					local NameText = Drawing.new("Text")
					NameText.Visible = false
					NameText.Center = true
					NameText.Outline = true
					NameText.Font = 2
					NameText.Size = 13
					NameText.Text = "Type"

					local DistanceText = Drawing.new("Text")
					DistanceText.Visible = false
					DistanceText.Center = true
					DistanceText.Outline = true
					DistanceText.Font = 2
					DistanceText.Size = 13
					DistanceText.Text = "Distance"

					function lineesp()
						game:GetService("RunService").RenderStepped:Connect(function()
							if v.Character ~= nil and v.Character:WaitForChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
								local Vector, OnScreen = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)

								if _G.ESPEnabled then
									if OnScreen then
										Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
										Tracer.To = Vector2.new(Vector.X, Vector.Y)
										Tracer.Color = _G.ESPTracerColor

										if not _G.ESPShowTracers  then
											Tracer.Visible = false
										end

										if _G.ESPTeamCheck and v.TeamColor == lplr.TeamColor then
											Tracer.Visible = false
										else
											if _G.ESPShowTracers then
												Tracer.Visible = true
											elseif not _G.ESPShowTracers then
												Tracer.Visible = false
											end
										end
									else
										Tracer.Visible = false
									end
								else
									Tracer.Visible = false
								end
							else
								Tracer.Visible = false
							end
						end)
					end

					function boxesp()
						game:GetService("RunService").RenderStepped:Connect(function()
							if v.Character ~= nil and v.Character:WaitForChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
								local Vector, OnScreen = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)

								local RootPart = v.Character.HumanoidRootPart
								local Head = v.Character.Head
								local RootPosition, RootVis = worldtoViewportPoint(CurrentCamera, RootPart.Position)
								local HeadPosition = worldtoViewportPoint(CurrentCamera, Head.Position + HeadOff)
								local LegPosition = worldtoViewportPoint(CurrentCamera, RootPart.Position - LegOff)

								if _G.ESPEnabled then
									if OnScreen then
										BoxOutline.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
										BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)

										Box.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
										Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
										Box.Color = _G.ESPBoxColor

										HealthBarOutline.Size = Vector2.new(2, HeadPosition.Y - LegPosition.Y)
										HealthBarOutline.Position = BoxOutline.Position - Vector2.new(6,0)

										HealthBar.Size = Vector2.new(2, (HeadPosition.Y - LegPosition.Y) / (v.Character:WaitForChild("Humanoid").MaxHealth / math.clamp(v.Character:WaitForChild("Humanoid").Health, 0, v.Character:WaitForChild("Humanoid").MaxHealth)))
										HealthBar.Position = Vector2.new(Box.Position.X - 6, Box.Position.Y + (1/HealthBar.Size.Y))
										HealthBar.Color = Color3.fromRGB(255 - 255 / (v.Character:WaitForChild("Humanoid").MaxHealth / v.Character:WaitForChild("Humanoid").Health), 255 / (v.Character:WaitForChild("Humanoid").MaxHealth / v.Character:WaitForChild("Humanoid").Health), 0)

										ItemName.Position = Vector2.new(Vector.X, Vector.Y - 30)
										NameText.Position = Vector2.new(Vector.X, Vector.Y - 20)
										DistanceText.Position = Vector2.new(Vector.X, Vector.Y - 10)

										local ItemDistance = math.round((v.Character:WaitForChild("HumanoidRootPart").Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude)

										NameText.Color = _G.ESPBoxColor
										DistanceText.Color = _G.ESPBoxColor
										ItemName.Color = _G.ESPBoxColor

										DistanceText.Text = "[" .. tostring(ItemDistance) .. "]"
										NameText.Text = v.Name

										if v.Character then
											if v.Character:FindFirstChild("ServerMeleeModel") or v.Character:FindFirstChild("ServerGunModel") then
												if v.Character:FindFirstChildWhichIsA("RayValue") then
													ItemName.Text = v.Character:FindFirstChildWhichIsA("RayValue").Name
													ItemName.Visible = true
												else
													ItemName.Visible = false
												end
											else
												ItemName.Visible = false
											end
										else
											ItemName.Visible = false
										end

										if _G.ESPShowName then
											NameText.Visible = true
										else
											NameText.Visible = false
										end

										if _G.ESPShowDistance then
											DistanceText.Visible = true
										else
											DistanceText.Visible = false
										end

										if _G.ESPShowTool then
											ItemName.Visible = true
										else
											ItemName.Visible = false
										end

										if _G.ESPTeamCheck and v.TeamColor == lplr.TeamColor then
											BoxOutline.Visible = false
											Box.Visible = false

											if _G.ESPHealthBar then
												HealthBarOutline.Visible = false
												HealthBar.Visible = false
											end
										else
											if _G.ESPShowBox then
												BoxOutline.Visible = true
												Box.Visible = true
											else
												BoxOutline.Visible = false
												Box.Visible = false
											end

											if _G.ESPHealthBar then
												HealthBarOutline.Visible = true
												HealthBar.Visible = true
											else
												HealthBarOutline.Visible = false
												HealthBar.Visible = false
											end
										end
									else
										BoxOutline.Visible = false
										Box.Visible = false
										HealthBarOutline.Visible = false
										HealthBar.Visible = false
										ItemName.Visible = false
										NameText.Visible = false
										DistanceText.Visible = false
									end
								else
									BoxOutline.Visible = false
									Box.Visible = false
									HealthBarOutline.Visible = false
									HealthBar.Visible = false
									ItemName.Visible = false
									NameText.Visible = false
									DistanceText.Visible = false
								end
							else
								BoxOutline.Visible = false
								Box.Visible = false
								HealthBarOutline.Visible = false
								HealthBar.Visible = false
								ItemName.Visible = false
								NameText.Visible = false
								DistanceText.Visible = false
							end
						end)
					end

					task.spawn(function()
						coroutine.wrap(lineesp)()
					end)
					task.spawn(function()
						coroutine.wrap(boxesp)()
					end)
				end	
			end

			game.Players.PlayerAdded:Connect(function(v)
				if v.Character ~= nil and v.Character:WaitForChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
					local Tracer = Drawing.new("Line")
					Tracer.Visible = false
					Tracer.Thickness = 1
					Tracer.Transparency = 1

					local BoxOutline = Drawing.new("Square")
					BoxOutline.Visible = false
					BoxOutline.Color = Color3.new(0,0,0)
					BoxOutline.Thickness = 3
					BoxOutline.Transparency = 1
					BoxOutline.Filled = false

					local Box = Drawing.new("Square")
					Box.Visible = false
					Box.Thickness = 1.5
					Box.Transparency = 1
					Box.Filled = false

					local HealthBarOutline = Drawing.new("Square")
					HealthBarOutline.Visible = false
					HealthBarOutline.Color = Color3.new(0,0,0)
					HealthBarOutline.Thickness = 1.5
					HealthBarOutline.Transparency = 1
					HealthBarOutline.Filled = false

					local HealthBar = Drawing.new("Square")
					HealthBar.Visible = false
					HealthBar.Thickness = 1
					HealthBar.Transparency = 1
					HealthBar.Filled = true

					local ItemName = Drawing.new("Text")
					ItemName.Visible = false
					ItemName.Center = true
					ItemName.Outline = true
					ItemName.Font = 2
					ItemName.Size = 13
					ItemName.Text = "Scrap"

					local NameText = Drawing.new("Text")
					NameText.Visible = false
					NameText.Center = true
					NameText.Outline = true
					NameText.Font = 2
					NameText.Size = 13
					NameText.Text = "Type"

					local DistanceText = Drawing.new("Text")
					DistanceText.Visible = false
					DistanceText.Center = true
					DistanceText.Outline = true
					DistanceText.Font = 2
					DistanceText.Size = 13
					DistanceText.Text = "Distance"

					function lineesp()
						game:GetService("RunService").RenderStepped:Connect(function()
							if v.Character ~= nil and v.Character:WaitForChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
								local Vector, OnScreen = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)

								if _G.ESPEnabled then
									if OnScreen then
										Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
										Tracer.To = Vector2.new(Vector.X, Vector.Y)
										Tracer.Color = _G.ESPTracerColor

										if not _G.ESPShowTracers  then
											Tracer.Visible = false
										end

										if _G.ESPTeamCheck and v.TeamColor == lplr.TeamColor then
											Tracer.Visible = false
										else
											if _G.ESPShowTracers then
												Tracer.Visible = true
											elseif not _G.ESPShowTracers then
												Tracer.Visible = false
											end
										end
									else
										Tracer.Visible = false
									end
								else
									Tracer.Visible = false
								end
							else
								Tracer.Visible = false
							end
						end)
					end

					function boxesp()
						game:GetService("RunService").RenderStepped:Connect(function()
							if v.Character ~= nil and v.Character:WaitForChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
								local Vector, OnScreen = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)

								local RootPart = v.Character.HumanoidRootPart
								local Head = v.Character.Head
								local RootPosition, RootVis = worldtoViewportPoint(CurrentCamera, RootPart.Position)
								local HeadPosition = worldtoViewportPoint(CurrentCamera, Head.Position + HeadOff)
								local LegPosition = worldtoViewportPoint(CurrentCamera, RootPart.Position - LegOff)

								if _G.ESPEnabled then
									if OnScreen then
										BoxOutline.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
										BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)

										Box.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
										Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
										Box.Color = _G.ESPBoxColor

										HealthBarOutline.Size = Vector2.new(2, HeadPosition.Y - LegPosition.Y)
										HealthBarOutline.Position = BoxOutline.Position - Vector2.new(6,0)

										HealthBar.Size = Vector2.new(2, (HeadPosition.Y - LegPosition.Y) / (v.Character:WaitForChild("Humanoid").MaxHealth / math.clamp(v.Character:WaitForChild("Humanoid").Health, 0, v.Character:WaitForChild("Humanoid").MaxHealth)))
										HealthBar.Position = Vector2.new(Box.Position.X - 6, Box.Position.Y + (1/HealthBar.Size.Y))
										HealthBar.Color = Color3.fromRGB(255 - 255 / (v.Character:WaitForChild("Humanoid").MaxHealth / v.Character:WaitForChild("Humanoid").Health), 255 / (v.Character:WaitForChild("Humanoid").MaxHealth / v.Character:WaitForChild("Humanoid").Health), 0)

										ItemName.Position = Vector2.new(Vector.X, Vector.Y - 30)
										NameText.Position = Vector2.new(Vector.X, Vector.Y - 20)
										DistanceText.Position = Vector2.new(Vector.X, Vector.Y - 10)

										local ItemDistance = math.ceil((v.Character:WaitForChild("HumanoidRootPart").Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude)

										NameText.Color = _G.ESPBoxColor
										DistanceText.Color = _G.ESPBoxColor
										ItemName.Color = _G.ESPBoxColor

										DistanceText.Text = "Distance: {" .. tostring(ItemDistance) .. "}"
										NameText.Text = v.Name

										if v.Character then
											if v.Character:FindFirstChild("ServerMeleeModel") or v.Character:FindFirstChild("ServerGunModel") then
												if v.Character:FindFirstChildWhichIsA("RayValue") then
													ItemName.Text = v.Character:FindFirstChildWhichIsA("RayValue").Name
													ItemName.Visible = true
												else
													ItemName.Visible = false
												end
											else
												ItemName.Visible = false
											end
										else
											ItemName.Visible = false
										end

										if _G.ESPShowName then
											NameText.Visible = true
										else
											NameText.Visible = false
										end

										if _G.ESPShowDistance then
											DistanceText.Visible = true
										else
											DistanceText.Visible = false
										end

										if _G.ESPShowTool then
											ItemName.Visible = true
										else
											ItemName.Visible = false
										end

										if _G.ESPTeamCheck and v.TeamColor == lplr.TeamColor then
											BoxOutline.Visible = false
											Box.Visible = false

											if _G.ESPHealthBar then
												HealthBarOutline.Visible = false
												HealthBar.Visible = false
											end
										else
											if _G.ESPShowBox then
												BoxOutline.Visible = true
												Box.Visible = true
											else
												BoxOutline.Visible = false
												Box.Visible = false
											end

											if _G.ESPHealthBar then
												HealthBarOutline.Visible = true
												HealthBar.Visible = true
											else
												HealthBarOutline.Visible = false
												HealthBar.Visible = false
											end
										end
									else
										BoxOutline.Visible = false
										Box.Visible = false
										HealthBarOutline.Visible = false
										HealthBar.Visible = false
										ItemName.Visible = false
										NameText.Visible = false
										DistanceText.Visible = false
									end
								else
									BoxOutline.Visible = false
									Box.Visible = false
									HealthBarOutline.Visible = false
									HealthBar.Visible = false
									ItemName.Visible = false
									NameText.Visible = false
									DistanceText.Visible = false
								end
							else
								BoxOutline.Visible = false
								Box.Visible = false
								HealthBarOutline.Visible = false
								HealthBar.Visible = false
								ItemName.Visible = false
								NameText.Visible = false
								DistanceText.Visible = false
							end
						end)
					end

					task.spawn(function()
						coroutine.wrap(lineesp)()
					end)
					task.spawn(function()
						coroutine.wrap(boxesp)()
					end)
				end
			end)
		end	

		StartESP()

		LeftVisualGroupBox:AddToggle('EnabledESP', {
			Text = 'Enable',
			Default = false, -- Default value (true / false)
			Tooltip = 'Enable the esp [if you experience extreme lag please enable the option [Show Distance]', -- Information shown when you hover over the toggle

			Callback = function(Value)
				_G.ESPEnabled = Value           
			end
		})

		LeftVisualGroupBox:AddToggle('TeamCheck', {
			Text = 'Team Check',
			Default = false, -- Default value (true / false)
			Tooltip = 'Checks if players are on your team (if there is no teams then set this to false)', -- Information shown when you hover over the toggle

			Callback = function(Value)
				_G.ESPTeamCheck = Value
			end
		})

		LeftVisualGroupBox:AddToggle('ShowTracers', {
			Text = 'Show Tracers',
			Default = true, -- Default value (true / false)
			Tooltip = 'Shows the tracers', -- Information shown when you hover over the toggle

			Callback = function(Value)
				_G.ESPShowTracers = Value
			end
		})

		LeftVisualGroupBox:AddToggle('ShowBox', {
			Text = 'Show Boxes',
			Default = true, -- Default value (true / false)
			Tooltip = 'Shows the boxes', -- Information shown when you hover over the toggle

			Callback = function(Value)
				_G.ESPShowBox = Value
			end
		})

		LeftVisualGroupBox:AddToggle('ShowHealthBar', {
			Text = 'Show HealthBar',
			Default = false, -- Default value (true / false)
			Tooltip = 'Shows the health bar of the player', -- Information shown when you hover over the toggle

			Callback = function(Value)
				_G.ESPHealthBar = Value
			end
		})

		LeftVisualGroupBox:AddToggle('DeathBag', {
			Text = 'Show Death Bags',
			Default = false, -- Default value (true / false)
			Tooltip = 'Shows all of the players death bags', -- Information shown when you hover over the toggle

			Callback = function(Value)
				_G.ESPDeathBag = Value
			end
		})

		LeftVisualGroupBox:AddToggle('ShowTool', {
			Text = 'Player Tool',
			Default = false, -- Default value (true / false)
			Tooltip = 'Shows if the player is holding a tool.', -- Information shown when you hover over the toggle

			Callback = function(Value)
				_G.ESPShowTool = Value
			end
		})

		LeftVisualGroupBox:AddToggle('ShowDistance', {
			Text = 'Show Distance',
			Default = false, -- Default value (true / false)
			Tooltip = 'Shows the distance between you and the player.', -- Information shown when you hover over the toggle

			Callback = function(Value)
				_G.ESPShowDistance = Value
			end
		})

		LeftVisualGroupBox:AddToggle('ShowName', {
			Text = 'Show Names',
			Default = false, -- Default value (true / false)
			Tooltip = 'Shows the name of the player kinda like [Nametags].', -- Information shown when you hover over the toggle

			Callback = function(Value)
				_G.ESPShowName = Value
			end
		})

		LeftVisualGroupBox:AddToggle('NPCDeathBag', {
			Text = 'Show NPC Death Bags',
			Default = false, -- Default value (true / false)
			Tooltip = 'Shows all of the NPCS death bags', -- Information shown when you hover over the toggle

			Callback = function(Value)
				_G.ESPNpcBag = Value
			end
		})

		LeftVisualGroupBox:AddToggle('DropBag', {
			Text = 'Show Drop Bags',
			Default = false, -- Default value (true / false)
			Tooltip = 'Shows all of the Dropped item bags', -- Information shown when you hover over the toggle

			Callback = function(Value)
				_G.ESPDropBag = Value
			end
		})

		LeftVisualGroupBox:AddToggle('NameTags', {
			Text = 'Nametags',
			Default = false, -- Default value (true / false)
			Tooltip = 'Shows all of the players nametags', -- Information shown when you hover over the toggle

			Callback = function(Value)
				if Value == false then
					for i,v in pairs(game.Workspace.Debris.Guis:GetChildren()) do
						v.MaxDistance = 20
						v.Size = UDim2.new(2.5,0, 0.9,0)
						v.SizeOffset = Vector2.new(0, 3.75)
						v.StudsOffset = Vector3.new(0,0,1)
						v.AlwaysOnTop = false
					end
				elseif Value == true then
					for i,v in pairs(game.Workspace.Debris.Guis:GetChildren()) do
						v.MaxDistance = 999999999999
						v.Size = UDim2.new(0,200, 0,30)
						v.SizeOffset = Vector2.new(0, 0)
						v.StudsOffset = Vector3.new(0,0,0)
						v.AlwaysOnTop = true
					end
				end
			end
		})

		LeftVisualGroupBox:AddDivider()

		LeftVisualGroupBox:AddLabel('Tracer Color'):AddColorPicker('ESPColorPicker', {
			Default = Color3.fromRGB(255,65,65), -- Bright green
			Title = 'Tracer Color', -- Optional. Allows you to have a custom color picker title (when you open it)
			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

			Callback = function(Value)
				_G.ESPTracerColor = Value
			end
		})

		LeftVisualGroupBox:AddLabel('Box Color'):AddColorPicker('ESPBoxColorPicker', {
			Default = Color3.fromRGB(255,65,65), -- Bright green
			Title = 'Box Color', -- Optional. Allows you to have a custom color picker title (when you open it)
			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

			Callback = function(Value)
				_G.ESPBoxColor = Value
			end
		})

		LeftVisualGroupBox:AddDivider()

		LeftVisualGroupBox:AddLabel('DeathBag Color'):AddColorPicker('ESPDeathBagColorPicker', {
			Default = Color3.fromRGB(179, 42, 44), -- Bright green
			Title = 'DeathBags Color', -- Optional. Allows you to have a custom color picker title (when you open it)
			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

			Callback = function(Value)
				_G.ESPDeathBagColor = Value
			end
		})

		LeftVisualGroupBox:AddLabel('NPC DeathBags Color'):AddColorPicker('ESPNPCDeathBagColorPicker', {
			Default = Color3.fromRGB(45, 179, 163), -- Bright green
			Title = 'NPC DeathBags Color', -- Optional. Allows you to have a custom color picker title (when you open it)
			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

			Callback = function(Value)
				_G.ESPNpcBagColor = Value
			end
		})

		LeftVisualGroupBox:AddLabel('Dropped Bags Color'):AddColorPicker('ESPDroppedBagColorPicker', {
			Default = Color3.fromRGB(68, 179, 55), -- Bright green
			Title = 'Dropped Bags Color', -- Optional. Allows you to have a custom color picker title (when you open it)
			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

			Callback = function(Value)
				_G.ESPDropBagColor = Value
			end
		})

		ChamsRightVisualGroupBox:AddToggle('EnableChams', {
			Text = 'Enable',
			Default = false, -- Default value (true / false)
			Tooltip = 'Enables chams', -- Information shown when you hover over the toggle

			Callback = function(Value)
				_G.CHAMSEnabled = Value
			end
		})

		ChamsRightVisualGroupBox:AddToggle('ShowCHAMSTeams', {
			Text = 'Show teamates',
			Default = true, -- Default value (true / false)
			Tooltip = 'Shows your teamates', -- Information shown when you hover over the toggle

			Callback = function(Value)
				_G.CHAMSShowTeams = Value
			end
		})

		ChamsRightVisualGroupBox:AddLabel('EnemyColor'):AddColorPicker('ChamsEnemyColorPicker', {
			Default = Color3.fromRGB(255, 84, 87), -- Bright green
			Title = 'Enemy Color', -- Optional. Allows you to have a custom color picker title (when you open it)
			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

			Callback = function(Value)
				_G.CHAMSEnemyColor = Value
			end
		})

		ChamsRightVisualGroupBox:AddLabel('Team Color'):AddColorPicker('ChamsTeamColorPicker', {
			Default = Color3.fromRGB(103, 89, 179), -- Bright green
			Title = 'Team Color', -- Optional. Allows you to have a custom color picker title (when you open it)
			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

			Callback = function(Value)
				_G.CHAMSTeamColor = Value
			end
		})

		local MyButton = GunsLeftVisualGroupBox:AddButton({
			Text = 'Rainbowfy',
			Func = function()
				_G.TurnRainbowEnabled = true
				TurnRainbow()
			end,
			DoubleClick = false,
			Tooltip = 'Turns anygun you have into rainbow'
		})

		GunsLeftVisualGroupBox:AddDivider()

		GunsLeftVisualGroupBox:AddLabel('[MORE TO COME]')

		CrosshairRightVisualGroupBox:AddInput('CrosshairImage', {
			Default = _G.DefaultCursor,
			Numeric = true,
			Finished = false,

			Text = 'Image',
			Tooltip = 'Changes the image of your cursor',
			Placeholder = '',

			Callback = function(Value)
				_G.CustomCursor = Value
			end
		})

		local AFMyButton = CrosshairRightVisualGroupBox:AddButton({
			Text = 'Set',
			Func = function()
				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui") then
					if not game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").FollowMouse:FindFirstChild("NewCustomCursor") then
						local NewCursor = Instance.new("ImageLabel")
						NewCursor.Size = game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").FollowMouse.Cursor.Size
						NewCursor.Image = "rbxassetid://".._G.CustomCursor
						NewCursor.BackgroundTransparency = 1
						NewCursor.ImageColor3 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").FollowMouse.Cursor.ImageColor3
						NewCursor.ImageTransparency = game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").FollowMouse.Cursor.ImageTransparency
						NewCursor.ZIndex = game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").FollowMouse.Cursor.ZIndex
						NewCursor.AnchorPoint = game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").FollowMouse.Cursor.AnchorPoint
						NewCursor.Name = "NewCustomCursor"
						NewCursor.Parent = game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").FollowMouse
						NewCursor.Position = UDim2.new(0.5,0,0.5,0)

						game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").FollowMouse.Cursor.Visible = false
					end

					if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").FollowMouse:FindFirstChild("NewCustomCursor") then
						game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").FollowMouse.NewCustomCursor.Size = UDim2.new(0, _G.CrossX, 0, _G.CrossY)
						game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").FollowMouse.NewCustomCursor.Image = "rbxassetid://".._G.CustomCursor
						game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").FollowMouse.NewCustomCursor.ImageColor3 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").FollowMouse.Cursor.ImageColor3

					end
				end
			end,
			DoubleClick = false,
			Tooltip = 'Sets the cursor to what you putted'
		})

		_G.CrossX = 11
		_G.CrossY = 11

		CrosshairRightVisualGroupBox:AddInput('Size1', {
			Default = _G.CrossX,
			Numeric = true,
			Finished = false,

			Text = 'Size X',
			Tooltip = '',
			Placeholder = '',

			Callback = function(Value)
				_G.CrossX = Value
			end
		})

		CrosshairRightVisualGroupBox:AddInput('Size2', {
			Default = _G.CrossY,
			Numeric = true,
			Finished = false,

			Text = 'Size Y',
			Tooltip = '',
			Placeholder = '',

			Callback = function(Value)
				_G.CrossY = Value
			end
		})

		task.spawn(function()
			while wait() do
				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui") then
					if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").FollowMouse:FindFirstChild("NewCustomCursor") then
						updateImageSize(game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").FollowMouse.NewCustomCursor)
						game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").FollowMouse.NewCustomCursor.Position = game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").FollowMouse.Cursor.Position
					end
				end
			end
		end)

		TracerLeftVisualGroupBox:AddToggle('Bullet Tracers', {
			Text = 'Enable',
			Default = false,
			Tooltip = 'Bullet Tracers',
			Callback = function(Value)
				Settings.BulletTracers = Value
			end
		})

		TracerLeftVisualGroupBox:AddLabel('Bullet Color'):AddColorPicker('ColorPicker', {
			Default = Color3.new(1, 1, 1),
			Title = 'Bullet Color',
			Transparency = 0,

			Callback = function(Value)
				Settings.BulletTracersColor = Value
			end
		})

		TracerLeftVisualGroupBox:AddDivider()

		TracerLeftVisualGroupBox:AddDropdown('Material', {
			Values = { 'ForceField', 'SmoothPlastic', 'Plastic', 'Neon', 'Glass', 'Grass', 'Wood', 'Slate', 'Concrete', 'CorrodedMetal', 'DiamondPlate', 'Foil', 'Granite', 'Marble', 'Brick', 'Pebble', 'Sand', 'Fabric', 'SmoothPlastic', 'Metal', 'Ice', 'ForceField'},
			Default = 1, 
			Multi = false,

			Text = 'Material',
			Tooltip = 'Material',

			Callback = function(Value)
				Settings.BulletTraceMeterial = Value
			end
		})

		game.UserInputService.InputBegan:Connect(function(input)
			if Settings.BulletTracers then
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					if HasGun then
						Tracer(game.Players.LocalPlayer.Character:FindFirstChild("Right Arm").Position, Camera.CFrame.Position + Camera.CFrame.LookVector * 1000)
					end
				end
			end
		end)

		OthersLeftVisualGroupBox:AddToggle('BFullBright', {
			Text = 'Fullbright',
			Default = false,
			Tooltip = 'see in the dark',
			Callback = function(Value)
				task.spawn(function()
					repeat task.wait()
						game.Lighting.TimeOfDay = 12
						game.Lighting.Brightness = 10
						game.Lighting.Ambient = Color3.fromRGB(255,255,255)
					until Value == false
					game.Lighting.Brightness = 3
					game.Lighting.Ambient = Color3.fromRGB(170,170,170)
				end)
			end
		})

		HitsoundLeftMiscGroupBox:AddInput('Ally hitsound', {
			Default = 3748780866,
			Numeric = true,
			Finished = false,

			Text = 'Ally hitsound',
			Tooltip = '',
			Placeholder = '',

			Callback = function(Value)
				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui") then
					game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").GunGuiLogic.Sounds.AllyHit.SoundId = "rbxassetid://"..Value
				end
			end
		})

		HitsoundLeftMiscGroupBox:AddInput('Died hitsound', {
			Default = 3748780866,
			Numeric = true,
			Finished = false,

			Text = 'Died hitsound',
			Tooltip = '',
			Placeholder = '',

			Callback = function(Value)
				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui") then
					game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").GunGuiLogic.Sounds.DiedHit.SoundId = "rbxassetid://"..Value
				end
			end
		})

		HitsoundLeftMiscGroupBox:AddInput('Head hitsound', {
			Default = 3748780866,
			Numeric = true,
			Finished = false,

			Text = 'Head hitsound',
			Tooltip = '',
			Placeholder = '',

			Callback = function(Value)
				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui") then
					game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").GunGuiLogic.Sounds.HeadHit.SoundId = "rbxassetid://"..Value
				end
			end
		})

		HitsoundLeftMiscGroupBox:AddInput('Kill hitsound', {
			Default = 3748780866,
			Numeric = true,
			Finished = false,

			Text = 'Kill hitsound',
			Tooltip = '',
			Placeholder = '',

			Callback = function(Value)
				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui") then
					game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").GunGuiLogic.Sounds.KillHit.SoundId = "rbxassetid://"..Value
				end
			end
		})

		HitsoundLeftMiscGroupBox:AddInput('Normal hitsound', {
			Default = 3748780866,
			Numeric = true,
			Finished = false,

			Text = 'Normal hitsound',
			Tooltip = '',
			Placeholder = '',

			Callback = function(Value)
				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui") then
					game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").GunGuiLogic.Sounds.NormalHit.SoundId = "rbxassetid://"..Value
				end
			end
		})

		HitsoundLeftMiscGroupBox:AddDivider()

		HitsoundLeftMiscGroupBox:AddSlider('AllyPitch', {
			Text = 'Ally Pitch',
			Default = 1.5,
			Min = 0,
			Max = 10,
			Rounding = 1,
			Compact = false,

			Callback = function(Value)
				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui") then
					game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").GunGuiLogic.Sounds.AllyHit.PlaybackSpeed = Value
				end
			end
		})

		HitsoundLeftMiscGroupBox:AddSlider('DiedPitch', {
			Text = 'Died Pitch',
			Default = 2,
			Min = 0,
			Max = 10,
			Rounding = 1,
			Compact = false,

			Callback = function(Value)
				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui") then
					game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").GunGuiLogic.Sounds.DiedHit.PlaybackSpeed = Value
				end
			end
		})

		HitsoundLeftMiscGroupBox:AddSlider('HeadPitch', {
			Text = 'Head Pitch',
			Default = 0.8,
			Min = 0,
			Max = 10,
			Rounding = 1,
			Compact = false,

			Callback = function(Value)
				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui") then
					game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").GunGuiLogic.Sounds.HeadHit.PlaybackSpeed = Value
				end
			end
		})

		HitsoundLeftMiscGroupBox:AddSlider('KillPitch', {
			Text = 'Kill Pitch',
			Default = 0.8,
			Min = 0,
			Max = 10,
			Rounding = 1,
			Compact = false,

			Callback = function(Value)
				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui") then
					game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").GunGuiLogic.Sounds.KillHit.PlaybackSpeed = Value
					game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").GunGuiLogic.Sounds.KillHit.PitchShiftSoundEffect:Destroy()
				end
			end
		})

		HitsoundLeftMiscGroupBox:AddSlider('NormalPitch', {
			Text = 'Normal Pitch',
			Default = 1,
			Min = 0,
			Max = 10,
			Rounding = 1,
			Compact = false,

			Callback = function(Value)
				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui") then
					game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").GunGuiLogic.Sounds.NormalHit.PlaybackSpeed = Value
				end
			end
		})

		HitsoundLeftMiscGroupBox:AddDivider()

		HitsoundLeftMiscGroupBox:AddSlider('AllyVolume', {
			Text = 'Ally Volume',
			Default = 1.75,
			Min = 0,
			Max = 10,
			Rounding = 1,
			Compact = false,

			Callback = function(Value)
				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui") then
					game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").GunGuiLogic.Sounds.AllyHit.Volume = Value
				end
			end
		})

		HitsoundLeftMiscGroupBox:AddSlider('DiedVolume', {
			Text = 'Died Volume',
			Default = 1.75,
			Min = 0,
			Max = 10,
			Rounding = 1,
			Compact = false,

			Callback = function(Value)
				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui") then
					game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").GunGuiLogic.Sounds.DiedHit.Volume = Value
				end
			end
		})

		HitsoundLeftMiscGroupBox:AddSlider('HeadVolume', {
			Text = 'Head Volume',
			Default = 1.75,
			Min = 0,
			Max = 10,
			Rounding = 1,
			Compact = false,

			Callback = function(Value)
				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui") then
					game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").GunGuiLogic.Sounds.HeadHit.Volume = Value
				end
			end
		})

		HitsoundLeftMiscGroupBox:AddSlider('KillVolume', {
			Text = 'Kill Volume',
			Default = 1.75,
			Min = 0,
			Max = 10,
			Rounding = 1,
			Compact = false,

			Callback = function(Value)
				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui") then
					game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").GunGuiLogic.Sounds.KillHit.Volume = Value
				end
			end
		})

		HitsoundLeftMiscGroupBox:AddSlider('NormalVolume', {
			Text = 'Normal Volume',
			Default = 1,
			Min = 0,
			Max = 10,
			Rounding = 1,
			Compact = false,

			Callback = function(Value)
				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui") then
					game.Players.LocalPlayer.PlayerGui:FindFirstChild("GunGui").GunGuiLogic.Sounds.NormalHit.Volume = Value
				end
			end
		})

		HitsoundLeftMiscGroupBox:AddDivider()

		HitsoundLeftMiscGroupBox:AddLabel('Defaults:')
		HitsoundLeftMiscGroupBox:AddLabel('Ally: 3748780866 / 1')
		HitsoundLeftMiscGroupBox:AddLabel('Died: 3748780866 / 2')
		HitsoundLeftMiscGroupBox:AddLabel('Head: 3748780866 / 0.8')
		HitsoundLeftMiscGroupBox:AddLabel('Kill: 3748780866 / 0.8')
		HitsoundLeftMiscGroupBox:AddLabel('Normal: 3748780866 / 1')
		
		KillAuraLeftCombatGroupBox:AddToggle('EnableAura', {
			Text = 'Enable',
			Default = false,
			Tooltip = 'Enable KillAura',
			Callback = function(Value)
				_G.AuraEnabled = Value
			end
		})
		
		KillAuraLeftCombatGroupBox:AddDropdown('LAockPart', {
			Values = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
			Default = 1,
			Multi = false,

			Text = 'Hit Part',
			Tooltip = '',

			Callback = function(Value)
				_G.AuraLockPart = Value
			end
		})
		
		KillAuraLeftCombatGroupBox:AddSlider('KLRange', {
			Text = 'Range',
			Default = 10,
			Min = 10,
			Max = 20,
			Rounding = 1,
			Compact = false,

			Callback = function(Value)
				_G.AuraRange = Value
			end
		})

		
		AimbotLeftCombatGroupBox:AddDivider()

		KillAuraLeftCombatGroupBox:AddToggle('KLWallCheck', {
			Text = 'Wall Check',
			Default = false,
			Tooltip = 'Checks if the targeted player is being a wall or not',
			Callback = function(Value)
				_G.AuraWallCheck = Value
			end
		})

		KillAuraLeftCombatGroupBox:AddToggle('KLAliveCheck', {
			Text = 'Alive Check',
			Default = false,
			Tooltip = 'Checks if the targeted player is alive or not',
			Callback = function(Value)
				_G.AuraAliveCheck = Value
			end
		})

		KillAuraLeftCombatGroupBox:AddDivider()

		KillAuraLeftCombatGroupBox:AddDropdown('KLBlacklistPlayer', {
			SpecialType = 'Player',
			Text = 'Blacklist Players',
			Tooltip = 'Blacklist a player to not be targeted',

			Multi = true,

			Callback = function(Value)
				_G.AuraBlacklistPlayers = Value
			end
		})

		KillAuraLeftCombatGroupBox:AddToggle('KLFriendd', {
			Text = 'BL Friends',
			Default = false,
			Tooltip = 'Blacklists your friends which prevents them from being targeted',
			Callback = function(Value)
				_G.AuraFriendsBlacklist = Value
			end
		})
		
		AimbotLeftCombatGroupBox:AddToggle('Enable', {
			Text = 'Enable',
			Default = false,
			Tooltip = 'Enable Aimbot',
			Callback = function(Value)
				_G.AimbotEnabled = Value
			end
		})

		AimbotLeftCombatGroupBox:AddLabel('Enable Keybind'):AddKeyPicker('EnableAKeybind', {
			Default = 'MB2',
			SyncToggleState = false,

			Mode = 'Always',

			Text = 'Enable Keybind',
			NoUI = false, 

			ChangedCallback = function(New)
				_G.AimKeybind = New
			end
		})

		AimbotLeftCombatGroupBox:AddSlider('ASens', {
			Text = 'Sensitivity',
			Default = 0,
			Min = 0,
			Max = 0.1,
			Rounding = 5,
			Compact = false,

			Callback = function(Value)
				_G.Sensitivity = Value
			end
		})

		AimbotLeftCombatGroupBox:AddDropdown('LockPart', {
			Values = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
			Default = 1,
			Multi = false,

			Text = 'Lock Part',
			Tooltip = '',

			Callback = function(Value)
				_G.AimPart = Value
			end
		})

		AimbotLeftCombatGroupBox:AddDivider()

		AimbotLeftCombatGroupBox:AddToggle('APlayerTrack', {
			Text = 'Player Track',
			Default = true,
			Tooltip = 'Aimbot will track onto players',
			Callback = function(Value)
				_G.PlayerTrack = Value
			end
		})

		AimbotLeftCombatGroupBox:AddToggle('ANpcTrack', {
			Text = 'NPC Track',
			Default = false,
			Tooltip = 'Aimbot will track on npcs',
			Callback = function(Value)
				_G.NPCTrack = Value
			end
		})

		AimbotLeftCombatGroupBox:AddDivider()

		AimbotLeftCombatGroupBox:AddToggle('ATeamCheck', {
			Text = 'Team Check',
			Default = false,
			Tooltip = 'Checks if you are on the same team or no',
			Callback = function(Value)
				_G.TeamCheck = Value
			end
		})

		AimbotLeftCombatGroupBox:AddToggle('AWallCheck', {
			Text = 'Wall Check',
			Default = false,
			Tooltip = 'Checks if the targeted player is being a wall or not',
			Callback = function(Value)
				_G.WallCheck = Value
			end
		})

		AimbotLeftCombatGroupBox:AddToggle('AAliveCheck', {
			Text = 'Alive Check',
			Default = false,
			Tooltip = 'Checks if the targeted player is alive or not',
			Callback = function(Value)
				_G.AliveCheck = Value
			end
		})

		AimbotLeftCombatGroupBox:AddDivider()

		AimbotLeftCombatGroupBox:AddDropdown('BlacklistPlayer', {
			SpecialType = 'Player',
			Text = 'Blacklist Players',
			Tooltip = 'Blacklist a player to not be targeted',

			Multi = true,

			Callback = function(Value)
				_G.BlacklistedPlayers = Value
			end
		})

		AimbotLeftCombatGroupBox:AddToggle('Friendd', {
			Text = 'BL Friends',
			Default = false,
			Tooltip = 'Blacklists your friends which prevents them from being targeted',
			Callback = function(Value)
				_G.FriendsBlacklist = Value
			end
		})

		AimbotLeftCombatGroupBox:AddDivider()

		AimbotLeftCombatGroupBox:AddLabel("[FOV EDITOR]")

		AimbotLeftCombatGroupBox:AddToggle('AUseFov', {
			Text = 'Show FOV',
			Default = false,
			Tooltip = 'Shows the fov',
			Callback = function(Value)
				_G.CircleVisible = Value
			end
		})

		AimbotLeftCombatGroupBox:AddSlider('AFRadius', {
			Text = 'FOV Radius',
			Default = 90,
			Min = 30,
			Max = 1000,
			Rounding = 1,
			Compact = false,

			Callback = function(Value)
				_G.CircleRadius = Value
			end
		})

		AimbotLeftCombatGroupBox:AddSlider('AFSIDES', {
			Text = 'FOV Sides',
			Default = 60,
			Min = 50,
			Max = 200,
			Rounding = 10,
			Compact = false,

			Callback = function(Value)
				_G.CircleSides = Value
			end
		})

		AimbotLeftCombatGroupBox:AddSlider('AFThick', {
			Text = 'FOV Thickness',
			Default = 1,
			Min = 1,
			Max = 3,
			Rounding = 1,
			Compact = false,

			Callback = function(Value)
				_G.CircleThickness = Value
			end
		})

		AimbotLeftCombatGroupBox:AddToggle('AFFilled', {
			Text = 'FOV Filled',
			Default = false,
			Tooltip = 'Fills the fov',
			Callback = function(Value)
				_G.CircleFilled = Value
			end
		})

		AimbotLeftCombatGroupBox:AddDivider()

		AimbotLeftCombatGroupBox:AddToggle('RainbowFOV', {
			Text = 'FOV Rainbow',
			Default = false,
			Tooltip = 'turns the color of the fov to rainbow',
			Callback = function(Value)
				ToggleRainbowFOV()
				_G.RainbowFov = Value
			end
		})

		AimbotLeftCombatGroupBox:AddLabel('FOV Color'):AddColorPicker('FOVColorPicker', {
			Default = Color3.fromRGB(255,255,255), -- Bright green
			Title = 'FOV Color', -- Optional. Allows you to have a custom color picker title (when you open it)
			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

			Callback = function(Value)
				_G.CircleColor = Value
				_G.OriginalCircleColor = Value
			end
		})
		
		MoveLeftMoveGroupBox:AddToggle('InfiniteStamina', {
			Text = 'Infinite Stamina',
			Default = false,
			Tooltip = 'Run forever',
			Callback = function(Value)
				if Value == true then
					task.spawn(function()
						while Value == true do
							game.Players.LocalPlayer:FindFirstChild("PlayerGui"):SetAttribute("Stamina", 100)
							task.wait()
						end
					end)
				end
			end
		})

		MoveLeftMoveGroupBox:AddToggle('InfiniteThirst', {
			Text = 'Infinite Thirst',
			Default = false,
			Tooltip = 'No more thirst',
			Callback = function(Value)
				if Value == true then
					task.spawn(function()
						while Value == true do
							game.Players.LocalPlayer:FindFirstChild("PlayerGui"):SetAttribute("Thirst", 100)
							task.wait()
						end
					end)
				end
			end
		})

		MoveLeftMoveGroupBox:AddToggle('InfiniteHunger', {
			Text = 'Infinite Hunger',
			Default = false,
			Tooltip = 'No more Hunger',
			Callback = function(Value)
				if Value == true then
					task.spawn(function()
						while Value == true do
							game.Players.LocalPlayer:FindFirstChild("PlayerGui"):SetAttribute("Hunger", 100)
							task.wait()
						end
					end)
				end
			end
		})
		
		MoveLeftMoveGroupBox:AddDivider()
		
		MoveLeftMoveGroupBox:AddToggle('SpeedE', {
			Text = 'Speedhack',
			Default = false,
			Tooltip = 'gives you alot of speed',
			Callback = function(Value)
				_G.SpeedEnabled = Value
			end
		})

		MoveLeftMoveGroupBox:AddSlider('Speed', {
			Text = 'Speed',
			Default = 0,
			Min = 0,
			Max = 50,
			Rounding = 10,
			Compact = false,

			Callback = function(Value)
				_G.Speed = Value
			end
		})

		MoveLeftMoveGroupBox:AddToggle('FlyE', {
			Text = 'Fly',
			Default = false,
			Tooltip = 'makes you able to fly',
			Callback = function(Value)
				_G.FlyEnabled = Value
			end
		})
		
		MoveLeftMoveGroupBox:AddToggle('Noclip', {
			Text = 'Noclip',
			Default = false,
			Tooltip = 'go thru walls',
			Callback = function(Value)
				if Value == true then
					noclip()
				else
					clip()
				end
			end
		})

		MoveLeftMoveGroupBox:AddDivider()
		
		LootLeftLootGroupBox:AddToggle('NoECooldown', {
			Text = 'No Hold Duration',
			Default = false,
			Tooltip = 'Removes the proximity prompt hold duration',
			Callback = function(Value)
				if Value == true then
					for i,v in pairs(game.Workspace:GetDescendants()) do
						if v:IsA("ProximityPrompt") then
							if not v:GetAttribute("OldDuration") then
								v:SetAttribute("OldDuration", v.HoldDuration)
							end

							v.HoldDuration = 0
						end     
					end  

					for i,v in pairs(game.Workspace:GetDescendants()) do
						v.ChildAdded:Connect(function(c)
							if c:IsA("ProximityPrompt") then
								if not c:GetAttribute("OldDuration") then
									c:SetAttribute("OldDuration", c.HoldDuration)
								end

								c.HoldDuration = 0
							end
						end)
					end
				elseif Value == false then
					for i,v in pairs(game.Workspace:GetDescendants()) do
						if v:IsA("ProximityPrompt") then
							v.HoldDuration = v:GetAttribute("OldDuration")
						end     
					end 
				end
			end
		})

		LootLeftLootGroupBox:AddToggle('InfLocks', {
			Text = 'Infinite Lockpicks',
			Default = false,
			Tooltip = 'Self explainatory',
			Callback = function(Value)
				if Value == true then
					game:GetService("ReplicatedStorage").Events.Loot:FindFirstChild("MinigameMistake").Name = "MinigameMistake1"
				elseif Value == false then
					if game:GetService("ReplicatedStorage").Events.Loot:FindFirstChild("MinigameMistake1") then
						game:GetService("ReplicatedStorage").Events.Loot:FindFirstChild("MinigameMistake1").Name = "MinigameMistake"
					end
				end
			end
		})

		StaffLeftMiscGroupBox:AddToggle('StaffWarn', {
			Text = 'Staff Notifier',
			Default = false,
			Tooltip = 'notifies you when a potential staff joins the game',
			Callback = function(Value)
				game.Players.PlayerAdded:Connect(function(plr)
					if plr:IsInGroup(6568965) and plr:GetRankInGroup(6568965) > 1 and Value == true then
						if _G.StaffMethod == "get kicked" then
							game.Players.LocalPlayer:Kick("Possible staff has joined your game")
						elseif _G.StaffMethod == "get notified" then
							game:GetService("StarterGui"):SetCore("SendNotification", {
								Title = "ALERT",
								Text = "A POTENTIAL STAFF HAS JOINED YOUR GAME!",
								Icon = "rbxassetid://17829955945",
								Duration = 6,
							})

							local Audio = Instance.new("Sound")
							Audio.Parent = workspace
							Audio.SoundId = "rbxassetid://2778386920"
							Audio:Play()
							game:GetService("Debris"):AddItem(Audio, Audio.TimeLength)
						end
					end
				end)
			end
		})

		StaffLeftMiscGroupBox:AddDropdown('StaffMethod', {
			Values = {"get kicked", "get notified"},
			Default = "get notified",
			Multi = false,

			Text = 'Method',
			Tooltip = 'the way in which it will notify you when a staff member joins',

			Callback = function(Value)
				_G.StaffMethod = Value
			end
		})

		MoveLeftMoveGroupBox:AddToggle('Spinbot', {
			Text = 'Spinbot',
			Default = false,
			Tooltip = 'spins you around alot so people cannot aim you correctly',
			Callback = function(Value)
				_G.Spinbot = Value
			end
		})

		FarmRightMiscGroupBox:AddToggle('RestockAutoFarm', {
			Text = 'Restock Auto Farm',
			Default = false,
			Tooltip = 'autofarms using the restock missions [need 500 cash before using this]',
			Callback = function(Value)
				_G.RestockAutoFarm = Value
				RestockAutoFarm()
			end
		})

		Library:SetWatermarkVisibility(true)

		waterLeftLootGroupBox:AddToggle('Watermark', {
			Text = 'Watermark',
			Default = true,
			Tooltip = 'removes or shows the watermark',
			Callback = function(Value)
				Library:SetWatermarkVisibility(Value)
			end
		})

		local FrameTimer = tick()
		local FrameCounter = 0
		local FPS = 60

		local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
			FrameCounter += 1

			if (tick() - FrameTimer) >= 1 then
				FPS = FrameCounter
				FrameTimer = tick()
				FrameCounter = 0
			end

			Library:SetWatermark(('NEBULA HUB | %s fps | %s ms | %s '):format(
				math.floor(FPS),
				math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue()),
				game.Players.LocalPlayer.Name
				))
		end)

		Library.KeybindFrame.Visible = false

		Library:OnUnload(function()
			WatermarkConnection:Disconnect()

			print('Unloaded!')
			Library.Unloaded = true
		end)


		local MenuGroup = Tabs['HUD']:AddLeftGroupbox('Menu')

		MenuGroup:AddButton('Unload', function() Library:Unload() end)

		ThemeManager:SetLibrary(Library)
		SaveManager:SetLibrary(Library)

		SaveManager:IgnoreThemeSettings()

		ThemeManager:SetFolder('EXPHUB')
		SaveManager:SetFolder('EXPHUB'..game.PlaceId)

		SaveManager:BuildConfigSection(Tabs['HUD'])

		ThemeManager:ApplyToTab(Tabs['HUD'])

		SaveManager:LoadAutoloadConfig()

		print("[NEBULA HUB]: Loaded👍")
	end
	
end
