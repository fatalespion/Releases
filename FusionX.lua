-- [ // configuration table \\ ]
local configuration = {
	-- [ // themes \\ ]
	themes = {
		Background = Color3.fromRGB(24, 24, 24),
		Glow = Color3.fromRGB(84, 209, 255),
		Accent = Color3.fromRGB(10, 10, 10),
		LightContrast = Color3.fromRGB(20, 20, 20),
		DarkContrast = Color3.fromRGB(14, 14, 14),  
		TextColor = Color3.fromRGB(255, 255, 255)
	},

	-- [ // tables \\ ]
	services = {},
	functions = {},
	cooldowns = {},
	variables = {},

	-- [ // rainbow vars \\ ]
	rainbowColor = nil,
	rainbowConnection = nil,
	rainbowSpeed = 0.1,
	rainbowI = 0,
}

configuration.functions.func = function()
	if getgenv()["__apikey"] ~= "admin" then
		warn("[FusionX] invalid key")
		return
	end
	
	-- [ // init \\ ]
	local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/VenyxUILIB.lua"))()
	local FusionX = library.new("FusionX", 5013109572)

	-- [ // fast services \\ ]
	configuration.services = setmetatable({}, {
		__index = function(_, service)
			return game:GetService(service)
		end,
	})

	-- [ // themes variables \\ ]
	configuration.variables.Themes = {}
	configuration.variables.Themes.Multicolor = false

	-- [ // rainbow \\ ]
	configuration.rainbowConnection = configuration.services.RunService.RenderStepped:Connect(function(delta)
		configuration.rainbowColor = Color3.fromHSV(configuration.rainbowI,1,1)
		configuration.rainbowI = (configuration.rainbowI + delta*configuration.rainbowSpeed) % 1

		if configuration.variables.Themes.Multicolor then
			FusionX:setTheme("Glow", configuration.rainbowColor)
		end
	end)

	-- [ // theme page \\ ]
	local theme = FusionX:addPage("Theme", 88098297592877)
	local colors = theme:addSection("Colors")

	for theme, color in pairs(configuration.themes) do
		colors:addColorPicker(theme, color, function(color3)
			FusionX:setTheme(theme, color3)
		end)
	end

	colors:addToggle("Multicolor", nil, function(value)
		print("Toggled", value)
	end)

	-- [ // load \\ ]
	FusionX:SelectPage(FusionX.pages[1], true)
end

return configuration
