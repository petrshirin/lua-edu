require("vector")
require("particle")
require("particleSystem")
require('SquareParticleSystem')


function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    particleSystem = SquareParticleSystem:create(Vector:create(width / 2, height / 2), 10)
end

function love.update(dt)
    particleSystem:update()
end

function love.draw()
    particleSystem:draw()
end

function love.mousepressed(x, y, button, istouch, presses)
    for i = 1, #particleSystem.particles do
        particleSystem.particles[i]:checkClick(x ,y)
    end
end

function love.mousereleased(x, y, button, istouch,  presses)
end    