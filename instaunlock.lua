local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local workspace = game:GetService("Workspace")
local vim = game:GetService("VirtualInputManager")

_G.instaUnlock = _G.instaUnlock or false

local function getClosestLootModel()
    local closestModel = nil
    local shortestDistance = math.huge
    
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("MeshPart") then
            local lootTable = part:FindFirstChild("LootTable")
            if lootTable then
                local model = lootTable.Parent.Parent
                if model:IsA("Model") then
                    local primaryPart = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
                    if primaryPart then
                        local distance = (character.PrimaryPart.Position - primaryPart.Position).magnitude
                        if distance < shortestDistance then
                            shortestDistance = distance
                            closestModel = model
                        end
                    end
                end
            end
        end
    end

    return closestModel
end

while true do
    if workspace:FindFirstChild("Lockpick") and _G.instaUnlock then
        local lootModel = getClosestLootModel()
        if lootModel then
            game.ReplicatedStorage.Events.Loot.MinigameResult:FireServer(lootModel, true)

            input = {
                hold = function(key, time)
                    vim:SendKeyEvent(true, key, false, game)
                    task.wait(time)
                    vim:SendKeyEvent(false, key, false, game)
                end,
                press = function(key)
                    vim:SendKeyEvent(true, key, false, game)
                    task.wait(0.005)
                    vim:SendKeyEvent(false, key, false, game)
                end,
                holdMouse = function(button, time, x, y)
                    vim:SendMouseButtonEvent(x, y, button.Value, true, game, 0)
                    task.wait(time)
                    vim:SendMouseButtonEvent(x, y, button.Value, false, game, 0)
                end,
                pressMouse = function(button, x, y)
                    vim:SendMouseButtonEvent(x, y, button.Value, true, game, 0)
                    task.wait(0.005)
                    vim:SendMouseButtonEvent(x, y, button.Value, false, game, 0)
                end
            }

            input.press(Enum.KeyCode.E)
        end
    end
    
    wait(1)
end
