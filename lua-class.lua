--[[
    Author: https://github.com/lodsdev
    Version: 1.0
    
    MIT License

    Copyright (c) 2012-2022 Scott Chacon and others

    Permission is hereby granted, free of charge, to any person obtaining
    a copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
    LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
    OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
    WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

local classes = {}
local interfaces = {}

local function table_copy(t)
    local newTbl = {}
    for i, v in pairs(t) do
        if (not newTbl[i]) then
            newTbl[i] = v
        end
    end
    return newTbl
end

function interface(interfaceName)
    return function(tbl)
        if (not interfaces[interfaceName]) then
            interfaces[interfaceName] = {}
        end

        local instance = {}
        for i, v in pairs(tbl) do
            instance[v] = v
        end

        interfaces[interfaceName] = instance
        return tbl
    end
end

function class(className)
    local newClasse = {}

    setmetatable(newClasse, {
        __call = function(self, ...)
            if (classes[className]) then
                error('Class ' .. className .. ' already exists.', 2)
            end

            local newInstance = table_copy(...)
            newInstance.__name = className

            classes[className] = newInstance
            return newInstance
        end
    })

    newClasse.extends = function(self, superClassName)
        return function(subClass)
            local superClass = classes[superClassName]
            subClass.__name = className
            subClass.super = superClass

            if (classes[className]) then
                error('Class ' .. className .. ' already exists.', 2)
            end

            setmetatable(subClass, { __index = subClass.super.public })
            classes[className] = subClass
        end
    end

    newClasse.implements = function(self, interfaceName)
        return function(subClass)

        end
    end

    return newClasse
end

function new(className)
    return function(...)
        local classe = classes[className]
        if (not classe) then
            error('Class ' .. className .. ' not found', 2)
        end

        if (classe.constructor) then
            classe:constructor(...)
        end

        return classe
    end
end


-- function implements(interfaceName)
--     return function(tbl)
--         if (not interfaces[interfaceName]) then error('Interface ' .. interfaceName .. ' not found') end

--         for i, v in pairs(interfaces[interfaceName]) do
--             if (not tbl[v]) then
--                 error('Interface ' .. interfaceName .. ' not implemented, method ' .. v .. ' not found')
--             end
--         end

--         return tbl
--     end
-- end

-- function instanceOf(instance, className)
--     local classe = classes[className]
--     if (not classe) then error('Class ' .. className .. ' not found', 2) end

--     if (instance._name == className) then
--         return true
--     end

--     if (instance.super) then
--         return instanceOf(instance.super, className)
--     end

--     return false
-- end