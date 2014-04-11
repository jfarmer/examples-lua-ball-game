require 'ball'
require 'wall'

function love.load()
  local window_w, window_h = 650, 650
  local ground_w, ground_h = 650, 50
  local pixels_per_meter, gravity = 64, 9.81

  love.physics.setMeter(pixels_per_meter)
  world = love.physics.newWorld(pixels_per_meter*gravity/2, pixels_per_meter*gravity, true)

  objects = {}

  objects.ground     = Wall(world, window_w/2, window_h - ground_h/2, ground_w, ground_h, {72, 160, 14})
  objects.ceiling    = Wall(world, window_w/2, ground_h/2, ground_w, ground_h, {142, 35, 35})
  objects.left_wall  = Wall(world, ground_h/2, window_h/2, ground_h, window_h - ground_h*2, {142, 35, 35})
  objects.right_wall = Wall(world, window_w - ground_h/2, window_h/2, ground_h, window_h - ground_h*2, {142, 35, 35})

  objects.ball = Ball(world, window_w/2, window_h/2, 20, 100)

  love.window.setMode(window_w, window_h)
end

function love.draw()
  for name, object in pairs(objects) do
    object:draw()
  end

  love.graphics.setColor(255, 255, 255)
  love.graphics.print(string.format("Fuel: %d", objects.ball.getFuel()), 100, 100)
end

function love.update(dt)
  world:update(dt)

  for name, object in pairs(objects) do
    if object.update then
      object:update(dt)
    end
  end
end
