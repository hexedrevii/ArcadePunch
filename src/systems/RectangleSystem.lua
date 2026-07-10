local System = require "lib.Concord.concord.system"
local Resources = require "src.Resources"

local RectangleSystem = System.new({ pool = { "rectangle", "colour", "fillmode", "position" } })

function RectangleSystem:draw(renderQueue)
  for _, entity in ipairs(self.pool) do
    table.insert(renderQueue, {
      layer = entity:has("layer") and entity.layer.depth or 1,
      draw = function()
        local colour = entity.colour

        local x, y = entity.position.x, entity.position.y

        if entity:has("grid") then
          x = (entity.grid.x + entity.position.x) * Resources.tileSize
          y = (entity.grid.y + entity.position.y) * Resources.tileSize
        end

        if entity:has("offset") then
          x = x + entity.offset.x
          y = y + entity.offset.y
        end

        love.graphics.setColor(colour.r, colour.g, colour.b, colour.a)

        love.graphics.rectangle(
          entity.fillmode.mode,
          x, y,
          entity.rectangle.w, entity.rectangle.h
        )

        love.graphics.setColor(1, 1, 1, 1)
      end
    })
  end
end

return RectangleSystem
