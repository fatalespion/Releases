local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Holding = false

_G.AimbotEnabled = true
_G.TeamCheck = false
_G.AimPart = "Head"
_G.Sensitivity = 0.1
_G.CircleSides = 64
_G.CircleColor = Color3.fromRGB(255, 255, 255)
_G.CircleTransparency = 0.7
_G.CircleRadius = 80
_G.CircleFilled = false
_G.CircleVisible = true
_G.CircleThickness = 1

_G.BlacklistedPlayers = {}  -- Table where player names are keys and values are true
_G.FriendsBlacklist = true
_G.AimKeybind = Enum.UserInputType.MouseButton2
_G.AliveCheck = true
_G.WallCheck = true

_G.PlayerTrack = true
_G.NPCTrack = true

local function IsPlayerAlive(player)
    return player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0
end

local function IsNPCAlive(npc)
    return npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0
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

local function IsNPCBehindWall(npc)
    if npc and npc:FindFirstChild(_G.AimPart) then
        local origin = Camera.CFrame.Position
        local target = npc[_G.AimPart].Position
        local ray = Ray.new(origin, (target - origin).Unit * (target - origin).Magnitude)
        local part = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, npc})
        return part ~= nil and part:IsDescendantOf(npc) == false
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

local function IsNPCInFront(localPlayer, npc)
    local playerCharacter = localPlayer.Character
    local npcPrimaryPart = npc.PrimaryPart

    if playerCharacter and npcPrimaryPart then
        local playerPosition = playerCharacter.PrimaryPart.Position
        local npcPosition = npcPrimaryPart.Position
        local directionToTarget = (npcPosition - playerPosition).Unit
        local playerLookVector = playerCharacter.PrimaryPart.CFrame.LookVector

        return playerLookVector:Dot(directionToTarget) > 0
    end

    return false
end

local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Filled = _G.CircleFilled
FOVCircle.Color = _G.CircleColor
FOVCircle.Visible = _G.CircleVisible
FOVCircle.Transparency = _G.CircleTransparency
FOVCircle.NumSides = _G.CircleSides
FOVCircle.Thickness = _G.CircleThickness

local function GetClosestTarget()
    local MaximumDistance = _G.CircleRadius
    local Target = nil
    local MouseLocation = UserInputService:GetMouseLocation()

    -- Check for closest player
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

    -- Check for closest NPC
    if _G.NPCTrack then
        local NPCs = workspace.NPCs.Hostile:GetChildren()
        for _, npc in ipairs(NPCs) do
            if npc and npc:FindFirstChild(_G.AimPart) then
                if not _G.AliveCheck or IsNPCAlive(npc) then
                    local ScreenPoint = Camera:WorldToScreenPoint(npc[_G.AimPart].Position)
                    local VectorDistance = (MouseLocation - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude

                    if VectorDistance < MaximumDistance and IsNPCInFront(LocalPlayer, npc) then
                        if not _G.WallCheck or not IsNPCBehindWall(npc) then
                            Target = npc
                            MaximumDistance = VectorDistance
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
        Holding = true
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == _G.AimKeybind or Input.KeyCode == _G.AimKeybind then
        Holding = false
    end
end)

RunService.RenderStepped:Connect(function()
    FOVCircle.Position = UserInputService:GetMouseLocation()
    FOVCircle.Radius = _G.CircleRadius
    FOVCircle.Filled = _G.CircleFilled
    FOVCircle.Color = _G.CircleColor
    FOVCircle.Visible = _G.CircleVisible
    FOVCircle.Transparency = _G.CircleTransparency
    FOVCircle.NumSides = _G.CircleSides
    FOVCircle.Thickness = _G.CircleThickness

    if Holding and _G.AimbotEnabled then
        local closestTarget = GetClosestTarget()
        if closestTarget and closestTarget:FindFirstChild(_G.AimPart) then
            local aimPartPosition = closestTarget[_G.AimPart].Position
            TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, aimPartPosition)}):Play()
        end
    end
end)
