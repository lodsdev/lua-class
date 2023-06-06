class 'OuterClass' {
    x = 10,

    constructor = function (self)

    end,

    test = function(self)
        print('OuterClass test')
    end,
}

class 'Main' : extends 'OuterClass' {
    constructor = function(self)
    end,
}

local main = new 'Main'()
main:test()