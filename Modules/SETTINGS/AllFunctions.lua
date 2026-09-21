--[[
    PenyaHubZ
    Modules/Settings/AllFunctions.lua

    Модуль SETTINGS.
]]

local Settings = {}

Settings.Name = "SETTINGS"
Settings.Version = "0.1.0"

--------------------------------------------------
-- Init
--------------------------------------------------

function Settings:Init(context)
    self.Context = context

    print("[PenyaHubZ] Settings initialized.")

    return true
end

--------------------------------------------------
-- Information
--------------------------------------------------

function Settings:GetName()
    return self.Name
end

function Settings:GetVersion()
    return self.Version
end

--------------------------------------------------
-- Destroy
--------------------------------------------------

function Settings:Destroy()
    self.Context = nil

    print("[PenyaHubZ] Settings destroyed.")

    return true
end

return Settings
