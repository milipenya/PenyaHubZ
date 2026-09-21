--[[
    PenyaHubZ
    Modules/Combat/AllFunctions.lua

    Модуль COMBAT.
]]

local Combat = {}

Combat.Name = "COMBAT"
Combat.Version = "0.1.0"

--------------------------------------------------
-- Init
--------------------------------------------------

function Combat:Init(context)
    self.Context = context

    print("[PenyaHubZ] Combat initialized.")

    return true
end

--------------------------------------------------
-- Information
--------------------------------------------------

function Combat:GetName()
    return self.Name
end

function Combat:GetVersion()
    return self.Version
end

--------------------------------------------------
-- Destroy
--------------------------------------------------

function Combat:Destroy()
    self.Context = nil

    print("[PenyaHubZ] Combat destroyed.")

    return true
end

return Combat
