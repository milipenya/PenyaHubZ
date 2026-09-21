--[[
    PenyaHubZ
    Core/UI.lua

    Основной пользовательский интерфейс.
]]

local UI = {}

local Players = game:GetService("Players")

local Theme
local Animations
local Toggle

local Player = Players.LocalPlayer

--------------------------------------------------
-- Tabs
--------------------------------------------------

local TAB_NAMES = {
    "CHANGE LOGS",
    "MINI GAMES",
    "GUARD MODE",
    "COMBAT",
    "MISC",
    "SETTINGS"
}

--------------------------------------------------
-- Mini Games
--------------------------------------------------

local MINI_GAME_NAMES = {
    "RED LIGHT GREEN LIGHT",
    "DALGONA",
    "PENTATHLON",
    "LIGHTS OUT",
    "HIDE AND SEEK",
    "TUG OF WAR",
    "GLASS BRIDGE",
    "JUMP ROPE",
    "MINGLE",
    "LAST DINNER",
    "SQUID GAME",
    "SKY SQUID GAME",
    "REBEL"
}

--------------------------------------------------
-- State
--------------------------------------------------

UI.ToggleStates = {}

--------------------------------------------------
-- Helpers
--------------------------------------------------

local function createCorner(parent, radius)

    local corner = Instance.new("UICorner")

    corner.CornerRadius =
        UDim.new(0, radius)

    corner.Parent = parent

    return corner
end

local function createLabel(parent, text, size, position)

    local label = Instance.new("TextLabel")

    label.Size = size
    label.Position = position

    label.BackgroundTransparency = 1

    label.Text = text
    label.TextColor3 = Theme.Colors.Text

    label.Font = Theme.Fonts.Medium
    label.TextSize = 14

    label.TextXAlignment =
        Enum.TextXAlignment.Left

    label.TextYAlignment =
        Enum.TextYAlignment.Center

    label.Parent = parent

    return label
end

--------------------------------------------------
-- Mini Game Button
--------------------------------------------------

local function createFunctionButton(
    parent,
    name,
    order
)

    local buttonFrame = Instance.new("Frame")

    buttonFrame.Name = name
    buttonFrame.Size =
        UDim2.new(1, -12, 0, 48)

    buttonFrame.BackgroundColor3 =
        Theme.Colors.Panel

    buttonFrame.BorderSizePixel = 0

    buttonFrame.LayoutOrder = order

    buttonFrame.Parent = parent

    createCorner(
        buttonFrame,
        Theme.Sizes.SmallCornerRadius
    )

    --------------------------------------------------
    -- Hover
    --------------------------------------------------

    local hoverButton = Instance.new("TextButton")

    hoverButton.Name = "HoverButton"

    hoverButton.Size =
        UDim2.fromScale(1, 1)

    hoverButton.BackgroundTransparency = 1

    hoverButton.Text = ""

    hoverButton.AutoButtonColor = false

    hoverButton.ZIndex = 1

    hoverButton.Parent = buttonFrame

    --------------------------------------------------
    -- Function Name
    --------------------------------------------------

    local label = createLabel(
        buttonFrame,
        name,
        UDim2.new(1, -80, 1, 0),
        UDim2.fromOffset(14, 0)
    )

    label.ZIndex = 2

    --------------------------------------------------
    -- Toggle
    --------------------------------------------------

    local toggle = Toggle:Create(
        buttonFrame,
        UDim2.new(1, -66, 0.5, -13),
        false,
        function(state)

            UI.ToggleStates[name] = state

            print(
                "[PenyaHubZ] " ..
                name ..
                " = " ..
                tostring(state)
            )

        end
    )

    local toggleGui = toggle:GetGui()

    toggleGui.ZIndex = 3

    --------------------------------------------------
    -- Hover Animation
    --------------------------------------------------

    hoverButton.MouseEnter:Connect(function()

        Animations:Color(
            buttonFrame,
            Theme.Colors.PanelLight,
            Animations.Duration.Fast
        )

    end)

    hoverButton.MouseLeave:Connect(function()

        Animations:Color(
            buttonFrame,
            Theme.Colors.Panel,
            Animations.Duration.Fast
        )

    end)

    --------------------------------------------------
    -- Click
    --------------------------------------------------

    hoverButton.MouseButton1Click:Connect(function()

        toggle:Toggle()

    end)

    return buttonFrame
end

--------------------------------------------------
-- Tab Button
--------------------------------------------------

local function createTabButton(
    parent,
    name,
    order
)

    local button = Instance.new("TextButton")

    button.Name = name
    button.Size =
        UDim2.new(1, -20, 0, 42)

    button.Position =
        UDim2.fromOffset(10, 0)

    button.BackgroundColor3 =
        Theme.Colors.Panel

    button.BorderSizePixel = 0

    button.Text = name

    button.TextColor3 =
        Theme.Colors.TextDim

    button.Font =
        Theme.Fonts.Semibold

    button.TextSize = 12

    button.TextXAlignment =
        Enum.TextXAlignment.Left

    button.AutoButtonColor = false

    button.LayoutOrder = order

    button.Parent = parent

    createCorner(
        button,
        Theme.Sizes.SmallCornerRadius
    )

    local padding =
        Instance.new("UIPadding")

    padding.PaddingLeft =
        UDim.new(0, 14)

    padding.Parent = button

    return button
end

--------------------------------------------------
-- UI Init
--------------------------------------------------

function UI:Init(context)

    if not context then
        warn("[PenyaHubZ] UI context is missing.")
        return false
    end

    Theme = context.Theme
    Animations = context.Animations
    Toggle = context.Toggle

    if not Theme or not Animations or not Toggle then

        warn(
            "[PenyaHubZ] UI dependencies are missing."
        )

        return false
    end

    --------------------------------------------------
    -- Existing GUI
    --------------------------------------------------

    local playerGui = Player:WaitForChild("PlayerGui")

    local oldGui =
        playerGui:FindFirstChild("PenyaHubZ")

    if oldGui then
        oldGui:Destroy()
    end

    --------------------------------------------------
    -- ScreenGui
    --------------------------------------------------

    local screenGui = Instance.new("ScreenGui")

    screenGui.Name = "PenyaHubZ"

    screenGui.ResetOnSpawn = false

    screenGui.ZIndexBehavior =
        Enum.ZIndexBehavior.Sibling

    screenGui.Parent = playerGui

    --------------------------------------------------
    -- Open Button
    --------------------------------------------------

    local openButton = Instance.new("TextButton")

    openButton.Name = "OpenButton"

    openButton.Size =
        UDim2.fromOffset(54, 54)

    openButton.Position =
        UDim2.new(1, -74, 0, 24)

    openButton.BackgroundColor3 =
        Theme.Colors.PurpleDark

    openButton.BorderSizePixel = 0

    openButton.Text = "P"

    openButton.TextColor3 =
        Theme.Colors.Text

    openButton.Font =
        Theme.Fonts.Black

    openButton.TextSize = 28

    openButton.AutoButtonColor = false

    openButton.Parent = screenGui

    createCorner(
        openButton,
        Theme.Sizes.CornerRadius
    )

    --------------------------------------------------
    -- Main Window
    --------------------------------------------------

    local mainWindow = Instance.new("Frame")

    mainWindow.Name = "MainWindow"

    mainWindow.AnchorPoint =
        Vector2.new(0.5, 0.5)

    mainWindow.Position =
        UDim2.fromScale(0.5, 0.5)

    mainWindow.Size =
        UDim2.fromOffset(
            Theme.Sizes.MainWidth,
            Theme.Sizes.MainHeight
        )

    mainWindow.BackgroundColor3 =
        Theme.Colors.Background

    mainWindow.BorderSizePixel = 0

    mainWindow.Visible = false

    mainWindow.Parent = screenGui

    createCorner(
        mainWindow,
        Theme.Sizes.CornerRadius
    )

    --------------------------------------------------
    -- Title
    --------------------------------------------------

    local title = createLabel(
        mainWindow,
        "PenyaHubZ",
        UDim2.new(1, -30, 0, 38),
        UDim2.fromOffset(15, 8)
    )

    title.Font =
        Theme.Fonts.Bold

    title.TextSize = 20

    --------------------------------------------------
    -- Sidebar
    --------------------------------------------------

    local sidebar = Instance.new("Frame")

    sidebar.Name = "Sidebar"

    sidebar.Size =
        UDim2.new(
            0,
            Theme.Sizes.SidebarWidth,
            1,
            -56
        )

    sidebar.Position =
        UDim2.fromOffset(
            0,
            50
        )

    sidebar.BackgroundColor3 =
        Theme.Colors.Panel

    sidebar.BorderSizePixel = 0

    sidebar.Parent = mainWindow

    createCorner(
        sidebar,
        Theme.Sizes.SmallCornerRadius
    )

    local tabList =
        Instance.new("UIListLayout")

    tabList.Padding =
        UDim.new(0, 8)

    tabList.HorizontalAlignment =
        Enum.HorizontalAlignment.Center

    tabList.SortOrder =
        Enum.SortOrder.LayoutOrder

    tabList.Parent = sidebar

    local tabPadding =
        Instance.new("UIPadding")

    tabPadding.PaddingTop =
        UDim.new(0, 10)

    tabPadding.Parent = sidebar

    --------------------------------------------------
    -- Content
    --------------------------------------------------

    local content = Instance.new("Frame")

    content.Name = "Content"

    content.Size =
        UDim2.new(
            1,
            -Theme.Sizes.SidebarWidth - 15,
            1,
            -56
        )

    content.Position =
        UDim2.new(
            0,
            Theme.Sizes.SidebarWidth + 10,
            0,
            50
        )

    content.BackgroundColor3 =
        Theme.Colors.Panel

    content.BorderSizePixel = 0

    content.Parent = mainWindow

    createCorner(
        content,
        Theme.Sizes.SmallCornerRadius
    )

    --------------------------------------------------
    -- Content Title
    --------------------------------------------------

    local pageTitle = createLabel(
        content,
        "CHANGE LOGS",
        UDim2.new(1, -30, 0, 32),
        UDim2.fromOffset(15, 10)
    )

    pageTitle.Font =
        Theme.Fonts.Bold

    pageTitle.TextSize = 17

    --------------------------------------------------
    -- Function Container
    --------------------------------------------------

    local functionContainer =
        Instance.new("ScrollingFrame")

    functionContainer.Name =
        "FunctionContainer"

    functionContainer.Size =
        UDim2.new(
            1,
            -20,
            1,
            -55
        )

    functionContainer.Position =
        UDim2.fromOffset(10, 50)

    functionContainer.BackgroundTransparency = 1

    functionContainer.BorderSizePixel = 0

    functionContainer.ScrollBarThickness = 3

    functionContainer.ScrollBarImageColor3 =
        Theme.Colors.Purple

    functionContainer.CanvasSize =
        UDim2.fromOffset(0, 0)

    functionContainer.AutomaticCanvasSize =
        Enum.AutomaticSize.Y

    functionContainer.Parent = content

    local functionList =
        Instance.new("UIListLayout")

    functionList.Padding =
        UDim.new(0, 7)

    functionList.SortOrder =
        Enum.SortOrder.LayoutOrder

    functionList.Parent =
        functionContainer

    local functionPadding =
        Instance.new("UIPadding")

    functionPadding.PaddingTop =
        UDim.new(0, 2)

    functionPadding.PaddingBottom =
        UDim.new(0, 5)

    functionPadding.Parent =
        functionContainer

    --------------------------------------------------
    -- Clear Functions
    --------------------------------------------------

    local function clearFunctions()

        for _, child in ipairs(
            functionContainer:GetChildren()
        ) do

            if child:IsA("Frame") then
                child:Destroy()
            end

        end

    end

    --------------------------------------------------
    -- Show Tab
    --------------------------------------------------

    local function showTab(tabName)

        pageTitle.Text = tabName

        clearFunctions()

        if tabName == "MINI GAMES" then

            for index, gameName in ipairs(
                MINI_GAME_NAMES
            ) do

                createFunctionButton(
                    functionContainer,
                    gameName,
                    index
                )

            end

        else

            local description = Instance.new("TextLabel")

            description.Size =
                UDim2.new(1, -30, 0, 80)

            description.Position =
                UDim2.fromOffset(15, 55)

            description.BackgroundTransparency = 1

            description.Text =
                "Functions for " .. tabName

            description.TextColor3 =
                Theme.Colors.TextDim

            description.Font =
                Theme.Fonts.Medium

            description.TextSize = 14

            description.TextXAlignment =
                Enum.TextXAlignment.Left

            description.TextYAlignment =
                Enum.TextYAlignment.Top

            description.TextWrapped = true

            description.Parent =
                functionContainer

        end

    end

    --------------------------------------------------
    -- Create Tabs
    --------------------------------------------------

    for index, tabName in ipairs(TAB_NAMES) do

        local tab =
            createTabButton(
                sidebar,
                tabName,
                index
            )

        tab.MouseButton1Click:Connect(function()

            showTab(tabName)

            for _, otherTab in ipairs(
                sidebar:GetChildren()
            ) do

                if otherTab:IsA("TextButton") then

                    Animations:Color(
                        otherTab,
                        Theme.Colors.Panel,
                        Animations.Duration.Fast
                    )

                    Animations:TextColor(
                        otherTab,
                        Theme.Colors.TextDim,
                        Animations.Duration.Fast
                    )

                end

            end

            Animations:Color(
                tab,
                Theme.Colors.PurpleDark,
                Animations.Duration.Fast
            )

            Animations:TextColor(
                tab,
                Theme.Colors.Text,
                Animations.Duration.Fast
            )

        end)

        if index == 1 then

            Animations:Color(
                tab,
                Theme.Colors.PurpleDark,
                Animations.Duration.Fast
            )

            Animations:TextColor(
                tab,
                Theme.Colors.Text,
                Animations.Duration.Fast
            )

        end

    end

    --------------------------------------------------
    -- Open / Close
    --------------------------------------------------

    local opened = false

    openButton.MouseButton1Click:Connect(function()

        opened = not opened

        if opened then

            mainWindow.Visible = true

            mainWindow.Size =
                UDim2.fromOffset(0, 0)

            Animations:OpenWindow(
                mainWindow,
                UDim2.fromOffset(
                    Theme.Sizes.MainWidth,
                    Theme.Sizes.MainHeight
                )
            )

        else

            local tween =
                Animations:CloseWindow(
                    mainWindow
                )

            if tween then

                tween.Completed:Connect(function()

                    if not opened then
                        mainWindow.Visible = false
                    end

                end)

            end

        end

    end)

    --------------------------------------------------
    -- Initial Page
    --------------------------------------------------

    showTab("CHANGE LOGS")

    print("[PenyaHubZ] UI initialized.")

    return true
end

return UI
