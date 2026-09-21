--[[
    PenyaHubZ
    Modules/MiniGames/AllFunctions.lua

    Контроллер Mini Games.
    Здесь хранится состояние функций и API для UI.
]]

local MiniGames = {}

MiniGames.Name = "MINI GAMES"
MiniGames.Version = "0.1.0"

--------------------------------------------------
-- Function List
--------------------------------------------------

MiniGames.Functions = {
    ["RED LIGHT GREEN LIGHT"] = false,
    ["DALGONA"] = false,
    ["PENTATHLON"] = false,
    ["LIGHTS OUT"] = false,
    ["HIDE AND SEEK"] = false,
    ["TUG OF WAR"] = false,
    ["GLASS BRIDGE"] = false,
    ["JUMP ROPE"] = false,
    ["MINGLE"] = false,
    ["LAST DINNER"] = false,
    ["SQUID GAME"] = false,
    ["SKY SQUID GAME"] = false,
    ["REBEL"] = false
}

--------------------------------------------------
-- Context
--------------------------------------------------

function MiniGames:Init(context)

    self.Context = context

    print(
        "[PenyaHubZ] MiniGames initialized."
    )

    return true
end

--------------------------------------------------
-- Enable
--------------------------------------------------

function MiniGames:Enable(name)

    if self.Functions[name] == nil then

        warn(
            "[PenyaHubZ] MiniGame function not found: " ..
            tostring(name)
        )

        return false
    end

    self.Functions[name] = true

    print(
        "[PenyaHubZ] MiniGame enabled: " ..
        name
    )

    return true
end

--------------------------------------------------
-- Disable
--------------------------------------------------

function MiniGames:Disable(name)

    if self.Functions[name] == nil then

        warn(
            "[PenyaHubZ] MiniGame function not found: " ..
            tostring(name)
        )

        return false
    end

    self.Functions[name] = false

    print(
        "[PenyaHubZ] MiniGame disabled: " ..
        name
    )

    return true
end

--------------------------------------------------
-- Toggle
--------------------------------------------------

function MiniGames:Toggle(name)

    if self.Functions[name] == nil then

        warn(
            "[PenyaHubZ] MiniGame function not found: " ..
            tostring(name)
        )

        return false
    end

    if self.Functions[name] then
        return self:Disable(name)
    end

    return self:Enable(name)
end

--------------------------------------------------
-- Get State
--------------------------------------------------

function MiniGames:IsEnabled(name)

    if self.Functions[name] == nil then
        return false
    end

    return self.Functions[name] == true
end

--------------------------------------------------
-- Get All States
--------------------------------------------------

function MiniGames:GetStates()

    local states = {}

    for name, enabled in pairs(
        self.Functions
    ) do

        states[name] = enabled

    end

    return states
end

--------------------------------------------------
-- Destroy
--------------------------------------------------

function MiniGames:Destroy()

    for name in pairs(
        self.Functions
    ) do

        self.Functions[name] = false

    end

    self.Context = nil

    print(
        "[PenyaHubZ] MiniGames destroyed."
    )

    return true
end

return MiniGames
