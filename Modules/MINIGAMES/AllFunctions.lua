--[[
    PenyaHubZ
    Modules/MiniGames/AllFunctions.lua

    Модуль MINI GAMES.
]]

local MiniGames = {}

MiniGames.Name = "MINI GAMES"
MiniGames.Version = "0.1.0"

--------------------------------------------------
-- Init
--------------------------------------------------

function MiniGames:Init(context)
    self.Context = context

    print("[PenyaHubZ] MiniGames initialized.")

    return true
end

--------------------------------------------------
-- Information
--------------------------------------------------

function MiniGames:GetName()
    return self.Name
end

function MiniGames:GetVersion()
    return self.Version
end

--------------------------------------------------
-- Destroy
--------------------------------------------------

function MiniGames:Destroy()
    self.Context = nil

    print("[PenyaHubZ] MiniGames destroyed.")

    return true
end

return MiniGames
