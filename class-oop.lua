local classes = {}
-- local subObj = {}
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

-- function subObj:extend(superClassName)
--     return function(subClass)
--         local super = classes[superClassName]
--         if (not super) then
--             error('Super class ' .. superClassName .. ' not found', 2)
--         end

--         setmetatable(subClass, { __index = super.array })

--         return subClass
--     end
-- end

function class(subClassName)
    return function(tbl)
        local subClass = classes[subClassName]
        
        if (not subClass) then
            classes[subClassName] = { name = subClassName, array = tbl }
        end

        return tbl
    end
end

function new(className)
    return function(...)
        local classe = classes[className]
        if (not classe) then error('Class ' .. className .. ' not found', 2) end

        local obj = table.copy(classe.array, getmetatable(classe.array))

        if (obj.constructor) then
            obj.constructor(obj, ...)
        end

        objAmount = objAmount + 1
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
