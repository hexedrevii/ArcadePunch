local ResourceManager = require "src.ResourceManager"
local Input           = require "lib.marshmallow.Input"
local Controller      = require "src.worlds.Controller"
local PixelCanvas     = require "lib.marshmallow.PixelCanvas"
local mathx           = require "lib.marshmallow.mathx"

local Resources       = {
  Renderer = PixelCanvas.new(320, 180),

  showTouch = false,

  cx = 320,
  cy = 180,

  tileSize = 16,

  version = "1.1",

  rows = 3,
  cols = 6,

  startX = 6,
  startY = 3,

  saveData = {
    version = 2,

    upgrades = {
    },

    options = {
      fullscreen = true,
      audio = true,
      shake = true,

      outline = true,
    },

    ticketsPer = 3,

    damage = 1,
    highScore = 0,
    tickets = 0,
    timeout = 40.0,
    -- timeout = 1.0,
  },

  Manager = ResourceManager.new(),
  Input = Input.new(),

  Worlds = Controller.new()
}

function Resources.isMobile()
  local os = love.system.getOS()

  return os == "Android" or os == "iOS"
end

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
