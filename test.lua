-- require('new-class')

interface 'telePhone' {
    'call',
    'hangUp'
}

interface 'iPhone' (extends 'telePhone' {
    'sendSMS',
    'receiveSMS'
})

class 'A' {
    constructor = function(self)

    end,
    center = function(self)
        print('center')
    end
}

class 'B' (extends 'A' {
    constructor = function(self)
    end,
    say = function(self)
        print('say')
    end
})

class 'C' (extends 'B' (implements 'iPhone' {
    constructor = function(self)
    end,
    call = function(self) 
        self.super.super.array:center()
    end,
    receiveSMS = function() end,
    sendSMS = function() end,
    hangUp = function() end
}))

class 'D' (extends 'C' {
    constructor = function(self)
    end,

    overload = function(self)

    end
})

local a = new 'A'()
local b = new 'B'()
local c = new 'C'()
local d = new 'D'()
d:call()