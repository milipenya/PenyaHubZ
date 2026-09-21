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
-- Core Dependencies
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
    local object = parent:FindFirstChild(name)

    if not object then
        warn(
            "[PenyaHubZ] Dependency not found: " ..
            tostring(name)
        )

        return nil
    end

    local success, result = pcall(function()
        return require(object)
    end)

    if not success then
        warn(
            "[PenyaHubZ] Failed to load '" ..
            tostring(name) ..
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

    if self.Modules[name] then
        warn(
            "[PenyaHubZ] Module already registered: " ..
            name
        )

        return false
    end

    self.Modules[name] = module

    return ModuleLoader:Register(name, module)
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

    return ModuleLoader:Start(name, self:GetContext())
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
-- Load Game Modules
--------------------------------------------------

local function loadModules(self)
    local rootFolder = script.Parent.Parent
    local modulesFolder = rootFolder:FindFirstChild("Modules")

    if not modulesFolder then
        warn("[PenyaHubZ] Modules folder not found.")
        return false
    end

    local moduleFolders = {
        "ChangeLogs",
        "MiniGames",
        "GuardMode",
        "Combat",
        "Misc",
        "Settings"
    }

    for _, folderName in ipairs(moduleFolders) do
        local folder = modulesFolder:FindFirstChild(folderName)

        if not folder then
            warn(
                "[PenyaHubZ] Module folder not found: " ..
                folderName
            )
            continue
        end

        local moduleScript = folder:FindFirstChild("AllFunctions")

        if not moduleScript then
            warn(
                "[PenyaHubZ] AllFunctions not found in: " ..
                folderName
            )
            continue
        end

        local success, module = pcall(function()
            return require(moduleScript)
        end)

        if not success then
            warn(
                "[PenyaHubZ] Failed to load module '" ..
                folderName ..
                "': " ..
                tostring(module)
            )
            continue
        end

        self:RegisterModule(folderName, module)
    end

    return true
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
    -- Modules
    --------------------------------------------------

    if not loadModules(self) then
        warn("[PenyaHubZ] Module loading failed.")
        return false
    end

    --------------------------------------------------
    -- Start Modules
    --------------------------------------------------

    ModuleLoader:StartAll(self:GetContext())

    --------------------------------------------------
    -- UI
    --------------------------------------------------

    if not UI:Init(self:GetContext()) then
        warn("[PenyaHubZ] UI initialization failed.")
        return false
    end

    print(
        "[PenyaHubZ] Modules loaded: " ..
        tostring(ModuleLoader:GetCount())
    )

    print("[PenyaHubZ] UI loaded.")
    print("[PenyaHubZ] Ready.")

    return true
end

--------------------------------------------------
-- Info
--------------------------------------------------

function PenyaHubZ:GetInfo()

    return {
        Name = self.Name,
        Version = self.Version,
        ModuleCount = ModuleLoader and ModuleLoader:GetCount() or 0
    }
end

--------------------------------------------------
-- Return
--------------------------------------------------

return PenyaHubZ
