local resources = require 'src.resources'
local game      = require 'src.worlds.game'

local function addKeybinds()
  resources.input:pushKeymap('left', 'a', 'dpleft')
  resources.input:pushKeymap('right', 'd', 'dpright')
  resources.input:pushKeymap('up', 'w', 'dpup')
  resources.input:pushKeymap('down', 's', 'dpdown')

  resources.input:pushKeymap('hit', 'space', 'a')
end

function love.load()
  addKeybinds()

  resources.manager
      :set('hammerUp', love.graphics.newImage('assets/hammer.png'))
      :set('hammerDown', love.graphics.newImage('assets/hammer-down.png'))
      :set('background', love.graphics.newImage('assets/background.png'))
      :set('ticket', love.graphics.newImage('assets/ticket.png'))
      :set('star', love.graphics.newImage('assets/star.png'))
      :set('skull', love.graphics.newImage('assets/skull.png'))
      :set('clock', love.graphics.newImage('assets/clock.png'))
      :set('mole', love.graphics.newImage('assets/mole.png'))
      :set('moleLeave', love.graphics.newImage('assets/mole-leave.png'))

  resources.manager
      :set('hit', love.audio.newSource('assets/audio/hit.wav', 'static'))
      :set('power', love.audio.newSource('assets/audio/powerUp.wav', 'static'))
      :set('death', love.audio.newSource('assets/audio/enemy-death.wav', 'static'))
      :set('finish', love.audio.newSource('assets/audio/end-whistle.mp3', 'static'))

  resources.manager
      :set('fontNormal', love.graphics.newFont('assets/fonts/Pixeled.ttf', 10))

  resources.worlds:set(game)
end

function love.update(delta)
  resources.worlds:update(delta)
end

function love.draw()
  resources.worlds:draw()
end

function love.keypressed(key)
  resources.input:keypressed(key)
end

function love.keyreleased(key)
  resources.input:keyreleased(key)
end

function love.gamepadpressed(joystick, button)
  resources.input:gamepadpressed(joystick, button)
end

function love.gamepadreleased(joystick, button)
  resources.input:gamepadreleased(joystick, button)
end
