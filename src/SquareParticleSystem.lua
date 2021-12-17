SquareParticleSystem = {}
SquareParticleSystem.__index = SquareParticleSystem


function SquareParticleSystem:create(startPosition, maxCount, particleClass)
    local squareParticleSystem = {}
    setmetatable(squareParticleSystem, SquareParticleSystem)
    squareParticleSystem.startPosition = startPosition
    squareParticleSystem.maxCount = maxCount
    squareParticleSystem.particleClass = particleClass or ParticleSystem
    squareParticleSystem.particles = {}
    return squareParticleSystem
end

function SquareParticleSystem:generateParticles()
    while #self.particles < self.maxCount do
        local particle = self.particleClass:create(Vector:create(
                math.random(0, 600),
                math.random(0, 600)), 50
        )
        table.insert(self.particles, particle)
        particle:draw()
    end

end

function SquareParticleSystem:removeDiedParticles()
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

function SquareParticleSystem:draw()
    self:drawParticles()
end

function SquareParticleSystem:drawParticles()
    for i = 1, #self.particles do
        self.particles[i]:draw()
    end
end

function SquareParticleSystem:updateParticles()
    for i = 1, #self.particles do
        self.particles[i]:update()
    end
end

function SquareParticleSystem:update()
    self:removeDiedParticles()
    self:generateParticles()
    self:updateParticles()
end