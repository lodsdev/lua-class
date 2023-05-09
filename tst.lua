interface 'SuperTest' {
    'mySuperTest',
}

class 'SuperTest' : implements 'SuperTest' {
    constructor = function(self)
    end,

    mySuperTest = function(self)
        iprint('testing inheritance lua oop.')
    end,
}

class 'Test' {
    constructor = function(self)
    end,

    myTest = function(self)
    end,
}

local classTest = new 'Test'()
classTest:myTest()

iprint(instanceOf(classTest, 'Test'))