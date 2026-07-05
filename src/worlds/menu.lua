local World              = require 'lib.Concord.concord.world'
local Resources          = require 'src.Resources'
local Utils = require "lib.Concord.concord.utils"

local menu               = {}

function menu:init()
  self.special = { 217 / 255, 87 / 255, 99 / 255 }
  self.high = { 253 / 255, 209 / 255, 121 / 255 }

  local font = Resources.Manager:get('fontNormal')

  local Systems = {}
  Utils.loadNamespace("src/systems", Systems)

  self.world = World.new()
  self.world:addSystems(
    Systems.ScreenShakeSystem,
    Systems.UICallbacks.RetryPressedSystem,
    Systems.UICallbacks.UIManagerSystem,
    Systems.UICallbacks.TextUISystem,
    Systems.UICallbacks.QuitPressedSystem
  )

  self.world:newEntity()
      :give('Position', 0, 25)
      :give('Text', 'Arcade Punch!', { 1, 1, 1, 1 }, nil, true, font)

  self.world:newEntity()
      :give('UIManager', 'vertical', 4)

  self.world:newEntity()
      :give('Position', 0, 100)
      :give('Text', 'Play', { 1, 1, 1, 1 }, self.high, true, font)
      :give('UI', 1, 'RetryPressed')

  self.world:newEntity()
      :give('Position', 0, 115)
      :give('Text', 'Shop', { 1, 1, 1, 1 }, self.high, true, font)
      :give('UI', 2, 'ShopPressed')

  self.world:newEntity()
      :give('Position', 0, 130)
      :give('Text', 'Options', { 1, 1, 1, 1 }, self.high, true, font)
      :give('UI', 3, 'OptionsPressed')

  self.world:newEntity()
      :give('Position', 0, 145)
      :give('Text', 'Quit', { 1, 1, 1, 1 }, self.high, true, font)
      :give('UI', 4, 'QuitPressed')
end

function menu:update(delta)
  self.world:emit('update', delta)
end

function menu:draw()
  Resources.Renderer:set()
  love.graphics.clear(1, 1, 1)
  love.graphics.draw(Resources.Manager:get('backgroundEmpty'), 0, 0)

  self.world:emit('draw')
  Resources.Renderer:render()
end

return menu
