local getVector = require("vector") -- Vector factory function

    -- Particle factory function
    -- Returns a Particle table
    -- @param<number> x
    -- @param<number> y
    -- @param<number> speed     : the particle velocity's magnitude
    -- @param<number> direction : the particle velocity's angle
    -- @param<number> grav      : the global gravity magnitude applied to the particle, default to 0
    -- @return<Particle>
    local function getParticle(x, y, speed, direction, grav)
        -- arguments type assertion
        assert(type(x) == "number", "getParticle(x, y, speed, direction, grav) typeof argument 'x' should be a number")
        assert(type(y) == "number", "getParticle(x, y, speed, direction, grav) typeof argument 'y' should be a number")
        assert(type(speed) == "number", "getParticle(x, y, speed, direction, grav) typeof argument 'speed' should be a number")
        assert(type(direction) == "number", "getParticle(x, y, speed, direction, grav) typeof argument 'direction' should be a number")
        if grav ~= nil then
            assert(type(grav) == "number", "getParticle(x, y, speed, direction, grav) typeof argument 'grav' should be a number")
        end
        
        -- @class Particle
        -- A particle is an entity submitted to forces (vectors)
        -- It can be initially represented by its position, velocity and a global acceleration vector (gravity)
        -- The particle moves when its velocity vector is added to its position vector
        -- The particle accelerate when one or multiple vectors are added to its velocity vector
        -- @field<number> mass
        -- @field<number radius
        -- @field<Vector> position
        -- @field<Vector> velocity
        -- @field<Vector> gravity
        local particle = {}
        
        particle.mass = 1
        particle.radius = 0
        particle.bounce = -1
        particle.friction = 1
        particle.position = getVector(x,y)
        
        particle.velocity = getVector()
        particle.velocity.setLength(speed)
        particle.velocity.setAngle(direction)
    
        particle.gravity = getVector(0, grav or 0)
    
        -- Add an acceleration vector to the particle's velocity (@field velocity)
        -- @param<Vector> v 
        particle.accelerate = function(v)
            assert(type(v) == "table", "particle.accelerate(v) typeof argument 'v' should be a table (Vector)")
            particle.velocity.addTo(v)
        end
        
        -- Update the particle position and velocity (Movement and acceleration)
        -- by adding the particle's velocity(@field velocity) to the particle's position(@field position)
        -- and adding the particle's gravity(@field gravity) to the particle's velocity(@field velocity)
        particle.update = function()
            particle.velocity.multiplyBy(particle.friction)
            particle.accelerate(particle.gravity)
            particle.position.addTo(particle.velocity)
        end
       
        -- Get the angle between this particle and another particle
        -- @param<Particle> p
        -- @return<number> 
        particle.angleTo = function(p)
            assert(type(p) == "table", "particle.angleTo(p) typeof argument 'p' should be a table (Particle)")
            local dx = p.position.getX() - particle.position.getX()
            local dy = p.position.getY() - particle.position.getY()
            return math.atan2(dy, dx)
        end
    
        -- Get the distance between this particle and another particle
        -- @param<Particle> p
        -- @return<number>
        particle.distanceTo = function(p)
            assert(type(p) == "table", "particle.distanceTo(p) typeof argument 'p' should be a table (Particle)")
            local dx = p.position.getX() - particle.position.getX()
            local dy = p.position.getY() - particle.position.getY()
            return math.sqrt(math.pow(dx, 2) + math.pow(dy, 2))
        end
    
        -- If this particle is within the attraction field of another particle then this particle can gravitate to that particle
        -- by adding the attraction vector to this particle velocity (@field velocity)
        -- the attraction magnitude is equal to (the attracting particle mass) / (distance between the two particles) ^ 2
        -- the attraction vector is defined by the attraction magnitude and the angle between the two particles
        -- @param<Particle>
        particle.gravitateTo = function(p)
            assert(type(p) == "table", "particle.gravitateTo(p) typeof argument 'p' should be a table (Particle)")
            local grav = getVector(0, 0)
            local distance = particle.distanceTo(p)
            grav.setLength(p.mass / math.pow(distance, 2))
            grav.setAngle(particle.angleTo(p))
            particle.accelerate(grav)
        end
        
        return particle
    end
    
    return getParticle