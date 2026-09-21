--[[
    PenyaHubZ
    Core/Animations.lua

    Центральная система анимаций интерфейса.
]]

local Animations = {}

local TweenService = game:GetService("TweenService")

Animations.Duration = {
    Fast = 0.15,
    Normal = 0.25,
    Slow = 0.35
}

Animations.EasingStyle = Enum.EasingStyle.Quint
Animations.EasingDirection = Enum.EasingDirection.Out

function Animations:Tween(object, properties, duration)
    if not object then
        return nil
    end

    local info = TweenInfo.new(
        duration or self.Duration.Normal,
        self.EasingStyle,
        self.EasingDirection
    )

    local tween = TweenService:Create(
        object,
        info,
        properties
    )

    tween:Play()

    return tween
end

function Animations:OpenWindow(window, size)
    return self:Tween(
        window,
        {
            Size = size
        },
        self.Duration.Slow
    )
end

function Animations:CloseWindow(window)
    return self:Tween(
        window,
        {
            Size = UDim2.fromOffset(0, 0)
        },
        self.Duration.Normal
    )
end

function Animations:Fade(object, transparency, duration)
    return self:Tween(
        object,
        {
            BackgroundTransparency = transparency
        },
        duration or self.Duration.Normal
    )
end

function Animations:Color(object, color, duration)
    return self:Tween(
        object,
        {
            BackgroundColor3 = color
        },
        duration or self.Duration.Fast
    )
end

function Animations:TextColor(object, color, duration)
    return self:Tween(
        object,
        {
            TextColor3 = color
        },
        duration or self.Duration.Fast
    )
end

return Animations
