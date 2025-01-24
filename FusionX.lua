-- [ // configuration table \\ ]
local configuration = {
	-- [ // themes \\ ]
	themes = {
		Background = Color3.fromRGB(24, 24, 24),
		Glow = Color3.fromRGB(0, 255, 247),
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

configuration.functions.load = function()
	if getgenv()["__apikey"] ~= "admin" then
		warn("[Xenoware] invalid key")
		return
	end

	warn("[Xenoware]: ###################### Loading...")

	-- [ // init \\ ]
	local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/VenyxUILIB.lua"))()
	local Xenoware = library.new("Xenoware", 5013109572)

	-- [ // fast services \\ ]
	configuration.services = setmetatable({}, {
		__index = function(_, service)
			return game:GetService(service)
		end,
	})
	
	--[ // functions \\ ]
	configuration.functions.getPlayer = function(text)
		local playerFound = nil

		for i, player in ipairs(configuration.services.Players:GetPlayers()) do
			if string.lower(player.Name):sub(1, #text) == string.lower(text) then
				playerFound = player.Name

				break
			end
		end

		return playerFound
	end
	
	configuration.functions.killAll = function(...)
		if (...) == "all" then
			for i = 1, 50 do
				task.wait()

				for _,v in pairs(configuration.services.Players:GetPlayers()) do
					local args = {
						[1] = 19.708738666665795,
						[2] = configuration.services.ReplicatedStorage:WaitForChild("Data"):WaitForChild(v.Name):WaitForChild("Limbs"):WaitForChild("Right Leg"),
						[3] = 177.37864799999215,
						[4] = v.Character.Humanoid
					}

					v.Character.FallReg.Damage:FireServer(unpack(args))
				end
			end
		else
			for i = 1, 50 do
				task.wait()

				local args = {
					[1] = 19.708738666665795,
					[2] = configuration.services.ReplicatedStorage:WaitForChild("Data"):WaitForChild((...).Name):WaitForChild("Limbs"):WaitForChild("Right Leg"),
					[3] = 177.37864799999215,
					[4] = (...).Character.Humanoid
				}

				(...).Character.FallReg.Damage:FireServer(unpack(args))
			end
		end
	end
	
	-- [ // miscellaneous variables \\ ]
	configuration.variables.Miscellaneous = {}
	configuration.variables.Miscellaneous.killAllTarget = ""
	
	-- [ // themes variables \\ ]
	configuration.variables.Themes = {}
	configuration.variables.Themes.Multicolor = false

	-- [ // rainbow \\ ]
	configuration.rainbowConnection = configuration.services.RunService.RenderStepped:Connect(function(delta)
		configuration.rainbowColor = Color3.fromHSV(configuration.rainbowI,1,1)
		configuration.rainbowI = (configuration.rainbowI + delta*configuration.rainbowSpeed) % 1

		if configuration.variables.Themes.Multicolor then
			Xenoware:setTheme("Glow", configuration.rainbowColor)
		end
	end)
	
	-- [ // misc \\ ]
	local miscellaneous = Xenoware:addPage("Miscellaneous", 9940320365)
	local killAllSection = miscellaneous:addSection("Kill All")
	
	killAllSection:addTextbox("Player", "N/A", function(value, focusLost)
		if focusLost then
			configuration.variables.Miscellaneous.killAllTarget = configuration.functions.getPlayer(value)
		end
	end)
	
	killAllSection:addButton("Kill Player!", function()
		if not configuration.services.Players:FindFirstChild(configuration.variables.Miscellaneous.killAllTarget) then
			Xenoware:Notify("KILL ALL ALERT", "Player not found.")
			return
		end
		
		configuration.functions.killAll(configuration.services.Players:FindFirstChild(configuration.variables.Miscellaneous.killAllTarget))
		
		Xenoware:Notify("KILL ALL ALERT", "Success.")
	end)
	
	killAllSection:addButton("Kill All!", function()
		configuration.functions.killAll("all")
	end)
	
	-- [ // theme page \\ ]
	local theme = Xenoware:addPage("Theme", 88098297592877)
	local colors = theme:addSection("Colors")

	for theme, color in pairs(configuration.themes) do
		Xenoware:setTheme(theme, color)

		colors:addColorPicker(theme, color, function(color3)
			Xenoware:setTheme(theme, color3)
		end)
	end

	colors:addToggle("Multicolor", nil, function(value)
		configuration.variables.Themes.Multicolor = value
	end)

	-- [ // load \\ ]
	Xenoware:SelectPage(Xenoware.pages[1], true)

	warn("[Xenoware]: ################################ 100%")
end

return configuration
