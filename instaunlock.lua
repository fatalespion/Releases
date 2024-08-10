local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local workspace = game:GetService("Workspace")
local vim = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

_G.instaUnlock = _G.instaUnlock or false
_G.takeAllObjects = _G.takeAllObjects or false
local lastLootTable = nil

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
                            lastLootTable = lootTable

                            if _G.takeAllObjects then
                                for _, lootObject in ipairs(lootTable:GetChildren()) do
                                    ReplicatedStorage.Events.Loot.LootObject:FireServer(lootTable, lootObject, true)
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return closestModel
end

local function processLastLootTable()
    if lastLootTable and _G.takeAllObjects then
        for _, lootObject in ipairs(lastLootTable:GetChildren()) do
            ReplicatedStorage.Events.Loot.LootObject:FireServer(lastLootTable, lootObject, true)
        end
    end
end

local function lootObjectsFromFrame(frame)
    local itemsList = frame:FindFirstChild("Items"):FindFirstChild("List")
    if not itemsList then return end
    if not _G.takeAllObjects then return end
    
    local objectNames = {}
    for _, button in ipairs(itemsList:GetChildren()) do
        if button:IsA("TextButton") then
            table.insert(objectNames, button.Name)
        end
    end

    if _G.takeAllObjects and #objectNames > 0 then
        for _, descendant in ipairs(workspace:GetDescendants()) do
            if descendant:IsA("Folder") and descendant.Name == "LootTable" then
                local lootTable = descendant
                local allObjects = lootTable:GetChildren()
                for _, obj in ipairs(allObjects) do
                    if obj:IsA("NumberValue") and table.find(objectNames, obj.Name) then
                        ReplicatedStorage.Events.Loot.LootObject:FireServer(lootTable, obj, true)
                    end
                end
            end
        end
    end
end

while true do
    if workspace:FindFirstChild("Lockpick") and _G.instaUnlock then
        local lootModel = getClosestLootModel()
        if lootModel then
            ReplicatedStorage.Events.Loot.MinigameResult:FireServer(lootModel, true)

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

    local frame = player.PlayerGui.MainGui:FindFirstChild("LootFrame")
    if frame and frame.Visible then
        lootObjectsFromFrame(frame)
        processLastLootTable()
    end
    
    wait(1)
end
