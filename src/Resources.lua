local ResourceManager = require "src.ResourceManager"
local Input           = require "lib.marshmallow.Input"
local Controller      = require "src.worlds.Controller"
local PixelCanvas     = require "lib.marshmallow.PixelCanvas"

local Resources       = {
  Renderer = PixelCanvas.new(320, 180),

  cx = 320,
  cy = 180,

  tileSize = 16,
  startX = 7,
  startY = 4,

  Manager = ResourceManager.new(),
  Input = Input.new(),

  Worlds = Controller.new()
}

return Resources
