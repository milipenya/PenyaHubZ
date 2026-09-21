--[[
    PenyaHubZ
    Core/UI.lua

    Базовый интерфейс хаба.
]]

local UI = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local COLORS = {
    Background = Color3.fromRGB(12, 10, 16),
    Panel = Color3.fromRGB(20, 17, 26),
    PanelLight = Color3.fromRGB(30, 25, 38),
    Purple = Color3.fromRGB(135, 65, 220),
    PurpleDark = Color3.fromRGB(82, 38, 140),
    Text = Color3.fromRGB(240, 238, 245),
    TextDim = Color3.fromRGB(150, 145, 160),
    Off = Color3.fromRGB(65, 61, 72)
}

local GUI_NAME = "PenyaHubZ"

local screenGui
local mainWindow
local openButton
local sidebar
local content
local titleLabel

local opened = false

local TAB_NAMES = {
    "CHANGE LOGS",
    "MINI GAMES",
    "GUARD MODE",
    "COMBAT",
    "MISC",
    "SETTINGS"
}

local function create(className, properties, parent)
    local object = Instance.new(className)

    for property, value in pairs(properties) do
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
    stroke.Color = COLORS.PurpleDark
    stroke.Thickness = 1
    stroke.Transparency = 0.25
    stroke.Parent = object

    return stroke
end

local function tween(object, properties, duration)
    local info = TweenInfo.new(
        duration or 0.25,
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    TweenService:Create(object, info, properties):Play()
end

local function setContent(tabName)
    if not content then
        return
    end

    for _, child in ipairs(content:GetChildren()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") then
            child:Destroy()
        end
    end

    local label = create("TextLabel", {
        Name = "PageTitle",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -30, 0, 40),
        Position = UDim2.fromOffset(15, 15),
        Font = Enum.Font.GothamBold,
        Text = tabName,
        TextColor3 = COLORS.Text,
        TextSize = 22,
        TextXAlignment = Enum.TextXAlignment.Left
    }, content)

    local description = create("TextLabel", {
        Name = "PageDescription",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -30, 0, 30),
        Position = UDim2.fromOffset(15, 55),
        Font = Enum.Font.Gotham,
        Text = "PenyaHubZ • " .. tabName,
        TextColor3 = COLORS.TextDim,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    }, content)
end

local function createTabs()
    for index, tabName in ipairs(TAB_NAMES) do
        local button = create("TextButton", {
            Name = tabName:gsub(" ", ""),
            BackgroundColor3 = COLORS.PanelLight,
            BorderSizePixel = 0,
            Size = UDim2.new(1, -16, 0, 42),
            Position = UDim2.fromOffset(8, 8 + ((index - 1) * 50)),
            Font = Enum.Font.GothamSemibold,
            Text = tabName,
            TextColor3 = COLORS.TextDim,
            TextSize = 12,
            AutoButtonColor = false
        }, sidebar)

        addCorner(button, 9)

        button.MouseEnter:Connect(function()
            if button:GetAttribute("Selected") ~= true then
                tween(button, {
                    BackgroundColor3 = COLORS.Panel
                }, 0.15)
            end
        end)

        button.MouseLeave:Connect(function()
            if button:GetAttribute("Selected") ~= true then
                tween(button, {
                    BackgroundColor3 = COLORS.PanelLight
                }, 0.15)
            end
        end)

        button.MouseButton1Click:Connect(function()
            for _, other in ipairs(sidebar:GetChildren()) do
                if other:IsA("TextButton") then
                    other:SetAttribute("Selected", false)

                    tween(other, {
                        BackgroundColor3 = COLORS.PanelLight,
                        TextColor3 = COLORS.TextDim
                    }, 0.15)
                end
            end

            button:SetAttribute("Selected", true)

            tween(button, {
                BackgroundColor3 = COLORS.PurpleDark,
                TextColor3 = COLORS.Text
            }, 0.15)

            setContent(tabName)
        end)

        if index == 1 then
            button:SetAttribute("Selected", true)
            button.BackgroundColor3 = COLORS.PurpleDark
            button.TextColor3 = COLORS.Text
        end
    end
end

function UI:Open()
    if opened then
        return
    end

    opened = true

    if mainWindow then
        mainWindow.Visible = true
        tween(mainWindow, {
            Size = UDim2.fromOffset(620, 400)
        }, 0.35)
    end
end

function UI:Close()
    if not opened then
        return
    end

    opened = false

    if mainWindow then
        tween(mainWindow, {
            Size = UDim2.fromOffset(0, 0)
        }, 0.25)

        task.delay(0.25, function()
            if not opened and mainWindow then
                mainWindow.Visible = false
            end
        end)
    end
end

function UI:Toggle()
    if opened then
        self:Close()
    else
        self:Open()
    end
end

function UI:Create()
    local oldGui = PlayerGui:FindFirstChild(GUI_NAME)

    if oldGui then
        oldGui:Destroy()
    end

    screenGui = create("ScreenGui", {
        Name = GUI_NAME,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }, PlayerGui)

    -- P button
    openButton = create("TextButton", {
        Name = "OpenButton",
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -25, 0, 25),
        Size = UDim2.fromOffset(52, 52),
        BackgroundColor3 = COLORS.Purple,
        BorderSizePixel = 0,
        Font = Enum.Font.GothamBlack,
        Text = "P",
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 27,
        AutoButtonColor = false
    }, screenGui)

    addCorner(openButton, 15)
    addStroke(openButton)

    openButton.MouseButton1Click:Connect(function()
        self:Toggle()
    end)

    -- Main window
    mainWindow = create("Frame", {
        Name = "MainWindow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(0, 0),
        BackgroundColor3 = COLORS.Background,
        BorderSizePixel = 0,
        Visible = false,
        ClipsDescendants = true
    }, screenGui)

    addCorner(mainWindow, 16)
    addStroke(mainWindow)

    -- Title
    titleLabel = create("TextLabel", {
        Name = "Title",
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(18, 12),
        Size = UDim2.new(1, -36, 0, 32),
        Font = Enum.Font.GothamBlack,
        Text = "PenyaHubZ",
        TextColor3 = COLORS.Text,
        TextSize = 20,
        TextXAlignment = Enum.TextXAlignment.Left
    }, mainWindow)

    -- Sidebar
    sidebar = create("Frame", {
        Name = "Sidebar",
        Position = UDim2.fromOffset(12, 55),
        Size = UDim2.fromOffset(175, 330),
        BackgroundColor3 = COLORS.Panel,
        BorderSizePixel = 0
    }, mainWindow)

    addCorner(sidebar, 12)

    -- Content
    content = create("Frame", {
        Name = "Content",
        Position = UDim2.fromOffset(197, 55),
        Size = UDim2.new(1, -209, 1, -67),
        BackgroundColor3 = COLORS.Panel,
        BorderSizePixel = 0
    }, mainWindow)

    addCorner(content, 12)

    createTabs()
    setContent(TAB_NAMES[1])
end

return UI
