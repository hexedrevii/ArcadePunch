local System = require('lib.Concord.concord.system')

local GameFinishSystem = System.new({ pool = { 'GameFinish' } })

function GameFinishSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local finish = entity.GameFinish
    finish.opacity = finish.opacity + delta
    if finish.opacity >= 1 then
      finish.opacity = 1
      -- TODO: End game scene
    end
  end
end

function GameFinishSystem:draw()
  for _, entity in ipairs(self.pool) do
    local finish = entity.GameFinish

    love.graphics.setColor(0, 0, 0, finish.opacity)
    love.graphics.rectangle('fill', 0, 0, 320, 180)
    love.graphics.setColor(1, 1, 1, 1)
  end
end

return GameFinishSystem
