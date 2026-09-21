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
-- Module System
--------------------------------------------------

function PenyaHubZ:RegisterModule(name, module)
    if type(name) ~= "string" then
        warn("[PenyaHubZ] Invalid module name.")
        return false
    end

    if type(module) ~= "table" then
        warn("[PenyaHubZ] Module '" .. name .. "' must return a table.")
        return false
    end

    self.Modules[name] = module

    return true
end

function PenyaHubZ:GetModule(name)
    return self.Modules[name]
end

function PenyaHubZ:StartModule(name)
    local module = self:GetModule(name)

    if not module then
        warn("[PenyaHubZ] Module not found: " .. tostring(name))
        return false
    end

    if type(module.Init) == "function" then
        local success, result = pcall(function()
            module:Init(self)
        end)

        if not success then
            warn(
                "[PenyaHubZ] Failed to initialize '" ..
                name ..
                "': " ..
                tostring(result)
            )

            return false
        end
    end

    return true
end

function PenyaHubZ:StopModule(name)
    local module = self:GetModule(name)

    if not module then
        return false
    end

    if type(module.Destroy) == "function" then
        local success, result = pcall(function()
            module:Destroy()
        end)

        if not success then
            warn(
                "[PenyaHubZ] Failed to destroy '" ..
                name ..
                "': " ..
                tostring(result)
            )

            return false
        end
    end

    return true
end

--------------------------------------------------
-- Load Core UI
--------------------------------------------------

local UI = nil

local function loadUI()
    local success, result = pcall(function()
        return require(script.Parent.UI)
    end)

    if not success then
        warn("[PenyaHubZ] Failed to load UI: " .. tostring(result))
        return false
    end

    UI = result

    return true
end

--------------------------------------------------
-- Start
--------------------------------------------------

function PenyaHubZ:Start()
    print("[PenyaHubZ] Starting...")
    print("[PenyaHubZ] Version: " .. self.Version)

    if not loadUI() then
        warn("[PenyaHubZ] Startup aborted.")
        return false
    end

    UI:Create()

    print("[PenyaHubZ] UI loaded.")
    print("[PenyaHubZ] Ready.")

    return true
end

--------------------------------------------------
-- Public API
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
