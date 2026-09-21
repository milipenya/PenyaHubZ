--[[
    PenyaHubZ
    Core/Toggle.lua

    Переиспользуемый компонент переключателя ON/OFF.
]]

local Toggle = {}

local Theme
local Animations

--------------------------------------------------
-- Init
--------------------------------------------------

function Toggle:Init(context)
    if not context then
        warn("[PenyaHubZ] Toggle context is missing.")
        return false
    end

    Theme = context.Theme
    Animations = context.Animations

    if not Theme or not Animations then
        warn("[PenyaHubZ] Toggle dependencies are missing.")
        return false
    end

    return true
end

--------------------------------------------------
-- Create
--------------------------------------------------

function Toggle:Create(parent, position, defaultState, callback)

    local state = defaultState == true

    local container = Instance.new("Frame")
    container.Name = "Toggle"
    container.Position = position or UDim2.fromOffset(0, 0)
    container.Size = UDim2.fromOffset(52, 26)
    container.BackgroundColor3 = state
        and Theme.Colors.On
        or Theme.Colors.Off
    container.BorderSizePixel = 0
    container.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = container

    local knob = Instance.new("Frame")
    knob.Name = "Knob"
    knob.Size = UDim2.fromOffset(20, 20)
    knob.Position = state
        and UDim2.new(1, -23, 0.5, -10)
        or UDim2.fromOffset(3, 3)
    knob.BackgroundColor3 = Theme.Colors.Text
    knob.BorderSizePixel = 0
    knob.Parent = container

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    local button = Instance.new("TextButton")
    button.Name = "Button"
    button.Size = UDim2.fromScale(1, 1)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.AutoButtonColor = false
    button.Parent = container

    local function setState(newState, instant)

        state = newState == true

        local targetColor = state
            and Theme.Colors.On
            or Theme.Colors.Off

        local targetPosition = state
            and UDim2.new(1, -23, 0.5, -10)
            or UDim2.fromOffset(3, 3)

        if instant then
            container.BackgroundColor3 = targetColor
            knob.Position = targetPosition
        else
            Animations:Color(
                container,
                targetColor,
                Animations.Duration.Fast
            )

            Animations:Tween(
                knob,
                {
                    Position = targetPosition
                },
                Animations.Duration.Fast
            )
        end

        if callback then
            callback(state)
        end
    end

    button.MouseButton1Click:Connect(function()
        setState(not state)
    end)

    local object = {}

    function object:Set(value)
        setState(value)
    end

    function object:Get()
        return state
    end

    function object:Toggle()
        setState(not state)
    end

    function object:GetGui()
        return container
    end

    return object
end

return Toggle
