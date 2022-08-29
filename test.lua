local Animal = Class:create({
    constructor = function(self, name)
        self.name = name
    end,

    eat = function(self)
        print("Animal: " .. self.name .. "  is eating")
    end
})

local Dog = Class:extends(Animal, {
    constructor = function(self)
        self.name = "Dog"
    end,

    eat = function(self)
        Animal.eat()
        print("Dog: " .. self.name .. "  is eating")
    end
})


local myAnimal = Animal('My animal')
local myDog = Dog()
myDog:eat()
