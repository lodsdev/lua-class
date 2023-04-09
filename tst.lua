class 'Teste' {
    constructor = function(self, message, info)
        self.test = false
    end,

    say = function(self)
        return print(self.message)
    end
}

local tst1 = new 'Teste'('Oi')
tst1:say()