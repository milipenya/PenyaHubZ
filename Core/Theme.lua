--[[
    PenyaHubZ
    Core/Theme.lua

    Центральная система цветов и визуальных параметров.
]]

local Theme = {}

Theme.Colors = {
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

Theme.Sizes = {
    MainWidth = 620,
    MainHeight = 400,

    SidebarWidth = 175,

    CornerRadius = 16,
    SmallCornerRadius = 9
}

Theme.Fonts = {
    Main = Enum.Font.Gotham,
    Medium = Enum.Font.GothamMedium,
    Semibold = Enum.Font.GothamSemibold,
    Bold = Enum.Font.GothamBold,
    Black = Enum.Font.GothamBlack
}

return Theme
