local Resources = require "src.Resources"

local World = require 'lib.Concord.concord.world'
local Entity = require 'lib.Concord.concord.entity'

local Utils = require "lib.Concord.concord.utils"

local game = {}

function game:init()
  local Systems = {}
  Utils.loadNamespace("src/systems", Systems)

  self.world = World.new()
  self.world:addSystems(
    Systems.WaveManagerSystem,

    Systems.MoleBehaviourSystem,

    Systems.AnimatedSpriteSystem,
    Systems.OverlaySystem,

    Systems.ScreenShakeSystem,

    Systems.ActivitySystem,
    Systems.SpriteSystem,

    Systems.PlayerInputSystem,
    Systems.SpriteSwitchSystem,

    Systems.TimerCallbacks.GameFinishSystem,
    Systems.TimerCallbacks.TimerSystem,
    Systems.TimerCallbacks.PlayerSpriteSwitchSystem,

    Systems.DeathSystem,
    Systems.DamageSystem
  )

  self.player = Entity.new(self.world)
      :give('Position', 1, 1)
      :give('Offset', 4, -2)
      :give('Sprite', Resources.Manager:get('hammerUp'))
      :give('Activity', 1, 1, 1, 0.7)
      :give('Player', Resources.saveData.tickets)

  self.world:newEntity()
      :give('WaveManager')

  self.world:newEntity()
      :give('Position')
      :give('Camera')

  self.dust = love.graphics.newParticleSystem(love.graphics.newImage('assets/dust.png'))
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

  Resources.Manager:set('dust', self.dust)
end

function game:update(delta)
  self.world:emit('update', delta)
  self.dust:update(delta)
end

function game:draw()
  Resources.Renderer:set()
  love.graphics.clear(0, 0, 0)

  love.graphics.draw(Resources.Manager:get('background'), 0, 0)
  self.world:emit('draw')
  love.graphics.draw(self.dust, 0, 0)

  Resources.Renderer:render()
end

return game
