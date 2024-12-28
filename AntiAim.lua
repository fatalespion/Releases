local Loader = loadstring((syn and syn.request or request)({Url="https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/GTAUILIB",Method="GET"}).Body)() 

Loader.UIColor = Color3.fromRGB(255, 255, 255)
Loader.UIColor2 = Color3.fromRGB(255, 255, 255)

local Library = Loader.create({
	Name = "ANTI NIGGER AIM",

	TopBarSelector = true,
	TopBar = true,

	BottomBarType = "Arrows",

	ImageBarType = "Text",
	ImageBarText = "ANTI NIGGER AIM",
	ImageBarTextSize = 35,
	--ImageGradient = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(176, 79, 255)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(237, 138, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(220, 78, 255))},

	UIGradient = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(87, 98, 255)), ColorSequenceKeypoint.new(0.63, Color3.fromRGB(77, 198, 131)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(76, 255, 157))},
})

local CFNew, CFAng, CFtoObjectSpace = CFrame.new, CFrame.Angles, CFrame.new().toObjectSpace

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local torso = character:WaitForChild("Torso")

local on = false

local Connection = nil

local Config = {
	turnAngle = 40,
	hasSpinBot = true,
	hasHead = true,
}

local characterPI = game.Players.LocalPlayer.Character
local humanoidMove = characterPI:WaitForChild("Humanoid").MoveDirection
local rootPart = characterPI:WaitForChild("HumanoidRootPart")

local turnAmount = 0
_G.tiltSpeed = 5

local function UpdateTilt()
	local tiltAngle = math.rad(turnAmount) * _G.tiltSpeed
	rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, tiltAngle, 0)
end

local function ToggleSpinBot()
	while wait() do
		if Connection == false then
			break
		end

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

local gmt = getrawmetatable(game)
if gmt then
	setreadonly(gmt, false)
	local oldNamecall = gmt.__namecall

	gmt.__namecall = newcclosure(function(self, ...)
		local args = {...}
		local method = getnamecallmethod()

		if tostring(method) == "FireServer" and tostring(self) == "MOVZREP" then
			if on and Config.hasHead then
				args[1][1][3] = CFtoObjectSpace(humanoidRootPart.CFrame, workspace.CurrentCamera.CFrame).LookVector.Unit * Vector3.new(0, -50, 0)
			end
		end

		return oldNamecall(self, unpack(args))
	end)
	setreadonly(gmt, true)
end

local NewText = Library.createText({
	Text = "<b> THIS IS TEMP </b>",
	TextPosition = "center",

	RichText = true,

	Parent = Library.MainFrame
})

local EnableToggle = Library.createToggle({
	Name = "Enable", 
	FlagName = "ANTI_AIM_ETOGGLE",

	Parent = Library.MainFrame,

	Default = false,

	Callback = function(val)
		on = val
	end,
})

Library.createSeperator()

local HeadTab = Library.createTab("Head", "HeadTab")
local SpinbotTab = Library.createTab("Spinbot", "SpinbotTab")

local EnableHeadToggle = Library.createToggle({
	Name = "Enable", 
	FlagName = "ANTI_AIM_HEAD_TOGGLE",

	Parent = HeadTab,

	Default = true,

	Callback = function(val)
		Config.hasHead = val
	end,
})

local EnableSpinbotToggle = Library.createToggle({
	Name = "Enable", 
	FlagName = "ANTI_AIM_SPINBOT_TOGGLE",

	Parent = SpinbotTab,

	Default = true,

	Callback = function(val)
		Config.hasSpinBot = val
		
		if Config.hasSpinBot then
			if on then
				Connection = true
				ToggleSpinBot()
			else
				Connection = false
			end
		end
	end,
})

local TiltSpeedSlider = Library.createSlider({
	Name = "Speed",
	FlagName = "ANTI_AIM_SPINBOT_SPEED",

	Parent = SpinbotTab,

	Min = 0,
	Default = 5,
	Max = 15,

	Interval = 1,

	Callback = function(val)
		_G.tiltSpeed = val
	end,
})

game.StarterGui:SetCore("SendNotification", {Title = "ANTI NIGGER AIM 9000"; Text = "Welcome to the anti nigger aim 9000 made by fatal hope you enjoy! PRESS [INSERT] TO ENABLE/DISABLE THE GUI"; Icon = "rbxassetid://13789996304"; Duration = 30 })
