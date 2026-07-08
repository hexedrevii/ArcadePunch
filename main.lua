local Resources = require "src.Resources"
local Game      = require "src.worlds.Game"

function love.load()
  local Utils = require 'lib.Concord.concord.utils'
  Utils.loadNamespace('src/components')

  Resources.Manager
      :add("hammerUp", love.graphics.newImage("assets/hammer.png"))
      :add("hammerDown", love.graphics.newImage("assets/hammer-down.png"))
      :add("background", love.graphics.newImage("assets/background.png"))
      :add("backgroundEmpty", love.graphics.newImage("assets/background-empty.png"))
      :add("ticket", love.graphics.newImage("assets/ticket.png"))
      :add("star", love.graphics.newImage("assets/star.png"))
      :add("skull", love.graphics.newImage("assets/skull.png"))
      :add("clock", love.graphics.newImage("assets/clock.png"))
      :add("mole", love.graphics.newImage("assets/mole.png"))
      :add("moleLeave", love.graphics.newImage("assets/mole-leave.png"))

  Resources.Manager
      :add("hit", love.audio.newSource("assets/audio/hit.wav", "static"))
      :add("power", love.audio.newSource("assets/audio/powerUp.wav", "static"))
      :add("death", love.audio.newSource("assets/audio/enemy-death.wav", "static"))
      :add("finish", love.audio.newSource("assets/audio/end-whistle.mp3", "static"))

  Resources.Worlds:set(Game)
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
