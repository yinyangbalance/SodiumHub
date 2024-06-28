-- Constants for GUI appearance
local GUI_WIDTH = 300
local GUI_HEIGHT = 250
local TITLE_HEIGHT = 30
local TAB_HEIGHT = 30

-- Global variable to track GUI visibility
local guiVisible = true

-- Function to create AnimationChanger GUI
local function createAnimationChanger()
    -- Check if GUI already exists
    local existingGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("AnimationChanger")
    if existingGui then
        -- GUI already exists, do not recreate
        return
    end

    -- Create AnimationChanger GUI
    local AnimationChanger = Instance.new("ScreenGui")
    AnimationChanger.Name = "AnimationChanger"
    AnimationChanger.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- MainFrame setup
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, GUI_WIDTH, 0, GUI_HEIGHT)
    MainFrame.Position = UDim2.new(0.5, -GUI_WIDTH / 2, 0.5, -GUI_HEIGHT / 2)
    MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = guiVisible  -- Initialize visibility
    MainFrame.Parent = AnimationChanger

    -- TitleBar setup
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, TITLE_HEIGHT)
    TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TitleBar.BorderSizePixel = 0
    TitleBar.Position = UDim2.new(0, 0, 0, -TITLE_HEIGHT)
    TitleBar.Parent = MainFrame

    -- TitleLabel setup
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Size = UDim2.new(1, 0, 0, TITLE_HEIGHT)
    TitleLabel.Position = UDim2.new(0, 0, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 18
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.Text = "Animation Changer"
    TitleLabel.Parent = TitleBar

    -- CloseButton setup
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.TextSize = 18
    CloseButton.Parent = TitleBar
    CloseButton.MouseButton1Click:Connect(function()
        AnimationChanger.Visible = false
    end)

    -- MinimizeButton setup
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Text = "_"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.Font = Enum.Font.SourceSansBold
    MinimizeButton.TextSize = 18
    MinimizeButton.Parent = TitleBar
    MinimizeButton.MouseButton1Click:Connect(function()
        guiVisible = not guiVisible
        MainFrame.Visible = guiVisible
    end)

    -- NormalTab setup
    local NormalTab = Instance.new("Frame")
    NormalTab.Name = "NormalTab"
    NormalTab.Size = UDim2.new(1, 0, 1, -TITLE_HEIGHT - TAB_HEIGHT)
    NormalTab.Position = UDim2.new(0, 0, 0, TITLE_HEIGHT)
    NormalTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    NormalTab.BorderSizePixel = 0
    NormalTab.Parent = MainFrame

    -- A_Ninja button setup (example)
    local A_Ninja = Instance.new("TextButton")
    A_Ninja.Name = "A_Ninja"
    A_Ninja.Size = UDim2.new(0, 150, 0, 30)
    A_Ninja.Position = UDim2.new(0.5, -75, 0, 20)
    A_Ninja.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    A_Ninja.BorderSizePixel = 0
    A_Ninja.Font = Enum.Font.SourceSans
    A_Ninja.Text = "Ninja Animation"
    A_Ninja.TextColor3 = Color3.fromRGB(255, 255, 255)
    A_Ninja.TextSize = 18
    A_Ninja.Parent = NormalTab

    -- Function to set animations for the Ninja
    local function setNinjaAnimations()
        -- Replace with your animation setting logic
        print("Setting Ninja animations...")
    end

    -- Connect A_Ninja button to setNinjaAnimations function
    A_Ninja.MouseButton1Click:Connect(function()
        setNinjaAnimations()
    end)

    -- Function to handle character added (for respawn)
    local function onCharacterAdded(character)
        -- Check if AnimationChanger GUI exists
        if not AnimationChanger:IsDescendantOf(game.Players.LocalPlayer:WaitForChild("PlayerGui")) then
            -- Recreate GUI if it doesn't exist (player respawned)
            createAnimationChanger()
        end
        -- Optionally, reapply animations or settings here
    end

    -- Connect character added event
    game.Players.LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

    -- Check if GUI needs to be created initially (first load)
    if game.Players.LocalPlayer.Character then
        onCharacterAdded(game.Players.LocalPlayer.Character)
    end

    -- Keybind to toggle visibility (LeftCtrl)
    local UserInputService = game:GetService("UserInputService")
    local leftCtrlPressed = false

    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.LeftControl then
            leftCtrlPressed = true
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.LeftControl then
            leftCtrlPressed = false
        end
    end)

    RunService.RenderStepped:Connect(function()
        if leftCtrlPressed then
            guiVisible = not guiVisible
            MainFrame.Visible = guiVisible
        end
    end)
end

-- Call createAnimationChanger function when the game starts
createAnimationChanger()
