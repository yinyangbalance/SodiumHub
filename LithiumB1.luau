-- Load Fluent and its addons
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- Create Fluent Window for Lithium Console
local Window = Fluent:CreateWindow({
    Title = "Lithium Console",
    SubTitle = "A powerful GUI console for exploiters",
    Size = UDim2.fromOffset(600, 400),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Console Output Display
local OutputText = ""
local ConsoleOutput = Window:AddLabel({
    Title = "Console Output:",
    Text = OutputText,
    Size = UDim2.new(1, 0, 0, 300),
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top
})

-- Redirect print function to update the GUI console
local function RedirectPrint(...)
    local args = {...}
    local message = table.concat(args, " ")
    OutputText = OutputText .. "\n" .. message
    ConsoleOutput:SetText(OutputText)
end

-- Override print function to redirect output
local originalPrint = print
print = RedirectPrint

-- Function to execute server commands
local function ExecuteServerCommand(command)
    local RemoteEvent = game:GetService("ReplicatedStorage"):FindFirstChild("CommandRemoteEvent")
    if RemoteEvent then
        RemoteEvent:FireServer(command)
    else
        print("[ERROR]: CommandRemoteEvent not found")
    end
end

-- Function to execute local commands
local function ExecuteLocalCommand(command)
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    if command == "reset" then
        if character then
            character:SetPrimaryPartCFrame(CFrame.new(Vector3.new(0, 50, 0)))
            print("[INFO]: Character reset to origin")
        else
            print("[ERROR]: Character not found")
        end
    else
        print("[ERROR]: Invalid local command")
    end
end

-- Input Field for Commands
local InputField = Window:AddInput("CommandInput", {
    Title = "Command:",
    Placeholder = "Enter your command...",
    Numeric = false,
    Finished = true,
    Callback = function(value)
        if value == "" then return end
        
        if string.sub(value, 1, 1) == "/" then
            -- Server command
            ExecuteServerCommand(string.sub(value, 2))  -- Remove the '/' prefix
        else
            -- Local command
            ExecuteLocalCommand(value)
        end
    end
})

-- Example usage
print("[INFO]: Lithium Console initialized.")

-- Restore original print function
print = originalPrint
