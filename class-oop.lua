-- function Class(tbl)
--     setmetatable(tbl, {
--         __call = function(cls, ...)
--             local self = {}
            
--             setmetatable(self, {
--                 __index = cls
--             })
            
--             self:constructor(...)

--             return self
--         end
--     })
--     return tbl
-- end

-- function ClassExtends(target, base)
--     local ClassExtended = {}

--     ClassExtended = base
--     target.super = base

--     local staticMetatable = setmetatable({__index = base}, base)
--     setmetatable(ClassExtended, staticMetatable)
--     local baseMetatable = getmetatable(base)
    
--     if (baseMetatable) then
--         if (type(baseMetatable.__index) == 'function') then
--             staticMetatable.__index = baseMetatable.__index
--         end
--         if (type(baseMetatable.__newindex) == 'function') then
--             staticMetatable.__newindex = baseMetatable.__newindex
--         end
--     end

--     setmetatable(ClassExtended, base)
--     if (type(base.__index) == 'function') then
--         ClassExtended.__index = base.__index
--     end
--     if (type(base.__newindex) == 'function') then
--         ClassExtended.__newindex = base.__newindex
--     end
--     if (type(base.__tostring) == 'function') then
--         ClassExtended.__tostring = base.__tostring
--     end

--     return Class(ClassExtended)
-- end

local Class = {}

function Class:new()
    local instance = {}
    __call = function(cls, ...)
        setmetatable(instance, {
            __index = cls
        })

        instance:constructor(...)
    end
    setmetatable(instance, {
        __index = Class
    })
    return instance
end

function Class:constructor()
    iprint(self)
end
