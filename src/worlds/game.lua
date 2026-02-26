local resources = require "src.resources"

local World = require 'lib.Concord.concord.world'
local Entity = require 'lib.Concord.concord.entity'

-- Load components
local Utils = require 'lib.Concord.concord.utils'
Utils.loadNamespace('src/components')
Utils.loadNamespace('src/components/sprites')

-- Load systems, after components or else it freaks out bruh
local SpriteSystem = require "src.systems.SpriteSystem"
local PlayerInputSystem = require "src.systems.PlayerInputSystem"
local SpriteSwitchSystem = require "src.systems.SpriteSwitchSystem"
local TimerSystem = require "src.systems.timers.TimerSystem"
local PlayerSpriteSwitchSystem = require "src.systems.timers.PlayerSpriteSwitchSystem"
local ScreenShakeSystem = require "src.systems.ScreenShakeSystem"
local ActivitySystem = require "src.systems.ActivitySystem"
local OverlaySystem = require "src.systems.OverlaySystem"
local AnimatedSpriteSystem = require "src.systems.AnimatedSpriteSystem"
local DeathSystem = require "src.systems.DeathSystem"
local DamageSystem = require "src.systems.DamageSystem"
local MoleBehaviourSystem = require "src.systems.MoleBehaviourSystem"
local WaveManagerSystem = require "src.systems.WaveManagerSystem"
local GameFinishSystem = require "src.systems.timers.GameFinishSystem"

local game = {}

function game:init()
  self.world = World.new()
  self.world:addSystems(
    WaveManagerSystem,

    MoleBehaviourSystem,

    AnimatedSpriteSystem,
    OverlaySystem,

    ScreenShakeSystem,

    ActivitySystem,
    SpriteSystem,

    PlayerInputSystem,
    SpriteSwitchSystem,

    GameFinishSystem,
    TimerSystem,
    PlayerSpriteSwitchSystem,
    DeathSystem,
    DamageSystem
  )

  self.player = Entity.new(self.world)
      :give('Position', 1, 1)
      :give('Offset', 4, -2)
      :give('Sprite', resources.manager:get('hammerUp'))
      :give('Activity', 1, 1, 1, 0.7)
      :give('Player', resources.saveData.tickets)

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

  resources.manager:set('dust', self.dust)
end

function game:update(delta)
  self.world:emit('update', delta)
  self.dust:update(delta)
end

function game:draw()
  resources.renderer:set()
  love.graphics.clear(0, 0, 0)

  love.graphics.draw(resources.manager:get('background'), 0, 0)
  self.world:emit('draw')
  love.graphics.draw(self.dust, 0, 0)

  resources.renderer:render()
end

return game
