--[[
    MIT License
    
    Author: https://github.com/lodsdev
    Version: 1.0.0

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

local function tblCopy(t, mt)
    local t2 = {}
    for i, v in pairs(t) do
        if (not t2[i]) then
            t2[i] = v
        end
    end
    if (mt) then
        t2.super = mt
        setmetatable(t2, { __index = t2.super.array })
    end
    return t2
end

function class(className)
    return function(tbl, super)
        local class = classes[className]
        if (not class) then
            if (super) then
                super._name = super.name
            end
            tbl._name = className
            classes[className] = { name = className, array = tbl, super = super }
        end
        return tbl
    end
end

function new(className)
    return function(...)
        local classe = classes[className]
        if (not classe) then error('Class ' .. className .. ' not found') end

        local super = (classe.super and classe.super or false)
        local obj = tblCopy(classe.array, (super and super or false))

        obj.overload = function(tbl, ...)
            local args = {...}
            local func = tbl[#args]
            func(obj, ...)
        end

        if (obj.constructor) then
            obj:constructor(...)
        end
        return obj
    end
end

function extends(superObjName)
    return function(tbl)
        local super

        if (classes[superObjName]) then 
            super = classes[superObjName]
            setmetatable(tbl, {__index = super.array})
        elseif (interfaces[superObjName]) then
            super = interfaces[superObjName]
            for i, v in pairs(super) do
                tbl[i] = v
            end
        end

        return tbl, super
    end
end

function interface(interfaceName)
    return function(tbl)
        if (not interfaces[interfaceName]) then
            interfaces[interfaceName] = {}
        end

        for i, v in pairs(tbl) do
            interfaces[interfaceName][v] = v
        end

        return tbl
    end
end

function implements(interfaceName)
    return function(tbl)
        if (not interfaces[interfaceName]) then error('Interface ' .. interfaceName .. ' not found') end

        for i, v in pairs(interfaces[interfaceName]) do
            if (not tbl[v]) then
                error('Interface ' .. interfaceName .. ' not implemented, method ' .. v .. ' not found')
            end
        end

        return tbl
    end
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