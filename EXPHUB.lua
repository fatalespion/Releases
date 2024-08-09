print("[NEBULA HUB]: Loading")
shared.key = "hG8LdA7sQWEr"
if shared.key ~= "hG8LdA7sQWEr" then
	print("⛔ [NEBULA HUB]: Auth Failed [INVALID KEY]")
	return
end

print("[NEBULA HUB]: Passed Auth")

local repo = 'https://raw.githubusercontent.com/'

local Library = loadstring(game:HttpGet(repo .. 'fatalespion/Releases/main/Lino.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'fatalespion/Releases/main/ThemeManager'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'violin-suzutsuki/LinoriaLib/main/addons/SaveManager.lua'))()
local AimbotLoadString = loadstring(game:HttpGet("https://raw.githubusercontent.com/fatalespion/Releases/main/Aimbot"))()
local Window = Library:CreateWindow({
	Title = 'NEBULA HUB | Game: UNKNOWN | BETA',
	Center = true,
	AutoShow = true,
	TabPadding = 8,
	MenuFadeTime = 0.2
})


local Tabs = {
	Combat = Window:AddTab('Combat'),
	Visual = Window:AddTab('Visual'),
	Movement = Window:AddTab('Movement'),
	['HUD'] = Window:AddTab('Settings'),
}

local LeftVisualGroupBox = Tabs.Visual:AddLeftGroupbox('ESP')
local ChamsRightVisualGroupBox = Tabs.Visual:AddRightGroupbox('CHAMS')
local GunsLeftVisualGroupBox = Tabs.Visual:AddLeftGroupbox('GUN MODS')
local TracerLeftVisualGroupBox = Tabs.Visual:AddLeftGroupbox('TRACER')
local OthersLeftVisualGroupBox = Tabs.Visual:AddRightGroupbox('OTHERS')

local AimbotLeftCombatGroupBox = Tabs.Combat:AddLeftGroupbox('CAMLOCK')

local MoveLeftMoveGroupBox = Tabs.Combat:AddRightGroupbox('MOVEMENT')
local spinRightMoveGroupBox = Tabs.Movement:AddRightGroupbox('SPINBOT & BHOP')
local speedRightMoveGroupBox = Tabs.Movement:AddRightGroupbox('SPPED & FLY')

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

_G.CHAMSEnemyColor = Color3.fromRGB(255, 84, 87)
_G.CHAMSTeamColor = Color3.fromRGB(103, 89, 179)
_G.CHAMSEnabled = false
_G.CHAMSShowTeams = true

_G.TurnRainbowEnabled = false

_G.Spinbot = false

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

-- Press X to fly

local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()

localplayer = plr

if workspace:FindFirstChild("Core") then
	workspace.Core:Destroy()
end

local Core = Instance.new("Part")
Core.Name = "Core"
Core.Size = Vector3.new(0.05, 0.05, 0.05)

spawn(function()
	Core.Parent = workspace
	local Weld = Instance.new("Weld", Core)
	Weld.Part0 = Core
	Weld.Part1 = localplayer.Character.Torso
	Weld.C0 = CFrame.new(0, 0, 0)
end)

workspace:WaitForChild("Core")

local torso = workspace.Core
flying = true
_G.FlySpeed = 11
local speed= _G.FlySpeed
local keys={a=false,d=false,w=false,s=false}
local e1
local e2
local function start()
	local pos = Instance.new("BodyPosition",torso)
	local gyro = Instance.new("BodyGyro",torso)
	pos.Name="EPIXPOS"
	pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
	pos.position = torso.Position
	gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
	gyro.cframe = torso.CFrame
	repeat
		wait()
		localplayer.Character.Humanoid.PlatformStand=true
		local new=gyro.cframe - gyro.cframe.p + pos.position
		if not keys.w and not keys.s and not keys.a and not keys.d then
			speed=5
		end
		if keys.w then
			new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
			speed=speed+0
		end
		if keys.s then
			new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
			speed=speed+0
		end
		if keys.d then
			new = new * CFrame.new(speed,0,0)
			speed=speed+0
		end
		if keys.a then
			new = new * CFrame.new(-speed,0,0)
			speed=speed+0
		end
		if speed>10 then
			speed=5
		end
		pos.position=new.p
		if keys.w then
			gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
		elseif keys.s then
			gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
		else
			gyro.cframe = workspace.CurrentCamera.CoordinateFrame
		end
	until flying == false
	if gyro then gyro:Destroy() end
	if pos then pos:Destroy() end
	flying=false
	localplayer.Character.Humanoid.PlatformStand=false
	speed=10
end
e1=mouse.KeyDown:connect(function(key)
	if not torso or not torso.Parent then flying=false e1:disconnect() e2:disconnect() return end
	if key=="w" then
		keys.w=true
	elseif key=="s" then
		keys.s=true
	elseif key=="a" then
		keys.a=true
	elseif key=="d" then
		keys.d=true
	elseif key=="x" and _G.FlyEnable == true then
		if flying==true then
			flying=false
		else
			flying=true
			start()
		end
	end
end)
e2=mouse.KeyUp:connect(function(key)
	if key=="w" then
		keys.w=false
	elseif key=="s" then
		keys.s=false
	elseif key=="a" then
		keys.a=false
	elseif key=="d" then
		keys.d=false
	end
end)

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

local function ToggleRainbowFOV(Value)
	task.spawn(function()
		while Value do
			_G.CircleColor = RainbowColor
			task.wait()
		end

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

local IsAvaible = true


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

local function TurnRainbow()
	if _G.TurnRainbowEnabled then


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

_G.EnableFieldOfView = false

GunsLeftVisualGroupBox:AddToggle('FOVEnable', {
	Text = 'FieldOfView',
	Default = false,
	Tooltip = 'Custom FieldOfView',
	Callback = function(Value)
		_G.EnableFieldOfView = Value
	end
})

GunsLeftVisualGroupBox:AddSlider('FOVS', {
	Text = 'Amount',
	Default = 70,
	Min = 30,
	Max = 110,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		task.spawn(function()
			while wait() do
				if _G.EnableFieldOfView then
					Camera.FieldOfView = Value
				end
			end
		end)
	end
})

GunsLeftVisualGroupBox:AddDivider()

GunsLeftVisualGroupBox:AddLabel('[MORE TO COME]')

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
		ToggleRainbowFOV(Value)
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

AimbotLeftCombatGroupBox:AddToggle('NoECooldown', {
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

spinRightMoveGroupBox:AddToggle('Spinbot', {
	Text = 'Spinbot',
	Default = false,
	Tooltip = 'spins you around alot so people cannot aim you correctly',
	Callback = function(Value)
		_G.Spinbot = Value
	end
})

speedRightMoveGroupBox:AddToggle('SpeedE', {
	Text = 'Speedhack',
	Default = false,
	Tooltip = 'gives you alot of speed',
	Callback = function(Value)
		_G.SpeedEnabled = Value
	end
})

AimbotLeftCombatGroupBox:AddSlider('Speed', {
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

speedRightMoveGroupBox:AddToggle('FlyE', {
	Text = 'Fly',
	Default = false,
	Tooltip = 'makes you able to fly',
	Callback = function(Value)
		_G.FlyEnabled = Value
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
