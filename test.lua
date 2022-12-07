-- require('new-class')

-- interface 'telePhone' {
--     'call',
--     'hangUp'
-- }

-- interface 'iPhone' (extend 'telePhone' {
--     'sendSMS',
--     'receiveSMS'
-- })

class 'Tmp' {
    constructor = function(self, count)
        print('constructor' .. count)
    end,

    say = function(self)
        print(self._name)
    end
}

class 'Vinicenter' {
    constructor = function(self)

    end,

    center = function(self)
        print('center')
    end
}

class 'Lods' (extend 'Tmp' (extend 'Vinicenter' {
    constructor = function(self, num)
        self.num = num
    end,
    
    say = function(self)
        print(self._name)
        self.super:say()
    end
}))

local lods = new 'Lods'(2)
-- iprint(lods)
-- lods:center()