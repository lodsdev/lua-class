Class = {}

function Class:new()
    local instance = {}

    function instance:privateMethod()
        print("privateMethod")
    end

    setmetatable(instance, {
        __index = Class
    })

    return instance
end

return Class