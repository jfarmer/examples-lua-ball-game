require 'class'

Wall = class()

function Wall:init(world, x, y, w, h, color)
  self.body    = love.physics.newBody(world, x, y)
  self.shape   = love.physics.newRectangleShape(w, h)
  self.fixture = love.physics.newFixture(self.body, self.shape)
  self.color = color
end

function Wall:draw()
  old_rgba = {love.graphics.getColor()} -- save the color color, if there is one
  love.graphics.setColor(unpack(self.color))
  love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
  love.graphics.setColor(unpack(old_rgba)) -- restore the old color
end
