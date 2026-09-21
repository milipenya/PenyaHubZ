--[[
    PenyaHubZ
    Core/ModuleLoader.lua

    Система регистрации и управления модулями.
]]

local ModuleLoader = {}

ModuleLoader.Modules = {}
ModuleLoader.Started = {}

--------------------------------------------------
-- Register
--------------------------------------------------

function ModuleLoader:Register(name, module)
    if type(name) ~= "string" then
        warn("[PenyaHubZ] Module name must be a string.")
        return false
    end

    if type(module) ~= "table" then
        warn("[PenyaHubZ] Module '" .. name .. "' must return a table.")
        return false
    end

    if self.Modules[name] then
        warn("[PenyaHubZ] Module already registered: " .. name)
        return false
    end

    self.Modules[name] = module

    return true
end

--------------------------------------------------
-- Get
--------------------------------------------------

function ModuleLoader:Get(name)
    return self.Modules[name]
end

--------------------------------------------------
-- Start
--------------------------------------------------

function ModuleLoader:Start(name, context)
    local module = self:Get(name)

    if not module then
        warn("[PenyaHubZ] Module not found: " .. tostring(name))
        return false
    end

    if self.Started[name] then
        return true
    end

    if type(module.Init) == "function" then
        local success, result = pcall(function()
            module:Init(context)
        end)

        if not success then
            warn(
                "[PenyaHubZ] Failed to start '" ..
                name ..
                "': " ..
                tostring(result)
            )

            return false
        end
    end

    self.Started[name] = true

    return true
end

--------------------------------------------------
-- Stop
--------------------------------------------------

function ModuleLoader:Stop(name)
    local module = self:Get(name)

    if not module then
        return false
    end

    if not self.Started[name] then
        return true
    end

    if type(module.Destroy) == "function" then
        local success, result = pcall(function()
            module:Destroy()
        end)

        if not success then
            warn(
                "[PenyaHubZ] Failed to stop '" ..
                name ..
                "': " ..
                tostring(result)
            )

            return false
        end
    end

    self.Started[name] = nil

    return true
end

--------------------------------------------------
-- Start All
--------------------------------------------------

function ModuleLoader:StartAll(context)
    for name in pairs(self.Modules) do
        self:Start(name, context)
    end
end

--------------------------------------------------
-- Stop All
--------------------------------------------------

function ModuleLoader:StopAll()
    for name in pairs(self.Modules) do
        self:Stop(name)
    end
end

--------------------------------------------------
-- Information
--------------------------------------------------

function ModuleLoader:GetCount()
    local count = 0

    for _ in pairs(self.Modules) do
        count += 1
    end

    return count
end

return ModuleLoader
