local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/fatalespion/Releases/refs/heads/main/xsx.lua"))()

local RunService = game:GetService("RunService")
local Camera = game.Workspace.CurrentCamera

library.rank = "developer"
local Wm = library:Watermark("empyreal | v0.0.5 | " .. library:GetUsername() .. " | rank: " .. library.rank)
local FpsWm = Wm:AddWatermark("fps: " .. library.fps)
coroutine.wrap(function()
    while wait(.75) do
        FpsWm:Text("fps: " .. library.fps)
    end
end)()


local Notif = library:InitNotifications()

for i = 5,0,-1 do 
    task.wait(0.05)
    local LoadingXSX = Notif:Notify("Loading empyreal, please be patient.", 3, "information") -- notification, alert, error, success, information
end 

library.title = "Empyreal"

_G.CameraOffset = Vector3.new(0, 0, 0)

_G.EnabledThirdPerson = false
_G.EnabledForceField = false

for _, v in pairs(game.Workspace.Playermodels[tostring(game.Players.LocalPlayer.UserId)]:GetChildren()) do
    if v:IsA("BasePart") then
        v:SetAttribute("OriginalColor", v.Color)
    end
end

local function ToggleThirdPerson()
    RunService.RenderStepped:Connect(function()

        for _, v in pairs(game.Workspace.Playermodels[tostring(game.Players.LocalPlayer.UserId)]:GetChildren()) do
            if v:IsA("BasePart") then
                if _G.EnabledThirdPerson then
                    v.LocalTransparencyModifier = 0

                    if _G.EnabledForceField then
                        v.Color = Color3.fromRGB(0, 255, 0)
                        v.Material = Enum.Material.ForceField
                    else
                        v.Color = v:GetAttribute("OriginalColor")
                        v.Material = Enum.Material.Plastic
                    end   
                else
                    v.LocalTransparencyModifier = 1
                end   
            end
        end

        for _, v in pairs(game.Workspace.Playermodels[tostring(game.Players.LocalPlayer.UserId)]:GetChildren()) do
            if v:IsA("BasePart") then
               
            end
        end

        local cameraCFrame = Camera.CFrame
        Camera.CFrame = cameraCFrame * CFrame.new(_G.CameraOffset)
    end)
end

ToggleThirdPerson()

library:Introduction()
wait(1)
local Init = library:Init()

local Visual = Init:NewTab("Visual")

local ThirdPersonSection = Visual:NewSection("ThirdPerson")

local EnableThirdPerson = Visual:NewToggle("Enable", false, function(value)
    local vers = value and "on" or "off"

    if vers == "on" then
        _G.CameraOffset = Vector3.new(0, 1, 4)

        for _, viewmodels in pairs(game.Workspace.CurrentCamera:GetDescendants()) do
            if viewmodels:IsA("BasePart") then
                viewmodels:SetAttribute("OriginalTransparency", viewmodels.Transparency)
                 viewmodels.Transparency = 1
            end
        end

        _G.EnabledThirdPerson = true
    else
        _G.CameraOffset = Vector3.new(0, 0, 0)
        _G.EnabledThirdPerson = false

         for _, viewmodels in pairs(game.Workspace.CurrentCamera:GetDescendants()) do
            if viewmodels:IsA("BasePart") then
                viewmodels.Transparency = viewmodels:GetAttribute("OriginalTransparency")
            end
        end
    end
end)

local EnableForcefield = Visual:NewToggle("ForceField Material", false, function(value)
    local vers = value and "on" or "off"

    if vers == "on" then
        _G.EnabledForceField = true
    else
        _G.EnabledForceField = false
    end
end)


local FinishedLoading = Notif:Notify("Loaded empyreal", 4, "success")

