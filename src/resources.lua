local InputManager = require 'lib.marshmallow.input'
local Renderer = require 'lib.marshmallow.pixelCanvas'
local WorldController = require 'lib.marshmallow.worldController'
local ResourceManager = require 'src.resourcemanager'

local resources = {
  input = InputManager.new(),
  renderer = Renderer.new(320, 180),
  worlds = WorldController.new(),
  manager = ResourceManager.new(),

  cols = 6,
  rows = 3,
  tileSize = 16,

  sx = 6,
  sy = 3,

  saveData = {
    highScore = 0,
    timeOut = 40,
    --timeOut = 2,
    tickets = 10,
  }
}

function resources.randf(min, max)
  return min + (max - min) * love.math.random()
end

function resources.playRandomPitch(soundName)
  ---@type love.Source
  local sound = resources.manager:get(soundName)

  sound:setPitch(resources.randf(1, 1.5))
  sound:play()
end

return resources
