_G.ESPTeamCheck = true
_G.ESPEnabled = true
_G.ESPLocal = true
_G.ESPShowTracers = true
_G.ESPHealthBar = true
_G.ESPShowBox = true
_G.ESPTracerColor = Color3.fromRGB(0, 255, 140)
_G.ESPBoxColor = Color3.fromRGB(0, 255, 140)


local lplr = game.Players.LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local CurrentCamera = workspace.CurrentCamera
local worldtoViewportPoint = CurrentCamera.WorldToViewportPoint

local HeadOff = Vector3.new(0, 0.5, 0)
local LegOff = Vector3.new(0,3,0)

for i,v in pairs(game.Players:GetChildren()) do

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
	BoxOutline.Visible = false
	BoxOutline.Color = Color3.new(0,0,0)
	BoxOutline.Thickness = 3
	BoxOutline.Transparency = 1
	BoxOutline.Filled = false

	local HealthBar = Drawing.new("Square")
	BoxOutline.Visible = false
	BoxOutline.Thickness = 1
	BoxOutline.Transparency = 1
	BoxOutline.Filled = false


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

						--HealthBarOutline.Size = Vector2.new(2, HeadPosition.Y - LegPosition.Y)
						--HealthBarOutline.Position = BoxOutline.Position - Vector2.new(6,0)

						--HealthBar.Size = Vector2.new(2, (HeadPosition.Y - LegPosition.Y) / (game:GetService("Players")[v.Character.Name]:FindFirstChild("Humanoid").MaxHealth / math.clamp(game:GetService("Players")[v.Character.Name]:FindFirstChild("Humanoid").Health, 0, game:GetService("Players")[v.Character.Name]:WaitForChild("Humanoid").MaxHealth)))
						--HealthBar.Position = Vector2.new(Box.Position.X - 6, Box.Position.Y + (1/HealthBar.Size.Y))
						--HealthBar.Color = Color3.fromRGB(255 - 255 / (game:GetService("Players")[v.Character.Name]:FindFistChild("Humanoid").MaxHealth / game:GetService("Players")[v.Character.Name]:FindFistChild("Humanoid").Health), 255 / (game:GetService("Players")[v.Character.Name]:FindFistChild("Humanoid").MaxHealth / game:GetService("Players")[v.Character.Name]:FindFistChild("Humanoid").Health), 0)

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
		coroutine.wrap(boxesp)()
	end)
end

game.Players.PlayerAdded:Connect(function(v)

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
	BoxOutline.Visible = false
	BoxOutline.Color = Color3.new(0,0,0)
	BoxOutline.Thickness = 3
	BoxOutline.Transparency = 1
	BoxOutline.Filled = false

	local HealthBar = Drawing.new("Square")
	BoxOutline.Visible = false
	BoxOutline.Thickness = 1
	BoxOutline.Transparency = 1
	BoxOutline.Filled = false


	function boxesp()
		game:GetService("RunService").RenderStepped:Connect(function()
			if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
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

						--HealthBarOutline.Size = Vector2.new(2, HeadPosition.Y - LegPosition.Y)
						--HealthBarOutline.Position = BoxOutline.Position - Vector2.new(6,0)

						--HealthBar.Size = Vector2.new(2, (HeadPosition.Y - LegPosition.Y) / (game:GetService("Players")[v.Character.Name]:FindFirstChild("Humanoid").MaxHealth / math.clamp(game:GetService("Players")[v.Character.Name]:FindFirstChild("Humanoid").Health, 0, game:GetService("Players")[v.Character.Name]:WaitForChild("Humanoid").MaxHealth)))
						--HealthBar.Position = Vector2.new(Box.Position.X - 6, Box.Position.Y + (1/HealthBar.Size.Y))
						--HealthBar.Color = Color3.fromRGB(255 - 255 / (game:GetService("Players")[v.Character.Name]:FindFistChild("Humanoid").MaxHealth / game:GetService("Players")[v.Character.Name]:FindFistChild("Humanoid").Health), 255 / (game:GetService("Players")[v.Character.Name]:FindFistChild("Humanoid").MaxHealth / game:GetService("Players")[v.Character.Name]:FindFistChild("Humanoid").Health), 0)

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
		coroutine.wrap(boxesp)()
	end)
end)
