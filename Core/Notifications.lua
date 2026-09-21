--[[
    PenyaHubZ
    Core/Notifications.lua

    Система уведомлений.
]]

local Notifications = {}

local TweenService = game:GetService("TweenService")

local Theme

local ScreenGui
local Container

--------------------------------------------------
-- Init
--------------------------------------------------

function Notifications:Init(context)

    if context then
        Theme = context.Theme
    end

    if not Theme then
        warn("[PenyaHubZ] Notifications theme is missing.")
        return false
    end

    --------------------------------------------------
    -- Existing GUI
    --------------------------------------------------

    local player =
        game:GetService("Players").LocalPlayer

    local playerGui =
        player:WaitForChild("PlayerGui")

    local oldGui =
        playerGui:FindFirstChild(
            "PenyaHubZ_Notifications"
        )

    if oldGui then
        oldGui:Destroy()
    end

    --------------------------------------------------
    -- ScreenGui
    --------------------------------------------------

    ScreenGui = Instance.new("ScreenGui")

    ScreenGui.Name =
        "PenyaHubZ_Notifications"

    ScreenGui.ResetOnSpawn = false

    ScreenGui.ZIndexBehavior =
        Enum.ZIndexBehavior.Sibling

    ScreenGui.Parent = playerGui

    --------------------------------------------------
    -- Container
    --------------------------------------------------

    Container = Instance.new("Frame")

    Container.Name = "Container"

    Container.AnchorPoint =
        Vector2.new(1, 0)

    Container.Position =
        UDim2.new(1, -20, 0, 20)

    Container.Size =
        UDim2.fromOffset(300, 0)

    Container.AutomaticSize =
        Enum.AutomaticSize.Y

    Container.BackgroundTransparency = 1

    Container.Parent = ScreenGui

    local list =
        Instance.new("UIListLayout")

    list.Padding =
        UDim.new(0, 8)

    list.HorizontalAlignment =
        Enum.HorizontalAlignment.Right

    list.VerticalAlignment =
        Enum.VerticalAlignment.Top

    list.SortOrder =
        Enum.SortOrder.LayoutOrder

    list.Parent = Container

    print("[PenyaHubZ] Notifications initialized.")

    return true
end

--------------------------------------------------
-- Show
--------------------------------------------------

function Notifications:Show(
    title,
    message,
    duration
)

    if not Container then
        warn(
            "[PenyaHubZ] Notifications are not initialized."
        )

        return
    end

    duration = duration or 3

    --------------------------------------------------
    -- Notification
    --------------------------------------------------

    local notification =
        Instance.new("Frame")

    notification.Name =
        "Notification"

    notification.Size =
        UDim2.fromOffset(280, 70)

    notification.BackgroundColor3 =
        Theme.Colors.Panel

    notification.BackgroundTransparency = 1

    notification.BorderSizePixel = 0

    notification.LayoutOrder =
        os.clock() * 1000

    notification.Parent =
        Container

    local corner =
        Instance.new("UICorner")

    corner.CornerRadius =
        UDim.new(
            0,
            Theme.Sizes.SmallCornerRadius
        )

    corner.Parent =
        notification

    --------------------------------------------------
    -- Accent
    --------------------------------------------------

    local accent =
        Instance.new("Frame")

    accent.Name = "Accent"

    accent.Size =
        UDim2.new(0, 4, 1, -16)

    accent.Position =
        UDim2.fromOffset(8, 8)

    accent.BackgroundColor3 =
        Theme.Colors.Purple

    accent.BorderSizePixel = 0

    accent.Parent =
        notification

    local accentCorner =
        Instance.new("UICorner")

    accentCorner.CornerRadius =
        UDim.new(1, 0)

    accentCorner.Parent =
        accent

    --------------------------------------------------
    -- Title
    --------------------------------------------------

    local titleLabel =
        Instance.new("TextLabel")

    titleLabel.Size =
        UDim2.new(1, -35, 0, 24)

    titleLabel.Position =
        UDim2.fromOffset(22, 9)

    titleLabel.BackgroundTransparency = 1

    titleLabel.Text =
        tostring(title or "PenyaHubZ")

    titleLabel.TextColor3 =
        Theme.Colors.Text

    titleLabel.Font =
        Theme.Fonts.Semibold

    titleLabel.TextSize = 14

    titleLabel.TextXAlignment =
        Enum.TextXAlignment.Left

    titleLabel.Parent =
        notification

    --------------------------------------------------
    -- Message
    --------------------------------------------------

    local messageLabel =
        Instance.new("TextLabel")

    messageLabel.Size =
        UDim2.new(1, -35, 0, 28)

    messageLabel.Position =
        UDim2.fromOffset(22, 33)

    messageLabel.BackgroundTransparency = 1

    messageLabel.Text =
        tostring(message or "")

    messageLabel.TextColor3 =
        Theme.Colors.TextDim

    messageLabel.Font =
        Theme.Fonts.Main

    messageLabel.TextSize = 12

    messageLabel.TextWrapped = true

    messageLabel.TextXAlignment =
        Enum.TextXAlignment.Left

    messageLabel.TextYAlignment =
        Enum.TextYAlignment.Top

    messageLabel.Parent =
        notification

    --------------------------------------------------
    -- Fade In
    --------------------------------------------------

    local fadeIn =
        TweenInfo.new(
            0.2,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        )

    TweenService:Create(
        notification,
        fadeIn,
        {
            BackgroundTransparency = 0
        }
    ):Play()

    --------------------------------------------------
    -- Lifetime
    --------------------------------------------------

    task.delay(
        duration,
        function()

            if not notification.Parent then
                return
            end

            local fadeOut =
                TweenInfo.new(
                    0.2,
                    Enum.EasingStyle.Quint,
                    Enum.EasingDirection.In
                )

            local tween =
                TweenService:Create(
                    notification,
                    fadeOut,
                    {
                        BackgroundTransparency = 1
                    }
                )

            tween:Play()

            tween.Completed:Connect(
                function()

                    if notification then
                        notification:Destroy()
                    end

                end
            )

        end
    )

    return notification
end

--------------------------------------------------
-- Destroy
--------------------------------------------------

function Notifications:Destroy()

    if ScreenGui then
        ScreenGui:Destroy()
    end

    ScreenGui = nil
    Container = nil

    print("[PenyaHubZ] Notifications destroyed.")

    return true
end

return Notifications
