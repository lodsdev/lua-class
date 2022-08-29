local Animal = Class:new({
    constructor = function(self, name)
        self.name = name
        -- print(self.name)
    end,

    eat = function(self)
        print(self.name .. " is eating")
    end
})

local dog = Animal('Pitbull')
dog:eat()
