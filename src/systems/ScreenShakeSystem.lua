local System = require 'lib.Concord.concord.system'

local ScreenShakeSystem = System.new({ pool = { 'ScreenShake', 'Camera' } })

function ScreenShakeSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local shake = entity.ScreenShake

    shake.duration = shake.duration - delta
    if shake.duration <= 0 then
      entity:remove('ScreenShake')
    end
  end
end

function ScreenShakeSystem:draw()
  for _, entity in ipairs(self.pool) do
    local shake = entity.ScreenShake

    local dx = love.math.random(-shake.magnitude, shake.magnitude)
    local dy = love.math.random(-shake.magnitude, shake.magnitude)

    love.graphics.translate(dx, dy)
  end
end

return ScreenShakeSystem
