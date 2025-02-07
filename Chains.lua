local player = game.Players.LocalPlayer

local char = player.Character
player.CharacterAdded:Connect(function()
	char = player.Character
end)

-- { SERVICES, ETC. } --

local rs = game:GetService("RunService")
local ts = game:GetService("TweenService")
local ss = game:GetService("SoundService")
local lighting = game:GetService("Lighting")
local repstorage = game:GetService("ReplicatedStorage")

local variables = {
	fov = 70,
	defaultfov = 70,
	
	stamina_regen = 0.7,
	combatstam_regen = 3.5,
	combatstam_rate = 1,
	
	runspeed = 29.25,
	walkspeed = 12,
	crouchspeed = 3,
	
	fullbright_color = Color3.fromRGB(255,255,255),
	brightness = 3,
	
	hitmarkerid = 0,
	spin = 1,
	
	fps = 60,
}

local toggled = {
	fov = false,
	fullbright = false,
	fogdisable = false,
	
	infstamina = false,
	infcmbtstamina = false,
	
	stamregen = false,
	cmbtstamregen = false,
	cmbtstamrate = false,
	
	runspeed = false,
	walkspeed = false,
	crouchspeed = false,
	
	noregencd = false,
	nocmbtregencd = false,
	
	alwayscrouch = false,
	autoqte = false,
	hitmarker = false,
}

local fps_thread
local hitmarker_con

-- { ESP SETUP } --

local scraps = {}
local lootables = {}

local chain_obj
local chain_enabled = false
local chain_color = Color3.fromRGB(255,0,0)

local Sense = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Sirius/refs/heads/request/library/sense/source.lua'))()

workspace.Misc.AI.ChildAdded:Connect(function()
	if workspace.Misc.AI:FindFirstChild("CHAIN") then	
		local chain = workspace.Misc.AI:FindFirstChild("CHAIN")
		chain_obj = Sense.AddInstance(chain, {
			enabled = chain_enabled,
			text = "{name} | {distance}", -- Placeholders: {name}, {distance}, {position}
			textColor = { chain_color, 1 },
			textOutline = true,
			textOutlineColor = Color3.new(),
			limitDistance = false,
		})
	end
end)
if workspace.Misc.AI:FindFirstChild("CHAIN") then
	local chain = workspace.Misc.AI:FindFirstChild("CHAIN")
	chain_obj = Sense.AddInstance(chain, {
		enabled = false,
		text = "{name} | {distance}", -- Placeholders: {name}, {distance}, {position}
		textColor = { Color3.fromRGB(255,0,0), 1 },
		textOutline = true,
		textOutlineColor = Color3.new(),
		limitDistance = false,
	})
end

for _,v in workspace.Misc.Lootables:GetChildren() do
	if v.Name ~= "Radio" then
		table.insert(lootables, Sense.AddInstance(v, {
			enabled = false,
			text = "{name} | {distance}", -- Placeholders: {name}, {distance}, {position}
			textColor = { Color3.fromRGB(255,255,0), 1 },
			textOutline = true,
			textOutlineColor = Color3.new(),
			limitDistance = false,
		}))
	end
end
for _,v in workspace.Misc.Zones.LootingItems.Scrap:GetChildren() do
	if v.Name == "ScrapNormal" then
		table.insert(scraps, Sense.AddInstance(v, {
			enabled = false,
			text = "Scrap | {distance}", -- Placeholders: {name}, {distance}, {position}
			textColor = { Color3.fromRGB(0,255,0), 1 },
			textOutline = true,
			textOutlineColor = Color3.new(),
			limitDistance = false,
		}))
	end
end

Sense.teamSettings.enemy.boxColor[1] = Color3.new(1, 1, 1)
Sense.teamSettings.enemy.boxFillColor = { Color3.new(1,1,1), 0 }

Sense.teamSettings.enemy.boxFill = true

-- { MAIN SETUP } --

local repo = 'https://raw.githubusercontent.com/Okorix/moddedlinorialib/main/'

local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Okorix/moddedlinorialib/main/source.lua'))()
local ThemeManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/Okorix/moddedlinorialib/main/addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/Okorix/moddedlinorialib/main/addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
	Title = 'gore.xyz',
	Center = true,
	AutoShow = true,
	TabPadding = 8
})

local Tabs = {	
	Main = Window:AddTab('Main'),
	['UI Settings'] = Window:AddTab('UI Settings'),
}

local ModsTabbox = Tabs.Main:AddLeftTabbox()
local MiscGroupbox = Tabs.Main:AddRightGroupbox('Misc')

-- [[ VISUALS ]] --
local VisualsTab = ModsTabbox:AddTab('visuals')

-- FOV --

VisualsTab:AddToggle('FOVChanger', {
	Text = 'FOV CHANGER',
	Default = false,
	Tooltip = 'Repeats the FOV change (breaks fov-related stuff)', 

	Callback = function(Value)
		print('[cb] FOV Changer changed to:', Value)

		if Value ~= false then
			local function beforeCamera()
				ts:Create(workspace.CurrentCamera, TweenInfo.new(0), {FieldOfView = variables.fov}):Play()
			end
			rs:BindToRenderStep("CameraFOV_gorexyz", Enum.RenderPriority.Camera.Value - 1, beforeCamera)
		else
			rs:UnbindFromRenderStep("CameraFOV_gorexyz")
			workspace.CurrentCamera.FieldOfView = variables.defaultfov
		end
	end
})
VisualsTab:AddSlider('FOVSlider', {
	Text = '',
	Default = 70,
	Min = 70,
	Max = 120,
	Rounding = 0,
	Compact = false,

	Callback = function(Value)
		print('[cb] FOV Slider was changed! New value:', Value)

		variables.fov = Value
	end
})

-- LIGHTING --
VisualsTab:AddDivider()

VisualsTab:AddToggle('Fullbright', {
	Text = 'FULLBRIGHT',
	Default = false,
	Tooltip = 'mat_fullbright 1', 

	Callback = function(Value)
		print('[cb] Fullbright changed to:', Value)

		if Value ~= false then
			local function beforeCamera()				
				ts:Create(lighting, TweenInfo.new(0), {Ambient = variables.fullbright_color, OutdoorAmbient = variables.fullbright_color, Brightness = variables.brightness}):Play()
			end
			rs:BindToRenderStep("Fullbright_gorexyz", Enum.RenderPriority.Camera.Value - 1, beforeCamera)
		else
			rs:UnbindFromRenderStep("Fullbright_gorexyz")
			
			lighting.Ambient = Color3.fromRGB(45,45,45)
			lighting.OutdoorAmbient = Color3.fromRGB(13,13,13)
			lighting.Brightness = 2.2
		end
	end
}):AddColorPicker('AmbientColor', {
	Default = Color3.fromRGB(255,255,255),
	Title = 'AMBIENT COLOR',
	Transparency = nil,

	Callback = function(Value)
		print('[cb] Ambient Color changed!', Value)
		
		variables.fullbright_color = Value
	end
})

local BrightnessDep = VisualsTab:AddDependencyBox()
BrightnessDep:AddSlider('BrightnessSlider', {
	Text = 'BRIGHTNESS',
	Default = 2.2,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		variables.brightness = Value
	end
})

VisualsTab:AddToggle('FogDisable', {
	Text = 'DISABLE FOG',
	Default = false,
	Tooltip = 'Obvious, turns off fog', 

	Callback = function(Value)
		print('[cb] Fog Disabler changed to:', Value)

		if Value ~= false then
			local function beforeCamera()
				ts:Create(lighting.Misc, TweenInfo.new(0), {Density = 0}):Play()
			end
			rs:BindToRenderStep("FogDisable_gorexyz", Enum.RenderPriority.Camera.Value - 1, beforeCamera)
		else
			rs:UnbindFromRenderStep("FogDisable_gorexyz")
			lighting.Misc.Density = workspace.GameStuff.Values:GetAttribute("Night") and 0.85 or 0.65
		end
	end
})

-- ESP --
VisualsTab:AddDivider()

VisualsTab:AddToggle('ESP_Toggle', {
	Text = 'ESP',
	Default = false,
	Tooltip = 'Enables ESP', 

	Callback = function(Value)
		print('[cb] ESP Toggle changed to:', Value)

		if Value ~= false then
			Sense.Load()
		else
			Sense.Unload()
		end
	end
})

VisualsTab:AddToggle('PlayerESP', {
	Text = 'PLAYER ESP',
	Default = false,
	Tooltip = 'Shows players', 

	Callback = function(Value)
		print('[cb] Player ESP changed to:', Value)

		Sense.teamSettings.enemy.enabled = Value
	end
}):AddColorPicker('PlayerColor', {
	Default = Color3.fromRGB(255,255,255),
	Title = 'PLAYER COLOR',
	Transparency = nil,

	Callback = function(Value)
		print('[cb] Player Color changed!', Value)

		Sense.teamSettings.enemy.boxColor[1] = Value
	end
})

VisualsTab:AddLabel('PLAYER OUTLINE'):AddColorPicker('PlayerOutline', {
	Default = Color3.new(0, 0, 0),
	Title = 'OUTLINE COLOR',
	Transparency = 1,
})
VisualsTab:AddLabel('PLAYER FILL'):AddColorPicker('PlayerFill', {
	Default = Color3.new(1, 1, 1),
	Title = 'FILL COLOR',
	Transparency = 1,
})
VisualsTab:AddLabel('PLAYER INFO TEXT'):AddColorPicker('PlayerText', {
	Default = Color3.new(1, 1, 1),
	Title = 'TEXT COLOR',
	Transparency = 0,
})

Options.PlayerOutline:OnChanged(function()
	Sense.teamSettings.enemy.boxOutlineColor = {Options.PlayerOutline.Value, 1-Options.PlayerOutline.Transparency}
end)
Options.PlayerFill:OnChanged(function()
	Sense.teamSettings.enemy.boxFillColor = {Options.PlayerFill.Value, 1-Options.PlayerFill.Transparency}
end)
Options.PlayerText:OnChanged(function()
	Sense.teamSettings.enemy.healthTextColor = {Options.PlayerText.Value, 1-Options.PlayerText.Transparency}
	Sense.teamSettings.enemy.distanceColor = {Options.PlayerText.Value, 1-Options.PlayerText.Transparency}
end)

VisualsTab:AddToggle('ChainESP', {
	Text = 'CHAIN ESP',
	Default = false,
	Tooltip = 'Shows the bad guy (chain)', 

	Callback = function(Value)
		print('[cb] Chain ESP changed to:', Value)
		
		if chain_obj and chain_obj.instance then
			chain_obj.options.enabled = Value
		end
		chain_enabled = Value
	end
}):AddColorPicker('ChainColor', {
	Default = Color3.fromRGB(255,0,0),
	Title = 'CHAIN COLOR',
	Transparency = nil,

	Callback = function(Value)
		print('[cb] Chain Color changed!', Value)

		if chain_obj and chain_obj.instance then
			chain_obj.options.textColor[1] = Value
		end
		chain_color = Value 
	end
})

VisualsTab:AddToggle('ScrapESP', {
	Text = 'SCRAP ESP',
	Default = false,
	Tooltip = 'Shows scrap (very pro)', 

	Callback = function(Value)
		print('[cb] Scrap ESP changed to:', Value)
		
		if Value ~= false then			
			local function beforeCamera()
				for _,v in scraps do
					v.options.enabled = v.instance.Values:GetAttribute("Available")
				end
			end
			rs:BindToRenderStep("ScrapESP_gorexyz", Enum.RenderPriority.Camera.Value - 1, beforeCamera)
		else
			rs:UnbindFromRenderStep("ScrapESP_gorexyz")			
			
			for _,v in scraps do
				v.options.enabled = false
			end
		end
	end
}):AddColorPicker('ScrapColor', {
	Default = Color3.fromRGB(0,255,0),
	Title = 'SCRAP COLOR',
	Transparency = nil,

	Callback = function(Value)
		print('[cb] Scrap Color changed!', Value)

		for _,v in scraps do
			v.options.textColor[1] = Value
		end
	end
})

VisualsTab:AddToggle('LootESP', {
	Text = 'LOOT ESP',
	Default = false,
	Tooltip = 'Shows all lootables (cabinets and loot crates)', 

	Callback = function(Value)
		print('[cb] Loot ESP changed to:', Value)

		if Value ~= false then			
			local function beforeCamera()
				for _,v in lootables do
					v.options.enabled = not v.instance:GetAttribute("Opened") or not v.instance:GetAttribute("Active")
				end
			end
			rs:BindToRenderStep("LootESP_gorexyz", Enum.RenderPriority.Camera.Value - 1, beforeCamera)
		else
			rs:UnbindFromRenderStep("LootESP_gorexyz")			
			for _,v in lootables do
				v.options.enabled = false
			end
		end
	end
}):AddColorPicker('LootColor', {
	Default = Color3.fromRGB(255,255,0),
	Title = 'LOOT COLOR',
	Transparency = nil,

	Callback = function(Value)
		print('[cb] Loot Color changed!', Value)

		for _,v in lootables do
			v.options.textColor[1] = Value
		end
	end
})

VisualsTab:AddToggle('ESP_Names', {
	Text = 'ESP NAMES',
	Default = false,
	Tooltip = 'Enables ESP names', 

	Callback = function(Value)
		print('[cb] ESP Names changed to:', Value)
		
		Sense.teamSettings.enemy.name = Value
	end
}):AddColorPicker('NameColor', {
	Default = Color3.fromRGB(255,255,255),
	Title = 'NAME COLOR',
	Transparency = nil,

	Callback = function(Value)
		print('[cb] Player Color changed!', Value)

		Sense.teamSettings.enemy.nameColor[1] = Value
	end
})

VisualsTab:AddToggle('ESP_HealthText', {
	Text = 'ESP HEALTH TEXT',
	Default = false,
	Tooltip = 'Enables ESP health text', 

	Callback = function(Value)
		print('[cb] ESP HP Text changed to:', Value)

		Sense.teamSettings.enemy.healthText = Value
	end
})
VisualsTab:AddToggle('ESP_Distance', {
	Text = 'ESP DISTANCE',
	Default = false,
	Tooltip = 'Enables ESP distance', 

	Callback = function(Value)
		print('[cb] ESP Dist changed to:', Value)

		Sense.teamSettings.enemy.distance = Value
	end
})

VisualsTab:AddToggle('ESP_Boxes', {
	Text = 'ESP BOXES',
	Default = false,
	Tooltip = 'Enables ESP boxes', 

	Callback = function(Value)
		print('[cb] ESP Boxes changed to:', Value)

		Sense.teamSettings.enemy.box = Value
	end
})

--[[ STAT CHANGERS ]] --
local StatsTab = ModsTabbox:AddTab('player')

-- STAMINA / COMBAT STAMINA --

StatsTab:AddToggle('StamChanger', {
	Text = 'INF STAMINA',
	Default = false,
	Tooltip = 'Makes your stamina truly infinite', 

	Callback = function(Value)
		print('[cb] Infinite Stamina changed to:', Value)

		if Value ~= false then
			local function beforeCamera()
				pcall(function()
					char.Stats.Stamina.Value = 100
				end)
			end
			rs:BindToRenderStep("StaminaRefill_gorexyz", Enum.RenderPriority.Camera.Value - 1, beforeCamera)
		else
			rs:UnbindFromRenderStep("StaminaRefill_gorexyz")
		end
	end
})
StatsTab:AddToggle('CombatStamChanger', {
	Text = 'INF COMBAT STAMINA',
	Default = false,
	Tooltip = 'Lets you fight for centuries', 

	Callback = function(Value)
		print('[cb] Inf Combat Stamina changed to:', Value)

		if Value ~= false then
			local function beforeCamera()
				pcall(function()
					char.Stats.CombatStamina.Value = 100
				end)
			end
			rs:BindToRenderStep("CombatStam_Refill_gorexyz", Enum.RenderPriority.Camera.Value - 1, beforeCamera)
		else
			rs:UnbindFromRenderStep("CombatStam_Refill_gorexyz")
		end
	end
})

-- STAMINA REGEN --
StatsTab:AddDivider()

StatsTab:AddToggle('StaminaRegen', {
	Text = 'STAMINA REGEN',
	Default = false,
	Tooltip = 'Changes your stamina regen amount', 

	Callback = function(Value)
		print('[cb] Stamina Regen Changer changed to:', Value)

		if Value ~= false then
			local function beforeCamera()
				pcall(function()
					char.Stats.StaminaRegen.Value = variables.stamina_regen
				end)
			end
			rs:BindToRenderStep("StaminaRegen_gorexyz", Enum.RenderPriority.Camera.Value - 1, beforeCamera)
		else
			rs:UnbindFromRenderStep("StaminaRegen_gorexyz")
			char.Stats.StaminaRegen.Value = 0.7
		end
	end
})

local StamRegenDep = StatsTab:AddDependencyBox()
StamRegenDep:AddSlider('StamRegenSlider', {
	Text = '',
	Default = 0.7,
	Min = 0,
	Max = 100,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		variables.runspeed = Value
	end
})

StatsTab:AddToggle('CombatStamRegen', {
	Text = 'COMBAT STAMINA REGEN',
	Default = false,
	Tooltip = 'Changes your combat stamina regen amount', 

	Callback = function(Value)
		print('[cb] Combat Stamina Amount changed to:', Value)

		if Value ~= false then
			local function beforeCamera()
				pcall(function()
					char.Stats.CombatStamina:SetAttribute("Regen", variables.combatstam_regen)
				end)
			end
			rs:BindToRenderStep("CombatStamRegen_gorexyz", Enum.RenderPriority.Camera.Value - 1, beforeCamera)
		else
			rs:UnbindFromRenderStep("CombatStamRegen_gorexyz")
			char.Stats.CombatStamina:SetAttribute("Regen", 3.5)
		end
	end
})

local CombatStamRegenDep = StatsTab:AddDependencyBox()
CombatStamRegenDep:AddSlider('CombatStamRegenSlider', {
	Text = '',
	Default = 3.5,
	Min = 0,
	Max = 100,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		variables.combatstam_regen = Value
	end
})

StatsTab:AddToggle('CombatStamRate', {
	Text = 'COMBAT STAMINA RATE',
	Default = false,
	Tooltip = 'Changes your combat stamina regen rate', 

	Callback = function(Value)
		print('[cb] Combat Stamina Rate changed to:', Value)

		if Value ~= false then
			local function beforeCamera()
				pcall(function()
					char.Stats.CombatStamina:SetAttribute("Regen_Rate", variables.combatstam_rate)
				end)
			end
			rs:BindToRenderStep("CombatStamRate_gorexyz", Enum.RenderPriority.Camera.Value - 1, beforeCamera)
		else
			rs:UnbindFromRenderStep("CombatStamRate_gorexyz")
			char.Stats.CombatStamina:SetAttribute("Regen_Rate", 1)
		end
	end
})

local CombatStamRateDep = StatsTab:AddDependencyBox()
CombatStamRateDep:AddSlider('CombatStamRateSlider', {
	Text = '',
	Default = 3.5,
	Min = 0,
	Max = 100,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		variables.combatstam_regen = Value
	end
})

-- SPEED --
StatsTab:AddDivider()

StatsTab:AddToggle('RunSpeed', {
	Text = 'RUN SPEED',
	Default = false,
	Tooltip = 'Changes your running speed', 

	Callback = function(Value)
		print('[cb] Run Speed Changer changed to:', Value)

		if Value ~= false then
			local function beforeCamera()
				pcall(function()
					char.Stats.RunSpeed.Value = variables.runspeed
				end)
			end
			rs:BindToRenderStep("RunSpeed_gorexyz", Enum.RenderPriority.Camera.Value - 1, beforeCamera)
		else
			rs:UnbindFromRenderStep("RunSpeed_gorexyz")
			char.Stats.RunSpeed.Value = 29.25
		end
	end
})

local RunDep = StatsTab:AddDependencyBox()
RunDep:AddSlider('RunSlider', {
	Text = '',
	Default = 29.25,
	Min = 0,
	Max = 60,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		print('[cb] Run Speed Slider was changed! New value:', Value)

		variables.runspeed = Value
	end
})

StatsTab:AddToggle('WalkSpeed', {
	Text = 'WALK SPEED',
	Default = false,
	Tooltip = 'Changes your walking speed', 

	Callback = function(Value)
		print('[cb] Walk Speed Changer changed to:', Value)

		if Value ~= false then
			local function beforeCamera()
				pcall(function()
					char.Stats.WalkSpeed.Value = variables.walkspeed
				end)
			end
			rs:BindToRenderStep("WalkSpeed_gorexyz", Enum.RenderPriority.Camera.Value - 1, beforeCamera)
		else
			rs:UnbindFromRenderStep("WalkSpeed_gorexyz")
			char.Stats.WalkSpeed.Value = 12
		end
	end
})

local WalkDep = StatsTab:AddDependencyBox()
WalkDep:AddSlider('WalkSlider', {
	Text = '',
	Default = 12,
	Min = 0,
	Max = 60,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		print('[cb] Walk Speed Slider was changed! New value:', Value)

		variables.walkspeed = Value
	end
})

StatsTab:AddToggle('CrouchSpeed', {
	Text = 'CROUCH SPEED',
	Default = false,
	Tooltip = 'Changes your crouching speed', 

	Callback = function(Value)
		print('[cb] Crouch Speed Changer changed to:', Value)

		if Value ~= false then
			local function beforeCamera()
				pcall(function()
					char.Stats.CrouchSpeed.Value = variables.crouchspeed
				end)
			end
			rs:BindToRenderStep("CrouchSpeed_gorexyz", Enum.RenderPriority.Camera.Value - 1, beforeCamera)
		else
			rs:UnbindFromRenderStep("CrouchSpeed_gorexyz")
			char.Stats.CrouchSpeed.Value = 3
		end
	end
})

local CrouchDep = StatsTab:AddDependencyBox()
CrouchDep:AddSlider('CrouchSlider', {
	Text = '',
	Default = 3,
	Min = 0,
	Max = 60,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		print('[cb] Crouch Speed Slider was changed! New value:', Value)

		variables.crouchspeed = Value
	end
})

-- [[CD REMOVERS]] --
local CDTab = ModsTabbox:AddTab('cooldowns')

CDTab:AddToggle('NoRegenCD', {
	Text = 'STAMINA NO REGEN',
	Default = false,
	Tooltip = 'No cooldown on stamina regen', 

	Callback = function(Value)
		print('[cb] Stamina Regen CD Changer changed to:', Value)

		if Value ~= false then
			local function beforeCamera()
				if char.Humanoid:FindFirstChild("NoRegen") then
					char.Humanoid.NoRegen:Destroy()
				end
			end
			rs:BindToRenderStep("NoRegenCD_gorexyz", Enum.RenderPriority.Camera.Value - 1, beforeCamera)
		else
			rs:UnbindFromRenderStep("NoRegenCD_gorexyz")
		end
	end
})

CDTab:AddToggle('NoCombatRegenCD', {
	Text = 'COMBAT STAMINA NO REGEN',
	Default = false,
	Tooltip = 'No cooldown on combat stamina regen', 

	Callback = function(Value)
		print('[cb] Combat Stam Regen CD Changer changed to:', Value)

		if Value ~= false then
			local function beforeCamera()
				if char.Humanoid:FindFirstChild("CMBATNoRegen") then
					char.Humanoid.CMBATNoRegen:Destroy()
				end
			end
			rs:BindToRenderStep("NoCombatRegenCD_gorexyz", Enum.RenderPriority.Camera.Value - 1, beforeCamera)
		else
			rs:UnbindFromRenderStep("NoCombatRegenCD_gorexyz")
		end
	end
})

-- this one kicks you, gonna fix that later

--[[CDTab:AddToggle('NoDodgeCD', {
	Text = 'NO DODGE COOLDOWN',
	Default = false,
	Tooltip = 'No cooldown on dodging (i had to decompile and re-add the entire script with one line changed lol)', 

	Callback = function(Value)
		print('[cb] Dodge CD Changer changed to:', Value)

		if Value ~= false then
			char.CharacterMobility.Enabled = false
			
			movementscript_thread = task.spawn(function()
				loadstring(game:HttpGet("https://pastebin.com/raw/R592Wq86"))()
			end)
		else
			task.cancel(movementscript_thread)
			movementscript_thread = nil
			
			char.CharacterMobility.Enabled = true
		end
	end
})]]

-- [[ MISC ]] --

MiscGroupbox:AddToggle('AlwaysCrouch', {
	Text = 'ALWAYS CROUCH',
	Default = false,
	Tooltip = 'looks funny (you have to be uncrouched)', 

	Callback = function(Value)
		print('[cb] Always Crouch changed to:', Value)

		if Value ~= false then
			local function beforeCamera()
				pcall(function()
					char.Stats.Crouching.Value = true
				end)
			end
			rs:BindToRenderStep("AlwaysCrouch_gorexyz", Enum.RenderPriority.Camera.Value - 1, beforeCamera)
		else
			rs:UnbindFromRenderStep("AlwaysCrouch_gorexyz")
			char.Stats.Crouching.Value = false
		end
	end
})

MiscGroupbox:AddToggle('AutoQTE', {
	Text = 'AUTO QTE',
	Default = false,
	Tooltip = 'literally sets your strength always at max during QTE sequences', 

	Callback = function(Value)
		print('[cb] Auto QTE changed to:', Value)

		if Value ~= false then
			local function beforeCamera()
				pcall(function()
					char.Stats.ClashStrength.Value = 100
				end)
			end
			rs:BindToRenderStep("AutoQTE_gorexyz", Enum.RenderPriority.Camera.Value - 1, beforeCamera)
		else
			rs:UnbindFromRenderStep("AutoQTE_gorexyz")
			char.Stats.ClashStrength.Value = 0
		end
	end
})

MiscGroupbox:AddToggle('Hitmarker', {
	Text = 'HITMARKER SOUND',
	Default = false,
	Tooltip = 'cod hitmarker sound xddd', 

	Callback = function(Value)
		print('[cb] Hitmarker changed to:', Value)

		if Value ~= false then
			hitmarker_con = repstorage.GameStuff.Remotes.Network.OnClientEvent:Connect(function(p63, p64)				
				--if player == p57 then
				--	if p58 == "Hitmarker" then
				--		pcall(function()
				--			local hitmarker = Instance.new("Sound")
				--			hitmarker.SoundId = "rbxassetid://"..variables.hitmarkerid
				--			hitmarker.Volume = 1
				--			hitmarker.Parent = ss
				--			hitmarker:Play()

				--			game.Debris:AddItem(hitmarker, hitmarker.TimeLength+0.05)
				--		end)
				--	else
				--		return
				--	end
				--else
				--	return
				--end
				
				if p63 == "Hitmarker" then
					local hitmarker = Instance.new("Sound")
					hitmarker.Name = "hitsound"
					hitmarker.SoundId = "rbxassetid://"..variables.hitmarkerid
					hitmarker.Volume = 1
					hitmarker.Parent = ss
					hitmarker:Play()

					game.Debris:AddItem(hitmarker, 2)
					return
				end
				return
			end)		
		else
			hitmarker_con:Disconnect()
			hitmarker_con = nil
		end
	end
})

MiscGroupbox:AddInput('HitmarkerID', {
	Default = '0',
	Numeric = true, -- true / false, only allows numbers
	Finished = true, -- true / false, only calls callback when you press enter

	Text = 'Hitmarker ID',
	Tooltip = 'Put any ID in there (has to be public)', -- Information shown when you hover over the textbox

	Placeholder = '0', -- placeholder text when the box is empty
	-- MaxLength is also an option which is the max length of the text

	Callback = function(Value)
		print('[cb] ID updated. New ID:', Value)
		variables.hitmarkerid = tonumber(Value)
	end
})

MiscGroupbox:AddToggle('Spinbot', {
	Text = 'SPINBOT',
	Default = false,
	Tooltip = 'csgo reference lol xddd', 

	Callback = function(Value)
		print('[cb] Spinbot changed to:', Value)

		if Value ~= false then
			local spin_amt = 0
			
			local function beforeCamera(delta)
				pcall(function()
					char.Humanoid.AutoRotate = false
					char.Humanoid.RootPart.CFrame = CFrame.new(char.Humanoid.RootPart.CFrame.Position) * CFrame.Angles(0, spin_amt, 0)
					
					spin_amt += delta*variables.spin
				end)
			end
			rs:BindToRenderStep("Spinbot_gorexyz", Enum.RenderPriority.Camera.Value - 1, beforeCamera)
		else
			rs:UnbindFromRenderStep("Spinbot_gorexyz")
			char.Humanoid.AutoRotate = true
		end
	end
})

local SpinDep = MiscGroupbox:AddDependencyBox()
SpinDep:AddSlider('SpinSlider', {
	Text = '',
	Default = 1,
	Min = 1,
	Max = 25,
	Rounding = 0,
	Compact = false,

	Callback = function(Value)
		print('[cb] Spin Slider was changed! New value:', Value)

		variables.spin = Value
	end
})

-- [[ SETUP DEPENDENCIES ]] --

BrightnessDep:SetupDependencies({
	{ Toggles.Fullbright, true },
});
StamRegenDep:SetupDependencies({
	{ Toggles.StaminaRegen, true },
});
CombatStamRegenDep:SetupDependencies({
	{ Toggles.CombatStamRegen, true },
});
CombatStamRateDep:SetupDependencies({
	{ Toggles.CombatStamRate, true },
});
RunDep:SetupDependencies({
	{ Toggles.RunSpeed, true },
});
WalkDep:SetupDependencies({
	{ Toggles.WalkSpeed, true },
});
CrouchDep:SetupDependencies({
	{ Toggles.CrouchSpeed, true },
});
SpinDep:SetupDependencies({
	{ Toggles.Spinbot, true },
});

-- [[ SETTINGS ]] --

Library:OnUnload(function()
	fps_thread:Disconnect()
	Library.Unloaded = true
end)


local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')


MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind 

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()

SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

ThemeManager:SetFolder('gorexyz')
SaveManager:SetFolder('gorexyz/chain')

SaveManager:BuildConfigSection(Tabs['UI Settings'])

ThemeManager:ApplyToTab(Tabs['UI Settings'])


SaveManager:LoadAutoloadConfig()

-- [[ ON LOAD ]] --

Library:SetWatermarkVisibility(true)
Library:Notify("loaded gore.xyz. ready to rock!", 5)
Library:SetWatermark(`gore.xyz | CHAIN | {game.Players.LocalPlayer.name} | {variables.fps} FPS`)

local update_tick = tick()

fps_thread = rs.RenderStepped:Connect(function(deltaTime)
	variables.fps = math.floor(1 / deltaTime)
	if (tick()-update_tick) >= 0.5 then
		update_tick = tick()
		Library:SetWatermark(`gore.xyz | CHAIN | {variables.fps} FPS`)
	end
end)
