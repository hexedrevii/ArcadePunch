local ResourceManager = require "src.ResourceManager"
local Input           = require "lib.marshmallow.Input"
local Controller      = require "src.worlds.Controller"
local PixelCanvas     = require "lib.marshmallow.PixelCanvas"

local Resources       = {
  Renderer = PixelCanvas.new(320, 180),

  cx = 320,
  cy = 180,

  tileSize = 16,

  rows = 3,
  cols = 6,

  startX = 6,
  startY = 3,

  saveData = {
    highScore = 0,
    tickets = 10,
    timeout = 40.0,
    -- timeout = 1.0,
  },

  Manager = ResourceManager.new(),
  Input = Input.new(),

  Worlds = Controller.new()
}

return Resources
