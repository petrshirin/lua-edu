Particle = {}
Particle.__index = Particle

function Particle:create(location, locationB)
    local particle = {}
    setmetatable(particle, Particle)
    particle.location = location
    particle.locationB = locationB
    particle.acceleration = Vector:create(0, 0)
    particle.velocity = Vector:create(0, 0)
    particle.lifespan = 250
    particle.decay = 0
    particle.clicked = False
    return particle
end

function Particle:update()
    self.velocity:add(self.acceleration)
    self.location:add(self.velocity)
    self.locationB:add(self.velocity)
    self.acceleration:mul(0)
    self.lifespan = self.lifespan - self.decay
end

function Particle:applyForce(force)
    self.acceleration:add(force)
end

function Particle:isDead()
    return self.lifespan <= 0
end

function Particle:draw()
    r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(1,1,1, self.lifespan / 100)
    if (self.clicked) then
        love.graphics.setColor(255,0,0, self.lifespan / 100)
    end
    love.graphics.line(self.location.x, self.location.y, self.locationB.x, self.locationB.y)
    love.graphics.setColor(r, g, b, a)
end