--[[
    PenyaHubZ
    Core/Notifications.lua

    Система уведомлений интерфейса.
]]

local Notifications = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local GUI_NAME = "PenyaHubZ_Notifications"

local container

local function createContainer()
    if container then
        return
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = GUI_NAME
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = PlayerGui

    container = Instance.new("Frame")
    container.Name = "Container"
    container.AnchorPoint = Vector2.new(1, 0)
    container.Position = UDim2.new(1, -20, 0, 90)
    container.Size = UDim2.fromOffset(300, 0)
    container.BackgroundTransparency = 1
    container.Parent = screenGui

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = container
end

local function createCorner(object)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = object
end

function Notifications:Init()
    createContainer()
end

function Notifications:Show(title, message, duration)
    createContainer()

    duration = duration or 3

    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = UDim2.fromOffset(280, 70)
    notification.BackgroundColor3 = Color3.fromRGB(20, 17, 26)
    notification.BackgroundTransparency = 0.05
    notification.BorderSizePixel = 0
    notification.LayoutOrder = os.clock()
    notification.Parent = container

    createCorner(notification)

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(82, 38, 140)
    stroke.Thickness = 1
    stroke.Transparency = 0.2
    stroke.Parent = notification

    local titleLabel = Instance.new("TextLabel")
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.fromOffset(12, 8)
    titleLabel.Size = UDim2.new(1, -24, 0, 22)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = tostring(title or "PenyaHubZ")
    titleLabel.TextColor3 = Color3.fromRGB(240, 238, 245)
    titleLabel.TextSize = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = notification

    local messageLabel = Instance.new("TextLabel")
    messageLabel.BackgroundTransparency = 1
    messageLabel.Position = UDim2.fromOffset(12, 31)
    messageLabel.Size = UDim2.new(1, -24, 0, 28)
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.Text = tostring(message or "")
    messageLabel.TextColor3 = Color3.fromRGB(150, 145, 160)
    messageLabel.TextSize = 12
    messageLabel.TextWrapped = true
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.Parent = notification

    notification.Position = UDim2.fromOffset(320, 0)

    local showTween = TweenService:Create(
        notification,
        TweenInfo.new(
            0.3,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        {
            Position = UDim2.fromOffset(0, 0)
        }
    )

    showTween:Play()

    task.delay(duration, function()
        if not notification or not notification.Parent then
            return
        end

        local hideTween = TweenService:Create(
            notification,
            TweenInfo.new(
                0.25,
                Enum.EasingStyle.Quint,
                Enum.EasingDirection.In
            ),
            {
                Position = UDim2.fromOffset(320, 0),
                BackgroundTransparency = 1
            }
        )

        hideTween:Play()

        task.wait(0.25)

        if notification then
            notification:Destroy()
        end
    end)
end

return Notifications
