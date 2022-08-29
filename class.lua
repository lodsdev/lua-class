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

Class = {}

function Class:new(tbl)
    setmetatable(tbl, {
        __call = function(cls, ...)
            local self = {}

            setmetatable(self, {
                __index = cls
            })

            self:constructor(...)

            return self
        end
    })
    return tbl
end