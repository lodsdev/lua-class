function Class(self)
    local tbl = {}
    tbl.__index = tbl
    tbl.constructor = tbl
    return tbl
end

function New(target, ...)
    local instance = setmetatable({}, target)
    instance:constructor(...)
    return instance
end

function ClassExtends(target, base)
    target.super = base
    local staticMetatable = setmetatable({__index = base}, base)
    setmetatable(target, staticMetatable)
    local baseMetatable = getmetatable(base)
    
    if (baseMetatable) then
        if (type(baseMetatable.__index) == 'function') then
            staticMetatable.__index = baseMetatable.__index
        end
        if (type(baseMetatable.__newindex) == 'function') then
            staticMetatable.__newindex = baseMetatable.__newindex
        end
    end
    
    setmetatable(target, base)
    if (type(base.__index) == 'function') then
        target.__index = base.__index
    end
    if (type(base.__newindex) == 'function') then
        target.__newindex = base.__newindex
    end
    if (type(base.__tostring) == 'function') then
        target.__tostring = base.__tostring
    end
end
