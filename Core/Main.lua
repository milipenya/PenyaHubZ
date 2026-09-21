--[[
    PenyaHubZ
    Core/Main.lua

    Главная точка запуска.
    Core отвечает за запуск интерфейса и регистрацию модулей.
]]

local PenyaHubZ = {}

PenyaHubZ.Version = "0.1.0"
PenyaHubZ.Name = "PenyaHubZ"

-- Хранилище подключённых модулей
PenyaHubZ.Modules = {}

-- Регистрация модуля
function PenyaHubZ:RegisterModule(name, module)
    if type(name) ~= "string" then
        warn("[PenyaHubZ] Module name must be a string.")
        return false
    end

    if type(module) ~= "table" then
        warn("[PenyaHubZ] Module '" .. name .. "' must return a table.")
        return false
    end

    self.Modules[name] = module

    return true
end

-- Получение модуля
function PenyaHubZ:GetModule(name)
    return self.Modules[name]
end

-- Запуск модуля
function PenyaHubZ:StartModule(name)
    local module = self:GetModule(name)

    if not module then
        warn("[PenyaHubZ] Module not found: " .. tostring(name))
        return false
    end

    if type(module.Init) == "function" then
        local success, result = pcall(module.Init, module, self)

        if not success then
            warn("[PenyaHubZ] Failed to initialize module '" .. name .. "': " .. tostring(result))
            return false
        end
    end

    return true
end

-- Остановка модуля
function PenyaHubZ:StopModule(name)
    local module = self:GetModule(name)

    if not module then
        return false
    end

    if type(module.Destroy) == "function" then
        local success, result = pcall(module.Destroy, module)

        if not success then
            warn("[PenyaHubZ] Failed to destroy module '" .. name .. "': " .. tostring(result))
            return false
        end
    end

    return true
end

-- Информация о хабе
function PenyaHubZ:GetInfo()
    return {
        Name = self.Name,
        Version = self.Version,
        ModuleCount = #self.Modules
    }
end

print("[PenyaHubZ] Core loaded.")
print("[PenyaHubZ] Version: " .. PenyaHubZ.Version)

return PenyaHubZ
