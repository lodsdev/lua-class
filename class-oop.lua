--[[
    Author: https://github.com/lodsdev
    Version: 2.0.0
]]

local classes = {}
local interfaces = {}

local function table_copy(t, st)
    local newTbl = {}
    for i, v in pairs(t) do
        if (not newTbl[i]) then
            newTbl[i] = v
        end
    end
    if (st) then
        newTbl.super = st
        setmetatable(newTbl, { __index = newTbl.super })
    end
    return newTbl
end

local function table_implements(t, t2)
    local newTbl = {}
    for k, v in ipairs(t2) do
        t[#t+1] = v
    end
    newTbl = table_copy(t)
    return newTbl
end

local function createClass(className, structure, superClass)
    if (classes[className]) then
        error('Class ' .. className .. ' already exists.', 2)
    end

    local newClass = structure
    newClass.__name = className

    if (superClass) then
        newClass.super = superClass
        setmetatable(newClass, { __index = superClass })
    end

    classes[className] = newClass
    return newClass
end

function interface(interfaceName)
    local newInterface = {}

    setmetatable(newInterface, {
        __call = function(self, ...)
            if (interfaces[interfaceName]) then
                error('Interface ' .. interfaceName .. ' already exists.', 2)
            end

            local newInstance = ...
            interfaces[interfaceName] = newInstance
            return newInstance
        end
    })

    newInterface.extends = function(self, superInterfaceName)
        return function(subInterface)
            local superInterface = interfaces[superInterfaceName]
            local newInstance = table_implements(subInterface, superInterface)

            if (interfaces[interfaceName]) then
                error('Interface ' .. interfaceName .. ' already exists.', 2)
            end

            interfaces[interfaceName] = newInstance
            return newInstance
        end
    end

    return newInterface
end

function class(className)
    local newClasse = {}
    local modifiers = {
        extends = function(self, superClassName)
            return function(subClass)
                local superClass = classes[superClassName]
                local classCreated = createClass(className, subClass, superClass)
                return classCreated
            end
        end,

        implements = function(self, ...)
            local interfacesNames = {...}
            return function(subClass)
                local classeCreated = createClass(className, subClass)

                for _, v in pairs(interfacesNames) do
                    if (not interfaces[v]) then
                        error('Interface ' .. v .. ' not found', 2)
                    end

                    for _, method in pairs(interfaces[v]) do
                        if (not subClass[method]) then
                            error('Interface ' .. v .. ' not implemented, method ' .. method .. ' not found', 2)
                        end
                    end
                end

                return classeCreated
            end
        end
    }

    setmetatable(newClasse, {
        __index = function (self, key)
            if (modifiers[key]) then
                return modifiers[key]
            end

            if (classes[className]) then
                return classes[className][key]
            end

            error('Class ' .. className .. ' not found', 2)
        end,

        __call = function(self, ...)
            if (classes[className]) then
                error('Class ' .. className .. ' already exists.', 2)
            end

            local newInstance = createClass(className, ...)
            return newInstance
        end
    })

    return newClasse
end

function new(className)
    return function(...)
        local classe = classes[className]
        if (not classe) then
            error('Class ' .. className .. ' not found', 2)
        end

        local super = classe.super
        local newObj = table_copy(classe, super)
        if (newObj.constructor) then
            newObj:constructor(...)
        end

        return newObj
    end
end

function instanceOf(instance, className)
    local classe = classes[className]
    if (not classe) then
        error('Class ' .. className .. ' not found', 2)
    end

    if (instance.__name == className) then
        return true
    end

    return false
end