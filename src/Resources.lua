local ResourceManager = require "src.ResourceManager"
local Input           = require "lib.marshmallow.Input"
local Controller      = require "src.worlds.Controller"
local PixelCanvas     = require "lib.marshmallow.PixelCanvas"
local mathx           = require "lib.marshmallow.mathx"

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
    options = {
      fullscreen = false,
      audio = true,
      shake = true
    },

    highScore = 0,
    tickets = 10,
    timeout = 40.0,
    -- timeout = 1.0,
  },

  Manager = ResourceManager.new(),
  Input = Input.new(),

  Worlds = Controller.new()
}

---@param name string The resource name of the audio
---@param randomPitch boolean?
function Resources.playAudio(name, randomPitch)
  if not Resources.saveData.options.audio then return end

  ---@type love.Source
  local audio = Resources.Manager:get(name)

  if audio:isPlaying() then
    audio:stop()
  end

  if randomPitch then
    audio:setPitch(mathx.randf(1, 1.5))
  end

  audio:play()
end

return Resources
