--[[
    PenyaHubZ
    Modules/ChangeLogs/AllFunctions.lua

    Модуль CHANGE LOGS.
]]

local ChangeLogs = {}

ChangeLogs.Name = "CHANGE LOGS"
ChangeLogs.Version = "0.1.0"

--------------------------------------------------
-- Init
--------------------------------------------------

function ChangeLogs:Init(context)
    self.Context = context

    print("[PenyaHubZ] ChangeLogs initialized.")

    return true
end

--------------------------------------------------
-- Information
--------------------------------------------------

function ChangeLogs:GetVersion()
    return self.Version
end

function ChangeLogs:GetName()
    return self.Name
end

--------------------------------------------------
-- Destroy
--------------------------------------------------

function ChangeLogs:Destroy()
    self.Context = nil

    print("[PenyaHubZ] ChangeLogs destroyed.")

    return true
end

return ChangeLogs
