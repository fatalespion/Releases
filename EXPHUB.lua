local HWID = game:GetService("RbxAnalyticsService"):GetClientId();
local WhitelistedHWIDs = loadstring(game:HttpGet("https://pastebin.com/raw/sNmUwBsx"))()
local qNVAKkuwxNpqruLjSRHg = false 

function CheckHWID(hwidval)
	for _,whitelisted in pairs(WhitelistedHWIDs) do
		if hwidval == whitelisted then
			return true
		elseif hwidval ~= whitelisted then
			return false
		end
	end
end

qNVAKkuwxNpqruLjSRHg = CheckHWID(HWID)

if qNVAKkuwxNpqruLjSRHg == true then
	if shared.pass ~= "hFzU4cM8w2gE7C" then
		print(1)
		return
	end

	if shared.user ~= game.Players.LocalPlayer.UserId then
		if HWID == "22546EE2-F5D6-4271-8575-67299BEA5DCF" then
			if shared.user ~= "admin" then
				return
			end  
		else
			return
		end    
	end  

	local repo = 'https://raw.githubusercontent.com/'

	local Library = loadstring(game:HttpGet(repo .. 'fatalespion/Releases/main/Lino.lua'))()
	local ThemeManager = loadstring(game:HttpGet(repo .. 'violin-suzutsuki/LinoriaLib/main/addons/ThemeManager.lua'))()
	local SaveManager = loadstring(game:HttpGet(repo .. 'violin-suzutsuki/LinoriaLib/main/addons/SaveManager.lua'))()

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
		Misc = Window:AddTab('Miscellaneous'),
		Debugging = Window:AddTab('Debug'),
		['HUD'] = Window:AddTab('Settings'),
	}

	local AvailbleRemotes = {}

	for i,v in pairs(game.ReplicatedStorage:GetDescendants()) do
		if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") or v:IsA("BindableEvent") then
			table.insert(AvailbleRemotes, v.Name)
		end     
	end  
	
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V3/main/src/Aimbot.lua"))()()
	
	local LeftVisualGroupBox = Tabs.Visual:AddLeftGroupbox('ESP')
	local ChamsRightVisualGroupBox = Tabs.Visual:AddRightGroupbox('CHAMS')
	local GunsLeftVisualGroupBox = Tabs.Visual:AddLeftGroupbox('GUN MODS')
	local CrosshairRightVisualGroupBox = Tabs.Visual:AddRightGroupbox('CROSSHAIR')
	local TracerLeftVisualGroupBox = Tabs.Visual:AddLeftGroupbox('TRACER')
	local OthersLeftVisualGroupBox = Tabs.Visual:AddRightGroupbox('OTHERS')
	
	local HitsoundLeftMiscGroupBox = Tabs.Misc:AddLeftGroupbox('HITSOUNDS')
	
	local AimbotLeftCombatGroupBox = Tabs.Misc:AddLeftGroupbox('AIMBOT')
	
	local HasGun = false

	_G.ESPTeamCheck = false
	_G.ESPEnabled = false
	_G.ESPLocal = false
	_G.ESPShowTracers = true
	_G.ESPHealthBar = false
	_G.ESPShowBox = true
	_G.ESPTracerColor = Color3.fromRGB(103, 89, 179)
	_G.ESPBoxColor = Color3.fromRGB(103, 89, 179)
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
	
	getgenv().ExunysDeveloperAimbot = {
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
			Enabled = true,
			Visible = true,

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
			local Tracer = Drawing.new("Line")
			Tracer.Visible = false

			Tracer.Thickness = 1
			Tracer.Transparency = 1


			function lineesp()
				game:GetService("RunService").RenderStepped:Connect(function()
					if game.Workspace.Debris.Loot:FindFirstChild(v.Name) then
						local Vector, OnScreen = camera:WorldToViewportPoint(v.Position)

						if _G.ESPEnabled then
							if OnScreen then
								Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
								Tracer.To = Vector2.new(Vector.X, Vector.Y)

								if v.Color == Color3.fromRGB(255,63,63) then
									if _G.ESPDeathBag == true then
										Tracer.Color = _G.ESPDeathBagColor
										Tracer.Visible = true
									else
										Tracer.Visible = false
									end
								elseif v.Color == Color3.fromRGB(0,127,255) then
									if v.Name == "DeathBag" then
										if _G.ESPNpcBag == true then
											Tracer.Color = _G.ESPNpcBagColor
											Tracer.Visible = true
										else
											Tracer.Visible = false
										end
									elseif v.Name == "DuffelBag" then
										if _G.ESPDropBag == true then
											Tracer.Color = _G.ESPDropBagColor
											Tracer.Visible = true
										else
											Tracer.Visible = false
										end
									end
								end

								if not _G.ESPShowTracers  then
									Tracer.Visible = false
								end

								v.Destroying:Connect(function()
									Tracer.Visible = false
								end)
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

			task.spawn(function()
				coroutine.wrap(lineesp)()
			end)
		end

		game.Workspace.Debris.Loot.ChildAdded:Connect(function(v)
			local Tracer = Drawing.new("Line")
			Tracer.Visible = false

			Tracer.Thickness = 1
			Tracer.Transparency = 1


			function lineesp()
				game:GetService("RunService").RenderStepped:Connect(function()
					if game.Workspace.Debris.Loot:FindFirstChild(v.Name) then
						local Vector, OnScreen = camera:WorldToViewportPoint(v.Position)

						if _G.ESPEnabled then
							if OnScreen then
								Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
								Tracer.To = Vector2.new(Vector.X, Vector.Y)

								if v.Color == Color3.fromRGB(255,63,63) then
									if _G.ESPDeathBag == true then
										Tracer.Color = _G.ESPDeathBagColor
										Tracer.Visible = true
									else
										Tracer.Visible = false
									end
								elseif v.Color == Color3.fromRGB(0,127,255) then
									if v.Name == "DeathBag" then
										if _G.ESPNpcBag == true then
											Tracer.Color = _G.ESPNpcBagColor
											Tracer.Visible = true
										else
											Tracer.Visible = false
										end
									elseif v.Name == "DuffelBag" then
										if _G.ESPDropBag == true then
											Tracer.Color = _G.ESPDropBagColor
											Tracer.Visible = true
										else
											Tracer.Visible = false
										end
									end
								end

								if not _G.ESPShowTracers  then
									Tracer.Visible = false
								end

								v.Destroying:Connect(function()
									Tracer.Visible = false
								end)
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

			task.spawn(function()
				coroutine.wrap(lineesp)()
			end)
		end)

		for i,v in pairs(game.Players:GetChildren()) do
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
							end
						else
							BoxOutline.Visible = false
							Box.Visible = false
							HealthBarOutline.Visible = false
							HealthBar.Visible = false
						end
					else
						BoxOutline.Visible = false
						Box.Visible = false
						HealthBarOutline.Visible = false
						HealthBar.Visible = false
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

		game.Players.PlayerAdded:Connect(function(v)
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
							end
						else
							BoxOutline.Visible = false
							Box.Visible = false
							HealthBarOutline.Visible = false
							HealthBar.Visible = false
						end
					else
						BoxOutline.Visible = false
						Box.Visible = false
						HealthBarOutline.Visible = false
						HealthBar.Visible = false
					end
				end)
			end

			task.spawn(function()
				coroutine.wrap(lineesp)()
			end)
			task.spawn(function()
				coroutine.wrap(boxesp)()
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
		Default = Color3.fromRGB(103, 89, 179), -- Bright green
		Title = 'Tracer Color', -- Optional. Allows you to have a custom color picker title (when you open it)
		Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

		Callback = function(Value)
			_G.ESPTracerColor = Value
		end
	})

	LeftVisualGroupBox:AddLabel('Box Color'):AddColorPicker('ESPBoxColorPicker', {
		Default = Color3.fromRGB(103, 89, 179), -- Bright green
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
		Tooltip = 'be a bat',
		Callback = function(Value)
			if Value == true then
				local ColorCorrection = Instance.new("ColorCorrectionEffect")
				ColorCorrection.Brightness = 0.1
				ColorCorrection.Parent = Camera
				ColorCorrection.Name = "fullbrightness"
			elseif Value == false then
				Camera:FindFirstChild("fullbrightness"):Destroy()
			end
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
	
	AimbotLeftCombatGroupBox:AddToggle('Enable', {
		Text = 'Enable',
		Default = false,
		Tooltip = 'Enable Aimbot',
		Callback = function(Value)
			getgenv().ExunysDeveloperAimbot.Settings.Enabled = Value
		end
	})
	
	AimbotLeftCombatGroupBox:AddToggle('ATeamCheck', {
		Text = 'Team Check',
		Default = false,
		Tooltip = 'Checks if you are on the same team or no',
		Callback = function(Value)
			getgenv().ExunysDeveloperAimbot.Settings.TeamCheck = Value
		end
	})
	
	AimbotLeftCombatGroupBox:AddToggle('AAliveCheck', {
		Text = 'Alive Check',
		Default = true,
		Tooltip = 'Checks if player you are aiming is alive',
		Callback = function(Value)
			getgenv().ExunysDeveloperAimbot.Settings.TeamCheck = Value
		end
	})
	
	AimbotLeftCombatGroupBox:AddToggle('AWallCheck', {
		Text = 'Wall Check',
		Default = false,
		Tooltip = 'Checks if there is a wall between the player and you',
		Callback = function(Value)
			getgenv().ExunysDeveloperAimbot.Settings.WallCheck = Value
		end
	})
	
	AimbotLeftCombatGroupBox:AddSlider('ASens', {
		Text = 'Sensitivity',
		Default = 0,
		Min = 1,
		Max = 5,
		Rounding = 1,
		Compact = false,

		Callback = function(Value)
			getgenv().ExunysDeveloperAimbot.FOVSettings.Sensitivity = Value
		end
	})
	
	AimbotLeftCombatGroupBox:AddDropdown('LockPart', {
		Values = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
		Default = 1,
		Multi = false,

		Text = 'Lock Part',
		Tooltip = '',

		Callback = function(Value)
			getgenv().ExunysDeveloperAimbot.Settings.LockPart = Value
		end
	})
	
	AimbotLeftCombatGroupBox:AddLabel('TriggerKey'):AddKeyPicker('KeyPicker', {
		Default = 'MB2',
		SyncToggleState = false,

		Mode = 'Hold',

		Text = 'TriggerKey',
		NoUI = false,

		Callback = function(Value)
		end,

		ChangedCallback = function(New)
			getgenv().ExunysDeveloperAimbot.Settings.TriggerKey = New
		end
	})
	
	AimbotLeftCombatGroupBox:AddDivider()
	
	AimbotLeftCombatGroupBox:AddToggle('AUseFov', {
		Text = 'Enable FOV',
		Default = false,
		Tooltip = 'Uses the fov so the people in that circle can get aimed at',
		Callback = function(Value)
			getgenv().ExunysDeveloperAimbot.FOVSettings.Enabled = Value
		end
	})
	
	AimbotLeftCombatGroupBox:AddToggle('AUseFov', {
		Text = 'Show FOV',
		Default = false,
		Tooltip = 'Shows the fov',
		Callback = function(Value)
			getgenv().ExunysDeveloperAimbot.FOVSettings.Visible = Value
		end
	})
	
	AimbotLeftCombatGroupBox:AddSlider('AFRadius', {
		Text = 'FOV Radius',
		Default = 90,
		Min = 30,
		Max = 1000,
		Rounding = 10,
		Compact = false,

		Callback = function(Value)
			getgenv().ExunysDeveloperAimbot.FOVSettings.Radius = Value
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
			getgenv().ExunysDeveloperAimbot.FOVSettings.NumSides = Value
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
			getgenv().ExunysDeveloperAimbot.FOVSettings.Thickness = Value
		end
	})
	
	AimbotLeftCombatGroupBox:AddToggle('AFFilled', {
		Text = 'FOV Filled',
		Default = false,
		Tooltip = 'Fills the fov',
		Callback = function(Value)
			getgenv().ExunysDeveloperAimbot.Settings.Filled = Value
		end
	})
	
	AimbotLeftCombatGroupBox:AddToggle('AFRainbow', {
		Text = 'Rainbow',
		Default = false,
		Tooltip = 'Sets the fov color to rainbow',
		Callback = function(Value)
			getgenv().ExunysDeveloperAimbot.Settings.RainbowColor = Value
		end
	})
	
	AimbotLeftCombatGroupBox:AddToggle('AFRainbowO', {
		Text = 'Rainbow Outline',
		Default = false,
		Tooltip = 'Sets the fov outline color to rainbow',
		Callback = function(Value)
			getgenv().ExunysDeveloperAimbot.Settings.RainbowOutlineColor = Value
		end
	})
	
	AimbotLeftCombatGroupBox:AddDivider()
	
	AimbotLeftCombatGroupBox:AddLabel('FOV Color'):AddColorPicker('FOVColorPicker', {
		Default = Color3.fromRGB(255,255,255), -- Bright green
		Title = 'FOV Color', -- Optional. Allows you to have a custom color picker title (when you open it)
		Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

		Callback = function(Value)
			getgenv().ExunysDeveloperAimbot.Settings.Color = Value
		end
	})
	
	AimbotLeftCombatGroupBox:AddLabel('FOV Outline Color'):AddColorPicker('FOVOutlineColorPicker', {
		Default = Color3.fromRGB(0,0,0), -- Bright green
		Title = 'FOV Outline Color', -- Optional. Allows you to have a custom color picker title (when you open it)
		Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

		Callback = function(Value)
			getgenv().ExunysDeveloperAimbot.Settings.OutlineColor = Value
		end
	})
	
	AimbotLeftCombatGroupBox:AddLabel('Locked Color'):AddColorPicker('FOVLockedColorPicker', {
		Default = Color3.fromRGB(255,150,150), -- Bright green
		Title = 'Locked Color', -- Optional. Allows you to have a custom color picker title (when you open it)
		Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

		Callback = function(Value)
			getgenv().ExunysDeveloperAimbot.Settings.LockedColor = Value
		end
	})
	
	local LeftGroupBox = Tabs.Debugging:AddLeftGroupbox('Remotes')

	LeftGroupBox:AddLabel('This allows you to run any remote of your choice')

	LeftGroupBox:AddDivider()

	_G.RemoteSelected = nil
	_G.Args1 = nil
	_G.Args2 = nil
	_G.Args3 = nil
	_G.Args4 = nil
	_G.Args5 = nil

	LeftGroupBox:AddDropdown('MyDropdown', {
		Values = AvailbleRemotes,
		Default = 1,
		Multi = false,

		Text = 'Remotes',
		Tooltip = '',

		Callback = function(Value)
			_G.RemoteSelected = Value
		end
	})

	LeftGroupBox:AddDivider()

	LeftGroupBox:AddInput('Args1', {
		Default = '',
		Numeric = false,
		Finished = false,

		Text = 'Argument 1',
		Tooltip = '',
		Placeholder = '',

		Callback = function(Value)
			_G.Args1 = Value
		end
	})

	LeftGroupBox:AddInput('Args2', {
		Default = '',
		Numeric = false,
		Finished = false,

		Text = 'Argument 2',
		Tooltip = '',
		Placeholder = '',

		Callback = function(Value)
			_G.Args2 = Value
		end
	})

	LeftGroupBox:AddInput('Args3', {
		Default = '',
		Numeric = false,
		Finished = false,

		Text = 'Argument 3',
		Tooltip = '',
		Placeholder = '',

		Callback = function(Value)
			_G.Args3 = Value
		end
	})

	LeftGroupBox:AddInput('Args4', {
		Default = '',
		Numeric = false,
		Finished = false,

		Text = 'Argument 4',
		Tooltip = '',
		Placeholder = '',

		Callback = function(Value)
			_G.Args4 = Value
		end
	})

	LeftGroupBox:AddInput('Args5', {
		Default = '',
		Numeric = false,
		Finished = false,

		Text = 'Argument 5',
		Tooltip = '',
		Placeholder = '',

		Callback = function(Value)
			_G.Args5 = Value
		end
	})

	LeftGroupBox:AddDivider()

	local MyButton = LeftGroupBox:AddButton({
		Text = 'Run',
		Func = function()
			for i,v in pairs(game.ReplicatedStorage:GetDescendants()) do
				if v:IsA("RemoteEvent") then
					if v.Name == _G.RemoteSelected then
						v:FireServer(_G.Args1, _G.Args2, _G.Args3, _G.Args4, _G.Args5)
					end   
				elseif v:IsA("RemoteFunction") then
					if v.Name == _G.RemoteSelected then
						v:InvokeServer(_G.Args1, _G.Args2, _G.Args3, _G.Args4, _G.Args5)
					end     
				elseif v:IsA("BindableEvent") then  
					if v.Name == _G.RemoteSelected then
						v:Fire(_G.Args1, _G.Args2, _G.Args3, _G.Args4, _G.Args5)
					end 
				end
			end    
		end,
		DoubleClick = false,
		Tooltip = 'Run the remote you chose'
	})

	local RightGroupBox = Tabs.Debugging:AddRightGroupbox('Script Hub')

	local IY = RightGroupBox:AddButton({
		Text = 'Infinite Yield',
		Func = function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
		end,
		DoubleClick = true,
		Tooltip = 'Run infinite yield'
	})

	Library:SetWatermarkVisibility(true)

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
	ThemeManager:ApplyTheme("Tokyo Night")

	SaveManager:LoadAutoloadConfig()
end
