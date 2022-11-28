-- local tbl = extend('SuperClass')
-- local f = class('MyClass')
-- local methods = f(tbl)


-- local registerMyClass = class('MyClass')
-- local extenderForMySuperClass = extend('MySuperClass')
-- local subClass = extenderForMySuperClass({
--     constructor = function(self, ...)
--         -- print('MyClass constructor')
--     end,

--     myMethod = function(self)
--         print('MyClass myMethod')
--     end
-- })

-- registerMyClass(subClass)

class 'MySuperSuperClass' {
    constructor = function(self, ...)
        -- print('MySuperClass constructor')
    end,

    mySuperSuperMethod = function(self)
        print('MySuperSuperClass myMethod')
    end
}

class 'MySuperClass' (extend 'MySuperSuperClass' {
    constructor = function(self, ...)
        -- print('MySuperClass constructor')
    end,

    mySuperMethod = function(self)
        print('MySuperClass myMethod')
    end
})

local mySuperClass = new 'MySuperClass'()
mySuperClass:mySuperSuperMethod()


-- class 'MyClass' (extend 'MySuperClass' {
--     constructor = function(self, name)
--         self.name = name
--     end,

--     getName = function(self)
--         print(self.name)
--     end
-- })

-- local myClass = new 'MyClass'('lods')
-- myClass:mySuperMethod()

-- local myClass2 = new 'MyClass'('tmp')
-- myClass2:getName()

-- local myClass3 = new 'MyClass'('zoiko')
-- myClass3:myMethod()