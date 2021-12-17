ParticleSystem = {}
ParticleSystem.__index = ParticleSystem


function ParticleSystem:create(startPosition, size, particleClass)
    local particleSystem = {}
    setmetatable(particleSystem, ParticleSystem)
    particleSystem.startPosition = startPosition
    particleSystem.maxCount = 4
    particleSystem.size = size
    particleSystem.particleClass = particleClass or Particle
    particleSystem.particles = {}
    particleSystem:generateParticles()
    return particleSystem
end

function ParticleSystem:generateParticles()
    local locationB = self.startPosition:copy()
    locationB.x = locationB.x + self.size
    local locationC = locationB:copy()
    local particleTop = self.particleClass:create(self.startPosition:copy(), locationB:copy())
    table.insert(self.particles, particleTop)
    locationC.y = locationB.y + self.size
    local particleLeft = self.particleClass:create(locationB:copy(), locationC:copy())
    table.insert(self.particles, particleLeft)
    local locationD = locationC:copy()
    locationD.x = locationD.x - self.size
    local particleBottom = self.particleClass:create(locationC:copy(), locationD:copy())
    table.insert(self.particles, particleBottom)
    local locationA = locationD:copy()
    locationA.y = locationA.y - self.size
    local particleRight = self.particleClass:create(locationD:copy(), locationA:copy())
    table.insert(self.particles, particleRight)
end

function ParticleSystem:removeDiedParticles()
    local deletedElements = {}
    for i = 1, #self.particles do
        if self.particles[i]:isDead() then
            table.insert(deletedElements, i)
        end
    end
    for i = 1, #deletedElements do
        table.remove(self.particles, deletedElements[i])
    end
end

function ParticleSystem:draw()
    self:drawParticles()
end

function ParticleSystem:isDead()
    return #self.particles == 0
end

function ParticleSystem:drawParticles()
    for i = 1, #self.particles do
        self.particles[i]:draw()
    end
end

function ParticleSystem:updateParticles()
    for i = 1, #self.particles do
        self.particles[i]:update()
    end
end

function ParticleSystem:update()
    self:removeDiedParticles()
    self:updateParticles()
end


function ParticleSystem:checkClick(x, y)
    if math.abs(self.startPosition.x - x) < self.size and math.abs(self.startPosition.y - y) < self.size and
            #self.particles == 4 then
        self.particles[1].velocity = Vector:create(-5, 0)
        self.particles[2].velocity = Vector:create(0, -5)
        self.particles[3].velocity = Vector:create(5, 0)
        self.particles[4].velocity = Vector:create(0, 5)
        for i = 1, #self.particles do
            self.particles[i].decay = 6
            self.particles[i].clicked = true
        end
    end
end