local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "Blackout Assets Dump",
	LoadingTitle = "a bunch of shit that you can do that can be useless or good",
	LoadingSubtitle = "password: 11/09/2001",
	ConfigurationSaving = {
		Enabled = false,
		FolderName = nil, -- Create a custom folder for your hub/game
		FileName = "Big Hub"
	},
	Discord = {
		Enabled = true,
		Invite = "criminality", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
		RememberJoins = false -- Set this to false to make them join the discord every time they load it up
	},
	KeySystem = true, -- Set this to true to use our key system
	KeySettings = {
		Title = "Key System if you couldn't tell",
		Subtitle = "key system to annoy you king gg",
		Note = "was in the loading screen should've paid attention",
		FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
		SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
		GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
		Key = {"11/09/2001"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
	}
})

_G.RainbowNotification = false
_G.ColorNotification = Color3.fromRGB(255,255,255)
_G.TitleNotification = ""
_G.TextNotification = ""
_G.IconNotification = "!"

_G.TitlePrompt = ""
_G.TextPrompt = ""

_G.Response1Prompt = "Yes"
_G.Response2Prompt = "No"

_G.Response1 = true
_G.Response2 = true

local Tab = Window:CreateTab("Notifications", 9861634198) -- Title, Image
local PromptsTab = Window:CreateTab("Prompts", 6673967738) -- Title, Image

local NotifSection = Tab:CreateSection("Create Notification")
local PromptsSection = PromptsTab:CreateSection("Create Notification")

local RainbowColor

task.spawn(function()
	local RunService = game:GetService("RunService")
	
	local SPEED = 0.1

	local i = 0
	RunService.RenderStepped:Connect(function(delta)
		RainbowColor = Color3.fromHSV(i,1,1)
		i = (i + delta*SPEED) % 1
	end)
end)

local SpawnNotification = function()
	game.ReplicatedStorage.AL:Invoke(_G.TitleNotification, _G.TextNotification, _G.IconNotification, nil, _G.ColorNotification)
	
	if _G.RainbowNotification then
		for _, v in pairs(game.Players.LocalPlayer:FindFirstChild("PlayerGui").MainGui.Alerts:GetChildren()) do
			if v:IsA("Frame") then
				task.spawn(function()
					repeat 
						if v.Title.Text == _G.TitleNotification then
							local v352, _, v354 = RainbowColor:ToHSV();
							v.Flash.BackgroundColor3 = RainbowColor;
							v.BarFrame.BackgroundColor3 = RainbowColor;
							v.Shine.ImageColor3 = RainbowColor;
							v.OnlyTitle.TextColor3 = RainbowColor;
							v.Title.TextColor3 = RainbowColor;
							v.Desc.TextColor3 = Color3.fromHSV(v352, 0.58, v354);
						end
					until v == nil
				end)
			end
		end
	end
end

local SpawnPrompt = function()
	if _G.Response1 and _G.Response2 then
		local v117 = game.ReplicatedStorage.Prompt:Invoke(_G.TitlePrompt, _G.TextPrompt, {
			_G.Response1Prompt,
			_G.Response2Prompt,
		});
	elseif not _G.Response1 and _G.Response2 then
		local v117 = game.ReplicatedStorage.Prompt:Invoke(_G.TitlePrompt, _G.TextPrompt, {
			_G.Response2Prompt,
		});
	elseif _G.Response1 and not _G.Response2 then
		local v117 = game.ReplicatedStorage.Prompt:Invoke(_G.TitlePrompt, _G.TextPrompt, {
			_G.Response1Prompt,
		});
	elseif not _G.Response1 and not _G.Response2 then
		local v117 = game.ReplicatedStorage.Prompt:Invoke(_G.TitlePrompt, _G.TextPrompt, {
			"You didnt put a response type dumbass",
		});
	end
end

local NotifLabel = Tab:CreateLabel("Create a custom notification using blackouts notification system")

local TitleNotifInput = Tab:CreateInput({
	Name = "Notification Title",
	PlaceholderText = "",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		_G.TitleNotification = Text
	end,
})

local TextNotifInput = Tab:CreateInput({
	Name = "Notification Text",
	PlaceholderText = "",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		_G.TextNotification = Text
	end,
})

local IconNotifInput = Tab:CreateInput({
	Name = "Notification Icon",
	PlaceholderText = "!",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		_G.IconNotification = Text
	end,
})

local NotificationColorPicker = Tab:CreateColorPicker({
	Name = "Notification Color",
	Color = Color3.fromRGB(255,255,255),
	Flag = "ColorPicker1a", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		_G.ColorNotification = Value
	end
})

local RainboxToggle = Tab:CreateToggle({
	Name = "Rainbow Notification",
	CurrentValue = false,
	Flag = "ggezf", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		_G.RainbowNotification = Value
	end,
})

local SpawnNotifButton = Tab:CreateButton({
	Name = "Spawn Notification",
	Callback = function()
		SpawnNotification()
	end,
})

local NotifLabel = PromptsSection:CreateLabel("Create a prompt like the drop thing that says Are you sure? or how many do you want to drop ect")

local TitleNotifInput = Tab:CreateInput({
	Name = "Prompt Title",
	PlaceholderText = "",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		_G.TitlePrompt = Text
	end,
})

local TextNotifInput = Tab:CreateInput({
	Name = "Prompt Text",
	PlaceholderText = "",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		_G.TextPrompt = Text
	end,
})

local TextNotifInput = Tab:CreateInput({
	Name = "Prompt Response1 Text",
	PlaceholderText = "Yes",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		_G.Response1Prompt = Text
	end,
})

local TextNotifInput = Tab:CreateInput({
	Name = "Prompt Response2 Text",
	PlaceholderText = "No",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		_G.Response2Prompt = Text
	end,
})

local RainboxToggle = Tab:CreateToggle({
	Name = "Prompt Response 1",
	CurrentValue = false,
	Flag = "ggezf", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		_G.Response1 = Value
	end,
})

local RainboxToggle = Tab:CreateToggle({
	Name = "Prompt Response 2",
	CurrentValue = false,
	Flag = "ggezfe", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		_G.Response2 = Value
	end,
})

local SpawnNotifButton = Tab:CreateButton({
	Name = "Spawn Prompt",
	Callback = function()
		SpawnPrompt()
	end,
})

game.ReplicatedStorage.AL:Invoke("EXECUTION SUCCESS", "Thank you for using this shitty thing. - fatal", "NIGGERS!!!!", nil, Color3.fromRGB(172, 56, 255))
