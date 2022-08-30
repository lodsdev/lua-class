local Animal = Class({
    constructor = function(self, name)
        self.name = name
    end,

    eat = function(self)
        print('Animal of name ' .. self.name .. ' is eating...')
    end
})

local Vehicle = Class({
    constructor = function(self, model)
        self.model = model
    end,

    create = function(self, pos)
        local x, y, z = unpack(pos)

        print('Vehicle of model ' .. self.model .. ' is created at ' .. x .. ' ' .. y .. ' ' .. z)
    end
})

local vehicle = Vehicle(481)
vehicle:create({0, 0, 0})