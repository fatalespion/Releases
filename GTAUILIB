local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")


local LIB = {
	UIColor = Color3.fromRGB(255, 255, 255),
	UIColor2 = Color3.fromRGB(207, 94, 255),
	
	Opened = true,
	
	Settings = {
		MaxCurrentNumber = 0,
		SelectedNumber = 1,
		CurrentTab = "MainFrame"
	},
	
	BlacklistedItems = {
		"Seperator",
		"ImageBar",
		"BottomFrame",
		"TopBar",
		"UIListLayout",
		"Text",
	},
	
	Keybinds = {
		Up = Enum.KeyCode.KeypadEight,
		Down = Enum.KeyCode.KeypadTwo,
		Left = Enum.KeyCode.KeypadFour,
		Right = Enum.KeyCode.KeypadSix,
		
		Enter = Enum.KeyCode.KeypadFive,
		Return = Enum.KeyCode.KeypadZero,
		
		Open = Enum.KeyCode.Insert,
	},
	
	ToggleSettings = {
		TickIcon = 6353957304,
		CrossIcon = 4661609682,
		
		Moved = UDim2.new(0.848, 0, 0.226, 0),
		Regular = UDim2.new(0.914191425, 0, 0.193548396, 0),
	},
	
	TextBoxSettings = {
		Moved = UDim2.new(0.848, 0, 0.226, 0),
		Regular = UDim2.new(0.931, 0 , 0.226, 0),
	},
	
	ColorPickerSettings = {
		Moved = UDim2.new(0.848, 0, 0.226, 0),
		Regular = UDim2.new(0.917, 0, 0.194, 0),
	},
	
	TabSettings = {
		Moved = UDim2.new(0.848, 0, 0.226, 0),
		Regular = UDim2.new(0.924092412, 0, 0.193548396, 0),
	},
	
	ButtonSettings = {
		Moved = UDim2.new(0.06, 0, 0.258, 0),
		Regular = UDim2.new(0.026, 0, 0.258, 0),
	},
	
	SliderSettings = {
		Moved = UDim2.new(0.848, 0, 0.226, 0),
		Regular = UDim2.new(0.904, 0, 0.226, 0),
	},
	
	ListSettings = {
		Moved = UDim2.new(0.798, 0, 0.226, 0),
		Regular = UDim2.new(0.825, 0, 0.226, 0)
	},
	
	Tab = {
		MainFrame = {
			LastTab = "no",
		},
	},
}

LIB.create = function(MainData)

	-- Instances:

	local TEST = Instance.new("ScreenGui")
	local MainFrame = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local TopBar = Instance.new("Frame")
	local LibName = Instance.new("TextLabel")
	local Selector = Instance.new("TextLabel")
	local BottomFrame = Instance.new("Frame")
	local Arrow1 = Instance.new("ImageLabel")
	local Arrow2 = Instance.new("ImageLabel")
	local Selector_2 = Instance.new("TextLabel")
	local MiddleBar = Instance.new("Frame")
	local BarName = Instance.new("TextLabel")
	local Arrow = Instance.new("TextLabel")
	local ImageBar = Instance.new("Frame")
	local ImageLabel = Instance.new("ImageLabel")
	local BarName_3 = Instance.new("TextLabel")
	local SliderFrame = Instance.new("Frame")
	local InputFrame = Instance.new("Frame")
	local TextBox = Instance.new("TextBox")
	local Tabs = Instance.new("LocalScript")
	
	local MainFrameTab = Instance.new("Folder")
	
	local clickSound = Instance.new("Sound")
	local hoverSound = Instance.new("Sound")
	local returnSound = Instance.new("Sound")
	
	local NewLib = {}

	--Properties:
	
	TEST.Name = MainData.Name
	TEST.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	TEST.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	TEST.ResetOnSpawn = false
	TEST.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
	TEST.DisplayOrder = math.huge
	
	clickSound.Parent = TEST
	hoverSound.Parent = TEST
	returnSound.Parent = TEST
	
	clickSound.SoundId = "rbxassetid://83685623871840"
	hoverSound.SoundId = "rbxassetid://139268396496928"
	returnSound.SoundId = "rbxassetid://115181827493042"
	
	Tabs.Name = "Tabs"
	Tabs.Parent = TEST
	Tabs.Disabled = true
	
	MainFrame.Name = "MainFrame"
	MainFrame.Parent = TEST
	MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MainFrame.BackgroundTransparency = 1.000
	MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MainFrame.BorderSizePixel = 0
	MainFrame.ClipsDescendants = true
	--MainFrame.Position = UDim2.new(0.0351693332, 0, 0.0754249319, 0)
	MainFrame.Position = UDim2.new(0, 100, 0, 100)
	MainFrame.Size = UDim2.new(0, 301, 0, 472)

	UIListLayout.Parent = MainFrame
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	TopBar.Name = "TopBar"
	TopBar.Parent = MainFrame
	TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	TopBar.BackgroundTransparency = 0.100
	TopBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TopBar.BorderSizePixel = 0
	TopBar.LayoutOrder = -999
	TopBar.Size = UDim2.new(1, 0, 0.0656779632, 0)
	TopBar.Visible = MainData.TopBar

	LibName.Name = "TabName"
	LibName.Parent = TopBar
	LibName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LibName.BackgroundTransparency = 1.000
	LibName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LibName.BorderSizePixel = 0
	LibName.Position = UDim2.new(0.0264026411, 0, 0.258064538, 0)
	LibName.Size = UDim2.new(0.821782172, 0, 0.483871102, 0)
	LibName.Font = Enum.Font.Unknown
	LibName.Text = "Home"
	LibName.TextColor3 = Color3.fromRGB(255, 255, 255)
	LibName.TextScaled = true
	LibName.TextSize = 14.000
	LibName.TextStrokeTransparency = 0.000
	LibName.TextWrapped = true
	LibName.TextXAlignment = Enum.TextXAlignment.Left

	Selector.Name = "Selector"
	Selector.Parent = TopBar
	Selector.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Selector.BackgroundTransparency = 1.000
	Selector.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Selector.BorderSizePixel = 0
	Selector.Position = UDim2.new(0.867986798, 0, 0.193548396, 0)
	Selector.Size = UDim2.new(0.102310233, 0, 0.612903178, 0)
	Selector.Font = Enum.Font.Unknown
	Selector.Text = "?/?"
	Selector.TextColor3 = Color3.fromRGB(255, 255, 255)
	Selector.TextScaled = true
	Selector.TextSize = 14.000
	Selector.TextStrokeTransparency = 0.000
	Selector.TextWrapped = true
	Selector.Visible = MainData.TopBarSelector

	BottomFrame.Name = "BottomFrame"
	BottomFrame.Parent = MainFrame
	BottomFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	BottomFrame.BackgroundTransparency = 0.100
	BottomFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BottomFrame.BorderSizePixel = 0
	BottomFrame.LayoutOrder = 9999
	BottomFrame.Size = UDim2.new(1, 0, 0.0656779632, 0)

	Arrow1.Name = "Arrow1"
	Arrow1.Parent = BottomFrame
	Arrow1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Arrow1.BackgroundTransparency = 1.000
	Arrow1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Arrow1.BorderSizePixel = 0
	Arrow1.Position = UDim2.new(0.465346545, 0, 0.387096792, 0)
	Arrow1.Size = UDim2.new(0.0659999996, 0, 0.58099997, 0)
	Arrow1.Image = "rbxassetid://11552476728"
	Arrow1.ScaleType = Enum.ScaleType.Fit

	Arrow2.Name = "Arrow2"
	Arrow2.Parent = BottomFrame
	Arrow2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Arrow2.BackgroundTransparency = 1.000
	Arrow2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Arrow2.BorderSizePixel = 0
	Arrow2.Position = UDim2.new(0.465346545, 0, 0, 0)
	Arrow2.Rotation = 180.000
	Arrow2.Size = UDim2.new(0.0660066009, 0, 0.580645263, 0)
	Arrow2.Image = "rbxassetid://11552476728"
	Arrow2.ScaleType = Enum.ScaleType.Fit

	Selector_2.Name = "Selector"
	Selector_2.Parent = BottomFrame
	Selector_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Selector_2.BackgroundTransparency = 1.000
	Selector_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Selector_2.BorderSizePixel = 0
	Selector_2.Position = UDim2.new(0.44884488, 0, 0.193548396, 0)
	Selector_2.Size = UDim2.new(0.102310233, 0, 0.612903178, 0)
	Selector_2.Visible = false
	Selector_2.Font = Enum.Font.Unknown
	Selector_2.Text = "?/?"
	Selector_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	Selector_2.TextScaled = true
	Selector_2.TextSize = 14.000
	Selector_2.TextStrokeTransparency = 0.000
	Selector_2.TextWrapped = true
	
	ImageBar.Name = "ImageBar"
	ImageBar.Parent = MainFrame
	ImageBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	ImageBar.BackgroundTransparency = 0.100
	ImageBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImageBar.BorderSizePixel = 0
	ImageBar.LayoutOrder = -9999
	ImageBar.Size = UDim2.new(1, 0, 0.211864412, 0)

	ImageLabel.Parent = ImageBar
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.BackgroundTransparency = 1.000
	ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Size = UDim2.new(1, 0, 1, 0)
	ImageLabel.Visible = false
	ImageLabel.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
	ImageLabel.ScaleType = Enum.ScaleType.Fit

	BarName_3.Name = "BarName"
	BarName_3.Parent = ImageBar
	BarName_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BarName_3.BackgroundTransparency = 1.000
	BarName_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BarName_3.BorderSizePixel = 0
	BarName_3.Size = UDim2.new(1, 0, 1, 0)
	BarName_3.Font = Enum.Font.GothamBold
	BarName_3.Text = MainData.Name
	BarName_3.TextColor3 = Color3.fromRGB(161, 98, 255)
	BarName_3.TextSize = 35.000
	BarName_3.TextStrokeTransparency = 0.000
	BarName_3.TextWrapped = true
	
	SliderFrame.Name = "SliderFrame"
	SliderFrame.Parent = TEST
	SliderFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	SliderFrame.BackgroundTransparency = 0.400
	SliderFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SliderFrame.BorderSizePixel = 0
	SliderFrame.Size = UDim2.new(1, 0, 1, 0)
	SliderFrame.Visible = false

	InputFrame.Name = "InputFrame"
	InputFrame.Parent = SliderFrame
	InputFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	InputFrame.BackgroundTransparency = 0.300
	InputFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	InputFrame.BorderSizePixel = 0
	InputFrame.Position = UDim2.new(0.0390000008, 0, 0.485000014, 0)
	InputFrame.Size = UDim2.new(0.921000004, 0, 0.0289999992, 0)

	TextBox.Parent = InputFrame
	TextBox.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
	TextBox.BackgroundTransparency = 1.000
	TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextBox.BorderSizePixel = 0
	TextBox.Position = UDim2.new(0.00486531574, 0, 0, 0)
	TextBox.Size = UDim2.new(0.995134711, 0, 1, 0)
	TextBox.Font = Enum.Font.GothamBold
	TextBox.PlaceholderText = "ENTER"
	TextBox.Text = ""
	TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextBox.TextSize = 14.000
	TextBox.TextStrokeTransparency = 0.000
	TextBox.TextXAlignment = Enum.TextXAlignment.Left
	
	MainFrameTab.Parent = Tabs
	MainFrameTab.Name = "MainFrame"
	
	if MainData.BottomBarType == "Arrows" then
		Arrow1.Visible = true
		Arrow2.Visible = true
		Selector_2.Visible = false
	elseif MainData.BottomBarType == "Selector" then
		Arrow1.Visible = false
		Arrow2.Visible = false
		Selector_2.Visible = true
	end
	
	if MainData.ImageGradient ~= nil then
		ImageBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TopBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BottomFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		
		local Gradient = Instance.new("UIGradient")
		Gradient.Parent = ImageBar
		Gradient.Color = MainData.ImageGradient
		
		local Gradient1 = Instance.new("UIGradient")
		Gradient1.Parent = TopBar
		Gradient1.Color = MainData.ImageGradient
		
		local Gradient1 = Instance.new("UIGradient")
		Gradient1.Parent = BottomFrame
		Gradient1.Color = MainData.ImageGradient
	end
	
	if MainData.ImageBarType == "Image" then
		ImageLabel.Image = "rbxassetid://"..MainData.ImageBarImage
		ImageLabel.Visible = true
		BarName_3.Visible = false
		
		if MainData.UIGradient ~= nil then
			local Gradient = Instance.new("UIGradient")
			Gradient.Parent = ImageLabel
			Gradient.Color = MainData.UIGradient
		end
	elseif MainData.ImageBarType == "Text" then
		BarName_3.Text = MainData.ImageBarText
		BarName_3.TextSize = MainData.ImageBarTextSize
		ImageLabel.Visible = false
		BarName_3.Visible = true
		
		if MainData.UIGradient ~= nil then
			local Gradient = Instance.new("UIGradient")
			Gradient.Parent = BarName_3
			Gradient.Color = MainData.UIGradient
			BarName_3.TextColor3 = Color3.fromRGB(255, 255, 255)
		end
	end
	
	NewLib.GUI = TEST
	NewLib.MainFrame = MainFrame
	NewLib.Rank = ""
	
	NewLib.createTab = function(TabName, FlagName, Parent)
		if not Parent then
			Parent = MainFrame
		end
		
		local Tab = Instance.new("Frame")
		local BarName = Instance.new("TextLabel")
		local Arrow = Instance.new("TextLabel")
		local NewTab = Instance.new("Folder")

		Tab.Name = FlagName
		Tab.Parent = Parent
		Tab.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Tab.BackgroundTransparency = 0.450
		Tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Tab.BorderSizePixel = 0
		Tab.Size = UDim2.new(1, 0, 0.0656779632, 0)

		BarName.Name = "BarName"
		BarName.Parent = Tab
		BarName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BarName.BackgroundTransparency = 1.000
		BarName.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BarName.BorderSizePixel = 0
		BarName.Position = UDim2.new(0.0264026411, 0, 0.258064538, 0)
		BarName.Size = UDim2.new(0.821782172, 0, 0.483871102, 0)
		BarName.Font = Enum.Font.Unknown
		BarName.Text = TabName
		BarName.TextColor3 = Color3.fromRGB(255, 255, 255)
		BarName.TextScaled = true
		BarName.TextSize = 14.000
		BarName.TextStrokeTransparency = 0.000
		BarName.TextWrapped = true
		BarName.TextXAlignment = Enum.TextXAlignment.Left

		Arrow.Name = "Arrow"
		Arrow.Parent = Tab
		Arrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Arrow.BackgroundTransparency = 1.000
		Arrow.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Arrow.BorderSizePixel = 0
		Arrow.Position = UDim2.new(0.924092412, 0, 0.193548396, 0)
		Arrow.Size = UDim2.new(0.0462046191, 0, 0.612903416, 0)
		Arrow.Font = Enum.Font.Unknown
		Arrow.Text = ">"
		Arrow.TextColor3 = Color3.fromRGB(255, 255, 255)
		Arrow.TextSize = 14.000
		Arrow.TextStrokeTransparency = 0.000
		Arrow.TextWrapped = true
		
		NewTab.Name = FlagName
		NewTab.Parent = Tabs
		
		Tab:SetAttribute("TAB", true)
		Tab:SetAttribute("PARENT", Parent.Name)
		
		LIB.Tab[FlagName] = {
			LastTab = nil,
		}
		
		return NewTab
	end
	
	NewLib.createText = function(data)
		if not data.Parent then
			data.Parent = MainFrame
		end
		
		if not data.TextPosition then
			data.TextPosition = "center"
		end
		
		if string.lower(data.TextPosition) == "left" then
			data.TextPosition = Enum.TextXAlignment.Left
		elseif string.lower(data.TextPosition) == "center" then
			data.TextPosition = Enum.TextXAlignment.Center
		elseif string.lower(data.TextPosition) == "right" then
			data.TextPosition = Enum.TextXAlignment.Right
		end 
		
		local Text = Instance.new("Frame")
		local BarName_3 = Instance.new("TextLabel")
		
		Text.Name = "Text"
		Text.Parent = data.Parent
		Text.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Text.BackgroundTransparency = 0.450
		Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Text.BorderSizePixel = 0
		Text.Size = UDim2.new(1, 0, 0.0656779632, 0)

		BarName_3.Name = "BarName"
		BarName_3.Parent = Text
		BarName_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BarName_3.BackgroundTransparency = 1.000
		BarName_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BarName_3.BorderSizePixel = 0
		BarName_3.Position = UDim2.new(0.0264026411, 0, 0.258064538, 0)
		BarName_3.Size = UDim2.new(0.943894386, 0, 0.483871132, 0)
		BarName_3.Font = Enum.Font.Unknown
		BarName_3.Text = data.Text
		BarName_3.TextColor3 = Color3.fromRGB(255, 255, 255)
		BarName_3.TextScaled = true
		BarName_3.TextSize = 14.000
		BarName_3.TextStrokeTransparency = 0.000
		BarName_3.TextWrapped = true
		BarName_3.TextXAlignment = data.TextPosition
		BarName_3.RichText = data.RichText
		
		Text:SetAttribute("PARENT", data.Parent.Name)
	end
	
	NewLib.createSeperator = function(Parent)
		if not Parent then
			Parent = MainFrame
		end
		
		local Seperator = Instance.new("Frame")
		local Frame = Instance.new("Frame")
		
		Seperator.Name = "Seperator"
		Seperator.Parent = Parent
		Seperator.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Seperator.BackgroundTransparency = 0.450
		Seperator.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Seperator.BorderSizePixel = 0
		Seperator.Size = UDim2.new(1, 0, 0.0656779632, 0)

		Frame.Parent = Seperator
		Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(0.0259999689, 0, 0.516064584, 0)
		Frame.Size = UDim2.new(0.944, 0, 0.02, 0)
		
		Seperator:SetAttribute("PARENT", Parent.Name)
	end
	
	NewLib.createToggle = function(data)
		if not data.Parent then
			data.Parent = MainFrame
		end
		
		local TEST_1 = Instance.new("Frame")
		local BarName_1 = Instance.new("TextLabel")
		local Circle = Instance.new("ImageLabel")
		
		TEST_1.Name = data.FlagName
		TEST_1.Parent = data.Parent
		TEST_1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		TEST_1.BackgroundTransparency = 0.450
		TEST_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TEST_1.BorderSizePixel = 0
		TEST_1.Size = UDim2.new(1, 0, 0.0656779632, 0)

		BarName_1.Name = "BarName"
		BarName_1.Parent = TEST_1
		BarName_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BarName_1.BackgroundTransparency = 1.000
		BarName_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BarName_1.BorderSizePixel = 0
		BarName_1.Position = UDim2.new(0.0264026411, 0, 0.258064538, 0)
		BarName_1.Size = UDim2.new(0.821782172, 0, 0.483871102, 0)
		BarName_1.Text = data.Name
		BarName_1.TextColor3 = Color3.fromRGB(255, 255, 255)
		BarName_1.TextScaled = true
		BarName_1.TextSize = 14.000
		BarName_1.TextStrokeTransparency = 0.000
		BarName_1.TextWrapped = true
		BarName_1.TextXAlignment = Enum.TextXAlignment.Left

		Circle.Name = "Circle"
		Circle.Parent = TEST_1
		Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Circle.BackgroundTransparency = 1.000
		Circle.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Circle.BorderSizePixel = 0
		Circle.Position = UDim2.new(0.914191425, 0, 0.193548396, 0)
		Circle.Size = UDim2.new(0.0624093898, 0, 0.548936427, 0)
		Circle.Image = "rbxassetid://4661609682"
		Circle.ImageColor3 = Color3.fromRGB(255, 74, 74)
		Circle.ScaleType = Enum.ScaleType.Fit
		
		if data.Default then
			Circle.Image = "rbxassetid://"..LIB.ToggleSettings.TickIcon
			Circle.ImageColor3 = LIB.UIColor2
			
			if MainData.UIGradient ~= nil then
				local Gradient = Instance.new("UIGradient")
				Gradient.Parent = Circle
				Gradient.Color = MainData.UIGradient

				Circle.ImageColor3 = Color3.fromRGB(255, 255, 255)
			end
		elseif not data.Default then
			Circle.Image = "rbxassetid://"..LIB.ToggleSettings.CrossIcon
			Circle.ImageColor3 = Color3.fromRGB(255, 74, 74)
			
			if MainData.UIGradient ~= nil then
				Circle.ImageColor3 = Color3.fromRGB(255,255,255)

				if Circle:FindFirstChild("UIGradient") then
					Circle:FindFirstChild("UIGradient"):Destroy()
				end
			end
		end
		
		
		
		TEST_1:SetAttribute("TOGGLE", true)
		TEST_1:SetAttribute("PARENT", data.Parent.Name)
		
		LIB.Tab[data.Parent.Name][data.FlagName] = data
	end
	
	NewLib.createSlider = function(data)
		if not data.Parent then
			data.Parent = MainFrame
		end
		
		local Slider = Instance.new("Frame")
		local BarName_2 = Instance.new("TextLabel")
		local Number = Instance.new("TextLabel")
		local Arrow1_2 = Instance.new("ImageLabel")
		local Arrow2_2 = Instance.new("ImageLabel")
		
		Slider.Name = data.FlagName
		Slider.Parent = data.Parent
		Slider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Slider.BackgroundTransparency = 0.450
		Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Slider.BorderSizePixel = 0
		Slider.Size = UDim2.new(1, 0, 0.0656779632, 0)

		BarName_2.Name = "BarName"
		BarName_2.Parent = Slider
		BarName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BarName_2.BackgroundTransparency = 1.000
		BarName_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BarName_2.BorderSizePixel = 0
		BarName_2.Position = UDim2.new(0.0264026411, 0, 0.258064538, 0)
		BarName_2.Size = UDim2.new(0.821782172, 0, 0.483871102, 0)
		BarName_2.Text = data.Name
		BarName_2.TextColor3 = Color3.fromRGB(255, 255, 255)
		BarName_2.TextScaled = true
		BarName_2.TextSize = 14.000
		BarName_2.TextStrokeTransparency = 0.000
		BarName_2.TextWrapped = true
		BarName_2.TextXAlignment = Enum.TextXAlignment.Left

		Number.Name = "Number"
		Number.Parent = Slider
		Number.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Number.BackgroundTransparency = 1.000
		Number.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Number.BorderSizePixel = 0
		Number.Position = UDim2.new(0.903999984, 0, 0.225999996, 0)
		Number.Size = UDim2.new(0.0792079195, 0, 0.548387229, 0)
		Number.Text = tostring(data.Default)
		Number.TextColor3 = Color3.fromRGB(255, 255, 255)
		Number.TextScaled = true
		Number.TextSize = 14.000
		Number.TextStrokeTransparency = 0.000
		Number.TextWrapped = true

		Arrow1_2.Name = "Arrow1"
		Arrow1_2.Parent = Slider
		Arrow1_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Arrow1_2.BackgroundTransparency = 1.000
		Arrow1_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Arrow1_2.BorderSizePixel = 0
		Arrow1_2.Position = UDim2.new(0.798679888, 0, 0.193548396, 0)
		Arrow1_2.Rotation = 90.000
		Arrow1_2.Size = UDim2.new(0.0726006851, 0, 0.58099997, 0)
		Arrow1_2.Image = "rbxassetid://11552476728"
		Arrow1_2.ImageTransparency = 1.000
		Arrow1_2.ScaleType = Enum.ScaleType.Fit

		Arrow2_2.Name = "Arrow2"
		Arrow2_2.Parent = Slider
		Arrow2_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Arrow2_2.BackgroundTransparency = 1.000
		Arrow2_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Arrow2_2.BorderSizePixel = 0
		Arrow2_2.Position = UDim2.new(0.899999976, 0, 0.194000006, 0)
		Arrow2_2.Rotation = -90.000
		Arrow2_2.Size = UDim2.new(0.0726006851, 0, 0.58099997, 0)
		Arrow2_2.Image = "rbxassetid://11552476728"
		Arrow2_2.ImageTransparency = 1.000
		Arrow2_2.ScaleType = Enum.ScaleType.Fit
		
		Slider:SetAttribute("SLIDER", true)
		Slider:SetAttribute("PARENT", data.Parent.Name)
		
		LIB.Tab[data.Parent.Name][data.FlagName] = data
	end
	
	NewLib.createList = function(data)
		if not data.Parent then
			data.Parent = MainFrame
		end

		local Slider = Instance.new("Frame")
		local BarName_2 = Instance.new("TextLabel")
		local Number = Instance.new("TextLabel")
		local Arrow1_2 = Instance.new("ImageLabel")
		local Arrow2_2 = Instance.new("ImageLabel")

		Slider.Name = data.FlagName
		Slider.Parent = data.Parent
		Slider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Slider.BackgroundTransparency = 0.450
		Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Slider.BorderSizePixel = 0
		Slider.Size = UDim2.new(1, 0, 0.0656779632, 0)

		BarName_2.Name = "BarName"
		BarName_2.Parent = Slider
		BarName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BarName_2.BackgroundTransparency = 1.000
		BarName_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BarName_2.BorderSizePixel = 0
		BarName_2.Position = UDim2.new(0.0264026411, 0, 0.258064538, 0)
		BarName_2.Size = UDim2.new(0.821782172, 0, 0.483871102, 0)
		BarName_2.Text = data.Name
		BarName_2.TextColor3 = Color3.fromRGB(255, 255, 255)
		BarName_2.TextScaled = true
		BarName_2.TextSize = 14.000
		BarName_2.TextStrokeTransparency = 0.000
		BarName_2.TextWrapped = true
		BarName_2.TextXAlignment = Enum.TextXAlignment.Left

		Number.Name = "Number"
		Number.Parent = Slider
		Number.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Number.BackgroundTransparency = 1.000
		Number.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Number.BorderSizePixel = 0
		Number.Position = UDim2.new(0.825, 0, 0.258, 0)
		Number.Size = UDim2.new(0.154891595, 0, 0.516322613, 0)
		Number.Text = data.Default
		Number.TextColor3 = Color3.fromRGB(255, 255, 255)
		Number.TextScaled = true
		Number.TextSize = 14.000
		Number.TextStrokeTransparency = 0.000
		Number.TextWrapped = true

		Arrow1_2.Name = "Arrow1"
		Arrow1_2.Parent = Slider
		Arrow1_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Arrow1_2.BackgroundTransparency = 1.000
		Arrow1_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Arrow1_2.BorderSizePixel = 0
		Arrow1_2.Position = UDim2.new(0.745697141, 0, 0.22580646, 0)
		Arrow1_2.Rotation = 90.000
		Arrow1_2.Size = UDim2.new(0.0726006851, 0, 0.58099997, 0)
		Arrow1_2.Image = "rbxassetid://11552476728"
		Arrow1_2.ImageTransparency = 1.000
		Arrow1_2.ScaleType = Enum.ScaleType.Fit

		Arrow2_2.Name = "Arrow2"
		Arrow2_2.Parent = Slider
		Arrow2_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Arrow2_2.BackgroundTransparency = 1.000
		Arrow2_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Arrow2_2.BorderSizePixel = 0
		Arrow2_2.Position = UDim2.new(0.926491261, 0, 0.226258069, 0)
		Arrow2_2.Rotation = -90.000
		Arrow2_2.Size = UDim2.new(0.0726006851, 0, 0.58099997, 0)
		Arrow2_2.Image = "rbxassetid://11552476728"
		Arrow2_2.ImageTransparency = 1.000
		Arrow2_2.ScaleType = Enum.ScaleType.Fit

		Slider:SetAttribute("LIST", true)
		Slider:SetAttribute("PARENT", data.Parent.Name)

		LIB.Tab[data.Parent.Name][data.FlagName] = data
	end
	
	NewLib.createButton = function(data)
		if not data.Parent then
			data.Parent = MainFrame
		end
		
		local Button = Instance.new("Frame")
		local BarName_2 = Instance.new("TextLabel")

		Button.Name = data.FlagName
		Button.Parent = data.Parent
		Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Button.BackgroundTransparency = 0.450
		Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Button.BorderSizePixel = 0
		Button.Size = UDim2.new(1, 0, 0.0656779632, 0)

		BarName_2.Name = "BarName"
		BarName_2.Parent = Button
		BarName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BarName_2.BackgroundTransparency = 1.000
		BarName_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BarName_2.BorderSizePixel = 0
		BarName_2.Position = UDim2.new(0.0264026411, 0, 0.258064538, 0)
		BarName_2.Size = UDim2.new(0.821782172, 0, 0.483871102, 0)
		BarName_2.Font = Enum.Font.Unknown
		BarName_2.Text = data.Name
		BarName_2.TextColor3 = Color3.fromRGB(255, 255, 255)
		BarName_2.TextScaled = true
		BarName_2.TextSize = 14.000
		BarName_2.TextStrokeTransparency = 0.000
		BarName_2.TextWrapped = true
		BarName_2.TextXAlignment = Enum.TextXAlignment.Left
		
		Button:SetAttribute("BUTTON", true)
		Button:SetAttribute("PARENT", data.Parent.Name)
		
		LIB.Tab[data.Parent.Name][data.FlagName] = data
	end
	
	NewLib.createTextBox = function(data)
		if data.Parent == nil then
			data.Parent = MainFrame
		end
		
		local ColorPicker = Instance.new("Frame")
		local BarName_55 = Instance.new("TextLabel")
		local TextBox_1 = Instance.new("TextBox")
		
		ColorPicker.Name = data.FlagName
		ColorPicker.Parent = data.Parent
		ColorPicker.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		ColorPicker.BackgroundTransparency = 0.450
		ColorPicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ColorPicker.BorderSizePixel = 0
		ColorPicker.Size = UDim2.new(1, 0, 0.0656779632, 0)

		BarName_55.Name = "BarName"
		BarName_55.Parent = ColorPicker
		BarName_55.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BarName_55.BackgroundTransparency = 1.000
		BarName_55.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BarName_55.BorderSizePixel = 0
		BarName_55.Position = UDim2.new(0.0264026411, 0, 0.258064538, 0)
		BarName_55.Size = UDim2.new(0.821782172, 0, 0.483871102, 0)
		BarName_55.Text = data.Name
		BarName_55.TextColor3 = Color3.fromRGB(255, 255, 255)
		BarName_55.TextScaled = true
		BarName_55.TextSize = 14.000
		BarName_55.TextStrokeTransparency = 0.000
		BarName_55.TextWrapped = true
		BarName_55.TextXAlignment = Enum.TextXAlignment.Left
		
		TextBox_1.Parent = ColorPicker
		TextBox_1.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
		TextBox_1.BackgroundTransparency = 0.500
		TextBox_1.BorderColor3 = Color3.fromRGB(104, 104, 104)
		TextBox_1.BorderSizePixel = 2
		TextBox_1.Position = UDim2.new(0.930556953, 0, 0.226258069, 0)
		TextBox_1.Size = UDim2.new(0.0264913719, 0, 0.548999965, 0)
		TextBox_1.ClearTextOnFocus = false
		TextBox_1.Font = Enum.Font.GothamBold
		TextBox_1.Text = ""
		TextBox_1.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextBox_1.TextScaled = true
		TextBox_1.TextSize = 14.000
		TextBox_1.TextStrokeTransparency = 0.000
		TextBox_1.TextWrapped = true

		ColorPicker:SetAttribute("TEXTBOX", true)
		ColorPicker:SetAttribute("PARENT", data.Parent.Name)

		LIB.Tab[data.Parent.Name][data.FlagName] = data
	end
	
	NewLib.createColorPicker = function(data)
		if data.Parent == nil then
			data.Parent = MainFrame
		end
		
		local ColorPicker = Instance.new("Frame")
		local BarName_55 = Instance.new("TextLabel")
		local Preview = Instance.new("Frame")
		local TextBox_1 = Instance.new("TextBox")
		
		ColorPicker.Name = data.FlagName
		ColorPicker.Parent = data.Parent
		ColorPicker.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		ColorPicker.BackgroundTransparency = 0.450
		ColorPicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ColorPicker.BorderSizePixel = 0
		ColorPicker.Size = UDim2.new(1, 0, 0.0656779632, 0)

		BarName_55.Name = "BarName"
		BarName_55.Parent = ColorPicker
		BarName_55.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BarName_55.BackgroundTransparency = 1.000
		BarName_55.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BarName_55.BorderSizePixel = 0
		BarName_55.Position = UDim2.new(0.0264026411, 0, 0.258064538, 0)
		BarName_55.Size = UDim2.new(0.821782172, 0, 0.483871102, 0)
		BarName_55.Text = data.Name
		BarName_55.TextColor3 = Color3.fromRGB(255, 255, 255)
		BarName_55.TextScaled = true
		BarName_55.TextSize = 14.000
		BarName_55.TextStrokeTransparency = 0.000
		BarName_55.TextWrapped = true
		BarName_55.TextXAlignment = Enum.TextXAlignment.Left

		Preview.Name = "Preview"
		Preview.Parent = ColorPicker
		Preview.BackgroundColor3 = data.Default
		Preview.BorderColor3 = Color3.fromRGB(109, 109, 109)
		Preview.BorderSizePixel = 0
		Preview.Position = UDim2.new(0.917311251, 0, 0.194000006, 0)
		Preview.Size = UDim2.new(0.058688581, 0, 0.549000025, 0)

		TextBox_1.Parent = ColorPicker
		TextBox_1.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
		TextBox_1.BackgroundTransparency = 0.500
		TextBox_1.BorderColor3 = Color3.fromRGB(104, 104, 104)
		TextBox_1.BorderSizePixel = 2
		TextBox_1.Position = UDim2.new(0.655709028, 0, 0.194000006, 0)
		TextBox_1.Size = UDim2.new(0.0264913719, 0, 0.548999965, 0)
		TextBox_1.Visible = false
		TextBox_1.Font = Enum.Font.GothamBold
		TextBox_1.Text = ""
		TextBox_1.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextBox_1.TextScaled = true
		TextBox_1.TextSize = 14.000
		TextBox_1.TextStrokeTransparency = 0.000
		TextBox_1.TextWrapped = true
		TextBox_1.ClearTextOnFocus = false
		TextBox_1.AutomaticSize = Enum.AutomaticSize.X
		
		ColorPicker:SetAttribute("COLORPICKER", true)
		ColorPicker:SetAttribute("PARENT", data.Parent.Name)

		LIB.Tab[data.Parent.Name][data.FlagName] = data
	end
	
	NewLib.MoveUp = function()
		LIB.Settings.SelectedNumber -= 1

		if LIB.Settings.SelectedNumber <= 0 then
			LIB.Settings.SelectedNumber = LIB.Settings.MaxCurrentNumber
		end

		NewLib.UpdateVisual()
	end

	NewLib.MoveDown = function()
		LIB.Settings.SelectedNumber += 1

		if LIB.Settings.SelectedNumber > LIB.Settings.MaxCurrentNumber then
			LIB.Settings.SelectedNumber = 1
		end

		NewLib.UpdateVisual()
	end
	
	NewLib.AssertNumber = function()
		local Number = 0

		for _, Items in pairs(MainFrame:GetChildren()) do
			if not table.find(LIB.BlacklistedItems, Items.Name) then
				Number += 1
				Items:SetAttribute("TempNumber", Number)
			end
		end

		return Number
	end

	NewLib.RemoveNumber = function(Item)
		if Item then
			Item:SetAttribute("TempNumber", nil)
		else
			for _, Items in pairs(MainFrame:GetChildren()) do
				if Items:GetAttribute("TempNumber") then
					Items:SetAttribute("TempNumber", nil)
				end
			end
		end
		
	end
	
	NewLib.UpdateGUI = function()
		NewLib.RemoveNumber()

		LIB.Settings.MaxCurrentNumber = NewLib.AssertNumber()
	end

	NewLib.UpdateVisual = function()
		for _, Items in pairs(MainFrame:GetChildren()) do
			if Items:GetAttribute("TempNumber") and Items:GetAttribute("TempNumber") == LIB.Settings.SelectedNumber then
				Items.BackgroundColor3 = LIB.UIColor
				Items.BackgroundTransparency = 0.1
				
				if MainData.UIGradient ~= nil then
					local Gradient = Instance.new("UIGradient")
					Gradient.Parent = Items
					Gradient.Color = MainData.UIGradient

					Items.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				end

				if Items:GetAttribute("SLIDER") then
					game.TweenService:Create(Items.Number, TweenInfo.new(0.2), {Position = LIB.SliderSettings.Moved}):Play()

					game.TweenService:Create(Items.Arrow1, TweenInfo.new(0.2), {ImageTransparency = 0}):Play()
					game.TweenService:Create(Items.Arrow2, TweenInfo.new(0.2), {ImageTransparency = 0}):Play()
				elseif Items:GetAttribute("LIST") then
					game.TweenService:Create(Items.Number, TweenInfo.new(0.2), {Position = LIB.ListSettings.Moved}):Play()

					game.TweenService:Create(Items.Arrow1, TweenInfo.new(0.2), {ImageTransparency = 0}):Play()
					game.TweenService:Create(Items.Arrow2, TweenInfo.new(0.2), {ImageTransparency = 0}):Play()
				elseif Items:GetAttribute("TOGGLE") then
					game.TweenService:Create(Items.Circle, TweenInfo.new(0.2), {Position = LIB.ToggleSettings.Moved}):Play()
				elseif Items:GetAttribute("TAB") then
					game.TweenService:Create(Items.Arrow, TweenInfo.new(0.2), {Position = LIB.TabSettings.Moved}):Play()
				elseif Items:GetAttribute("BUTTON") then
					game.TweenService:Create(Items.BarName, TweenInfo.new(0.2), {Position = LIB.ButtonSettings.Moved}):Play()
				elseif Items:GetAttribute("COLORPICKER") then
					game.TweenService:Create(Items.Preview, TweenInfo.new(0.2), {Position = LIB.ColorPickerSettings.Moved}):Play()
				elseif Items:GetAttribute("TEXTBOX") then
					game.TweenService:Create(Items.TextBox, TweenInfo.new(0.2), {Position = LIB.TextBoxSettings.Moved}):Play()
				end
			elseif Items:GetAttribute("TempNumber") and Items:GetAttribute("TempNumber") ~= LIB.Settings.SelectedNumber then
				Items.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				Items.BackgroundTransparency = 0.45
				
				if MainData.UIGradient ~= nil then
					if Items:FindFirstChild("UIGradient") then
						Items:FindFirstChild("UIGradient"):Destroy()
					end
				end
				
				if Items:GetAttribute("SLIDER") then
					game.TweenService:Create(Items.Number, TweenInfo.new(0.2), {Position = LIB.SliderSettings.Regular}):Play()

					game.TweenService:Create(Items.Arrow1, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
					game.TweenService:Create(Items.Arrow2, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
				elseif Items:GetAttribute("LIST") then
					game.TweenService:Create(Items.Number, TweenInfo.new(0.2), {Position = LIB.ListSettings.Regular}):Play()

					game.TweenService:Create(Items.Arrow1, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
					game.TweenService:Create(Items.Arrow2, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
				elseif Items:GetAttribute("TOGGLE") then
					game.TweenService:Create(Items.Circle, TweenInfo.new(0.2), {Position = LIB.ToggleSettings.Regular}):Play()
				elseif Items:GetAttribute("TAB") then
					game.TweenService:Create(Items.Arrow, TweenInfo.new(0.2), {Position = LIB.TabSettings.Regular}):Play()
				elseif Items:GetAttribute("BUTTON") then
					game.TweenService:Create(Items.BarName, TweenInfo.new(0.2), {Position = LIB.ButtonSettings.Regular}):Play()
				elseif Items:GetAttribute("COLORPICKER") then
					game.TweenService:Create(Items.Preview, TweenInfo.new(0.2), {Position = LIB.ColorPickerSettings.Regular}):Play()
				elseif Items:GetAttribute("TEXTBOX") then
					game.TweenService:Create(Items.TextBox, TweenInfo.new(0.2), {Position = LIB.TextBoxSettings.Regular}):Play()
				end
			end
		end
		
		if LIB.Settings.MaxCurrentNumber == 0 then
			Selector.Text = "[ N/A ]"
			Selector_2.Text = "[ N/A ]"
		else
			Selector.Text = "[ "..tostring(LIB.Settings.SelectedNumber).."/"..tostring(LIB.Settings.MaxCurrentNumber).." ]"
			Selector_2.Text = "[ "..tostring(LIB.Settings.SelectedNumber).."/"..tostring(LIB.Settings.MaxCurrentNumber).." ]"
		end
	end
	
	NewLib.Select = function()
		for _, Items in pairs(MainFrame:GetChildren()) do
			if Items:GetAttribute("TempNumber") and Items:GetAttribute("TempNumber") == LIB.Settings.SelectedNumber then
				if Items:GetAttribute("SLIDER") then
					SliderFrame.Visible = true
					TextBox.Text = ""
					task.wait(0.1)
					TextBox:CaptureFocus()
					
					TextBox:GetPropertyChangedSignal("Text"):Connect(function()
						TextBox.Text = TextBox.Text:gsub('[^%d.]', '')
					end)
					
					TextBox.FocusLost:Connect(function(EnterPressed)
						if not EnterPressed then return end
						
						if EnterPressed then
							SliderFrame.Visible = false
							
							if LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value == nil then
								LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value = LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Default
							end
							
							if TextBox.Text == "" then
								TextBox.Text = tostring(LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Max)
							end
							
							local Number = tonumber(TextBox.Text)
							
							if Number > LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Max then
								Number = LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Max
							end
							
							if Number < LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Min then
								Number = LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Min
							end
							
							LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value = Number

							LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Callback(LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value)

							Items.Number.Text = tostring(LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value)
							
							TextBox:ReleaseFocus()
						end
					end)
				elseif Items:GetAttribute("COLORPICKER") then
					Items.TextBox.Visible = true
					task.wait(0.1)
					Items.TextBox:CaptureFocus()

					Items.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
						Items.TextBox.Text = Items.TextBox.Text:gsub('[^%d,]', '')
					end)

					Items.TextBox.FocusLost:Connect(function(EnterPressed)
						if not EnterPressed then return end

						if EnterPressed then
							Items.TextBox.Visible = false

							if LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value == nil then
								LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value = LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Default
							end

							if Items.TextBox.Text == "" then
								Items.TextBox.Text = "255,255,255"
							end
							
							local Args = string.split(Items.TextBox.Text, ",")
							
							if not Args[1] or not Args[2] or not Args[3] then
								Args = {255,255,255}
							end
							
							local Number = Color3.fromRGB(Args[1], Args[2], Args[3])

							LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value = Number

							LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Callback(LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value)

							Items.Preview.BackgroundColor3 = LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value

							Items.TextBox:ReleaseFocus()
						end
					end)
				elseif Items:GetAttribute("TEXTBOX") then
					task.wait(0.1)
					Items.TextBox:CaptureFocus()
					
					local ts = game:GetService("TextService")
					
					local NewTextboxSize = ts:GetTextSize(Items.TextBox.Text, Items.TextBox.TextSize, Items.TextBox.Font, Vector2.new(math.huge,math.huge))
					local ForcedMaxSize = ts:GetTextSize(Items.TextBox.Text, Items.TextBox.TextSize, Items.TextBox.Font, Vector2.new(math.huge,math.huge))
					
					local function ResizeTextBox()
						NewTextboxSize = ts:GetTextSize(Items.TextBox.Text, Items.TextBox.TextSize, Items.TextBox.Font, Vector2.new(math.huge,math.huge))
						if NewTextboxSize.X < (396 - ForcedMaxSize.X) - 10 then
							game.TweenService:Create(Items.TextBox, TweenInfo.new(0.07, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0), {Size = UDim2.new(0, -NewTextboxSize.X - 8, 0, 20)}):Play()
						else
							game.TweenService:Create(Items.TextBox, TweenInfo.new(0.07, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0), {Size = UDim2.new(0, (396 - ForcedMaxSize.X) - 12, 0, 20)}):Play()
						end
					end
					
					local function SetMaxSize()
						ForcedMaxSize = ts:GetTextSize(Items.TextBox.Text, Items.TextBox.TextSize, Items.TextBox.Font, Vector2.new(math.huge,math.huge))
						local def = 396 - ForcedMaxSize.X
					end
					
					ResizeTextBox()
					SetMaxSize()
					
					Items.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
						ResizeTextBox()
						SetMaxSize()
						
						Items.TextBox.Text = Items.TextBox.Text:sub(1,28)
					end)
					
					Items.TextBox.FocusLost:Connect(function(EnterPressed)
						if not EnterPressed then return end

						if EnterPressed then

							if LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value == nil then
								LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value = LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Default
							end
							
							LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value = Items.TextBox.Text

							LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Callback(LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value)

							Items.TextBox:ReleaseFocus()
						end
					end)
				elseif Items:GetAttribute("BUTTON") then
					LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Callback()
				elseif Items:GetAttribute("TOGGLE") then
					
					if LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value == nil then
						LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value = LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Default
					end
					
					LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value = not LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value
					
					LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Callback(LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value)
					
					if LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value then
						Items.Circle.Image = "rbxassetid://"..LIB.ToggleSettings.TickIcon
						Items.Circle.ImageColor3 = LIB.UIColor2
						
						if MainData.UIGradient ~= nil then
							local Gradient = Instance.new("UIGradient")
							Gradient.Parent = Items.Circle
							Gradient.Color = MainData.UIGradient
							
							Items.Circle.ImageColor3 = Color3.fromRGB(255, 255, 255)
						end
					elseif not LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value then
						Items.Circle.Image = "rbxassetid://"..LIB.ToggleSettings.CrossIcon
						Items.Circle.ImageColor3 = Color3.fromRGB(255, 74, 74)
						
						if MainData.UIGradient ~= nil then
							Items.Circle.ImageColor3 = Color3.fromRGB(255,255,255)
							
							if Items.Circle:FindFirstChild("UIGradient") then
								Items.Circle:FindFirstChild("UIGradient"):Destroy()
							end
						end
					end
				elseif Items:GetAttribute("TAB") then
					LIB.Tab[Items.Name].LastTab = LIB.Settings.CurrentTab
					
					for _, Items2 in pairs(MainFrame:GetChildren()) do
						if Items2:GetAttribute("TempNumber") then
							NewLib.RemoveNumber(Items2)
							Items2.Parent = Tabs[Items2:GetAttribute("PARENT")]
							
							if Items2:GetAttribute("SLIDER") then
								game.TweenService:Create(Items2.Number, TweenInfo.new(0.2), {Position = LIB.SliderSettings.Regular}):Play()

								game.TweenService:Create(Items2.Arrow1, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
								game.TweenService:Create(Items2.Arrow2, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
							elseif Items2:GetAttribute("LIST") then
								game.TweenService:Create(Items2.Number, TweenInfo.new(0.2), {Position = LIB.ListSettings.Regular}):Play()

								game.TweenService:Create(Items2.Arrow1, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
								game.TweenService:Create(Items2.Arrow2, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
							elseif Items2:GetAttribute("TOGGLE") then
								game.TweenService:Create(Items2.Circle, TweenInfo.new(0.2), {Position = LIB.ToggleSettings.Regular}):Play()
							elseif Items2:GetAttribute("TAB") then
								game.TweenService:Create(Items2.Arrow, TweenInfo.new(0.2), {Position = LIB.TabSettings.Regular}):Play()
							elseif Items2:GetAttribute("BUTTON") or Items2:GetAttribute("TEXTBOX") then
								game.TweenService:Create(Items2.BarName, TweenInfo.new(0.2), {Position = LIB.ButtonSettings.Regular}):Play()
							elseif Items2:GetAttribute("COLORPICKER") then
								game.TweenService:Create(Items2.Preview, TweenInfo.new(0.2), {Position = LIB.ColorPickerSettings.Regular}):Play()
							elseif Items2:GetAttribute("TEXTBOX") then
								game.TweenService:Create(Items2.TextBox, TweenInfo.new(0.2), {Position = LIB.TextBoxSettings.Regular}):Play()
							end
						elseif Items2.Name == "Text" or Items2.Name == "Seperator" then
							Items2.Parent = Tabs[Items2:GetAttribute("PARENT")]
							
							if Items2:GetAttribute("SLIDER") then
								game.TweenService:Create(Items2.Number, TweenInfo.new(0.2), {Position = LIB.SliderSettings.Regular}):Play()

								game.TweenService:Create(Items2.Arrow1, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
								game.TweenService:Create(Items2.Arrow2, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
							elseif Items2:GetAttribute("LIST") then
								game.TweenService:Create(Items2.Number, TweenInfo.new(0.2), {Position = LIB.ListSettings.Regular}):Play()

								game.TweenService:Create(Items2.Arrow1, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
								game.TweenService:Create(Items2.Arrow2, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
							elseif Items2:GetAttribute("TOGGLE") then
								game.TweenService:Create(Items2.Circle, TweenInfo.new(0.2), {Position = LIB.ToggleSettings.Regular}):Play()
							elseif Items2:GetAttribute("TAB") then
								game.TweenService:Create(Items2.Arrow, TweenInfo.new(0.2), {Position = LIB.TabSettings.Regular}):Play()
							elseif Items2:GetAttribute("BUTTON") or Items2:GetAttribute("TEXTBOX") then
								game.TweenService:Create(Items2.BarName, TweenInfo.new(0.2), {Position = LIB.ButtonSettings.Regular}):Play()
							elseif Items2:GetAttribute("COLORPICKER") then
								game.TweenService:Create(Items2.Preview, TweenInfo.new(0.2), {Position = LIB.ColorPickerSettings.Regular}):Play()
							elseif Items2:GetAttribute("TEXTBOX") then
								game.TweenService:Create(Items2.TextBox, TweenInfo.new(0.2), {Position = LIB.TextBoxSettings.Regular}):Play()
							end
						end
					end
					
					for _, Items3 in pairs(Tabs[Items.Name]:GetChildren()) do
						Items3.Parent = MainFrame
					end
					
					LIB.Settings.CurrentTab = Items.Name
					
					NewLib.MainFrame.TopBar.TabName.Text = Items.BarName.Text
					
					NewLib.AssertNumber()
					
					LIB.Settings.SelectedNumber = 1
					
					NewLib.UpdateGUI()
					NewLib.UpdateVisual()
				end
			end
		end
	end
	
	NewLib.GetMaxList = function(List)
		if typeof(List) ~= "table" then
			return
		end
		
		local Number = 1
		
		for _, v in pairs(List) do
			if List[Number] ~= nil then
				Number += 1
			end
		end
		
		Number -= 1
		
		return Number
	end
	
	NewLib.GetDefaultNumber = function(List, Default)
		if typeof(List) ~= "table" then
			return
		end

		local Number = 1

		for i, v in pairs(List) do
			if v == Default then
				Number = i
			end
		end

		return Number
	end
	
	NewLib.MoveLeft = function()
		for _, Items in pairs(MainFrame:GetChildren()) do
			if Items:GetAttribute("TempNumber") and Items:GetAttribute("TempNumber") == LIB.Settings.SelectedNumber then
				if Items:GetAttribute("SLIDER") then
					if LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value == nil then
						LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value = LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Default
					end

					LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value -= LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Interval

					if LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value < LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Min then
						LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value = LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Min
					end

					LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Callback(LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value)
					
					Items.Number.Text = tostring(LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value)
				elseif Items:GetAttribute("LIST") then
					if LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value == nil then
						LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value = LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Default
					end

					if LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Max == nil then
						LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Max = NewLib.GetMaxList(LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Lists)
					end

					if LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].NumberValue == nil then
						LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].NumberValue = NewLib.GetDefaultNumber(LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Lists, LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Default)
					end
					
					LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].NumberValue -= 1
					
					if LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].NumberValue <= 0 then
						LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].NumberValue = LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Max
					end
					
					if LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].NumberValue > LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Max then
						LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].NumberValue = 1
					end
					
					LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value = LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Lists[LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].NumberValue]
					
					LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Callback(LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value)

					Items.Number.Text = tostring(LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value)
				end
			end
		end	
	end
	
	NewLib.MoveRight = function()
		for _, Items in pairs(MainFrame:GetChildren()) do
			if Items:GetAttribute("TempNumber") and Items:GetAttribute("TempNumber") == LIB.Settings.SelectedNumber then
				if Items:GetAttribute("SLIDER") then
					if LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value == nil then
						LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value = LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Default
					end

					LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value += LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Interval
					
					if LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value > LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Max then
						LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value = LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Max
					end
					
					LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Callback(LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value)
					
					Items.Number.Text = tostring(LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value)
				elseif Items:GetAttribute("LIST") then
					if LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value == nil then
						LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value = LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Default
					end

					if LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Max == nil then
						LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Max = NewLib.GetMaxList(LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Lists)
					end

					if LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].NumberValue == nil then
						LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].NumberValue = NewLib.GetDefaultNumber(LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Lists, LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Default)
					end

					LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].NumberValue += 1

					if LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].NumberValue <= 0 then
						LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].NumberValue = LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Max
					end

					if LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].NumberValue > LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Max then
						LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].NumberValue = 1
					end
										
					LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value = LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Lists[LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].NumberValue]

					LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Callback(LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value)

					Items.Number.Text = tostring(LIB.Tab[Items:GetAttribute("PARENT")][Items.Name].Value)
				end
			end
		end	
	end
	
	NewLib.Return = function()
		if LIB.Tab[LIB.Settings.CurrentTab].LastTab == "no" then
			NewLib.MainFrame.TopBar.TabName.Text = "Home"
			return
		end
		
		for _, Items2 in pairs(MainFrame:GetChildren()) do
			if Items2:GetAttribute("TempNumber") then
				NewLib.RemoveNumber(Items2)
				Items2.Parent = Tabs[Items2:GetAttribute("PARENT")]
				
				Items2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				Items2.BackgroundTransparency = 0.45

				if MainData.UIGradient ~= nil then
					if Items2:FindFirstChild("UIGradient") then
						Items2:FindFirstChild("UIGradient"):Destroy()
					end
				end

				if Items2:GetAttribute("SLIDER") then
					game.TweenService:Create(Items2.Number, TweenInfo.new(0.2), {Position = LIB.SliderSettings.Regular}):Play()

					game.TweenService:Create(Items2.Arrow1, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
					game.TweenService:Create(Items2.Arrow2, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
				elseif Items2:GetAttribute("LIST") then
					game.TweenService:Create(Items2.Number, TweenInfo.new(0.2), {Position = LIB.ListSettings.Regular}):Play()

					game.TweenService:Create(Items2.Arrow1, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
					game.TweenService:Create(Items2.Arrow2, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
				elseif Items2:GetAttribute("TOGGLE") then
					game.TweenService:Create(Items2.Circle, TweenInfo.new(0.2), {Position = LIB.ToggleSettings.Regular}):Play()
				elseif Items2:GetAttribute("TAB") then
					game.TweenService:Create(Items2.Arrow, TweenInfo.new(0.2), {Position = LIB.TabSettings.Regular}):Play()
				elseif Items2:GetAttribute("BUTTON") or Items2:GetAttribute("TEXTBOX") then
					game.TweenService:Create(Items2.BarName, TweenInfo.new(0.2), {Position = LIB.ButtonSettings.Regular}):Play()
				elseif Items2:GetAttribute("COLORPICKER") then
					game.TweenService:Create(Items2.Preview, TweenInfo.new(0.2), {Position = LIB.ColorPickerSettings.Regular}):Play()
				elseif Items2:GetAttribute("TEXTBOX") then
					game.TweenService:Create(Items2.TextBox, TweenInfo.new(0.2), {Position = LIB.TextBoxSettings.Regular}):Play()
				end
			elseif Items2.Name == "Text" or Items2.Name == "Seperator" then
				Items2.Parent = Tabs[Items2:GetAttribute("PARENT")]
				
				Items2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				Items2.BackgroundTransparency = 0.45

				if MainData.UIGradient ~= nil then
					if Items2:FindFirstChild("UIGradient") then
						Items2:FindFirstChild("UIGradient"):Destroy()
					end
				end

				if Items2:GetAttribute("SLIDER") then
					game.TweenService:Create(Items2.Number, TweenInfo.new(0.2), {Position = LIB.SliderSettings.Regular}):Play()

					game.TweenService:Create(Items2.Arrow1, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
					game.TweenService:Create(Items2.Arrow2, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
				elseif Items2:GetAttribute("LIST") then
					game.TweenService:Create(Items2.Number, TweenInfo.new(0.2), {Position = LIB.ListSettings.Regular}):Play()

					game.TweenService:Create(Items2.Arrow1, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
					game.TweenService:Create(Items2.Arrow2, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
				elseif Items2:GetAttribute("TOGGLE") then
					game.TweenService:Create(Items2.Circle, TweenInfo.new(0.2), {Position = LIB.ToggleSettings.Regular}):Play()
				elseif Items2:GetAttribute("TAB") then
					game.TweenService:Create(Items2.Arrow, TweenInfo.new(0.2), {Position = LIB.TabSettings.Regular}):Play()
				elseif Items2:GetAttribute("BUTTON") or Items2:GetAttribute("TEXTBOX") then
					game.TweenService:Create(Items2.BarName, TweenInfo.new(0.2), {Position = LIB.ButtonSettings.Regular}):Play()
				elseif Items2:GetAttribute("COLORPICKER") then
					game.TweenService:Create(Items2.Preview, TweenInfo.new(0.2), {Position = LIB.ColorPickerSettings.Regular}):Play()
				elseif Items2:GetAttribute("TEXTBOX") then
					game.TweenService:Create(Items2.TextBox, TweenInfo.new(0.2), {Position = LIB.TextBoxSettings.Regular}):Play()
				end
			end
		end
		
		for _, Items3 in pairs(Tabs[LIB.Tab[LIB.Settings.CurrentTab].LastTab]:GetChildren()) do
			Items3.Parent = MainFrame
		end
		
		LIB.Settings.CurrentTab = LIB.Tab[LIB.Settings.CurrentTab].LastTab
		
		print(LIB.Settings.CurrentTab)
		
		if LIB.Tab[LIB.Settings.CurrentTab].LastTab ~= "no" then
			NewLib.MainFrame.TopBar.TabName.Text = Tabs[LIB.Tab[LIB.Settings.CurrentTab].LastTab]:FindFirstChild(LIB.Settings.CurrentTab).BarName.Text
		end
		
		if LIB.Settings.CurrentTab == "MainFrame" then
			NewLib.MainFrame.TopBar.TabName.Text = "Home"
		end
		
		NewLib.AssertNumber()

		LIB.Settings.SelectedNumber = 1

		NewLib.UpdateGUI()
		NewLib.UpdateVisual()
	end
	
	NewLib.UpdateGUI()
	NewLib.UpdateVisual()
	
	UserInputService.InputBegan:Connect(function(Input, GP)
		if GP then return end
		
		if Input.KeyCode == LIB.Keybinds.Up then
			if not LIB.Opened then return end
			
			hoverSound:Play()
			
			NewLib.MoveUp()
		elseif Input.KeyCode == LIB.Keybinds.Down then
			if not LIB.Opened then return end
			
			hoverSound:Play()
			
			NewLib.MoveDown()
		elseif Input.KeyCode == LIB.Keybinds.Left then
			if not LIB.Opened then return end
			
			hoverSound:Play()
			
			NewLib.MoveLeft()
		elseif Input.KeyCode == LIB.Keybinds.Right then
			if not LIB.Opened then return end
			
			hoverSound:Play()
			
			NewLib.MoveRight()
		elseif Input.KeyCode == LIB.Keybinds.Enter then
			if not LIB.Opened then return end
			
			clickSound:Play()
			
			NewLib.Select()
		elseif Input.KeyCode == LIB.Keybinds.Return then
			if not LIB.Opened then return end
			
			returnSound:Play()
			
			NewLib.Return()			
		elseif Input.KeyCode == LIB.Keybinds.Open then
			NewLib.GUI.Enabled = not NewLib.GUI.Enabled
			LIB.Opened = not LIB.Opened
		end
	end)
	
	NewLib.setupSettings = function()
		local SettingsTab = NewLib.createTab("Settings", "SettingsTAB")
		
		local XSlider = NewLib.createSlider({
			Name = "Alignment [X]",
			FlagName = "XSliderAlign",

			Parent = SettingsTab,

			Min = NewLib.MainFrame.Position.X.Offset,
			Default = NewLib.MainFrame.Position.X.Offset,
			Max = 1750,

			Interval = 1,

			Callback = function(val)
				NewLib.MainFrame.Position = UDim2.new(NewLib.MainFrame.Position.X.Scale, val, NewLib.MainFrame.Position.Y.Scale, NewLib.MainFrame.Position.Y.Offset)
			end,
		})
		
		local YSlider = NewLib.createSlider({
			Name = "Alignment [Y]",
			FlagName = "YSliderAlign",

			Parent = SettingsTab,

			Min = NewLib.MainFrame.Position.Y.Offset,
			Default = NewLib.MainFrame.Position.Y.Offset,
			Max = 500,

			Interval = 1,

			Callback = function(val)
				NewLib.MainFrame.Position = UDim2.new(NewLib.MainFrame.Position.X.Scale, NewLib.MainFrame.Position.X.Offset, NewLib.MainFrame.Position.Y.Scale, val)
			end,
		})
	end
	
	return NewLib
end

return LIB
