local World = require "lib.Concord.concord.world"
local Entity = require "lib.Concord.concord.entity"
local Utils = require "lib.Concord.concord.utils"
local Resources = require "src.Resources"

local Game = {}

function Game:init()
  self.world = World.new()

  local Systems = {}
  Utils.loadNamespace("src/systems", Systems)

  self.world:addSystems(
    Systems.SpriteSystem,
    Systems.RectangleSystem,

    Systems.SpriteSheetSystem,
    Systems.SpritesheetCallbacks.MoleEnterSystem,
    Systems.SpritesheetCallbacks.MoleLeaveSystem,

    Systems.Player.MovementSystem,
    Systems.Player.PunchSystem,
    Systems.Player.PauseSystem,

    Systems.TextSystem,
    Systems.TextUpdate.ScoreTextSystem,
    Systems.TextUpdate.SkullTextSystem,
    Systems.TextUpdate.TimeTextSystem,

    Systems.DamageSystem,
    Systems.DeathSystem,

    Systems.TimerCallbacks.PunchCallbackSystem,
    Systems.TimerCallbacks.MoleCallbackSystem,
    Systems.TimerCallbacks.WaveManagerCallbackSystem,
    Systems.TimerCallbacks.GameTimeCallbackSystem,
    Systems.TimerSystem,

    Systems.GameTimeSystem,
    Systems.FadeSystem,

    Systems.TransitionSystem,

    Systems.ScreenShakeSystem,
    Systems.VirtualButtonSystem,

    Systems.ButtonManagerSystem,
    Systems.UICallbacks.MainMenuPressedSystem
  )

  if self.fromTransition then
    Entity.new(self.world)
        :give("position", 0, 0)
        :give("colour", 0, 0, 0, 1)
        :give("sprite", Resources.Manager:get("backgroundEmpty"))
        :give("fade", 1, true)
        :give("layer", 98)

    self.fromTransition = false
  end

  if Resources.isMobile() or Resources.showTouch then
    Entity.new(self.world)
        :give("position", 40, 90)
        :give("virtual_button", "vup")
        :give("rectangle", 32, 32)
        :give("colour", 1, 1, 1, 0.4)
        :give("sprite", Resources.Manager:get("up"))
        :give("layer", 97)

    Entity.new(self.world)
        :give("position", 40, 140)
        :give("virtual_button", "vdown")
        :give("rectangle", 32, 32)
        :give("colour", 1, 1, 1, 0.4)
        :give("sprite", Resources.Manager:get("down"))
        :give("layer", 97)

    Entity.new(self.world)
        :give("position", 10, 115)
        :give("virtual_button", "vleft")
        :give("rectangle", 32, 32)
        :give("colour", 1, 1, 1, 0.4)
        :give("sprite", Resources.Manager:get("left"))
        :give("layer", 97)

    Entity.new(self.world)
        :give("position", 70, 115)
        :give("virtual_button", "vright")
        :give("rectangle", 32, 32)
        :give("colour", 1, 1, 1, 0.4)
        :give("sprite", Resources.Manager:get("right"))
        :give("layer", 97)

    Entity.new(self.world)
        :give("position", 270, 115)
        :give("virtual_button", "vhit")
        :give("rectangle", 32, 32)
        :give("colour", 1, 1, 1, 0.4)
        :give("sprite", Resources.Manager:get("action"))
        :give("layer", 97)

    Entity.new(self.world)
        :give("position", 5, 5)
        :give("virtual_button", "vpause")
        :give("rectangle", 32, 32)
        :give("colour", 1, 1, 1, 0.4)
        :give("sprite", Resources.Manager:get("pause"))
        :give("layer", 97)
  end

  -- Background (No longer hardcoded (what the fuck was i thinking))
  Entity.new(self.world)
      :give("position", 0, 0)
      :give("sprite", Resources.Manager:get("background"))
      :give("layer", 0)

  -- Wave manager
  Entity.new(self.world)
      :give("timer", 2, false)
      :give("wave_manager")

  -- Pause handler
  Entity.new(self.world)
      :give("paused")

  if Resources.saveData.options.shake then
    -- Camera (only for shake)
    Entity.new(self.world)
        :give("camera")
        :give("layer", 99)
  end

  -- Data holder
  Entity.new(self.world)
      :give("game_data", 0, 0)
      :give("game_time", Resources.saveData.timeout)

  -- Player
  Entity.new(self.world)
      :give("timed_movement", 0.15)
      :give("position", 1, 1)
      :give("grid", Resources.startX, Resources.startY)
      :give("offset", -4, -1)
      :give("colour", 1, 1, 1, 0.7)
      :give("sprite", Resources.Manager:get("hammerUp"))
      :give("layer", 3)
      :give("player")

  -- Panels
  local overlayr, overlayg, overlayb, overlaya = love.math.colorFromBytes(115, 76, 67)
  local outliner, outlineg, outlineb, outlinea = love.math.colorFromBytes(61, 51, 51)
  local height = 40

  Entity.new(self.world)
      :give("position", 0, 180 - height)
      :give("rectangle", 320, height)
      :give("fillmode", "fill")
      :give("colour", overlayr, overlayg, overlayb, overlaya)
      :give("layer", 1)

  Entity.new(self.world)
      :give("position", 1, 180 - height + 1)
      :give("rectangle", 318, height - 2)
      :give("fillmode", "line")
      :give("colour", outliner, outlineg, outlineb, outlinea)
      :give("layer", 2)

  -- Panel sprites
  Entity.new(self.world)
      :give("position", 3, 145)
      :give("sprite", Resources.Manager:get("star"))
      :give("layer", 3)

  Entity.new(self.world)
      :give("position", 3, 163)
      :give("sprite", Resources.Manager:get("ticket"))
      :give("layer", 3)

  Entity.new(self.world)
      :give("position", 308, 145)
      :give("sprite", Resources.Manager:get("clock"))
      :give("layer", 3)

  Entity.new(self.world)
      :give("position", 306, 163)
      :give("sprite", Resources.Manager:get("skull"))
      :give("layer", 3)

  -- Panel text
  local font = Resources.Manager:get("fontNormal")
  Entity.new(self.world)
      :give("position", 100, 142)
      :give("text", "Whack O' Mole!", font)
      :give("colour", 1, 1, 1, 1)
      :give("layer", 4)

  -- Score
  Entity.new(self.world)
      :give("position", 15, 133)
      :give("text", "0", font)
      :give("colour", 1, 1, 1, 1)
      :give("score_text")
      :give("layer", 4)

  -- Tickets
  Entity.new(self.world)
      :give("position", 15, 151)
      :give("text", tostring(Resources.saveData.tickets), font)
      :give("colour", 1, 1, 1, 1)
      :give("layer", 4)

  -- Time
  local time = string.format("%.2f", Resources.saveData.timeout)
  local timeWidth = font:getWidth(time)
  Entity.new(self.world)
      :give("position", Resources.cx - timeWidth - 15, 133)
      :give("text", time, font)
      :give("colour", 1, 1, 1, 1)
      :give("time_text")
      :give("layer", 4)

  -- Kills
  local kills = "0"
  local killsWidth = font:getWidth(kills)
  Entity.new(self.world)
      :give("position", Resources.cx - killsWidth - 15, 151)
      :give("text", kills, font)
      :give("colour", 1, 1, 1, 1)
      :give("skull_text")
      :give("layer", 4)

  self.dust = love.graphics.newParticleSystem(Resources.Manager:get("dust"))
  self.dust:setParticleLifetime(0.4, 0.8)
  self.dust:setSpin(-10, 10)
  self.dust:setSpeed(80, 120)
  self.dust:setSpread(math.pi * 2)
  self.dust:setLinearDamping(3, 6)
  self.dust:setSizes(1.5, 1.0, 0.0)
  self.dust:setColors(
    1, 1, 1, 1,
    1, 1, 1, 0.5,
    1, 1, 1, 0
  )

  Resources.Manager:add("dustParticles", self.dust)
end

function Game:update(delta)
  self.world:emit("update", delta)
  self.dust:update(delta)
end

function Game:draw()
  Resources.Renderer:set()
  love.graphics.clear(0, 0, 0)

  local renderQueue = {}
  self.world:emit("draw", renderQueue)
  table.sort(renderQueue, function(a, b)
    return a.layer < b.layer
  end)

  for _, command in ipairs(renderQueue) do
    command.draw()
  end

  love.graphics.draw(self.dust, 0, 0)
  Resources.Renderer:render()
end

return Game
