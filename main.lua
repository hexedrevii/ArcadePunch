local Resources = require("src.Resources")
local Scrambler = require("src.Scrambler")
local json = require("lib.json")

local Menu = require 'src.worlds.Menu'

local function addKeybinds()
  Resources.Input:pushKeymap("left", "a", "dpleft")
  Resources.Input:pushKeymap("right", "d", "dpright")
  Resources.Input:pushKeymap("up", "w", "dpup")
  Resources.Input:pushKeymap("down", "s", "dpdown")

  Resources.Input:pushKeymap("hit", "return", "a")
end

function love.load()
  local Utils = require 'lib.Concord.concord.utils'
  Utils.loadNamespace('src/components')

  addKeybinds()
  Resources:applyOptions()

  local data = Scrambler:load()
  if data ~= nil then
    Resources.saveData = json.decode(data)
  end

  Resources.Manager
      :set("hammerUp", love.graphics.newImage("assets/hammer.png"))
      :set("hammerDown", love.graphics.newImage("assets/hammer-down.png"))
      :set("background", love.graphics.newImage("assets/background.png"))
      :set("backgroundEmpty", love.graphics.newImage("assets/background-empty.png"))
      :set("ticket", love.graphics.newImage("assets/ticket.png"))
      :set("star", love.graphics.newImage("assets/star.png"))
      :set("skull", love.graphics.newImage("assets/skull.png"))
      :set("clock", love.graphics.newImage("assets/clock.png"))
      :set("mole", love.graphics.newImage("assets/mole.png"))
      :set("moleLeave", love.graphics.newImage("assets/mole-leave.png"))

  Resources.Manager
      :set("hit", love.audio.newSource("assets/audio/hit.wav", "static"))
      :set("power", love.audio.newSource("assets/audio/powerUp.wav", "static"))
      :set("death", love.audio.newSource("assets/audio/enemy-death.wav", "static"))
      :set("finish", love.audio.newSource("assets/audio/end-whistle.mp3", "static"))

  Resources.Manager
      :set("fontNormal", love.graphics.newFont("assets/fonts/Pixeled.ttf", 10))
      :set("fontBig", love.graphics.newFont("assets/fonts/Pixeled.ttf", 20))

  Resources.Worlds:set(Menu)
end

function love.update(delta)
  Resources.Worlds:update(delta)
end

function love.draw()
  Resources.Worlds:draw()
end

function love.keypressed(key)
  Resources.Input:keypressed(key)
end

function love.keyreleased(key)
  Resources.Input:keyreleased(key)
end

function love.gamepadpressed(joystick, button)
  Resources.Input:gamepadpressed(joystick, button)
end

function love.gamepadreleased(joystick, button)
  Resources.Input:gamepadreleased(joystick, button)
end
