-- STILL IN TESTING MODE
-- Load Fluent and its addons so i wont have to suffer
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- Create Fluent lib Window so it wont look like shit
local Window = Fluent:CreateWindow({
    Title = "Lithium Hub " .. Fluent.Version,
    SubTitle = "A powerful yet simple hub for exploiters",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Tabs yez tabs
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- Notification to warn the user
Fluent:Notify({
    Title = "Lithium Supports synapse x ( down ), krnl ( down ), And solara ( active )",
    Content = "This is a notification",
    Duration = 5
})

-- SaveManager and InterfaceManager setup
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)

Fluent:Notify({
    Title = "Fluent Lithium",
    Content = "The script has been loaded.",
    Duration = 8
})

SaveManager:LoadAutoloadConfig()

-- Integrate Lithium functionality
local main = true
if main then
    local function lithiumFunction()
        local lithium = {
            localplayer = game:GetService("Players"):WaitForChild("LocalPlayer"),
            localplayer_root = game:GetService("Players"):WaitForChild("LocalPlayer"):WaitForChild("HumanoidRootPart")
        }
        -- Add Lithium-specific functionalities here
    end
    lithiumFunction()
end

-- Button to fire all function objects in the game
Tabs.Main:AddButton({
    Title = "Fire All Functions",
    Description = "Fires every function object in the game",
    Callback = function()
        for _, v in pairs(game:GetDescendants()) do
            if typeof(v) == "Instance" and v:IsA("RemoteEvent") then
                v:FireServer()
            elseif typeof(v) == "Instance" and v:IsA("RemoteFunction") then
                v:InvokeServer()
            elseif typeof(v) == "Instance" and v:IsA("BindableEvent") then
                v:Fire()
            elseif typeof(v) == "Instance" and v:IsA("BindableFunction") then
                v:Invoke()
            end
        end
    end
})
