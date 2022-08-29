function Class(tbl)
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

local Animal = Class({
    senha = '123',

    constructor = function(self, name)
        self.name = name
        -- print(self.name)
    end,

    eat = function(self)
        print(self.name .. " is eating")
    end,

    getPass = function(self)
        return self.senha
    end
})

local dog = Animal('Pitbull')
print(dog:getPass())
print(dog.senha)