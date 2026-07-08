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

  -- Player
  Entity.new(self.world)
      :give("timed_movement", 0.15)
      :give("position", 1, 1)
      :give("grid", Resources.startX, Resources.startY)
      :give("offset", -4, -1)
      :give("colour", 1, 1, 1, 0.7)
      :give("sprite", Resources.Manager:get("hammerUp"))
      :give("layer", 2)
      :give("game_data", 0, 0)
      :give("player")

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
  self.world:emit("draw")
  love.graphics.draw(self.dust, 0, 0)
  Resources.Renderer:render()
end

return Game
