-- require('new-class')

interface 'telePhone' {
    'call',
    'hangUp'
}

interface 'iPhone' (extend 'telePhone' {
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

class 'B' (extend 'A' {
    constructor = function(self)
    end,
    say = function(self)
        print('say')
    end
})

class 'C' (extend 'B' (implements 'iPhone' {
    constructor = function(self)
    end,
    call = function() end,
    receiveSMS = function() end,
    sendSMS = function() end,
}))

local a = new 'A'()
local b = new 'B'()
local c = new 'C'()
c:center()