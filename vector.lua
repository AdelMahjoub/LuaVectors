local function getVector(x, y) 
    local vector = {}
    vector.x = x or 0
    vector.y = y or 0

    function vector.getX()
        return vector.x
    end
        
    function vector.setX(value)
        assert(type(value) == "number", "vector.setX(arg) type of arg should be a number.")
        vector.x = value
    end
        
    function vector.getY()
        return vector.y
    end
        
    function vector.setY(value)
        assert(type(value) == "number", "vector.setY(arg) type of arg should be a number.")
        vector.y = value
    end

    function vector.getAngle()
        return math.atan2(vector.y, vector.x)
    end

    function vector.setAngle(angle)
        assert(type(angle) == "number", "vector.setAngle(arg) type of arg should be a number.")
        local length = vector.getLength()
        vector.x = length * math.cos(angle)
        vector.y = length * math.sin(angle)
    end

    function vector.getLength()
        return math.sqrt(math.pow(vector.x, 2) + math.pow(vector.y, 2))
    end

    function vector.setLength(length)
        assert(type(length) == "number", "vector.setLength(arg) type of arg should be a number.")
        local angle = vector.getAngle()
        vector.x = length * math.cos(angle)
        vector.y = length * math.sin(angle)
    end
    
    function vector.add(v) 
        assert(type(v) == "table", "vector.add(arg) type of arg should be a table(vector {x,y}).")
        return getVector(vector.x + v.x, vector.y + v.y)
    end
    
    function vector.substract(v) 
        assert(type(v) == "table", "vector.substract(arg) type of arg should be a table(vector {x,y}).")
        return getVector(vector.x - v.x, vector.y - v.y)
    end
    
    function vector.multiply(scalar) 
        assert(type(scalar) == "number", "vector.multiply(arg) type of arg should be a number.")
        return getVector(vector.x * scalar, vector.y * scalar)
    end
    
    function vector.divide(scalar) 
        assert(type(scalar) == "number", "vector.multiply(arg) type of arg should be a number.")
        return getVector(vector.x / scalar, vector.y / scalar)
    end
    
    function vector.addTo(v) 
        assert(type(v) == "table", "vector.addTo(arg) type of arg should be a table(vector {x,y}).")
        vector.x = vector.x + v.x
        vector.y = vector.y + v.y
    end
    
    function vector.substractFrom(v) 
        assert(type(v) == "table", "vector.substractFrom(arg) type of arg should be a table(vector {x,y}).")
        vector.x = vector.x - v.x
        vector.y = vector.y - v.y
    end
    
    function vector.multiplyBy(scalar) 
        assert(type(scalar) == "number", "vector.multiplyBy(arg) type of arg should be a number.")
        vector.x = vector.x * scalar 
        vector.y = vector.y * scalar
    end
    
    function vector.divideBy(scalar) 
        assert(type(scalar) == "number", "vector.divideBy(arg) type of arg should be a number.")
        vector.x = vector.x / scalar 
        vector.y = vector.y / scalar
    end
    
    return vector
end

return getVector







