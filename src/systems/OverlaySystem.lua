local System = require 'lib.Concord.concord.system'
local Resources = require 'src.Resources'

local OverlaySystem = System.new({ pool = { 'Player', 'Position' } })

---@diagnostic disable-next-line: duplicate-set-field
function OverlaySystem:init()
  self.overlayColour = { 115 / 255, 76 / 255, 67 / 255, 1 }
  self.outlineColour = { 61 / 255, 51 / 255, 51 / 255, 1 }

  self.specialKillColour = { 217 / 255, 87 / 255, 99 / 255 }

  self.height = 40
  self.currentTime = Resources.saveData.timeOut

  self.stop = false
end

function OverlaySystem:update(delta)
  for _, entity in ipairs(self.pool) do
    if self.stop then return end

    self.currentTime = self.currentTime - delta
    if self.currentTime <= 0 then
      self.currentTime = 0
      Resources.Manager:get('finish'):play()

      entity:give('Timer', 0.75, 'GameFinish')
      self.stop = true

      -- Remove systems so the game doesnt fuck around after the whistle blows
      local world = self:getWorld()
      world:getSystem(require("src.systems.MoleBehaviourSystem")):setEnabled(false)
      world:getSystem(require("src.systems.PlayerInputSystem")):setEnabled(false)
    end
  end
end

function OverlaySystem:draw()
  ---@type love.Font
  local font = Resources.Manager:get('fontNormal')

  for _, entity in ipairs(self.pool) do
    local player = entity.Player

    local width = love.graphics.getLineWidth()

    -- Background
    love.graphics.setColor(self.overlayColour)
    love.graphics.rectangle('fill', 0, 180 - self.height, 320, self.height)

    -- Accent
    love.graphics.setColor(self.outlineColour)
    love.graphics.rectangle('line', 0 + width, 180 - self.height + width, 320 - width - 1, self.height - width - 1)

    -- Data
    love.graphics.setFont(font)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(Resources.Manager:get('star'), 3, 145)
    love.graphics.print('' .. player.score, 15, 133)

    love.graphics.draw(Resources.Manager:get('ticket'), 3, 163)
    love.graphics.print('' .. player.tickets, 15, 151)

    love.graphics.print('Whack o\' Mole!', 100, 142)

    love.graphics.draw(Resources.Manager:get('clock'), 320 - 12, 145)

    local timeLeft = string.format('%.2f', self.currentTime)
    local timeWidth = font:getWidth(timeLeft)
    love.graphics.print(timeLeft, 320 - timeWidth - 15, 133)

    love.graphics.draw(Resources.Manager:get('skull'), 320 - 14, 163)

    if player.kills >= 50 then
      love.graphics.setColor(self.specialKillColour)
    end

    local killWidth = font:getWidth('' .. player.kills)
    love.graphics.print('' .. player.kills, 320 - killWidth - 15, 151)

    love.graphics.setColor(1, 1, 1, 1)
  end
end

return OverlaySystem
