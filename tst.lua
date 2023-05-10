class 'OuterClass' {
    x = 10,

    class 'InnerClass' {
        y = 5,
    }
}

class 'Main' {
    constructor = function(self)
        local  myOuter = new 'OuterClass'()
        local myInner = new 'InnerClass'()
        print(myInner.y + myOuter.x)
    end
}

new 'Main'()