local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
	Title = 'EXP HUB | Blackout',
	Center = true,
	AutoShow = true,
	TabPadding = 8,
	MenuFadeTime = 0.2
})

local Tabs = {
	Visual = Window:AddTab('Visual'),
	Debugging = Window:AddTab('Debug'),
	['HUD'] = Window:AddTab('HUD'),
}

local AvailbleRemotes = {}

for i,v in pairs(game.ReplicatedStorage:GetDescendants()) do
	if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") or v:IsA("BindableEvent") then
		table.insert(AvailbleRemotes, v.Name)
	end     
end  

local LeftVisualGroupBox = Tabs.Visual:AddLeftGroupbox('ESP')
local ChamsRightVisualGroupBox = Tabs.Visual:AddRightGroupbox('CHAMS')

_G.ESPTeamCheck = false
_G.ESPEnabled = false
_G.ESPLocal = false
_G.ESPShowTracers = true
_G.ESPHealthBar = false
_G.ESPShowBox = true
_G.ESPTracerColor = Color3.fromRGB(0, 255, 140)
_G.ESPBoxColor = Color3.fromRGB(0, 255, 140)

_G.CHAMSEnemyColor = Color3.fromRGB(255, 84, 87)
_G.CHAMSTeamColor = Color3.fromRGB(0, 255, 140)
_G.CHAMSEnabled = false
_G.CHAMSShowTeams = true

local ESPLines = {}

local Camera = workspace.CurrentCamera

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
								newinstance.Visible = true
							else
								newinstance.FillColor = _G.CHAMSEnemyColor
							end
						elseif not _G.CHAMSShowTeams then
							if player.TeamColor == lplr.TeamColor then
								newinstance.Visible = false
								newinstance.FillColor = _G.CHAMSTeamColor
							else
								newinstance.Visible = true
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

			v.CharacterAdded:Connect(function()
				create("Highlight", ChamsStats, v.Character, v)
			end)
		end
	end)
end

StartCHAMS()

local function StartESP()
	local lplr = game.Players.LocalPlayer
	local camera = game:GetService("Workspace").CurrentCamera
	local CurrentCamera = workspace.CurrentCamera
	local worldtoViewportPoint = CurrentCamera.WorldToViewportPoint

	local HeadOff = Vector3.new(0, 0.5, 0)
	local LegOff = Vector3.new(0,3,0)

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

LeftVisualGroupBox:AddDivider()

LeftVisualGroupBox:AddLabel('Tracer Color'):AddColorPicker('ESPColorPicker', {
	Default = Color3.fromRGB(0, 255, 140), -- Bright green
	Title = 'Tracer Color', -- Optional. Allows you to have a custom color picker title (when you open it)
	Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

	Callback = function(Value)
		_G.ESPTracerColor = Value
	end
})

LeftVisualGroupBox:AddLabel('Box Color'):AddColorPicker('ESPBoxColorPicker', {
	Default = Color3.fromRGB(0, 255, 140), -- Bright green
	Title = 'Box Color', -- Optional. Allows you to have a custom color picker title (when you open it)
	Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

	Callback = function(Value)
		_G.ESPBoxColor = Value
	end
})

LeftVisualGroupBox:AddLabel('if you are using the healthbar')
LeftVisualGroupBox:AddLabel('use non vibrant color for better visibility')

ChamsRightVisualGroupBox:AddToggle('EnableChams', {
	Text = 'Enable',
	Default = true, -- Default value (true / false)
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
	Default = Color3.fromRGB(0, 255, 140), -- Bright green
	Title = 'Team Color', -- Optional. Allows you to have a custom color picker title (when you open it)
	Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

	Callback = function(Value)
		_G.CHAMSTeamColor = Value
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

	Library:SetWatermark(('EXP HUB | %s fps | %s ms | %s '):format(
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
ThemeManager:ApplyTheme("Mint")

SaveManager:LoadAutoloadConfig()
