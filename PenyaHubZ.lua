--// PenyaHubZ
--// Single-file UI version
--// UI/controller only

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- CONFIG
--==================================================

local VERSION = "0.1.0"

local THEME = {
    Background = Color3.fromRGB(12, 10, 16),
    Panel = Color3.fromRGB(20, 17, 26),
    PanelLight = Color3.fromRGB(30, 25, 38),
    Purple = Color3.fromRGB(135, 65, 220),
    PurpleDark = Color3.fromRGB(82, 38, 140),
    Text = Color3.fromRGB(240, 238, 245),
    TextDim = Color3.fromRGB(150, 145, 160),
    Off = Color3.fromRGB(65, 61, 72),
    On = Color3.fromRGB(135, 65, 220)
}

local MAIN_SIZE = UDim2.fromOffset(620, 400)

local TWEEN_FAST = TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local TWEEN_NORMAL = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local TWEEN_SLOW = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

--==================================================
-- DATA
--==================================================

local TABS = {
    "CHANGE LOGS",
    "MINI GAMES",
    "GUARD MODE",
    "COMBAT",
    "MISC",
    "SETTINGS"
}

local MINI_GAMES = {
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

local GUARD_MODE = {
    "AUTO QTE",
    "INFINITE AMMO",
    "NO RECOIL",
    "AIM",
    "AUTO BLUE BUTTON",
    "BOXING DUMMY"
}

local COMBAT = {
    "CAMLOCK",
    "ANTI SLOW",
    "ANTI-KILLING"
}

local MISC = {
    "AUTO QTE EVENT",
    "PEABERTS ESP",
    "INFINITY JUMP",
    "INSTANT INTERACT",
    "ANTI PUSH / RAGDOLL",
    "TELEPORT",
    "ADMIN ABUSE TOOLS"
}

local SETTINGS = {
    "CONFIGS",
    "GAME VERSION / JOB ID",
    "VERSION CHECK"
}

local states = {}

--==================================================
-- CLEAN OLD UI
--==================================================

local oldGui = PlayerGui:FindFirstChild("PenyaHubZ")
if oldGui then
    oldGui:Destroy()
end

--==================================================
-- HELPERS
--==================================================

local function create(className, properties, parent)
    local object = Instance.new(className)

    for property, value in pairs(properties or {}) do
        object[property] = value
    end

    if parent then
        object.Parent = parent
    end

    return object
end

local function addCorner(object, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = object
    return corner
end

local function tween(object, properties, info)
    if object and object.Parent then
        local t = TweenService:Create(object, info or TWEEN_NORMAL, properties)
        t:Play()
        return t
    end
end

--==================================================
-- SCREEN GUI
--==================================================

local ScreenGui = create("ScreenGui", {
    Name = "PenyaHubZ",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 100
}, PlayerGui)

--==================================================
-- OPEN BUTTON
--==================================================

local OpenButton = create("TextButton", {
    Name = "OpenButton",
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -20, 0, 20),
    Size = UDim2.fromOffset(48, 48),
    BackgroundColor3 = THEME.Panel,
    BorderSizePixel = 0,
    Text = "P",
    TextColor3 = THEME.Text,
    TextSize = 20,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false
}, ScreenGui)

addCorner(OpenButton, 13)

local openStroke = create("UIStroke", {
    Color = THEME.Purple,
    Thickness = 1.5,
    Transparency = 0.25
}, OpenButton)

--==================================================
-- MAIN WINDOW
--==================================================

local MainWindow = create("Frame", {
    Name = "MainWindow",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(0, 0),
    BackgroundColor3 = THEME.Background,
    BorderSizePixel = 0,
    Visible = false
}, ScreenGui)

addCorner(MainWindow, 16)

create("UIStroke", {
    Color = THEME.PurpleDark,
    Thickness = 1,
    Transparency = 0.2
}, MainWindow)

--==================================================
-- TOP BAR
--==================================================

local TopBar = create("Frame", {
    Name = "TopBar",
    Size = UDim2.new(1, 0, 0, 54),
    BackgroundColor3 = THEME.Panel,
    BorderSizePixel = 0
}, MainWindow)

addCorner(TopBar, 16)

local Title = create("TextLabel", {
    Name = "Title",
    Position = UDim2.fromOffset(20, 9),
    Size = UDim2.fromOffset(250, 22),
    BackgroundTransparency = 1,
    Text = "PenyaHubZ",
    TextColor3 = THEME.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 18,
    TextXAlignment = Enum.TextXAlignment.Left
}, TopBar)

local Version = create("TextLabel", {
    Name = "Version",
    Position = UDim2.fromOffset(20, 31),
    Size = UDim2.fromOffset(250, 16),
    BackgroundTransparency = 1,
    Text = "Version " .. VERSION,
    TextColor3 = THEME.TextDim,
    Font = Enum.Font.Gotham,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left
}, TopBar)

local CloseButton = create("TextButton", {
    Name = "CloseButton",
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -14, 0.5, 0),
    Size = UDim2.fromOffset(32, 32),
    BackgroundColor3 = THEME.PanelLight,
    BorderSizePixel = 0,
    Text = "×",
    TextColor3 = THEME.TextDim,
    Font = Enum.Font.GothamMedium,
    TextSize = 22,
    AutoButtonColor = false
}, TopBar)

addCorner(CloseButton, 9)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = create("Frame", {
    Name = "Sidebar",
    Position = UDim2.fromOffset(12, 66),
    Size = UDim2.new(0, 175, 1, -78),
    BackgroundColor3 = THEME.Panel,
    BorderSizePixel = 0
}, MainWindow)

addCorner(Sidebar, 12)

local TabList = create("Frame", {
    Name = "TabList",
    Position = UDim2.fromOffset(8, 10),
    Size = UDim2.new(1, -16, 1, -20),
    BackgroundTransparency = 1
}, Sidebar)

create("UIListLayout", {
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder
}, TabList)

--==================================================
-- CONTENT
--==================================================

local Content = create("Frame", {
    Name = "Content",
    Position = UDim2.fromOffset(199, 66),
    Size = UDim2.new(1, -211, 1, -78),
    BackgroundColor3 = THEME.Panel,
    BorderSizePixel = 0
}, MainWindow)

addCorner(Content, 12)

local ContentTitle = create("TextLabel", {
    Name = "ContentTitle",
    Position = UDim2.fromOffset(18, 12),
    Size = UDim2.new(1, -36, 0, 28),
    BackgroundTransparency = 1,
    Text = "MINI GAMES",
    TextColor3 = THEME.Text,
    Font = Enum.Font.GothamSemibold,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left
}, Content)

local Scroll = create("ScrollingFrame", {
    Name = "Functions",
    Position = UDim2.fromOffset(12, 48),
    Size = UDim2.new(1, -24, 1, -60),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = THEME.PurpleDark,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y
}, Content)

create("UIPadding", {
    PaddingLeft = UDim.new(0, 4),
    PaddingRight = UDim.new(0, 4),
    PaddingBottom = UDim.new(0, 6)
}, Scroll)

local FunctionLayout = create("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder
}, Scroll)

--==================================================
-- NOTIFICATION
--==================================================

local NotificationContainer = create("Frame", {
    Name = "Notifications",
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -20, 0, 78),
    Size = UDim2.fromOffset(280, 0),
    AutomaticSize = Enum.AutomaticSize.Y,
    BackgroundTransparency = 1
}, ScreenGui)

create("UIListLayout", {
    Padding = UDim.new(0, 7),
    HorizontalAlignment = Enum.HorizontalAlignment.Right,
    VerticalAlignment = Enum.VerticalAlignment.Top,
    SortOrder = Enum.SortOrder.LayoutOrder
}, NotificationContainer)

local function notify(title, message)
    local notification = create("Frame", {
        Size = UDim2.fromOffset(270, 62),
        BackgroundColor3 = THEME.Panel,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }, NotificationContainer)

    addCorner(notification, 10)

    create("Frame", {
        Position = UDim2.fromOffset(7, 8),
        Size = UDim2.new(0, 3, 1, -16),
        BackgroundColor3 = THEME.Purple,
        BorderSizePixel = 0
    }, notification)

    create("TextLabel", {
        Position = UDim2.fromOffset(20, 7),
        Size = UDim2.new(1, -28, 0, 20),
        BackgroundTransparency = 1,
        Text = tostring(title),
        TextColor3 = THEME.Text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    }, notification)

    create("TextLabel", {
        Position = UDim2.fromOffset(20, 27),
        Size = UDim2.new(1, -28, 0, 27),
        BackgroundTransparency = 1,
        Text = tostring(message),
        TextColor3 = THEME.TextDim,
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left
    }, notification)

    tween(notification, {BackgroundTransparency = 0}, TWEEN_NORMAL)

    task.delay(2.5, function()
        if notification.Parent then
            local out = tween(notification, {BackgroundTransparency = 1}, TWEEN_NORMAL)
            if out then
                out.Completed:Wait()
            end
            if notification then
                notification:Destroy()
            end
        end
    end)
end

--==================================================
-- TOGGLE
--==================================================

local function createToggle(parent, defaultState, callback)
    local state = defaultState == true

    local container = create("Frame", {
        Size = UDim2.fromOffset(52, 26),
        BackgroundColor3 = state and THEME.On or THEME.Off,
        BorderSizePixel = 0
    }, parent)

    addCorner(container, 13)

    local knob = create("Frame", {
        Size = UDim2.fromOffset(20, 20),
        Position = state
            and UDim2.new(1, -23, 0.5, -10)
            or UDim2.fromOffset(3, 3),
        BackgroundColor3 = THEME.Text,
        BorderSizePixel = 0
    }, container)

    addCorner(knob, 10)

    local button = create("TextButton", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false
    }, container)

    local function setState(value)
        state = value == true

        tween(
            container,
            {BackgroundColor3 = state and THEME.On or THEME.Off},
            TWEEN_FAST
        )

        tween(
            knob,
            {
                Position = state
                    and UDim2.new(1, -23, 0.5, -10)
                    or UDim2.fromOffset(3, 3)
            },
            TWEEN_FAST
        )

        if callback then
            callback(state)
        end
    end

    button.MouseButton1Click:Connect(function()
        setState(not state)
    end)

    return {
        Set = setState,
        Get = function()
            return state
        end
    }
end

--==================================================
-- FUNCTION ROW
--==================================================

local function clearFunctions()
    for _, child in ipairs(Scroll:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextLabel") then
            child:Destroy()
        end
    end
end

local function createFunctionRow(name, index)
    states[name] = states[name] or false

    local row = create("Frame", {
        Name = "Function_" .. tostring(index),
        Size = UDim2.new(1, 0, 0, 48),
        BackgroundColor3 = THEME.PanelLight,
        BorderSizePixel = 0,
        LayoutOrder = index
    }, Scroll)

    addCorner(row, 9)

    local label = create("TextLabel", {
        Position = UDim2.fromOffset(14, 0),
        Size = UDim2.new(1, -84, 1, 0),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = THEME.Text,
        Font = Enum.Font.GothamMedium,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    }, row)

    local toggleHolder = create("Frame", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.fromOffset(52, 26),
        BackgroundTransparency = 1
    }, row)

    local toggle = createToggle(toggleHolder, states[name], function(value)
        states[name] = value

        if value then
            notify(name, "Enabled")
        else
            notify(name, "Disabled")
        end
    end)

    local hover = create("TextButton", {
        Size = UDim2.new(1, -68, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false
    }, row)

    hover.MouseEnter:Connect(function()
        tween(row, {BackgroundColor3 = THEME.PurpleDark}, TWEEN_FAST)
    end)

    hover.MouseLeave:Connect(function()
        tween(row, {BackgroundColor3 = THEME.PanelLight}, TWEEN_FAST)
    end)

    return toggle
end

--==================================================
-- PLACEHOLDER / INFO
--==================================================

local function createInfo(text)
    local label = create("TextLabel", {
        Size = UDim2.new(1, -8, 0, 70),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = THEME.TextDim,
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top
    }, Scroll)

    return label
end

--==================================================
-- TAB CONTENT
--==================================================

local function getTabFunctions(tab)
    if tab == "MINI GAMES" then
        return MINI_GAMES
    elseif tab == "GUARD MODE" then
        return GUARD_MODE
    elseif tab == "COMBAT" then
        return COMBAT
    elseif tab == "MISC" then
        return MISC
    elseif tab == "SETTINGS" then
        return SETTINGS
    end

    return nil
end

local function renderTab(tab)
    ContentTitle.Text = tab
    clearFunctions()

    local functions = getTabFunctions(tab)

    if functions then
        for index, name in ipairs(functions) do
            createFunctionRow(name, index)
        end
    elseif tab == "CHANGE LOGS" then
        createInfo(
            "PenyaHubZ\n\n" ..
            "Version: " .. VERSION .. "\n" ..
            "Single-file UI build.\n\n" ..
            "Current build contains the interface and controller states. " ..
            "Gameplay functions are not connected yet."
        )
    end
end

--==================================================
-- TABS
--==================================================

local tabButtons = {}

local function selectTab(tab)
    for name, button in pairs(tabButtons) do
        local selected = name == tab

        tween(
            button,
            {
                BackgroundColor3 = selected
                    and THEME.PurpleDark
                    or THEME.Panel
            },
            TWEEN_FAST
        )

        local text = button:FindFirstChild("TextLabel")
        if text then
            tween(
                text,
                {
                    TextColor3 = selected
                        and THEME.Text
                        or THEME.TextDim
                },
                TWEEN_FAST
            )
        end
    end

    renderTab(tab)
end

for index, tab in ipairs(TABS) do
    local button = create("TextButton", {
        Name = "Tab_" .. tostring(index),
        Size = UDim2.new(1, 0, 0, 43),
        BackgroundColor3 = THEME.Panel,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = index
    }, TabList)

    addCorner(button, 9)

    local text = create("TextLabel", {
        Name = "TextLabel",
        Position = UDim2.fromOffset(12, 0),
        Size = UDim2.new(1, -24, 1, 0),
        BackgroundTransparency = 1,
        Text = tab,
        TextColor3 = THEME.TextDim,
        Font = Enum.Font.GothamMedium,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left
    }, button)

    tabButtons[tab] = button

    button.MouseEnter:Connect(function()
        if ContentTitle.Text ~= tab then
            tween(button, {BackgroundColor3 = THEME.PanelLight}, TWEEN_FAST)
        end
    end)

    button.MouseLeave:Connect(function()
        if ContentTitle.Text ~= tab then
            tween(button, {BackgroundColor3 = THEME.Panel}, TWEEN_FAST)
        end
    end)

    button.MouseButton1Click:Connect(function()
        selectTab(tab)
    end)
end

--==================================================
-- OPEN / CLOSE
--==================================================

local isOpen = false
local isAnimating = false

local function openMenu()
    if isOpen or isAnimating then
        return
    end

    isOpen = true
    isAnimating = true
    MainWindow.Visible = true
    MainWindow.Size = UDim2.fromOffset(0, 0)

    tween(OpenButton, {BackgroundColor3 = THEME.PurpleDark}, TWEEN_FAST)

    local animation = tween(MainWindow, {Size = MAIN_SIZE}, TWEEN_SLOW)

    if animation then
        animation.Completed:Wait()
    end

    isAnimating = false
end

local function closeMenu()
    if not isOpen or isAnimating then
        return
    end

    isOpen = false
    isAnimating = true

    tween(OpenButton, {BackgroundColor3 = THEME.Panel}, TWEEN_FAST)

    local animation = tween(
        MainWindow,
        {Size = UDim2.fromOffset(0, 0)},
        TWEEN_NORMAL
    )

    if animation then
        animation.Completed:Wait()
    end

    MainWindow.Visible = false
    isAnimating = false
end

OpenButton.MouseEnter:Connect(function()
    tween(OpenButton, {
        BackgroundColor3 = THEME.PanelLight
    }, TWEEN_FAST)
end)

OpenButton.MouseLeave:Connect(function()
    tween(OpenButton, {
        BackgroundColor3 = isOpen
            and THEME.PurpleDark
            or THEME.Panel
    }, TWEEN_FAST)
end)

OpenButton.MouseButton1Click:Connect(function()
    if isOpen then
        closeMenu()
    else
        openMenu()
    end
end)

CloseButton.MouseEnter:Connect(function()
    tween(CloseButton, {
        BackgroundColor3 = THEME.PurpleDark,
        TextColor3 = THEME.Text
    }, TWEEN_FAST)
end)

CloseButton.MouseLeave:Connect(function()
    tween(CloseButton, {
        BackgroundColor3 = THEME.PanelLight,
        TextColor3 = THEME.TextDim
    }, TWEEN_FAST)
end)

CloseButton.MouseButton1Click:Connect(closeMenu)

--==================================================
-- INITIAL STATE
--==================================================

selectTab("CHANGE LOGS")

print("[PenyaHubZ] Loaded successfully.")
print("[PenyaHubZ] Version: " .. VERSION)
print("[PenyaHubZ] UI ready.")
