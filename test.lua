-- local Animal = Class({
--     constructor = function(self, name)
--         self.name = name
--     end,

--     eat = function(self)
--         print("Animal: " .. self.name .. "  is eating")
--     end
-- })

-- local Dog = Class({
--     name = 'Dog',

--     constructor = function(self)

--     end,

--     eat = function(self)
--         print("Dog: " .. self.name .. "  is eating")
--     end
-- })

-- ClassExtends(Dog, Animal)


-- local myAnimal = New(Animal)
-- local myDog = New(Dog)
-- myDog:eat()

    
local Animal = Class({
    constructor = function(self, name)
        self.name = name
    end,

    eat = function(self)
        print('Animal of name ' .. self.name .. ' is eating...')
    end
})

local Dog = ClassExtends({
    constructor = function(self)
        print(self.name)
    end
}, Animal)

local anim = Animal('MyAnimal')
local dog = Dog()

anim:eat()