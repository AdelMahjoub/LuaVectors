-- Vector factory function
-- Returns a Vector table
-- @param<number> x
-- @param<number> y
-- @return<Vector> 
local function getVector(x, y) 

    -- @class Vector
    -- A vector is a quantity defined by its magnitude(length) and its angle
    -- A vector can be represented by its x and y coordinate withing a drawing context
    -- @field<number> x
    -- @field<number> y
    local vector = {}
    vector.x = x or 0
    vector.y = y or 0

    -- @return<number>
    vector.getX = function()
        return vector.x
    end
        
    -- @param<number> value
    vector.setX = function(value)
        assert(type(value) == "number", "vector.setX(arg) type of arg should be a number.")
        vector.x = value
    end
        
    -- @return<number>
    vector.getY = function()
        return vector.y
    end
        
    -- @param<number> value
    vector.setY = function(value)
        assert(type(value) == "number", "vector.setY(arg) type of arg should be a number.")
        vector.y = value
    end

    -- @return<number>
    vector.getAngle = function()
        return math.atan2(vector.y, vector.x)
    end

    -- @param<number> angle
    vector.setAngle = function(angle)
        assert(type(angle) == "number", "vector.setAngle(arg) type of arg should be a number.")
        local length = vector.getLength()
        vector.x = length * math.cos(angle)
        vector.y = length * math.sin(angle)
    end

    -- @return<number>
    vector.getLength = function()
        return math.sqrt(math.pow(vector.x, 2) + math.pow(vector.y, 2))
    end

    -- Set the vector magnitude
    -- @param<number> length
    vector.setLength = function(length)
        assert(type(length) == "number", "vector.setLength(arg) type of arg should be a number.")
        local angle = vector.getAngle()
        vector.x = length * math.cos(angle)
        vector.y = length * math.sin(angle)
    end
    
    -- @param<Vector> v
    -- @return<Vector>
    vector.add = function(v) 
        assert(type(v) == "table", "vector.add(arg) type of arg should be a table(vector {x,y}).")
        return getVector(vector.x + v.x, vector.y + v.y)
    end
    
    -- @param<Vector> v
    -- @return<Vector>
    vector.substract = function(v) 
        assert(type(v) == "table", "vector.substract(arg) type of arg should be a table(vector {x,y}).")
        return getVector(vector.x - v.x, vector.y - v.y)
    end
    
    -- @param<number> scalar
    -- @return<Vector>
    vector.multiply = function(scalar) 
        assert(type(scalar) == "number", "vector.multiply(arg) type of arg should be a number.")
        return getVector(vector.x * scalar, vector.y * scalar)
    end
    
    -- @param<number> scalar
    -- @return<Vector>
    vector.divide = function(scalar) 
        assert(type(scalar) == "number", "vector.multiply(arg) type of arg should be a number.")
        return getVector(vector.x / scalar, vector.y / scalar)
    end
    
    -- @param<Vector> v
    vector.addTo = function(v) 
        assert(type(v) == "table", "vector.addTo(arg) type of arg should be a table(vector {x,y}).")
        vector.x = vector.x + v.x
        vector.y = vector.y + v.y
    end
    
    -- @param<Vector> v
    vector.substractFrom = function(v) 
        assert(type(v) == "table", "vector.substractFrom(arg) type of arg should be a table(vector {x,y}).")
        vector.x = vector.x - v.x
        vector.y = vector.y - v.y
    end
    
    -- @param<scalar> scalar
    vector.multiplyBy = function(scalar) 
        assert(type(scalar) == "number", "vector.multiplyBy(arg) type of arg should be a number.")
        vector.x = vector.x * scalar 
        vector.y = vector.y * scalar
    end
    
    -- @param<scalar> scalar
    vector.divideBy = function(scalar) 
        assert(type(scalar) == "number", "vector.divideBy(arg) type of arg should be a number.")
        vector.x = vector.x / scalar 
        vector.y = vector.y / scalar
    end

    return vector
end

return getVector
