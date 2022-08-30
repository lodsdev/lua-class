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

-- local MyClass = Class()
-- MyClass.name = 'MyClass'

-- function MyClass.constructor(self, name)
--     self.name = name
--     print('Name of class: ' .. self.name)
-- end

-- local tstClass = New(MyClass, 'tstClass')

-- iprint(tstClass)


local Animal = Class({
    constructor = function(self)
    end,

    eat = function(self)
        print('Animal is eating...')
    end
})

local Dog = ClassExtends({
    constructor = function(self)

    end
}, Animal)

local anim = Animal()
local dog = Dog('dog')

dog:eat()