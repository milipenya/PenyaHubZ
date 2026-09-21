--[[
    PenyaHubZ
    Modules/Misc/AllFunctions.lua

    Модуль MISC.
]]

local Misc = {}

Misc.Name = "MISC"
Misc.Version = "0.1.0"

--------------------------------------------------
-- Init
--------------------------------------------------

function Misc:Init(context)
    self.Context = context

    print("[PenyaHubZ] Misc initialized.")

    return true
end

--------------------------------------------------
-- Information
--------------------------------------------------

function Misc:GetName()
    return self.Name
end

function Misc:GetVersion()
    return self.Version
end

--------------------------------------------------
-- Destroy
--------------------------------------------------

function Misc:Destroy()
    self.Context = nil

    print("[PenyaHubZ] Misc destroyed.")

    return true
end

return Misc
