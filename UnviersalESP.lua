if (...).Criminality then
	local repo = 'https://raw.githubusercontent.com/'
	------------------------------------ LINKS ------------------------------------
	local Library = loadstring(game:HttpGet(repo .. 'fatalespion/Releases/main/Lino.lua'))()
	local ThemeManager = loadstring(game:HttpGet(repo .. 'fatalespion/Releases/refs/heads/main/ThemeManager'))()
	local SaveManager = loadstring(game:HttpGet(repo .. 'violin-suzutsuki/LinoriaLib/main/addons/SaveManager.lua'))()

	local players = game:GetService("Players")
	local localPlayer = players.LocalPlayer
	local workspace = game:GetService("Workspace")
	local currentCamera = workspace.CurrentCamera
	local guiService = game:GetService("GuiService")
	local runService = game:GetService("RunService")
	local CNew, CF, C3, Vec2, Vec3 = ColorSequence.new, CFrame.new, Color3.fromRGB, Vector2.new, Vector3.new
	------------------------------------ WINDOW -----------------------------------
	local Window = Library:CreateWindow({
		Title = '$N2 [CRIMINALITY]',
		Center = true,
		AutoShow = true,
		TabPadding = 8,
		MenuFadeTime = 0.2
	})

	local Tabs = {
		Visuals = Window:AddTab('Visuals'),
		['UI Settings'] = Window:AddTab('Settings'),
	}

	local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
	local ESPTabbox = Tabs.Visuals:AddLeftTabbox()
	local ESPTab  = ESPTabbox:AddTab('ESP')
	local ESPSTab = ESPTabbox:AddTab('ESP Settings')
	local DealerTabbox = Tabs.Visuals:AddRightTabbox()
	local DealerTab  = DealerTabbox:AddTab('ESP')
	local DealerSTab = DealerTabbox:AddTab('ESP Settings')
	local FinderTabbox = Tabs.Visuals:AddLeftTabbox()
	local FinderTab  = FinderTabbox:AddTab('Item Finder')

	local esp = {
		playerObjects = {},
		enabled = false,
		teamcheck = false,
		fontsize = 13,
		font = 1,
		settings = {
			name = {enabled = false, outline = false, displaynames = false, color = C3(255, 255, 255)},
			box = {enabled = false, outline = false, color = C3(255, 255, 255)},
			boxfill = {enabled = false, color = C3(255, 0, 0), transparency = 0.5},
			healthbar = {enabled = false, outline = false},
			healthtext = {enabled = false, outline = false, color = C3(255, 255, 255)},
			distance = {enabled = false, outline = false, color = C3(255, 255, 255)},
			tool = {enabled = false, outline = false, color = C3(255, 255, 255)},
			viewangle = {enabled = false, color = C3(255, 255, 255)},
		}
	}
	
	local esp2 = {
		playerObjects = {},
		enabled = false,
		fontsize = 13,
		font = 1,
		settings = {
			name = {enabled = false, outline = false, displaynames = false, color = C3(255, 255, 255)},
			box = {enabled = false, outline = false, color = C3(255, 255, 255)},
			boxfill = {enabled = false, color = C3(255, 0, 0), transparency = 0.5},
			distance = {enabled = false, outline = false, color = C3(255, 255, 255)},
			viewangle = {enabled = false, color = C3(255, 255, 255)},
		}
	}
	
	local finderSettings = {
		playerObjects = {},
		foundDealers = {},
		enabled = false,
		fontsize = 13,
		font = 1,
		settings = {
			name = {enabled = false, outline = true, displaynames = false, color = C3(85, 102, 255)},
			box = {enabled = false, outline = true, color = C3(85, 102, 255)},
			boxfill = {enabled = false, color = C3(85, 102, 255), transparency = 0.5},
			distance = {enabled = false, outline = true, color = C3(85, 102, 255)},
			viewangle = {enabled = false, color = C3(85, 102, 255)},
			
			item = "",
		}
	}

	local function FindItem(Dealer)
		for _, Items in pairs(Dealer.CurrentStocks:GetChildren()) do
			if Items.Name == finderSettings.settings.item and Items.Value > 0 then
				
				finderSettings.foundDealers[Dealer] = Dealer
				
				if Dealer:FindFirstChild("DealerMan") then
					finderSettings.playerObjects[Dealer.DealerMan] = {
						name = esp.NewDrawing("Text", {Color = C3(85, 102, 255), Outline = true, Center = true, Size = 13, Font = 2}),
						boxOutline = esp.NewDrawing("Square", {Color = C3(0, 0, 0), Thickness = 3, ZIndex = 2}),
						box = esp.NewDrawing("Square", {Color = C3(85, 102, 255), Thickness = 1, ZIndex = 3}),
						boxfill = esp.NewDrawing("Square", {Color = C3(85, 102, 255), Thickness = 1, ZIndex = 1}),
						distance = esp.NewDrawing("Text", {Color = C3(85, 102, 255), Outline = true, Center = true, Size = 13, Font = 2}),
						viewAngle = esp.NewDrawing("Line", {Color = C3(85, 102, 255), Thickness = 1}),
					}
				elseif Dealer:FindFirstChild("ArmoryMan") then
					finderSettings.playerObjects[Dealer.ArmoryMan] = {
						name = esp.NewDrawing("Text", {Color = C3(85, 102, 255), Outline = true, Center = true, Size = 13, Font = 2}),
						boxOutline = esp.NewDrawing("Square", {Color = C3(0, 0, 0), Thickness = 3, ZIndex = 2}),
						box = esp.NewDrawing("Square", {Color = C3(85, 102, 255), Thickness = 1, ZIndex = 3}),
						boxfill = esp.NewDrawing("Square", {Color = C3(85, 102, 255), Thickness = 1, ZIndex = 1}),
						distance = esp.NewDrawing("Text", {Color = C3(85, 102, 255), Outline = true, Center = true, Size = 13, Font = 2}),
						viewAngle = esp.NewDrawing("Line", {Color = C3(85, 102, 255), Thickness = 1}),
					}
				end
				
				local Connection
				
				Connection = Items.Changed:Connect(function()
					if Items.Value <= 0 then
						Connection:Disconnect()
						
						if finderSettings.foundDealers[Dealer] then
							finderSettings.foundDealers[Dealer] = nil
						end

						if Dealer:FindFirstChild("DealerMan") then
							if finderSettings.playerObjects[Dealer.DealerMan] then
								for _, v in pairs(finderSettings.playerObjects[Dealer.DealerMan]) do
									v.Visible = false
								end
								finderSettings.playerObjects[Dealer.DealerMan] = nil
							end
						elseif Dealer:FindFirstChild("ArmoryMan") then
							if finderSettings.playerObjects[Dealer.ArmoryMan] then
								for _, v in pairs(finderSettings.playerObjects[Dealer.ArmoryMan]) do
									v.Visible = false
								end
								finderSettings.playerObjects[Dealer.ArmoryMan] = nil
							end
						end
					end
				end)
			elseif Items.Name == finderSettings.settings.item and Items.Value <= 0 then
				if finderSettings.foundDealers[Dealer] then
					finderSettings.foundDealers[Dealer] = nil
				end
				
				if Dealer:FindFirstChild("DealerMan") then
					if finderSettings.playerObjects[Dealer.DealerMan] then
						for _, v in pairs(finderSettings.playerObjects[Dealer.DealerMan]) do
							v.Visible = false
						end
						finderSettings.playerObjects[Dealer.DealerMan] = nil
					end
				elseif Dealer:FindFirstChild("ArmoryMan") then
					if finderSettings.playerObjects[Dealer.ArmoryMan] then
						for _, v in pairs(finderSettings.playerObjects[Dealer.ArmoryMan]) do
							v.Visible = false
						end
						finderSettings.playerObjects[Dealer.ArmoryMan] = nil
					end
				end
			end
		end
	end

	local function IsAlive(plr)
		if plr and plr.Character and plr.Character.FindFirstChild(plr.Character, "Humanoid") and plr.Character.Humanoid.Health > 0 then
			return true
		end

		return false
	end

	esp.NewDrawing = function(type, properties)
		local newD = Drawing.new(type)
		for i,v in next, properties or {} do
			local s,e = pcall(function()
				newD[i] = v
			end)

			if not s then
				warn(e)
			end
		end
		return newD
	end

	esp.HasCharacter = function(v)
		local pass = false
		-- if u dont want an self esp then do this: if v ~= game.Players.LocalPlayer and v.Character, else if v ~= v.Character
		if v ~= localPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Head") then
			pass = true
		end

		if s then return pass; end; return pass;
	end
	
	esp2.HasCharacter = function(v)
		local pass = true

		if s then return pass; end; return pass;
	end

	esp.TeamCheck = function(v)
		local pass = true
		if localPlayer.TeamColor == v.TeamColor then
			pass = false
		end

		if s then return pass; end; return pass;
	end --[true = Same Team | false = Same Team]

	esp.NewPlayer = function(v)
		esp.playerObjects[v] = {
			name = esp.NewDrawing("Text", {Color = C3(255, 255, 255), Outline = true, Center = true, Size = 13, Font = 2}),
			boxOutline = esp.NewDrawing("Square", {Color = C3(0, 0, 0), Thickness = 3, ZIndex = 2}),
			box = esp.NewDrawing("Square", {Color = C3(255, 255, 255), Thickness = 1, ZIndex = 3}),
			boxfill = esp.NewDrawing("Square", {Color = C3(255, 255, 255), Thickness = 1, ZIndex = 1}),
			healthBarOutline = esp.NewDrawing("Line", {Color = C3(0, 0, 0), Thickness = 3}),
			healthBar = esp.NewDrawing("Line", {Color = C3(255, 255, 255), Thickness = 1}),
			healthText = esp.NewDrawing("Text", {Color = C3(255, 255, 255), Outline = true, Center = true, Size = 13, Font = 2}),
			distance = esp.NewDrawing("Text", {Color = C3(255, 255, 255), Outline = true, Center = true, Size = 13, Font = 2}),
			tool = esp.NewDrawing("Text", {Color = C3(255, 255, 255), Outline = true, Center = true, Size = 13, Font = 2}),
			viewAngle = esp.NewDrawing("Line", {Color = C3(255, 255, 255), Thickness = 1}),
		}
	end
	
	esp2.NewDealer = function(v)
		esp2.playerObjects[v] = {
			name = esp.NewDrawing("Text", {Color = C3(255, 255, 255), Outline = true, Center = true, Size = 13, Font = 2}),
			boxOutline = esp.NewDrawing("Square", {Color = C3(0, 0, 0), Thickness = 3, ZIndex = 2}),
			box = esp.NewDrawing("Square", {Color = C3(255, 255, 255), Thickness = 1, ZIndex = 3}),
			boxfill = esp.NewDrawing("Square", {Color = C3(255, 255, 255), Thickness = 1, ZIndex = 1}),
			distance = esp.NewDrawing("Text", {Color = C3(255, 255, 255), Outline = true, Center = true, Size = 13, Font = 2}),
			viewAngle = esp.NewDrawing("Line", {Color = C3(255, 255, 255), Thickness = 1}),
		}
	end

	for _,v in ipairs(players:GetPlayers()) do
		esp.NewPlayer(v)
	end
	
	for _,v in ipairs(workspace.Map.Shopz:GetChildren()) do
		if v:FindFirstChild("DealerMan") then
			esp2.NewDealer(v:FindFirstChild("DealerMan"))
		elseif v:FindFirstChild("ArmoryMan") then
			esp2.NewDealer(v:FindFirstChild("ArmoryMan"))
		end
	end

	local FinderConnections = {}

	--// Finder \\--
	
	FinderTab:AddInput('finderitem', {
		Default = '',
		Numeric = false,
		Finished = true,

		Text = 'Item',
		Tooltip = 'This is the item that will be looked for',

		Placeholder = '',
	})

	Options.finderitem:OnChanged(function()
		finderSettings.settings.item = Options.finderitem.Value
		
		for _, Dealer in pairs(workspace.Map.Shopz:GetChildren()) do
			if finderSettings.foundDealers[Dealer] then
				finderSettings.foundDealers[Dealer] = nil
			end

			if Dealer:FindFirstChild("DealerMan") then
				if finderSettings.playerObjects[Dealer.DealerMan] then
					for _, v in pairs(finderSettings.playerObjects[Dealer.DealerMan]) do
						v.Visible = false
					end
					finderSettings.playerObjects[Dealer.DealerMan] = nil
				end
			elseif Dealer:FindFirstChild("ArmoryMan") then
				if finderSettings.playerObjects[Dealer.ArmoryMan] then
					for _, v in pairs(finderSettings.playerObjects[Dealer.ArmoryMan]) do
						v.Visible = false
					end
					finderSettings.playerObjects[Dealer.ArmoryMan] = nil
				end
			end
		end
	end)
	
	FinderTab:AddToggle('finderperm', {Text = 'Finder Loop', Default = false, Tooltip = 'This will keep looking inside of dealers for the item instead of clicking on a button'})
	Toggles.finderperm:OnChanged(function()
		if Toggles.finderperm.Value then
			for _,v in pairs(workspace.Map.Shopz:GetChildren()) do
				FindItem(v)
				
				FinderConnections[v] = v.CurrentStocks.Changed:Connect(function()
					FindItem(v)
				end)
			end
		else
			for _,v in pairs(workspace.Map.Shopz:GetChildren()) do
				if FinderConnections[v] ~= nil then
					FinderConnections[v]:Disconnect()
				end
			end
			
		end
	end)
	
	local finderButton = FinderTab:AddButton('[ FIND ]', function()
		for _,v in pairs(workspace.Map.Shopz:GetChildren()) do
			FindItem(v)
		end	
	end)
	
	FinderTab:AddLabel('ESP', true)
	FinderTab:AddToggle('finderenabled', {Text = 'Enabled', Default = false})
	Toggles.finderenabled:OnChanged(function()
		finderSettings.enabled = Toggles.finderenabled.Value
	end)

	FinderTab:AddToggle('finderbox', {Text = 'Box', Default = false})
	Toggles.finderbox:OnChanged(function()
		finderSettings.settings.box.enabled = Toggles.finderbox.Value
	end)

	FinderTab:AddToggle('findernames', {Text = 'Names', Default = false})
	Toggles.findernames:OnChanged(function()
		finderSettings.settings.name.enabled = Toggles.findernames.Value
	end)

	FinderTab:AddToggle('finderboxfill', {Text = 'Box Fill', Default = false})
	Toggles.finderboxfill:OnChanged(function()
		finderSettings.settings.boxfill.enabled = Toggles.finderboxfill.Value
	end)

	FinderTab:AddToggle('finderdistance', {Text = 'Distance', Default = false})
	Toggles.finderdistance:OnChanged(function()
		finderSettings.settings.distance.enabled = Toggles.finderdistance.Value
	end)
	
	FinderTab:AddToggle('finderoutline', {Text = 'Outline', Default = false})
	Toggles.finderoutline:OnChanged(function()
		for i,v in pairs(finderSettings.settings) do
			if typeof(v) == "string" then
				return
			end
			v.outline = Toggles.finderoutline.Value
		end
	end)

	FinderTab:AddSlider('findertsize', {Text = 'Text Size', Default = 13, Min = 1, Max = 50, Rounding = 0, Compact = false})
	Options.findertsize:OnChanged(function()
		finderSettings.fontsize = Options.findertsize.Value
	end)

	FinderTab:AddDropdown('finderfont', {Values = {'UI', 'System', 'Plex', 'Monospace'}, Default = 2, Multi = false, Text = 'Font'})
	Options.finderfont:OnChanged(function()
		if Options.finderfont.Value == 'UI' then
			finderSettings.font = 0
		elseif Options.finderfont.Value == 'System' then
			finderSettings.font = 1
		elseif Options.finderfont.Value == 'Plex' then
			finderSettings.font = 2
		elseif Options.finderfont.Value == 'Monospace' then
			finderSettings.font = 3
		end
	end)

	--// Dealer \\--

	DealerTab:AddLabel('Dealer', true)
	DealerTab:AddToggle('dealerenabled', {Text = 'Enabled', Default = false})
	Toggles.dealerenabled:OnChanged(function()
		esp2.enabled = Toggles.dealerenabled.Value
	end)

	DealerTab:AddToggle('dealerbox', {Text = 'Box', Default = false})
	Toggles.dealerbox:OnChanged(function()
		esp2.settings.box.enabled = Toggles.dealerbox.Value
	end)
	Toggles.dealerbox:AddColorPicker('dealerboxcolor', {Default = C3(255,255,255), Title = 'Box Color'})
	Options.dealerboxcolor:OnChanged(function()
		esp2.settings.box.color = Options.dealerboxcolor.Value
	end)

	DealerTab:AddToggle('dealernames', {Text = 'Names', Default = false})
	Toggles.dealernames:OnChanged(function()
		esp2.settings.name.enabled = Toggles.dealernames.Value
	end)
	Toggles.dealernames:AddColorPicker('dealernamescolor', {Default = C3(255,0,0), Title = 'Names Color'})
	Options.dealernamescolor:OnChanged(function()
		esp2.settings.name.color = Options.dealernamescolor.Value
	end)

	DealerTab:AddToggle('dealerboxfill', {Text = 'Box Fill', Default = false})
	Toggles.dealerboxfill:OnChanged(function()
		esp2.settings.boxfill.enabled = Toggles.dealerboxfill.Value
	end)
	Toggles.dealerboxfill:AddColorPicker('dealerboxfillcolor', {Default = C3(255,0,0), Title = 'Box Fill Color'})
	Options.dealerboxfillcolor:OnChanged(function()
		esp2.settings.boxfill.color = Options.dealerboxfillcolor.Value
	end)

	DealerTab:AddToggle('dealerdistance', {Text = 'Distance', Default = false})
	Toggles.dealerdistance:OnChanged(function()
		esp2.settings.distance.enabled = Toggles.dealerdistance.Value
	end)
	Toggles.dealerdistance:AddColorPicker('dealerdistancecolor', {Default = C3(255,255,255), Title = 'Distance Color'})
	Options.dealerdistancecolor:OnChanged(function()
		esp2.settings.distance.color = Options.dealerdistancecolor.Value
	end)

	DealerSTab:AddToggle('dealeroutline', {Text = 'Outline', Default = false})
	Toggles.dealeroutline:OnChanged(function()
		for i,v in pairs(esp2.settings) do
			v.outline = Toggles.dealeroutline.Value
		end
	end)

	DealerSTab:AddSlider('dealertsize', {Text = 'Text Size', Default = 13, Min = 1, Max = 50, Rounding = 0, Compact = false})
	Options.dealertsize:OnChanged(function()
		esp2.fontsize = Options.dealertsize.Value
	end)

	DealerSTab:AddDropdown('dealerfont', {Values = {'UI', 'System', 'Plex', 'Monospace'}, Default = 2, Multi = false, Text = 'Font'})
	Options.dealerfont:OnChanged(function()
		if Options.dealerfont.Value == 'UI' then
			esp2.font = 0
		elseif Options.dealerfont.Value == 'System' then
			esp2.font = 1
		elseif Options.dealerfont.Value == 'Plex' then
			esp2.font = 2
		elseif Options.dealerfont.Value == 'Monospace' then
			esp2.font = 3
		end
	end)

	--// Player \\--

	players.PlayerAdded:Connect(esp.NewPlayer)
	ESPTab:AddLabel('Player', true)
	ESPTab:AddToggle('espenabled', {Text = 'Enabled', Default = false})
	Toggles.espenabled:OnChanged(function()
		esp.enabled = Toggles.espenabled.Value
	end)

	ESPTab:AddToggle('espbox', {Text = 'Box', Default = false})
	Toggles.espbox:OnChanged(function()
		esp.settings.box.enabled = Toggles.espbox.Value
	end)
	Toggles.espbox:AddColorPicker('espboxcolor', {Default = C3(255,255,255), Title = 'Box Color'})
	Options.espboxcolor:OnChanged(function()
		esp.settings.box.color = Options.espboxcolor.Value
	end)

	ESPTab:AddToggle('espnames', {Text = 'Names', Default = false})
	Toggles.espnames:OnChanged(function()
		esp.settings.name.enabled = Toggles.espnames.Value
	end)
	Toggles.espnames:AddColorPicker('espnamescolor', {Default = C3(255,0,0), Title = 'Names Color'})
	Options.espnamescolor:OnChanged(function()
		esp.settings.name.color = Options.espnamescolor.Value
	end)

	ESPTab:AddToggle('espboxfill', {Text = 'Box Fill', Default = false})
	Toggles.espboxfill:OnChanged(function()
		esp.settings.boxfill.enabled = Toggles.espboxfill.Value
	end)
	Toggles.espboxfill:AddColorPicker('espboxfillcolor', {Default = C3(255,0,0), Title = 'Box Fill Color'})
	Options.espboxfillcolor:OnChanged(function()
		esp.settings.boxfill.color = Options.espboxfillcolor.Value
	end)

	ESPTab:AddToggle('esphb', {Text = 'Health bar', Default = false})
	Toggles.esphb:OnChanged(function()
		esp.settings.healthbar.enabled = Toggles.esphb.Value
	end)

	ESPTab:AddToggle('espht', {Text = 'Health text', Default = false})
	Toggles.espht:OnChanged(function()
		esp.settings.healthtext.enabled = Toggles.espht.Value
	end)
	Toggles.espht:AddColorPicker('esphtcolor', {Default = C3(0,255,0), Title = 'Health Text Color'})
	Options.esphtcolor:OnChanged(function()
		esp.settings.healthtext.color = Options.esphtcolor.Value
	end)

	ESPTab:AddToggle('espdistance', {Text = 'Distance', Default = false})
	Toggles.espdistance:OnChanged(function()
		esp.settings.distance.enabled = Toggles.espdistance.Value
	end)
	Toggles.espdistance:AddColorPicker('espdistancecolor', {Default = C3(255,255,255), Title = 'Distance Color'})
	Options.espdistancecolor:OnChanged(function()
		esp.settings.distance.color = Options.espdistancecolor.Value
	end)

	ESPTab:AddToggle('esptool', {Text = 'Tool', Default = false})
	Toggles.esptool:OnChanged(function()
		esp.settings.tool.enabled = Toggles.esptool.Value
	end)
	Toggles.esptool:AddColorPicker('esptoolcolor', {Default = C3(255,255,255), Title = 'Tool Color'})
	Options.esptoolcolor:OnChanged(function()
		esp.settings.tool.color = Options.esptoolcolor.Value
	end)

	ESPSTab:AddToggle('espoutline', {Text = 'Outline', Default = false})
	Toggles.espoutline:OnChanged(function()
		for i,v in pairs(esp.settings) do
			v.outline = Toggles.espoutline.Value
		end
	end)

	ESPSTab:AddToggle('espdisplay', {Text = 'Use Display Names', Default = false})
	Toggles.espdisplay:OnChanged(function()
		esp.settings.name.displaynames = Toggles.espdisplay.Value
	end)

	ESPSTab:AddSlider('esptsize', {Text = 'Text Size', Default = 13, Min = 1, Max = 50, Rounding = 0, Compact = false})
	Options.esptsize:OnChanged(function()
		esp.fontsize = Options.esptsize.Value
	end)

	ESPSTab:AddDropdown('espfont', {Values = {'UI', 'System', 'Plex', 'Monospace'}, Default = 2, Multi = false, Text = 'Font'})
	Options.espfont:OnChanged(function()
		if Options.espfont.Value == 'UI' then
			esp.font = 0
		elseif Options.espfont.Value == 'System' then
			esp.font = 1
		elseif Options.espfont.Value == 'Plex' then
			esp.font = 2
		elseif Options.espfont.Value == 'Monospace' then
			esp.font = 3
		end
	end)

	
	-- // Camera Tab
	local function ESP()
		for i,v in pairs(esp.playerObjects) do
			if not esp.HasCharacter(i) then
				v.name.Visible = false
				v.boxOutline.Visible = false
				v.box.Visible = false
				v.boxfill.Visible = false
			end

			if esp.HasCharacter(i) then
				local hum = i.Character.Humanoid
				local hrp = i.Character.HumanoidRootPart
				local head = i.Character.Head

				local Vector, onScreen = currentCamera:WorldToViewportPoint(i.Character.HumanoidRootPart.Position)

				local Size = (currentCamera:WorldToViewportPoint(hrp.Position - Vec3(0, 3, 0)).Y - currentCamera:WorldToViewportPoint(hrp.Position + Vec3(0, 2.6, 0)).Y) / 2
				local BoxSize = Vec2(math.floor(Size * 1.5), math.floor(Size * 1.9))
				local BoxPos = Vec2(math.floor(Vector.X - Size * 1.5 / 2), math.floor(Vector.Y - Size * 1.6 / 2))

				local BoxFillSize = Vec2(math.floor(Size * 1.5), math.floor(Size * 1.9)) --same as box
				local BoxFillPos = Vec2(math.floor(Vector.X - Size * 1.5 / 2), math.floor(Vector.Y - Size * 1.6 / 2)) -- this 1 too

				local BottomOffset = BoxSize.Y + BoxPos.Y + 1

				if onScreen and esp.enabled then
					if esp.settings.name.enabled then
						v.name.Position = Vec2(BoxSize.X / 2 + BoxPos.X, BoxPos.Y - 16)
						v.name.Outline = esp.settings.name.outline
						v.name.Color = esp.settings.name.color

						v.name.Font = esp.font
						v.name.Size = esp.fontsize

						if esp.settings.name.displaynames then
							v.name.Text = tostring(i.DisplayName)
						else
							v.name.Text = tostring(i.Name)
						end

						v.name.Visible = true
					else
						v.name.Visible = false
					end

					if esp.settings.distance.enabled and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
						v.distance.Position = Vec2(BoxSize.X / 2 + BoxPos.X, BottomOffset)
						v.distance.Outline = esp.settings.distance.outline
						v.distance.Text = "[" .. math.floor((hrp.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude) .. "]"
						v.distance.Color = esp.settings.distance.color
						BottomOffset = BottomOffset + 15

						v.distance.Font = esp.font
						v.distance.Size = esp.fontsize

						v.distance.Visible = true
					else
						v.distance.Visible = false
					end

					if esp.settings.box.enabled then
						v.boxOutline.Size = BoxSize
						v.boxOutline.Position = BoxPos
						v.boxOutline.Visible = esp.settings.box.outline

						v.box.Size = BoxSize
						v.box.Position = BoxPos
						v.box.Color = esp.settings.box.color
						v.box.Visible = true
					else
						v.boxOutline.Visible = false
						v.box.Visible = false
					end

					if esp.settings.boxfill.enabled then
						v.boxfill.Position = BoxFillPos
						v.boxfill.Size = BoxFillSize
						v.boxfill.Visible = esp.settings.boxfill.enabled
						v.boxfill.Filled = true
						v.boxfill.Color = esp.settings.boxfill.color
						v.boxfill.Transparency = esp.settings.boxfill.transparency
					else
						v.boxfill.Visible = false
						v.boxfill.Filled = false
					end

					if esp.settings.healthbar.enabled then
						v.healthBar.From = Vec2((BoxPos.X - 5), BoxPos.Y + BoxSize.Y)
						v.healthBar.To = Vec2(v.healthBar.From.X, v.healthBar.From.Y - (hum.Health / hum.MaxHealth) * BoxSize.Y)
						v.healthBar.Color = C3(255 - 255 / (hum["MaxHealth"] / hum["Health"]), 255 / (hum["MaxHealth"] / hum["Health"]), 0)
						v.healthBar.Visible = true

						v.healthBarOutline.From = Vec2(v.healthBar.From.X, BoxPos.Y + BoxSize.Y + 1)
						v.healthBarOutline.To = Vec2(v.healthBar.From.X, (v.healthBar.From.Y - 1 * BoxSize.Y) -1)
						v.healthBarOutline.Visible = esp.settings.healthbar.outline
					else
						v.healthBarOutline.Visible = false
						v.healthBar.Visible = false
					end

					if esp.settings.healthtext.enabled then
						v.healthText.Text = tostring(math.floor((hum.Health / hum.MaxHealth) * 100 + 0.5))
						v.healthText.Position = Vec2((BoxPos.X - 20), (BoxPos.Y + BoxSize.Y - 1 * BoxSize.Y) -1)
						v.healthText.Color = esp.settings.healthtext.color
						v.healthText.Outline = esp.settings.healthtext.outline

						v.healthText.Font = esp.font
						v.healthText.Size = esp.fontsize

						v.healthText.Visible = true
					else
						v.healthText.Visible = false
					end

					if esp.settings.tool.enabled then

						v.tool.Position = Vec2(BoxSize.X / 3 + BoxPos.X, BottomOffset)
						v.tool.Color = esp.settings.tool.color
						v.tool.Outline = esp.settings.tool.outline

						v.tool.Font = esp.font
						v.tool.Size = esp.fontsize

						v.tool.Visible = true  

						if i.Character then
							if game.GameId == 3326279937 then
								if i.Character:FindFirstChildWhichIsA("RayValue") then
									v.tool.Text = "["..string.upper(i.Character:FindFirstChildWhichIsA("RayValue").Name).."]"
								else
									v.tool.Text = "[NONE]"
								end
							else
								if i.Character:FindFirstChildWhichIsA("Tool") then
									v.tool.Text = "["..string.upper(i.Character:FindFirstChildWhichIsA("Tool").Name).."]"
								else
									v.tool.Text = "[NONE]"
								end
							end

						else
							v.tool.Text = "[NONE]"
						end
					else
						v.tool.Visible = false
					end

					if esp.settings.viewangle.enabled then
						local fromHead = currentCamera:worldToViewportPoint(head.CFrame.p)
						local toPoint = currentCamera:worldToViewportPoint((head.CFrame + (head.CFrame.lookVector * 10)).p)
						v.viewAngle.From = Vec2(fromHead.X, fromHead.Y)
						v.viewAngle.To = Vec2(toPoint.X, toPoint.Y)
						v.viewAngle.Color = esp.settings.viewangle.color
						v.viewAngle.Visible = true
					end

					if esp.teamcheck then
						if esp.TeamCheck(i) then
							v.name.Visible = esp.settings.name.enabled
							v.box.Visible = esp.settings.box.enabled
							v.boxfill.Visible = esp.settings.boxfill.enabled
							v.healthBar.Visible = esp.settings.healthbar.enabled
							v.healthText.Visible = esp.settings.healthtext.enabled
							v.distance.Visible = esp.settings.distance.enabled
							v.viewAngle.Visible = esp.settings.viewangle.enabled
							v.tool.Visible = esp.settings.tool.enabled
							if ESPOutline then
								if esp.settings.box.enabled then
									v.boxOutline.Visible = esp.settings.box.outline
									v.boxOutline.Visible = esp.settings.box.outline
								end

								if esp.settings.healthbar.enabled then
									v.healthBarOutline.Visible = esp.settings.healthbar.outline
								end
							end
						else
							v.name.Visible = false
							v.boxOutline.Visible = false
							v.box.Visible = false
							v.boxfill.Visible = false
							v.healthBarOutline.Visible = false
							v.healthBar.Visible = false
							v.healthText.Visible = false
							v.distance.Visible = false
							v.viewAngle.Visible = false
							v.tool.Visible = false
						end
					end
				else
					v.name.Visible = false
					v.boxOutline.Visible = false
					v.box.Visible = false
					v.boxfill.Visible = false
					v.healthBarOutline.Visible = false
					v.healthBar.Visible = false
					v.healthText.Visible = false
					v.distance.Visible = false
					v.viewAngle.Visible = false
					v.tool.Visible = false
				end
			else
				v.name.Visible = false
				v.boxOutline.Visible = false
				v.box.Visible = false
				v.boxfill.Visible = false
				v.healthBarOutline.Visible = false
				v.healthBar.Visible = false
				v.healthText.Visible = false
				v.distance.Visible = false
				v.viewAngle.Visible = false
				v.tool.Visible = false
			end
		end
	end
	
	local function DealerESP()
		for i,v in pairs(esp2.playerObjects) do
			if not esp2.HasCharacter(i) then
				v.name.Visible = false
				v.boxOutline.Visible = false
				v.box.Visible = false
				v.boxfill.Visible = false
			end

			if esp2.HasCharacter(i) then
				local hum = i.NPC
				local hrp = i.HumanoidRootPart
				local head = i.Head

				local Vector, onScreen = currentCamera:WorldToViewportPoint(i.HumanoidRootPart.Position)

				local Size = (currentCamera:WorldToViewportPoint(hrp.Position - Vec3(0, 3, 0)).Y - currentCamera:WorldToViewportPoint(hrp.Position + Vec3(0, 2.6, 0)).Y) / 2
				local BoxSize = Vec2(math.floor(Size * 1.5), math.floor(Size * 1.9))
				local BoxPos = Vec2(math.floor(Vector.X - Size * 1.5 / 2), math.floor(Vector.Y - Size * 1.6 / 2))

				local BoxFillSize = Vec2(math.floor(Size * 1.5), math.floor(Size * 1.9)) --same as box
				local BoxFillPos = Vec2(math.floor(Vector.X - Size * 1.5 / 2), math.floor(Vector.Y - Size * 1.6 / 2)) -- this 1 too

				local BottomOffset = BoxSize.Y + BoxPos.Y + 1

				if onScreen and esp2.enabled then
					if esp2.settings.name.enabled then
						v.name.Position = Vec2(BoxSize.X / 2 + BoxPos.X, BoxPos.Y - 16)
						v.name.Outline = esp2.settings.name.outline
						v.name.Color = esp2.settings.name.color

						v.name.Font = esp2.font
						v.name.Size = esp2.fontsize
						
						v.name.Text = i.Name

						v.name.Visible = true
					else
						v.name.Visible = false
					end

					if esp2.settings.distance.enabled and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
						v.distance.Position = Vec2(BoxSize.X / 2 + BoxPos.X, BottomOffset)
						v.distance.Outline = esp2.settings.distance.outline
						v.distance.Text = "[" .. math.floor((hrp.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude) .. "]"
						v.distance.Color = esp2.settings.distance.color
						BottomOffset = BottomOffset + 15

						v.distance.Font = esp2.font
						v.distance.Size = esp2.fontsize

						v.distance.Visible = true
					else
						v.distance.Visible = false
					end

					if esp2.settings.box.enabled then
						v.boxOutline.Size = BoxSize
						v.boxOutline.Position = BoxPos
						v.boxOutline.Visible = esp2.settings.box.outline

						v.box.Size = BoxSize
						v.box.Position = BoxPos
						v.box.Color = esp2.settings.box.color
						v.box.Visible = true
					else
						v.boxOutline.Visible = false
						v.box.Visible = false
					end

					if esp2.settings.boxfill.enabled then
						v.boxfill.Position = BoxFillPos
						v.boxfill.Size = BoxFillSize
						v.boxfill.Visible = esp2.settings.boxfill.enabled
						v.boxfill.Filled = true
						v.boxfill.Color = esp2.settings.boxfill.color
						v.boxfill.Transparency = esp2.settings.boxfill.transparency
					else
						v.boxfill.Visible = false
						v.boxfill.Filled = false
					end

					if esp2.settings.viewangle.enabled then
						local fromHead = currentCamera:worldToViewportPoint(head.CFrame.p)
						local toPoint = currentCamera:worldToViewportPoint((head.CFrame + (head.CFrame.lookVector * 10)).p)
						v.viewAngle.From = Vec2(fromHead.X, fromHead.Y)
						v.viewAngle.To = Vec2(toPoint.X, toPoint.Y)
						v.viewAngle.Color = esp2.settings.viewangle.color
						v.viewAngle.Visible = true
					end

					if true then
						if true then
							v.name.Visible = esp2.settings.name.enabled
							v.box.Visible = esp2.settings.box.enabled
							v.boxfill.Visible = esp2.settings.boxfill.enabled
							v.distance.Visible = esp2.settings.distance.enabled
							v.viewAngle.Visible = esp2.settings.viewangle.enabled
							if ESPOutline then
								if esp2.settings.box.enabled then
									v.boxOutline.Visible = esp2.settings.box.outline
									v.boxOutline.Visible = esp2.settings.box.outline
								end
							end
						else
							v.name.Visible = false
							v.boxOutline.Visible = false
							v.box.Visible = false
							v.boxfill.Visible = false
							v.distance.Visible = false
							v.viewAngle.Visible = false
						end
					end
				else
					v.name.Visible = false
					v.boxOutline.Visible = false
					v.box.Visible = false
					v.boxfill.Visible = false
					v.distance.Visible = false
					v.viewAngle.Visible = false
				end
			else
				v.name.Visible = false
				v.boxOutline.Visible = false
				v.box.Visible = false
				v.boxfill.Visible = false
				v.distance.Visible = false
				v.viewAngle.Visible = false
			end
		end
	end
	
	local function FinderESP()
		for i,v in pairs(finderSettings.playerObjects) do
			if not esp2.HasCharacter(i) then
				v.name.Visible = false
				v.boxOutline.Visible = false
				v.box.Visible = false
				v.boxfill.Visible = false
			end

			if esp2.HasCharacter(i) then
				local hum = i.NPC
				local hrp = i.HumanoidRootPart
				local head = i.Head

				local Vector, onScreen = currentCamera:WorldToViewportPoint(i.HumanoidRootPart.Position)

				local Size = (currentCamera:WorldToViewportPoint(hrp.Position - Vec3(0, 3, 0)).Y - currentCamera:WorldToViewportPoint(hrp.Position + Vec3(0, 2.6, 0)).Y) / 2
				local BoxSize = Vec2(math.floor(Size * 1.5), math.floor(Size * 1.9))
				local BoxPos = Vec2(math.floor(Vector.X - Size * 1.5 / 2), math.floor(Vector.Y - Size * 1.6 / 2))

				local BoxFillSize = Vec2(math.floor(Size * 1.5), math.floor(Size * 1.9)) --same as box
				local BoxFillPos = Vec2(math.floor(Vector.X - Size * 1.5 / 2), math.floor(Vector.Y - Size * 1.6 / 2)) -- this 1 too

				local BottomOffset = BoxSize.Y + BoxPos.Y + 1

				if onScreen and finderSettings.enabled and finderSettings.foundDealers[i.Parent] then
					if finderSettings.settings.name.enabled then
						v.name.Position = Vec2(BoxSize.X / 2 + BoxPos.X, BoxPos.Y - 16)
						v.name.Outline = finderSettings.settings.name.outline
						v.name.Color = finderSettings.settings.name.color

						v.name.Font = finderSettings.font
						v.name.Size = finderSettings.fontsize

						v.name.Text = finderSettings.settings.item

						v.name.Visible = true
					else
						v.name.Visible = false
					end

					if finderSettings.settings.distance.enabled and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
						v.distance.Position = Vec2(BoxSize.X / 2 + BoxPos.X, BottomOffset)
						v.distance.Outline = finderSettings.settings.distance.outline
						v.distance.Text = "[" .. math.floor((hrp.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude) .. "]"
						v.distance.Color = finderSettings.settings.distance.color
						BottomOffset = BottomOffset + 15

						v.distance.Font = finderSettings.font
						v.distance.Size = finderSettings.fontsize

						v.distance.Visible = true
					else
						v.distance.Visible = false
					end

					if finderSettings.settings.box.enabled then
						v.boxOutline.Size = BoxSize
						v.boxOutline.Position = BoxPos
						v.boxOutline.Visible = finderSettings.settings.box.outline

						v.box.Size = BoxSize
						v.box.Position = BoxPos
						v.box.Color = finderSettings.settings.box.color
						v.box.Visible = true
					else
						v.boxOutline.Visible = false
						v.box.Visible = false
					end

					if finderSettings.settings.boxfill.enabled then
						v.boxfill.Position = BoxFillPos
						v.boxfill.Size = BoxFillSize
						v.boxfill.Visible = finderSettings.settings.boxfill.enabled
						v.boxfill.Filled = true
						v.boxfill.Color = finderSettings.settings.boxfill.color
						v.boxfill.Transparency = finderSettings.settings.boxfill.transparency
					else
						v.boxfill.Visible = false
						v.boxfill.Filled = false
					end

					if finderSettings.settings.viewangle.enabled then
						local fromHead = currentCamera:worldToViewportPoint(head.CFrame.p)
						local toPoint = currentCamera:worldToViewportPoint((head.CFrame + (head.CFrame.lookVector * 10)).p)
						v.viewAngle.From = Vec2(fromHead.X, fromHead.Y)
						v.viewAngle.To = Vec2(toPoint.X, toPoint.Y)
						v.viewAngle.Color = finderSettings.settings.viewangle.color
						v.viewAngle.Visible = true
					end

					if true then
						if true then
							v.name.Visible = finderSettings.settings.name.enabled
							v.box.Visible = finderSettings.settings.box.enabled
							v.boxfill.Visible = finderSettings.settings.boxfill.enabled
							v.distance.Visible = finderSettings.settings.distance.enabled
							v.viewAngle.Visible = finderSettings.settings.viewangle.enabled
							if ESPOutline then
								if finderSettings.settings.box.enabled then
									v.boxOutline.Visible = finderSettings.settings.box.outline
									v.boxOutline.Visible = finderSettings.settings.box.outline
								end
							end
						else
							v.name.Visible = false
							v.boxOutline.Visible = false
							v.box.Visible = false
							v.boxfill.Visible = false
							v.distance.Visible = false
							v.viewAngle.Visible = false
						end
					end
				else
					v.name.Visible = false
					v.boxOutline.Visible = false
					v.box.Visible = false
					v.boxfill.Visible = false
					v.distance.Visible = false
					v.viewAngle.Visible = false
				end
			else
				v.name.Visible = false
				v.boxOutline.Visible = false
				v.box.Visible = false
				v.boxfill.Visible = false
				v.distance.Visible = false
				v.viewAngle.Visible = false
			end
		end
	end

	runService.RenderStepped:Connect(function()
		do ESP() end
		do DealerESP() end
		do FinderESP() end
	end)

	MenuGroup:AddButton('Unload', function() Library:Unload() end)
	MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

	Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

	ThemeManager:SetLibrary(Library)
	SaveManager:SetLibrary(Library)

	SaveManager:IgnoreThemeSettings() 

	SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 

	ThemeManager:SetFolder('$N2')
	SaveManager:SetFolder('$N2/main')

	SaveManager:BuildConfigSection(Tabs['UI Settings']) 

	ThemeManager:ApplyToTab(Tabs['UI Settings'])

	local OthersSettings = Tabs['UI Settings']:AddRightGroupbox('Others')

	OthersSettings:AddInput('uinamechange', {Default = '$N2 [CRIMINALITY]', Numeric = false, Finished = false, Text = 'Window Title', Tooltip = 'Changes window title', Placeholder = '. . .'})
	Options.uinamechange:OnChanged(function()
		Window:SetWindowTitle(Options.uinamechange.Value)
	end)

	OthersSettings:AddDivider()

	OthersSettings:AddButton('Rejoin', function() 
		local ts = game:GetService("TeleportService")
		local p = game:GetService("Players").LocalPlayer
		ts:Teleport(game.PlaceId, p)
	end)
else
	local repo = 'https://raw.githubusercontent.com/'
	------------------------------------ LINKS ------------------------------------
	local Library = loadstring(game:HttpGet(repo .. 'fatalespion/Releases/main/Lino.lua'))()
	local ThemeManager = loadstring(game:HttpGet(repo .. 'fatalespion/Releases/refs/heads/main/ThemeManager'))()
	local SaveManager = loadstring(game:HttpGet(repo .. 'violin-suzutsuki/LinoriaLib/main/addons/SaveManager.lua'))()

	local players = game:GetService("Players")
	local localPlayer = players.LocalPlayer
	local workspace = game:GetService("Workspace")
	local currentCamera = workspace.CurrentCamera
	local guiService = game:GetService("GuiService")
	local runService = game:GetService("RunService")
	local CNew, CF, C3, Vec2, Vec3 = ColorSequence.new, CFrame.new, Color3.fromRGB, Vector2.new, Vector3.new
	------------------------------------ WINDOW -----------------------------------
	local Window = Library:CreateWindow({
		Title = '$N2 ESP',
		Center = true,
		AutoShow = true,
		TabPadding = 8,
		MenuFadeTime = 0.2
	})

	local Tabs = {
		Visuals = Window:AddTab('Visuals'),
		['UI Settings'] = Window:AddTab('Settings'),
	}

	local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
	local ESPTabbox = Tabs.Visuals:AddLeftTabbox()
	local ESPTab  = ESPTabbox:AddTab('ESP')
	local ESPSTab = Tabs.Visuals:AddRightGroupbox('ESP Settings')
	local LocalTab = ESPTabbox:AddTab('Local')

	local esp = {
		playerObjects = {},
		enabled = false,
		teamcheck = false,
		fontsize = 13,
		font = 1,
		settings = {
			name = {enabled = false, outline = false, displaynames = false, color = C3(255, 255, 255)},
			box = {enabled = false, outline = false, color = C3(255, 255, 255)},
			boxfill = {enabled = false, color = C3(255, 0, 0), transparency = 0.5},
			healthbar = {enabled = false, outline = false},
			healthtext = {enabled = false, outline = false, color = C3(255, 255, 255)},
			distance = {enabled = false, outline = false, color = C3(255, 255, 255)},
			tool = {enabled = false, outline = false, color = C3(255, 255, 255)},
			viewangle = {enabled = false, color = C3(255, 255, 255)},
		}
	}

	local function IsAlive(plr)
		if plr and plr.Character and plr.Character.FindFirstChild(plr.Character, "Humanoid") and plr.Character.Humanoid.Health > 0 then
			return true
		end

		return false
	end

	esp.NewDrawing = function(type, properties)
		local newD = Drawing.new(type)
		for i,v in next, properties or {} do
			local s,e = pcall(function()
				newD[i] = v
			end)

			if not s then
				warn(e)
			end
		end
		return newD
	end

	esp.HasCharacter = function(v)
		local pass = false
		-- if u dont want an self esp then do this: if v ~= game.Players.LocalPlayer and v.Character, else if v ~= v.Character
		if v ~= localPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Head") then
			pass = true
		end

		if s then return pass; end; return pass;
	end

	esp.TeamCheck = function(v)
		local pass = true
		if localPlayer.TeamColor == v.TeamColor then
			pass = false
		end

		if s then return pass; end; return pass;
	end --[true = Same Team | false = Same Team]

	esp.NewPlayer = function(v)
		esp.playerObjects[v] = {
			name = esp.NewDrawing("Text", {Color = C3(255, 255, 255), Outline = true, Center = true, Size = 13, Font = 2}),
			boxOutline = esp.NewDrawing("Square", {Color = C3(0, 0, 0), Thickness = 3, ZIndex = 2}),
			box = esp.NewDrawing("Square", {Color = C3(255, 255, 255), Thickness = 1, ZIndex = 3}),
			boxfill = esp.NewDrawing("Square", {Color = C3(255, 255, 255), Thickness = 1, ZIndex = 1}),
			healthBarOutline = esp.NewDrawing("Line", {Color = C3(0, 0, 0), Thickness = 3}),
			healthBar = esp.NewDrawing("Line", {Color = C3(255, 255, 255), Thickness = 1}),
			healthText = esp.NewDrawing("Text", {Color = C3(255, 255, 255), Outline = true, Center = true, Size = 13, Font = 2}),
			distance = esp.NewDrawing("Text", {Color = C3(255, 255, 255), Outline = true, Center = true, Size = 13, Font = 2}),
			tool = esp.NewDrawing("Text", {Color = C3(255, 255, 255), Outline = true, Center = true, Size = 13, Font = 2}),
			viewAngle = esp.NewDrawing("Line", {Color = C3(255, 255, 255), Thickness = 1}),
		}
	end

	for _,v in ipairs(players:GetPlayers()) do
		esp.NewPlayer(v)
	end

	players.PlayerAdded:Connect(esp.NewPlayer)

	ESPTab:AddToggle('espenabled', {Text = 'Enabled', Default = false})
	Toggles.espenabled:OnChanged(function()
		esp.enabled = Toggles.espenabled.Value
	end)

	ESPTab:AddToggle('espbox', {Text = 'Box', Default = false})
	Toggles.espbox:OnChanged(function()
		esp.settings.box.enabled = Toggles.espbox.Value
	end)
	Toggles.espbox:AddColorPicker('espboxcolor', {Default = C3(255,255,255), Title = 'Box Color'})
	Options.espboxcolor:OnChanged(function()
		esp.settings.box.color = Options.espboxcolor.Value
	end)

	ESPTab:AddToggle('espnames', {Text = 'Names', Default = false})
	Toggles.espnames:OnChanged(function()
		esp.settings.name.enabled = Toggles.espnames.Value
	end)
	Toggles.espnames:AddColorPicker('espnamescolor', {Default = C3(255,0,0), Title = 'Names Color'})
	Options.espnamescolor:OnChanged(function()
		esp.settings.name.color = Options.espnamescolor.Value
	end)

	ESPTab:AddToggle('espboxfill', {Text = 'Box Fill', Default = false})
	Toggles.espboxfill:OnChanged(function()
		esp.settings.boxfill.enabled = Toggles.espboxfill.Value
	end)
	Toggles.espboxfill:AddColorPicker('espboxfillcolor', {Default = C3(255,0,0), Title = 'Box Fill Color'})
	Options.espboxfillcolor:OnChanged(function()
		esp.settings.boxfill.color = Options.espboxfillcolor.Value
	end)

	ESPTab:AddToggle('esphb', {Text = 'Health bar', Default = false})
	Toggles.esphb:OnChanged(function()
		esp.settings.healthbar.enabled = Toggles.esphb.Value
	end)

	ESPTab:AddToggle('espht', {Text = 'Health text', Default = false})
	Toggles.espht:OnChanged(function()
		esp.settings.healthtext.enabled = Toggles.espht.Value
	end)
	Toggles.espht:AddColorPicker('esphtcolor', {Default = C3(0,255,0), Title = 'Health Text Color'})
	Options.esphtcolor:OnChanged(function()
		esp.settings.healthtext.color = Options.esphtcolor.Value
	end)

	ESPTab:AddToggle('espdistance', {Text = 'Distance', Default = false})
	Toggles.espdistance:OnChanged(function()
		esp.settings.distance.enabled = Toggles.espdistance.Value
	end)
	Toggles.espdistance:AddColorPicker('espdistancecolor', {Default = C3(255,255,255), Title = 'Distance Color'})
	Options.espdistancecolor:OnChanged(function()
		esp.settings.distance.color = Options.espdistancecolor.Value
	end)

	ESPTab:AddToggle('esptool', {Text = 'Tool', Default = false})
	Toggles.esptool:OnChanged(function()
		esp.settings.tool.enabled = Toggles.esptool.Value
	end)
	Toggles.esptool:AddColorPicker('esptoolcolor', {Default = C3(255,255,255), Title = 'Tool Color'})
	Options.esptoolcolor:OnChanged(function()
		esp.settings.tool.color = Options.esptoolcolor.Value
	end)

	ESPSTab:AddToggle('espoutline', {Text = 'Outline', Default = false})
	Toggles.espoutline:OnChanged(function()
		for i,v in pairs(esp.settings) do
			v.outline = Toggles.espoutline.Value
		end
	end)

	ESPSTab:AddToggle('espdisplay', {Text = 'Use Display Names', Default = false})
	Toggles.espdisplay:OnChanged(function()
		esp.settings.name.displaynames = Toggles.espdisplay.Value
	end)

	ESPSTab:AddSlider('esptsize', {Text = 'Text Size', Default = 13, Min = 1, Max = 50, Rounding = 0, Compact = false})
	Options.esptsize:OnChanged(function()
		esp.fontsize = Options.esptsize.Value
	end)

	ESPSTab:AddDropdown('espfont', {Values = {'UI', 'System', 'Plex', 'Monospace'}, Default = 2, Multi = false, Text = 'Font'})
	Options.espfont:OnChanged(function()
		if Options.espfont.Value == 'UI' then
			esp.font = 0
		elseif Options.espfont.Value == 'System' then
			esp.font = 1
		elseif Options.espfont.Value == 'Plex' then
			esp.font = 2
		elseif Options.espfont.Value == 'Monospace' then
			esp.font = 3
		end
	end)

	local selfchmams = LocalTab:AddToggle('local_selfchams', {Text = 'Self Chams', Default = false,})
	Toggles.local_selfchams:OnChanged(function()
		while wait() do
			if not Toggles.local_selfchams.Value then
				break 
			end
			if IsAlive(localPlayer) then
				local chams = Instance.new("Highlight", localPlayer.Character)
				chams.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				chams.FillColor = Options.selfchams_fill.Value
				chams.FillTransparency = 0.25
				chams.OutlineColor = Options.selfchams_outline.Value
				chams.FillTransparency = 0.5
			end
		end
	end)
	selfchmams:AddColorPicker('selfchams_fill', {Default = C3(0, 0, 255), Title = 'Fill Color'})
	selfchmams:AddColorPicker('selfchams_outline', {Default = C3(0, 0, 0), Title = 'Outline Color'})
	-- // Camera Tab
	local function ESP()
		for i,v in pairs(esp.playerObjects) do
			if not esp.HasCharacter(i) then
				v.name.Visible = false
				v.boxOutline.Visible = false
				v.box.Visible = false
				v.boxfill.Visible = false
			end

			if esp.HasCharacter(i) then
				local hum = i.Character.Humanoid
				local hrp = i.Character.HumanoidRootPart
				local head = i.Character.Head

				local Vector, onScreen = currentCamera:WorldToViewportPoint(i.Character.HumanoidRootPart.Position)

				local Size = (currentCamera:WorldToViewportPoint(hrp.Position - Vec3(0, 3, 0)).Y - currentCamera:WorldToViewportPoint(hrp.Position + Vec3(0, 2.6, 0)).Y) / 2
				local BoxSize = Vec2(math.floor(Size * 1.5), math.floor(Size * 1.9))
				local BoxPos = Vec2(math.floor(Vector.X - Size * 1.5 / 2), math.floor(Vector.Y - Size * 1.6 / 2))

				local BoxFillSize = Vec2(math.floor(Size * 1.5), math.floor(Size * 1.9)) --same as box
				local BoxFillPos = Vec2(math.floor(Vector.X - Size * 1.5 / 2), math.floor(Vector.Y - Size * 1.6 / 2)) -- this 1 too

				local BottomOffset = BoxSize.Y + BoxPos.Y + 1

				if onScreen and esp.enabled then
					if esp.settings.name.enabled then
						v.name.Position = Vec2(BoxSize.X / 2 + BoxPos.X, BoxPos.Y - 16)
						v.name.Outline = esp.settings.name.outline
						v.name.Color = esp.settings.name.color

						v.name.Font = esp.font
						v.name.Size = esp.fontsize

						if esp.settings.name.displaynames then
							v.name.Text = tostring(i.DisplayName)
						else
							v.name.Text = tostring(i.Name)
						end

						v.name.Visible = true
					else
						v.name.Visible = false
					end

					if esp.settings.distance.enabled and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
						v.distance.Position = Vec2(BoxSize.X / 2 + BoxPos.X, BottomOffset)
						v.distance.Outline = esp.settings.distance.outline
						v.distance.Text = "[" .. math.floor((hrp.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude) .. "]"
						v.distance.Color = esp.settings.distance.color
						BottomOffset = BottomOffset + 15

						v.distance.Font = esp.font
						v.distance.Size = esp.fontsize

						v.distance.Visible = true
					else
						v.distance.Visible = false
					end

					if esp.settings.box.enabled then
						v.boxOutline.Size = BoxSize
						v.boxOutline.Position = BoxPos
						v.boxOutline.Visible = esp.settings.box.outline

						v.box.Size = BoxSize
						v.box.Position = BoxPos
						v.box.Color = esp.settings.box.color
						v.box.Visible = true
					else
						v.boxOutline.Visible = false
						v.box.Visible = false
					end

					if esp.settings.boxfill.enabled then
						v.boxfill.Position = BoxFillPos
						v.boxfill.Size = BoxFillSize
						v.boxfill.Visible = esp.settings.boxfill.enabled
						v.boxfill.Filled = true
						v.boxfill.Color = esp.settings.boxfill.color
						v.boxfill.Transparency = esp.settings.boxfill.transparency
					else
						v.boxfill.Visible = false
						v.boxfill.Filled = false
					end

					if esp.settings.healthbar.enabled then
						v.healthBar.From = Vec2((BoxPos.X - 5), BoxPos.Y + BoxSize.Y)
						v.healthBar.To = Vec2(v.healthBar.From.X, v.healthBar.From.Y - (hum.Health / hum.MaxHealth) * BoxSize.Y)
						v.healthBar.Color = C3(255 - 255 / (hum["MaxHealth"] / hum["Health"]), 255 / (hum["MaxHealth"] / hum["Health"]), 0)
						v.healthBar.Visible = true

						v.healthBarOutline.From = Vec2(v.healthBar.From.X, BoxPos.Y + BoxSize.Y + 1)
						v.healthBarOutline.To = Vec2(v.healthBar.From.X, (v.healthBar.From.Y - 1 * BoxSize.Y) -1)
						v.healthBarOutline.Visible = esp.settings.healthbar.outline
					else
						v.healthBarOutline.Visible = false
						v.healthBar.Visible = false
					end

					if esp.settings.healthtext.enabled then
						v.healthText.Text = tostring(math.floor((hum.Health / hum.MaxHealth) * 100 + 0.5))
						v.healthText.Position = Vec2((BoxPos.X - 20), (BoxPos.Y + BoxSize.Y - 1 * BoxSize.Y) -1)
						v.healthText.Color = esp.settings.healthtext.color
						v.healthText.Outline = esp.settings.healthtext.outline

						v.healthText.Font = esp.font
						v.healthText.Size = esp.fontsize

						v.healthText.Visible = true
					else
						v.healthText.Visible = false
					end

					if esp.settings.tool.enabled then

						v.tool.Position = Vec2(BoxSize.X / 3 + BoxPos.X, BottomOffset)
						v.tool.Color = esp.settings.tool.color
						v.tool.Outline = esp.settings.tool.outline

						v.tool.Font = esp.font
						v.tool.Size = esp.fontsize

						v.tool.Visible = true  

						if i.Character then
							if game.GameId == 3326279937 then
								if i.Character:FindFirstChildWhichIsA("RayValue") then
									v.tool.Text = "["..string.upper(i.Character:FindFirstChildWhichIsA("RayValue").Name).."]"
								else
									v.tool.Text = "[NONE]"
								end
							else
								if i.Character:FindFirstChildWhichIsA("Tool") then
									v.tool.Text = "["..string.upper(i.Character:FindFirstChildWhichIsA("Tool").Name).."]"
								else
									v.tool.Text = "[NONE]"
								end
							end

						else
							v.tool.Text = "[NONE]"
						end
					else
						v.tool.Visible = false
					end

					if esp.settings.viewangle.enabled then
						local fromHead = currentCamera:worldToViewportPoint(head.CFrame.p)
						local toPoint = currentCamera:worldToViewportPoint((head.CFrame + (head.CFrame.lookVector * 10)).p)
						v.viewAngle.From = Vec2(fromHead.X, fromHead.Y)
						v.viewAngle.To = Vec2(toPoint.X, toPoint.Y)
						v.viewAngle.Color = esp.settings.viewangle.color
						v.viewAngle.Visible = true
					end

					if esp.teamcheck then
						if esp.TeamCheck(i) then
							v.name.Visible = esp.settings.name.enabled
							v.box.Visible = esp.settings.box.enabled
							v.boxfill.Visible = esp.settings.boxfill.enabled
							v.healthBar.Visible = esp.settings.healthbar.enabled
							v.healthText.Visible = esp.settings.healthtext.enabled
							v.distance.Visible = esp.settings.distance.enabled
							v.viewAngle.Visible = esp.settings.viewangle.enabled
							v.tool.Visible = esp.settings.tool.enabled
							if ESPOutline then
								if esp.settings.box.enabled then
									v.boxOutline.Visible = esp.settings.box.outline
									v.boxOutline.Visible = esp.settings.box.outline
								end

								if esp.settings.healthbar.enabled then
									v.healthBarOutline.Visible = esp.settings.healthbar.outline
								end
							end
						else
							v.name.Visible = false
							v.boxOutline.Visible = false
							v.box.Visible = false
							v.boxfill.Visible = false
							v.healthBarOutline.Visible = false
							v.healthBar.Visible = false
							v.healthText.Visible = false
							v.distance.Visible = false
							v.viewAngle.Visible = false
							v.tool.Visible = false
						end
					end
				else
					v.name.Visible = false
					v.boxOutline.Visible = false
					v.box.Visible = false
					v.boxfill.Visible = false
					v.healthBarOutline.Visible = false
					v.healthBar.Visible = false
					v.healthText.Visible = false
					v.distance.Visible = false
					v.viewAngle.Visible = false
					v.tool.Visible = false
				end
			else
				v.name.Visible = false
				v.boxOutline.Visible = false
				v.box.Visible = false
				v.boxfill.Visible = false
				v.healthBarOutline.Visible = false
				v.healthBar.Visible = false
				v.healthText.Visible = false
				v.distance.Visible = false
				v.viewAngle.Visible = false
				v.tool.Visible = false
			end
		end
	end

	runService.RenderStepped:Connect(function()
		do ESP() end
	end)

	MenuGroup:AddButton('Unload', function() Library:Unload() end)
	MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

	Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

	ThemeManager:SetLibrary(Library)
	SaveManager:SetLibrary(Library)

	SaveManager:IgnoreThemeSettings() 

	SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 

	ThemeManager:SetFolder('$N2')
	SaveManager:SetFolder('$N2/main')

	SaveManager:BuildConfigSection(Tabs['UI Settings']) 

	ThemeManager:ApplyToTab(Tabs['UI Settings'])

	local OthersSettings = Tabs['UI Settings']:AddRightGroupbox('Others')

	OthersSettings:AddInput('uinamechange', {Default = '$N2 ESP', Numeric = false, Finished = false, Text = 'Window Title', Tooltip = 'Changes window title', Placeholder = '. . .'})
	Options.uinamechange:OnChanged(function()
		Window:SetWindowTitle(Options.uinamechange.Value)
	end)

	OthersSettings:AddDivider()

	OthersSettings:AddButton('Rejoin', function() 
		local ts = game:GetService("TeleportService")
		local p = game:GetService("Players").LocalPlayer
		ts:Teleport(game.PlaceId, p)
	end)
end
