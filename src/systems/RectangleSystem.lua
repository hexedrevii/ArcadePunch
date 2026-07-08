local System = require "lib.Concord.concord.system"

local RectangleSystem = System.new({ pool = { "rectangle", "colour", "fillmode", "position" } })

function RectangleSystem:draw(renderQueue)
  for _, entity in ipairs(self.pool) do
    table.insert(renderQueue, {
      layer = entity:has("layer") and entity.layer.depth or 1,
      draw = function()
        local colour = entity.colour

        love.graphics.setColor(colour.r, colour.g, colour.b, colour.a)

        love.graphics.rectangle(
          entity.fillmode.mode,
          entity.position.x, entity.position.y,
          entity.rectangle.w, entity.rectangle.h
        )

        love.graphics.setColor(1, 1, 1, 1)
      end
    })
  end
end

return RectangleSystem
