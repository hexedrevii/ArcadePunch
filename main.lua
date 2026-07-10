local Resources = require "src.Resources"
local Game      = require "src.worlds.Game"
local Menu      = require "src.worlds.Menu"
local Saver     = require "src.Saver"

local function loadKeys()
  Resources.Input:pushKeymap("left", "a", "dpleft", nil, "vleft")
  Resources.Input:pushKeymap("right", "d", "dpright", nil, "vright")
  Resources.Input:pushKeymap("up", "w", "dpup", nil, "vup")
  Resources.Input:pushKeymap("down", "s", "dpdown", nil, "vdown")

  Resources.Input:pushKeymap("hit", "return", "a", nil, "vhit")

  Resources.Input:pushKeymap("pause", "escape", "start", nil, "vpause")
end

function love.load()
  local Utils = require 'lib.Concord.concord.utils'
  Utils.loadNamespace('src/components')

  local data = Saver.load()
  if data then
    Resources.saveData = data
  end

  if Resources.saveData.options.fullscreen then
    love.window.setFullscreen(true, "desktop")
  end

  if Resources.isMobile() then
    love.window.setMode(2, 1)
  end

  loadKeys()

  Resources.Manager:add("fontNormal", love.graphics.newFont("assets/fonts/04B.TTF", 16))

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

  -- Mobile button stuff
  Resources.Manager
      :add("up", love.graphics.newImage("assets/up.png"))
      :add("left", love.graphics.newImage("assets/left.png"))
      :add("right", love.graphics.newImage("assets/right.png"))
      :add("down", love.graphics.newImage("assets/down.png"))
      :add("action", love.graphics.newImage("assets/action.png"))
      :add("pause", love.graphics.newImage("assets/pause.png"))

  Resources.Manager
      :add("hit", love.audio.newSource("assets/audio/hit.wav", "static"))
      :add("power", love.audio.newSource("assets/audio/powerUp.wav", "static"))
      :add("death", love.audio.newSource("assets/audio/enemy-death.wav", "static"))
      :add("finish", love.audio.newSource("assets/audio/end-whistle.mp3", "static"))
      :add("buy", love.audio.newSource("assets/audio/buy.wav", "static"))
      :add("reject", love.audio.newSource("assets/audio/rejected.wav", "static"))

  Resources.Worlds:set(Game)
end

function love.update(delta)
  if not Resources.showTouch then
    local touches = love.touch.getTouches()
    if not next(touches) == nil then
      Resources.showTouch = true
    end
  end

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
