local classes = {}
local interfaces = {}
local objAmount = 0

function table.copy(t, mt)
    local t2 = {}
    for k, v in pairs(t) do
        t2[k] = v
    end
    if (mt) then
        setmetatable(t2, mt)
    end
    return t2
end

function interface(name)
    return function(tbl)
        if (not interfaces[name]) then
            interfaces[name] = {}
        end
        
        for i, v in pairs(tbl) do
            interfaces[name][v] = v
        end

        return interfaces[name]
    end
end

function implements(interfaceName)
    return function(tbl)
        if (not interfaces[interfaceName]) then error('Interface ' .. interfaceName .. ' not found', 2) end

        for i, v in pairs(interfaces[interfaceName]) do
            if (not tbl[v]) then
                error('Interface ' .. interfaceName .. ' not implemented, method ' .. v .. ' not found', 2)
            end
        end

        return tbl
    end
end

function class(subClassName)
    return function(tbl, super)
        local subClass = classes[subClassName]
        
        if (not subClass) then
            classes[subClassName] = { name = subClassName, array = tbl, super = super }
        end

        return tbl
    end
end

function new(className)
    return function(...)
        local classe = classes[className]
        if (not classe) then error('Class ' .. className .. ' not found', 2) end

        local super = classe.super
        local obj = tblCopy(classe.array)
        obj.super = super.array
        obj.super._name = super._name
        obj._name = className

        setmetatable(obj, {
            __index = function(t, k)
                if (t.super[k]) then
                    return t.super[k]
                end
            end,
            __newindex = function(t, k, v)
                if (t.super[k]) then
                    t.super[k] = v
                end
            end,
            __gc = function(t)
                if (t.destructor) then
                    t:destructor()
                end
            end
        })

        if (obj.constructor) then
            obj:constructor(...)
        end

        return obj
    end
end

function extend(superClassName)
    return function(subClass)
        local super = classes[superClassName]
        if (not super) then
            error('Super class ' .. superClassName .. ' not found', 2)
        end

        setmetatable(subClass, { __index = super.array })

        return subClass
    end
end

function destroy(instance)
    if (instance.destructor) then
        instance.destructor()
        setmetatable(instance, nil)
        return true
    end
    return false
end

function instanceOf(instance, className)
    local classe = classes[className]
    if (not classe) then error('Class ' .. className .. ' not found', 2) end

    if (instance._name == className) then
        return true
    end

    if (instance.super) then
        return instanceOf(instance.super, className)
    end

    return false
end