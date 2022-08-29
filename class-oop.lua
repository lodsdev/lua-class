Class = {}

function Class:create(tbl)
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

function Class:extends(superCls, subCls)
    local tblExtends = {}
    tblExtends.super = superCls
    tblExtends.this = subCls

    for k, v in pairs(superCls) do
        tblExtends[k] = v
    end
    for k, v in pairs(subCls) do
        tblExtends[k] = v
    end

    return Class:create(tblExtends)
end