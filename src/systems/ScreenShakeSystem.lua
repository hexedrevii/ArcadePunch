local System = require 'lib.Concord.concord.system'

local ScreenShakeSystem = System.new({ pool = { "camera", "shake", "layer" } })

function ScreenShakeSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local shake = entity.shake

    shake.duration = shake.duration - delta
    if shake.duration <= 0 then
      entity:remove("shake")
    end
  end
end

function ScreenShakeSystem:draw(renderQueue)
  for _, entity in ipairs(self.pool) do
    table.insert(renderQueue, {
      layer = entity.layer.depth,
      draw = function()
        local shake = entity.shake

        local dx = love.math.random(-shake.magnitude, shake.magnitude)
        local dy = love.math.random(-shake.magnitude, shake.magnitude)

        love.graphics.translate(dx, dy)
      end
    })
  end
end

return ScreenShakeSystem
