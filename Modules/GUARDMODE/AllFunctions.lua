--[[
    PenyaHubZ
    Modules/GuardMode/AllFunctions.lua

    Модуль GUARD MODE.
]]

local GuardMode = {}

GuardMode.Name = "GUARD MODE"
GuardMode.Version = "0.1.0"

--------------------------------------------------
-- Init
--------------------------------------------------

function GuardMode:Init(context)
    self.Context = context

    print("[PenyaHubZ] GuardMode initialized.")

    return true
end

--------------------------------------------------
-- Information
--------------------------------------------------

function GuardMode:GetName()
    return self.Name
end

function GuardMode:GetVersion()
    return self.Version
end

--------------------------------------------------
-- Destroy
--------------------------------------------------

function GuardMode:Destroy()
    self.Context = nil

    print("[PenyaHubZ] GuardMode destroyed.")

    return true
end

return GuardMode
