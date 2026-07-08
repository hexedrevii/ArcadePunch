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

    Systems.SpriteSheetSystem,
    Systems.SpritesheetCallbacks.MoleEnterSystem,
    Systems.SpritesheetCallbacks.MoleLeaveSystem,

    Systems.Player.MovementSystem,
    Systems.Player.PunchSystem,

    Systems.DamageSystem,
    Systems.DeathSystem,

    Systems.TimerCallbacks.PunchCallbackSystem,
    Systems.TimerCallbacks.MoleCallbackSystem,
    Systems.TimerCallbacks.WaveManagerCallbackSystem,
    Systems.TimerSystem,

    Systems.RectangleSystem,
    Systems.ScreenShakeSystem
  )

  -- Background (No longer hardcoded (what the fuck was i thinking))
  Entity.new(self.world)
      :give("position", 0, 0)
      :give("sprite", Resources.Manager:get("background"))
      :give("layer", 0)

  -- Wave manager
  Entity.new(self.world)
      :give("timer", 2, false)
      :give("wave_manager")

  -- Camera (only for shake)
  Entity.new(self.world)
      :give("camera")
      :give("layer", 99)

  -- Player
  Entity.new(self.world)
      :give("timed_movement", 0.15)
      :give("position", 1, 1)
      :give("grid", Resources.startX, Resources.startY)
      :give("offset", -4, -1)
      :give("colour", 1, 1, 1, 0.7)
      :give("sprite", Resources.Manager:get("hammerUp"))
      :give("layer", 3)
      :give("game_data", 0, 0)
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
      :give("layer", 1)

  -- Panel sprites
  Entity.new(self.world)
      :give("position", 3, 145)
      :give("sprite", Resources.Manager:get("star"))
      :give("layer", 2)

  Entity.new(self.world)
      :give("position", 3, 163)
      :give("sprite", Resources.Manager:get("ticket"))
      :give("layer", 2)

  Entity.new(self.world)
      :give("position", 308, 145)
      :give("sprite", Resources.Manager:get("clock"))
      :give("layer", 2)

  Entity.new(self.world)
      :give("position", 306, 163)
      :give("sprite", Resources.Manager:get("skull"))
      :give("layer", 2)


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
