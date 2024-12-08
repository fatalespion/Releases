local Camera = workspace.CurrentCamera
local UserInputService = game:GetService('UserInputService')

_G.SilentAimEnabled = false
_G.WallCheck = false
_G.HeadChance = 100
_G.HitChance = 100
_G.HitPart = "Torso"
_G.UseFOV = false
_G.CircleRadius = 200
_G.CircleFilled = false
_G.CircleColor = Color3.fromRGB(255, 255, 255)
_G.CircleVisible = false
_G.CircleTransparency = 0.5
_G.CircleSides = 64
_G.CircleThickness = 1

local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Filled = _G.CircleFilled
FOVCircle.Color = _G.CircleColor
FOVCircle.Visible = _G.CircleVisible
FOVCircle.Transparency = _G.CircleTransparency
FOVCircle.NumSides = _G.CircleSides
FOVCircle.Thickness = _G.CircleThickness

warn("SILENT AIM V1")

local Client = {}
do
	for _, v in next, getgc(true) do
		if (type(v) == 'table') then
			if (rawget(v, 'Fire') and type(rawget(v, 'Fire')) == 'function' and not Client.Bullet) then
				Client.Bullet = v
			elseif (rawget(v, 'HiddenUpdate')) then
				Client.Players = debug.getupvalue(rawget(v, 'new'), 9)
			end
		end
	end

	function Client:GetPlayerHitbox(player, hitbox)
		for _, player_hitbox in next, player.Hitboxes do
			if (player_hitbox._name == hitbox) then
				return player_hitbox
			end
		end
	end

	function Client:GetClosestPlayerFromCursor()
		local nearest_player, distance = nil, math.huge

		for _, player in next, Client.Players do
			pcall(function()
				if (
					not player.Dead and
						player.PlayerModel and
						player.PlayerModel.Model.Head.Transparency == 0
					) then
					local pos, bounds = Camera:WorldToViewportPoint(player.Position)
					if bounds then
						local cursor_position = UserInputService:GetMouseLocation()
						local screen_position = Vector2.new(pos.X, pos.Y)
						local magnitude = (cursor_position - screen_position).Magnitude

						if _G.UseFOV and magnitude > _G.CircleRadius then
							return
						end

						if (magnitude < distance) then
							distance = magnitude
							nearest_player = player
						end
					end  
				end
			end)
		end 
		return nearest_player
	end

	function Client:CheckWall(startPos, targetPos)
		if not _G.WallCheck then return true end
		local raycastParams = RaycastParams.new()
		raycastParams.FilterDescendantsInstances = {workspace}
		raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
		local result = workspace:Raycast(startPos, (targetPos - startPos).Unit * 500, raycastParams)
		return result == nil
	end
end

Fire = hookfunction(Client.Bullet.Fire, function(self, ...)

	local args = {...}

	local target = Client:GetClosestPlayerFromCursor()
	if target then
		local hitChanceRoll = math.random(1, 100)
		if hitChanceRoll <= _G.HitChance and _G.SilentAimEnabled then
			local hitbox
			
			if _G.HeadChance >= math.random(1, 100) and _G.HitPart == "Head" then
				hitbox = "Head"
			elseif _G.HitPart ~= "Head" then
				hitbox = _G.HitPart
			end
			
			local targetHitbox = Client:GetPlayerHitbox(target, hitbox)

			if targetHitbox and Client:CheckWall(Camera.CFrame.Position, targetHitbox.CFrame.Position) then
				args[2] = CFrame.new(Camera.CFrame.Position, targetHitbox.CFrame.Position).LookVector
			end
		end
	end

	return Fire(self, unpack(args))
end)

game:GetService("RunService").RenderStepped:Connect(function()
	FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
	FOVCircle.Radius = _G.CircleRadius
	FOVCircle.Visible = _G.CircleVisible
	FOVCircle.Filled = _G.CircleFilled
	FOVCircle.Color = _G.CircleColor
	FOVCircle.Transparency = _G.CircleTransparency
	FOVCircle.Thickness = _G.CircleThickness
end)
