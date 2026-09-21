--[[
    PenyaHubZ
    Core/UI.lua

    Основной интерфейс PenyaHubZ.
]]

local UI = {}

local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Theme
local Animations

local screenGui
local mainWindow
local openButton
local sidebar
local content

local opened = false

local GUI_NAME = "PenyaHubZ"

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
-- Helpers
--------------------------------------------------

local function create(className, properties, parent)
    local object = Instance.new(className)

    for property, value in pairs(properties or {}) do
        object[property] = value
    end

    object.Parent = parent

    return object
end

local function addCorner(object, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = object

    return corner
end

local function addStroke(object)
    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.Colors.PurpleDark
    stroke.Thickness = 1
    stroke.Transparency = 0.25
    stroke.Parent = object

    return stroke
end

--------------------------------------------------
-- Clear Content
--------------------------------------------------

local function clearContent()
    if not content then
        return
    end

    for _, child in ipairs(content:GetChildren()) do
        child:Destroy()
    end
end

--------------------------------------------------
-- Create Function Button
--------------------------------------------------

local function createFunctionButton(parent, name, order)

    local button = create("TextButton", {
        Name = name:gsub(" ", ""),
        LayoutOrder = order,

        Size = UDim2.new(1, 0, 0, 44),

        BackgroundColor3 = Theme.Colors.PanelLight,
        BorderSizePixel = 0,

        Font = Theme.Fonts.Semibold,
        Text = name,
        TextColor3 = Theme.Colors.Text,
        TextSize = 12,

        AutoButtonColor = false
    }, parent)

    addCorner(
        button,
        Theme.Sizes.SmallCornerRadius
    )

    addStroke(button)

    --------------------------------------------------
    -- Hover
    --------------------------------------------------

    button.MouseEnter:Connect(function()
        Animations:Color(
            button,
            Theme.Colors.PurpleDark,
            Animations.Duration.Fast
        )
    end)

    button.MouseLeave:Connect(function()
        Animations:Color(
            button,
            Theme.Colors.PanelLight,
            Animations.Duration.Fast
        )
    end)

    --------------------------------------------------
    -- Click
    --------------------------------------------------

    button.MouseButton1Click:Connect(function()

        print(
            "[PenyaHubZ] Function selected: " ..
            name
        )

    end)

    return button
end

--------------------------------------------------
-- Mini Games Page
--------------------------------------------------

local function createMiniGamesPage()

    clearContent()

    local title = create("TextLabel", {
        Name = "PageTitle",

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(15, 12),
        Size = UDim2.new(1, -30, 0, 32),

        Font = Theme.Fonts.Bold,
        Text = "MINI GAMES",

        TextColor3 = Theme.Colors.Text,
        TextSize = 21,

        TextXAlignment = Enum.TextXAlignment.Left
    }, content)

    local description = create("TextLabel", {
        Name = "PageDescription",

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(15, 43),
        Size = UDim2.new(1, -30, 0, 25),

        Font = Theme.Fonts.Main,
        Text = "Select a mini game function",

        TextColor3 = Theme.Colors.TextDim,
        TextSize = 12,

        TextXAlignment = Enum.TextXAlignment.Left
    }, content)

    --------------------------------------------------
    -- Scroll
    --------------------------------------------------

    local scroll = create("ScrollingFrame", {
        Name = "FunctionList",

        Position = UDim2.fromOffset(15, 75),
        Size = UDim2.new(1, -30, 1, -90),

        BackgroundTransparency = 1,
        BorderSizePixel = 0,

        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Theme.Colors.PurpleDark,

        CanvasSize = UDim2.new(0, 0, 0, 0),

        AutomaticCanvasSize = Enum.AutomaticSize.Y,

        ScrollingDirection = Enum.ScrollingDirection.Y
    }, content)

    local padding = Instance.new("UIPadding")
    padding.PaddingBottom = UDim.new(0, 5)
    padding.Parent = scroll

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 7)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = scroll

    --------------------------------------------------
    -- Buttons
    --------------------------------------------------

    for index, gameName in ipairs(MINI_GAME_NAMES) do
        createFunctionButton(
            scroll,
            gameName,
            index
        )
    end
end

--------------------------------------------------
-- Default Page
--------------------------------------------------

local function createDefaultPage(tabName)

    clearContent()

    create("TextLabel", {
        Name = "PageTitle",

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(15, 15),
        Size = UDim2.new(1, -30, 0, 40),

        Font = Theme.Fonts.Bold,
        Text = tabName,

        TextColor3 = Theme.Colors.Text,
        TextSize = 22,

        TextXAlignment = Enum.TextXAlignment.Left
    }, content)

    create("TextLabel", {
        Name = "PageDescription",

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(15, 55),
        Size = UDim2.new(1, -30, 0, 30),

        Font = Theme.Fonts.Main,
        Text = "PenyaHubZ • " .. tabName,

        TextColor3 = Theme.Colors.TextDim,
        TextSize = 13,

        TextXAlignment = Enum.TextXAlignment.Left
    }, content)
end

--------------------------------------------------
-- Page Router
--------------------------------------------------

local function setContent(tabName)

    if tabName == "MINI GAMES" then
        createMiniGamesPage()
        return
    end

    createDefaultPage(tabName)
end

--------------------------------------------------
-- Tabs
--------------------------------------------------

local function createTabs()

    for index, tabName in ipairs(TAB_NAMES) do

        local button = create("TextButton", {
            Name = tabName:gsub(" ", ""),

            BackgroundColor3 = Theme.Colors.PanelLight,
            BorderSizePixel = 0,

            Size = UDim2.new(1, -16, 0, 42),

            Position = UDim2.fromOffset(
                8,
                8 + ((index - 1) * 50)
            ),

            Font = Theme.Fonts.Semibold,
            Text = tabName,

            TextColor3 = Theme.Colors.TextDim,
            TextSize = 12,

            AutoButtonColor = false
        }, sidebar)

        addCorner(
            button,
            Theme.Sizes.SmallCornerRadius
        )

        button.MouseEnter:Connect(function()

            if button:GetAttribute("Selected") ~= true then

                Animations:Color(
                    button,
                    Theme.Colors.Panel,
                    Animations.Duration.Fast
                )

            end

        end)

        button.MouseLeave:Connect(function()

            if button:GetAttribute("Selected") ~= true then

                Animations:Color(
                    button,
                    Theme.Colors.PanelLight,
                    Animations.Duration.Fast
                )

            end

        end)

        button.MouseButton1Click:Connect(function()

            for _, other in ipairs(sidebar:GetChildren()) do

                if other:IsA("TextButton") then

                    other:SetAttribute(
                        "Selected",
                        false
                    )

                    Animations:Color(
                        other,
                        Theme.Colors.PanelLight,
                        Animations.Duration.Fast
                    )

                    Animations:TextColor(
                        other,
                        Theme.Colors.TextDim,
                        Animations.Duration.Fast
                    )

                end

            end

            button:SetAttribute(
                "Selected",
                true
            )

            Animations:Color(
                button,
                Theme.Colors.PurpleDark,
                Animations.Duration.Fast
            )

            Animations:TextColor(
                button,
                Theme.Colors.Text,
                Animations.Duration.Fast
            )

            setContent(tabName)

        end)

        if index == 1 then

            button:SetAttribute(
                "Selected",
                true
            )

            button.BackgroundColor3 =
                Theme.Colors.PurpleDark

            button.TextColor3 =
                Theme.Colors.Text

        end

    end
end

--------------------------------------------------
-- Open
--------------------------------------------------

function UI:Open()

    if opened or not mainWindow then
        return
    end

    opened = true

    mainWindow.Visible = true

    Animations:OpenWindow(
        mainWindow,
        UDim2.fromOffset(
            Theme.Sizes.MainWidth,
            Theme.Sizes.MainHeight
        )
    )

end

--------------------------------------------------
-- Close
--------------------------------------------------

function UI:Close()

    if not opened or not mainWindow then
        return
    end

    opened = false

    local tween =
        Animations:CloseWindow(mainWindow)

    if tween then

        tween.Completed:Once(function()

            if not opened then
                mainWindow.Visible = false
            end

        end)

    end

end

--------------------------------------------------
-- Toggle
--------------------------------------------------

function UI:Toggle()

    if opened then
        self:Close()
    else
        self:Open()
    end

end

--------------------------------------------------
-- Create
--------------------------------------------------

function UI:Create()

    local oldGui =
        PlayerGui:FindFirstChild(GUI_NAME)

    if oldGui then
        oldGui:Destroy()
    end

    --------------------------------------------------
    -- ScreenGui
    --------------------------------------------------

    screenGui = create("ScreenGui", {
        Name = GUI_NAME,

        ResetOnSpawn = false,

        ZIndexBehavior =
            Enum.ZIndexBehavior.Sibling
    }, PlayerGui)

    --------------------------------------------------
    -- P Button
    --------------------------------------------------

    openButton = create("TextButton", {

        Name = "OpenButton",

        AnchorPoint =
            Vector2.new(1, 0),

        Position =
            UDim2.new(1, -25, 0, 25),

        Size =
            UDim2.fromOffset(52, 52),

        BackgroundColor3 =
            Theme.Colors.Purple,

        BorderSizePixel = 0,

        Font =
            Theme.Fonts.Black,

        Text = "P",

        TextColor3 =
            Color3.new(1, 1, 1),

        TextSize = 27,

        AutoButtonColor = false

    }, screenGui)

    addCorner(openButton, 15)
    addStroke(openButton)

    openButton.MouseButton1Click:Connect(function()
        self:Toggle()
    end)

    --------------------------------------------------
    -- Main Window
    --------------------------------------------------

    mainWindow = create("Frame", {

        Name = "MainWindow",

        AnchorPoint =
            Vector2.new(0.5, 0.5),

        Position =
            UDim2.fromScale(0.5, 0.5),

        Size =
            UDim2.fromOffset(0, 0),

        BackgroundColor3 =
            Theme.Colors.Background,

        BorderSizePixel = 0,

        Visible = false,

        ClipsDescendants = true

    }, screenGui)

    addCorner(
        mainWindow,
        Theme.Sizes.CornerRadius
    )

    addStroke(mainWindow)

    --------------------------------------------------
    -- Title
    --------------------------------------------------

    create("TextLabel", {

        Name = "Title",

        BackgroundTransparency = 1,

        Position =
            UDim2.fromOffset(18, 12),

        Size =
            UDim2.new(1, -36, 0, 32),

        Font =
            Theme.Fonts.Black,

        Text = "PenyaHubZ",

        TextColor3 =
            Theme.Colors.Text,

        TextSize = 20,

        TextXAlignment =
            Enum.TextXAlignment.Left

    }, mainWindow)

    --------------------------------------------------
    -- Sidebar
    --------------------------------------------------

    sidebar = create("Frame", {

        Name = "Sidebar",

        Position =
            UDim2.fromOffset(12, 55),

        Size =
            UDim2.fromOffset(
                Theme.Sizes.SidebarWidth,
                330
            ),

        BackgroundColor3 =
            Theme.Colors.Panel,

        BorderSizePixel = 0

    }, mainWindow)

    addCorner(sidebar, 12)

    --------------------------------------------------
    -- Content
    --------------------------------------------------

    content = create("Frame", {

        Name = "Content",

        Position =
            UDim2.fromOffset(197, 55),

        Size =
            UDim2.new(
                1,
                -209,
                1,
                -67
            ),

        BackgroundColor3 =
            Theme.Colors.Panel,

        BorderSizePixel = 0,

        ClipsDescendants = true

    }, mainWindow)

    addCorner(content, 12)

    --------------------------------------------------
    -- Build
    --------------------------------------------------

    createTabs()

    setContent(
        TAB_NAMES[1]
    )

end

--------------------------------------------------
-- Init
--------------------------------------------------

function UI:Init(context)

    if not context then

        warn(
            "[PenyaHubZ] UI context is missing."
        )

        return false

    end

    Theme =
        context.Theme

    Animations =
        context.Animations

    if not Theme or not Animations then

        warn(
            "[PenyaHubZ] UI dependencies are missing."
        )

        return false

    end

    self:Create()

    return true
end

return UI
