local Resources = require "src.Resources"
local Game      = require "src.worlds.Game"
local Menu      = require "src.worlds.Menu"
local Saver     = require "src.Saver"

local function loadKeys()
  Resources.Input:pushKeymap("left", "a", "dpleft")
  Resources.Input:pushKeymap("right", "d", "dpright")
  Resources.Input:pushKeymap("up", "w", "dpup")
  Resources.Input:pushKeymap("down", "s", "dpdown")

  Resources.Input:pushKeymap("hit", "return", "a")
end

function love.load()
  local Utils = require 'lib.Concord.concord.utils'
  Utils.loadNamespace('src/components')

  local data = Saver.load()
  if data then
    Resources.saveData = data
  end

  loadKeys()

  Resources.Manager:add("fontNormal", love.graphics.newFont("assets/fonts/Pixeled.ttf", 10))

  Resources.Manager
      :add("hammerUp", love.graphics.newImage("assets/hammer.png"))
      :add("hammerDown", love.graphics.newImage("assets/hammer-down.png"))
      :add("background", love.graphics.newImage("assets/background.png"))
      :add("backgroundEmpty", love.graphics.newImage("assets/background-empty.png"))
      :add("ticket", love.graphics.newImage("assets/ticket.png"))
      :add("star", love.graphics.newImage("assets/star.png"))
      :add("skull", love.graphics.newImage("assets/skull.png"))
      :add("clock", love.graphics.newImage("assets/clock.png"))
      :add("dust", love.graphics.newImage("assets/dust.png"))
      :add("moleEnter", love.graphics.newImage("assets/mole-enter.png"))
      :add("moleIdle", love.graphics.newImage("assets/mole-idle.png"))
      :add("moleLeave", love.graphics.newImage("assets/mole-leave.png"))

  Resources.Manager
      :add("hit", love.audio.newSource("assets/audio/hit.wav", "static"))
      :add("power", love.audio.newSource("assets/audio/powerUp.wav", "static"))
      :add("death", love.audio.newSource("assets/audio/enemy-death.wav", "static"))
      :add("finish", love.audio.newSource("assets/audio/end-whistle.mp3", "static"))

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
