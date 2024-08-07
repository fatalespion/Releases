local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Holding = false

local function IsPlayerAlive(player)
    return player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0
end

local function IsPlayerBehindWall(player)
    local character = player.Character
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
    local playerCharacter = localPlayer.Character
    local targetCharacter = targetPlayer.Character

    if playerCharacter and targetCharacter then
        local playerPosition = playerCharacter.PrimaryPart.Position
        local targetPosition = targetCharacter.PrimaryPart.Position
        local directionToTarget = (targetPosition - playerPosition).Unit
        local playerLookVector = playerCharacter.PrimaryPart.CFrame.LookVector

        return playerLookVector:Dot(directionToTarget) > 0
    end

    return false
end

local function GetClosestPlayer()
    local MaximumDistance = _G.CircleRadius
    local Target = nil
    local MouseLocation = UserInputService:GetMouseLocation()

    if _G.PlayerTrack then
        for _, v in ipairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and not _G.BlacklistedPlayers[v.Name] and not (_G.FriendsBlacklist and LocalPlayer:IsFriendsWith(v.UserId)) then
                if _G.TeamCheck and v.Team == LocalPlayer.Team then
                    continue
                end
    
                if not _G.AliveCheck or IsPlayerAlive(v) then
                    if v.Character and v.Character:FindFirstChild(_G.AimPart) then
                        local ScreenPoint = Camera:WorldToScreenPoint(v.Character[_G.AimPart].Position)
                        local VectorDistance = (MouseLocation - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
    
                        if VectorDistance < MaximumDistance and IsPlayerInFront(LocalPlayer, v) then
                            if not _G.WallCheck or not IsPlayerBehindWall(v) then
                                Target = v
                                MaximumDistance = VectorDistance
                            end
                        end
                    end
                end
            end
        end
    end   
    
    return Target
end

UserInputService.InputBegan:Connect(function(Input)
    if Input.UserInputType == _G.AimKeybind or Input.KeyCode == _G.AimKeybind then
        if _G.AAiming then
            return
        end        

        _G.AAiming = true
        Holding = true
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == _G.AimKeybind or Input.KeyCode == _G.AimKeybind then
        Holding = false
        _G.AAiming = false
    end
end)

RunService.RenderStepped:Connect(function()

    if Holding and _G.AimbotEnabled and _G.PlayerTrack and not _G.AAiming then
        local closestPlayer = GetClosestPlayer()
        if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild(_G.AimPart) then
            local aimPartPosition = closestPlayer.Character[_G.AimPart].Position
            TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, aimPartPosition)}):Play()
        end
    end
end)
