local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Holding = false

_G.AimbotEnabled = false
_G.AimPart = "Head"

_G.AimKeybind = Enum.UserInputType.MouseButton2
_G.AimbotWallCheck = true

local function IsPlayerAlive(player)
	return game.Workspace.Playermodels[tostring(player.UserId)] and game.Workspace.Playermodels[tostring(player.UserId)]:FindFirstChild("Humanoid") and game.Workspace.Playermodels[tostring(player.UserId)].Humanoid.Health > 0
end

local function IsPlayerBehindWall(player)
	local character = game.Workspace.Playermodels[tostring(player.UserId)]
	if character and character:FindFirstChild(_G.AimPart) then
		local origin = Camera.CFrame.Position
		local target = character[_G.AimPart].Position
		local ray = Ray.new(origin, (target - origin).Unit * (target - origin).Magnitude)
		local part = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, character})
		return part ~= nil and part:IsDescendantOf(character) == false
	end
	return true
end

local function IsPlayerInFront(localPlayer, targetPlayer)
	local playerCharacter = game.Workspace.Playermodels[tostring(localPlayer.UserId)]
	local targetCharacter = game.Workspace.Playermodels[tostring(targetPlayer.UserId)]

	if playerCharacter and targetCharacter then
		local playerPosition = playerCharacter.PrimaryPart.Position
		local targetPosition = targetCharacter.PrimaryPart.Position
		local directionToTarget = (targetPosition - playerPosition).Unit
		local playerLookVector = playerCharacter.PrimaryPart.CFrame.LookVector

		return playerLookVector:Dot(directionToTarget) > 0
	end

	return false
end

local function GetClosestTarget()
	local MaximumDistance = _G.CircleRadius
	local Target = nil
	local MouseLocation = UserInputService:GetMouseLocation()

	for _, v in ipairs(Players:GetPlayers()) do
		if v ~= LocalPlayer then
			local character = game.Workspace.Playermodels[tostring(v.UserId)]
			if character and character:FindFirstChild(_G.AimPart) then
				local aimPart = character[_G.AimPart]
				local ScreenPoint = Camera:WorldToScreenPoint(aimPart.Position)
				local VectorDistance = (MouseLocation - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude

				if VectorDistance < MaximumDistance and IsPlayerInFront(LocalPlayer, v) then
					if not _G.AimbotWallCheck or not IsPlayerBehindWall(v) then
						Target = aimPart
						MaximumDistance = VectorDistance
					end
				end
			end
		end
	end	

	return Target
end

local function GetMouseTarget()
	local MouseLocation = UserInputService:GetMouseLocation()

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then

			local character = game.Workspace.Playermodels[tostring(player.UserId)]
			if character and character:FindFirstChild(_G.AimPart) then
				local aimPart = character[_G.AimPart]
				local ScreenPoint = Camera:WorldToScreenPoint(aimPart.Position)
				if (MouseLocation - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude < _G.CircleRadius then
					if not IsPlayerBehindWall(player) then
						return aimPart
					end
				end
			end
		end
	end

	return nil
end

UserInputService.InputBegan:Connect(function(Input)
	if Input.UserInputType == _G.AimKeybind or Input.KeyCode == _G.AimKeybind then
		Holding = true
	end
end)

UserInputService.InputEnded:Connect(function(Input)
	if Input.UserInputType == _G.AimKeybind or Input.KeyCode == _G.AimKeybind then
		Holding = false
	end
end)

RunService.RenderStepped:Connect(function()
	if Holding and _G.AimbotEnabled then
		local closestTarget = GetClosestTarget()
		if closestTarget then
			TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, closestTarget.Position)}):Play()
		end
	end
end)
