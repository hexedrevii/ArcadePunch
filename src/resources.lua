local InputManager = require 'lib.marshmallow.input'
local Renderer = require 'lib.marshmallow.pixelCanvas'
local WorldController = require 'lib.marshmallow.worldController'
local ResourceManager = require 'src.ResourceManager'

local Resources = {
  Input = InputManager.new(),
  Renderer = Renderer.new(320, 180),
  Worlds = WorldController.new(),
  Manager = ResourceManager.new(),

  cols = 6,
  rows = 3,
  tileSize = 16,

  sx = 6,
  sy = 3,

  saveData = {
    highScore = 0,
    timeOut = 40,
    --timeOut = 3,
    tickets = 10,

    options = {
      fullscreen = true,
    }
  }
}

function Resources.randf(min, max)
  return min + (max - min) * love.math.random()
end

function Resources.playRandomPitch(soundName)
  ---@type love.Source
  local sound = Resources.Manager:get(soundName)

  sound:setPitch(Resources.randf(1, 1.5))
  sound:play()
end

function Resources:applyOptions()
  --love.window.setFullscreen(self.saveData.options.fullscreen, "desktop")
end

return Resources
