# Lua class library

## Introduction

The **Lua Class** library provides support for object-oriented programming in Lua. With it, you can create classes and objects easily and intuitively, using concepts such as inheritance, polymorphism, interfaces and method overloading. **[ Still in improvement ]**

## Installation

Just download file `class-oop.lua` and put it in your project directory. it will work in any project that uses Lua. 

* Note: This library he was created and tested on Lua 5.1

## Creating classes

To create a class, simply call the `class` function and pass the class name and a table containing the method constructor and attributes. For example:

```lua
class 'Animal' {
    constructor = function(self, name, type)
        self.name = name
        self.type = type
    end
}
```

## Instantiating

To instantiate an object, simply call the `new` function and pass the class name and the arguments of the constructor. For example:

```lua
local dog = new 'Animal'('Dog', 'Mammal')
```

## Inheritance

The **Lua Class** library supports simple and multiple class inheritance. To create a child class that inherits from another parent class, simply call the `extends` function and pass the child class name, the parent class name and a table containing the method constructor and attributes. For example:

```lua
class 'Animal' {
    constructor = function(self, name, type)
        self.name = name
        self.type = type
    end,

    eat = function(self)
        print('Eating...')
    end
}

class 'Dog' : extends 'Animal' {
    constructor = function(self, name)
        self.name = name
    end
}

local dog = new 'Dog'('Bob')
dog:eat() -- Eating...

```

## Polymorphism

The **Lua Class** library supports polymorphism naturally. This means it is possible to overload methods from the parent class in a child class, so that the implementation of the method in the child class is called intead of the implementation in the parent class. For example:

```lua
class 'Animal' {
    constructor = function(self, name, type)
        self.name = name
        self.type = type
    end,

    speak = function(self)
        print('Hello, my name is ' .. self.name .. ' and I am a ' .. self.type .. '.')
    end
}

class 'Dog' : extends 'Animal' {
    constructor = function(self, name)
        self.name = name
    end,

    speak = function(self)
        print('Woof! My name is ' .. self.name .. '.')
    end
}
```

## Interfaces

The **Lua Class** library als supports interface concepts. An interface is a blueprint of a class that defines the methods and attributes that a class must implement. A class can implement multiple interfaces and must implement all the methods and attributes defined in the interfaces it implements.

To create an interface, simply call the `interface` function and pass the interface name and table containing the methods attributes of the interface as arguments. For example:

```lua
interface 'telePhone' {
    'call',
    'sendSMS',
    'receiveSMS'
}
```
To make a class implement an interface, simply pass the interface name as an argument to the `implements` function. For example:

```lua
class 'SmartPhone' : implements 'telePhone' {
    constructor = function(self, number)
        self.number = number
    end,

    call = function(self, number)
        print('Calling ' .. number .. ' from ' .. self.number .. '...')
    end,

    sendSMS = function(self, number, message)
        print('Sending SMS to ' .. number .. ' from ' .. self.number .. '...')
    end,

    receiveSMS = function(self, number, message)
        print('Received SMS from ' .. number .. ' to ' .. self.number .. '...')
    end
}
```

### Multiple interfaces

The **Lua Class** library also supports multiple interfaces. This means that a class can implement multiple interfaces. To make a class implement multiple interfaces, simply pass the interface names as arguments to the `implements` function. For example:

```lua
interface 'telePhone' {
    'call',
    'sendSMS',
    'receiveSMS'
}

interface 'smartPhone' {
    'touchScreen',
    'internet'
}

class 'SmartPhone' : implements ('telePhone', 'smartPhone') {
    constructor = function(self, number)
        self.number = number
    end,

    call = function(self, number)
        print('Calling ' .. number .. ' from ' .. self.number .. '...')
    end,

    sendSMS = function(self, number, message)
        print('Sending SMS to ' .. number .. ' from ' .. self.number .. '...')
    end,

    receiveSMS = function(self, number, message)
        print('Received SMS from ' .. number .. ' to ' .. self.number .. '...')
    end,

    touchScreen = function(self)
        print('Touching screen...')
    end,

    internet = function(self)
        print('Accessing internet...')
    end
}
```

## Inheritance of interfaces

The **Lua Class** library also supports inheritance of interfaces. This means that a class can implement an interface that inherits from another interface. To make a class implement an interface that inherits from another interface, simply pass the interface name as an argument to the `extends` function. For example:

```lua
interface 'telePhone' {
    'call',
    'sendSMS',
    'receiveSMS'
}

interface 'smartPhone' : extends 'telePhone' {
    'touchScreen',
    'internet'
}
```

## instanceof

The **Lua Class** library also supports the `instanceof` operator. This operator is used to check if an object is an instance of a class. For example:

```lua
local dog = new 'Animal'('Dog', 'Mammal')
print(instanceOf(dog, 'Animal')) -- true
```

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/lodsdev/lua-oop/blob/main/MIT-LICENSE.txt) file for details