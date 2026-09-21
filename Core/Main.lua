--[[
    PenyaHubZ
    Core/Main.lua

    Главная точка запуска.
]]

local PenyaHubZ = {}

PenyaHubZ.Name = "PenyaHubZ"
PenyaHubZ.Version = "0.1.0"

PenyaHubZ.Modules = {}

--------------------------------------------------
-- Dependencies
--------------------------------------------------

local Theme
local Animations
local Notifications
local UI
local ModuleLoader

--------------------------------------------------
-- Load Dependency
--------------------------------------------------

local function loadDependency(parent, name)
    local success, result = pcall(function()
        return require(parent:WaitForChild(name))
    end)

    if not success then
        warn(
            "[PenyaHubZ] Failed to load '" ..
            name ..
            "': " ..
            tostring(result)
        )

        return nil
    end

    return result
end

--------------------------------------------------
-- Load Core
--------------------------------------------------

local function loadCore()
    local coreFolder = script.Parent

    Theme = loadDependency(coreFolder, "Theme")

    if not Theme then
        return false
    end

    Animations = loadDependency(coreFolder, "Animations")

    if not Animations then
        return false
    end

    Notifications = loadDependency(coreFolder, "Notifications")

    if not Notifications then
        return false
    end

    ModuleLoader = loadDependency(coreFolder, "ModuleLoader")

    if not ModuleLoader then
        return false
    end

    UI = loadDependency(coreFolder, "UI")

    if not UI then
        return false
    end

    return true
end

--------------------------------------------------
-- Register Module
--------------------------------------------------

function PenyaHubZ:RegisterModule(name, module)
    if type(name) ~= "string" then
        warn("[PenyaHubZ] Invalid module name.")
        return false
    end

    if type(module) ~= "table" then
        warn(
            "[PenyaHubZ] Module '" ..
            name ..
            "' must return a table."
        )

        return false
    end

    self.Modules[name] = module

    if ModuleLoader then
        ModuleLoader:Register(name, module)
    end

    return true
end

--------------------------------------------------
-- Get Module
--------------------------------------------------

function PenyaHubZ:GetModule(name)
    return self.Modules[name]
end

--------------------------------------------------
-- Start Module
--------------------------------------------------

function PenyaHubZ:StartModule(name)
    if not ModuleLoader then
        return false
    end

    return ModuleLoader:Start(name, self)
end

--------------------------------------------------
-- Stop Module
--------------------------------------------------

function PenyaHubZ:StopModule(name)
    if not ModuleLoader then
        return false
    end

    return ModuleLoader:Stop(name)
end

--------------------------------------------------
-- Context
--------------------------------------------------

function PenyaHubZ:GetContext()
    return {
        Hub = self,

        Theme = Theme,
        Animations = Animations,
        Notifications = Notifications,

        ModuleLoader = ModuleLoader
    }
end

--------------------------------------------------
-- Start
--------------------------------------------------

function PenyaHubZ:Start()

    print("[PenyaHubZ] Starting...")
    print("[PenyaHubZ] Version: " .. self.Version)

    --------------------------------------------------
    -- Core
    --------------------------------------------------

    if not loadCore() then
        warn("[PenyaHubZ] Core loading failed.")
        return false
    end

    --------------------------------------------------
    -- Notifications
    --------------------------------------------------

    Notifications:Init()

    --------------------------------------------------
    -- UI
    --------------------------------------------------

    local context = self:GetContext()

    if not UI:Init(context) then
        warn("[PenyaHubZ] UI initialization failed.")
        return false
    end

    print("[PenyaHubZ] UI loaded.")
    print("[PenyaHubZ] Ready.")

    return true
end

--------------------------------------------------
-- Info
--------------------------------------------------

function PenyaHubZ:GetInfo()

    local count = 0

    for _ in pairs(self.Modules) do
        count += 1
    end

    return {
        Name = self.Name,
        Version = self.Version,
        ModuleCount = count
    }
end

--------------------------------------------------
-- Return
--------------------------------------------------

return PenyaHubZ
