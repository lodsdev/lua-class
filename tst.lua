class 'SuperTest' {
    constructor = function(this)
    end,

    mySuperTest = function(this)
        iprint('testing inheritance lua oop.')
    end,
}

class 'Test' {
    constructor = function(this)
    end,

    myTest = function(this)
        iprint('testing myTest method lua oop.')
    end,
}

local classTest = new 'Test'()
classTest:myTest()