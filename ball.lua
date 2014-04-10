require 'class'

Ball = class()

function Ball:init(world, x, y, r, fuel)
  local density = 1
  local restitution = 0.75
  local fuel_rate = 20

  self.body = love.physics.newBody(world, x, y, "dynamic")
  self.shape = love.physics.newCircleShape(r)
  self.fixture = love.physics.newFixture(self.body, self.shape, density)
  self.fixture:setRestitution(restitution)

  self.getFuel = function()
    return fuel
  end

  self.spendFuel = function(self, dt)
    fuel = math.max(0, fuel - fuel_rate*dt)
  end
end

function Ball:update(dt)
  if self:getFuel() == 0 then return end

  if love.keyboard.isDown("w") then self:fireBottomThruster(dt) end
  if love.keyboard.isDown("a") then self:fireRightThruster(dt)  end
  if love.keyboard.isDown("s") then self:fireTopThruster(dt)    end
  if love.keyboard.isDown("d") then self:fireLeftThruster(dt)   end
end

function Ball:draw()
  old_rgba = {love.graphics.getColor()} -- save the old color, if there is one
  love.graphics.setColor(193, 47, 14)
  love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
  love.graphics.setColor(unpack(old_rgba)) -- restore the old color
end

function Ball:fireBottomThruster(dt)
  self.body:applyForce(0, -700)
  self:spendFuel(dt)
end

function Ball:fireTopThruster(dt)
  self.body:applyForce(0, 200)
  self:spendFuel(dt)
end

function Ball:fireLeftThruster(dt)
  self.body:applyForce(200, 0)
  self:spendFuel(dt)
end

function Ball:fireRightThruster(dt)
  self.body:applyForce(-200, 0)
  self:spendFuel(dt)
end
