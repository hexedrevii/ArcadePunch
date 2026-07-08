local System = require "lib.Concord.concord.system"

local TextSystem = System.new({ pool = { "text", "position", "colour" } })

function TextSystem:draw(renderQueue)
  for _, entity in ipairs(self.pool) do
    table.insert(renderQueue, {
      layer = entity:has("layer") and entity.layer.depth or 1,
      draw = function()
        love.graphics.setColor(entity.colour.r, entity.colour.g, entity.colour.b, entity.colour.a)
        love.graphics.setFont(entity.text.font)
        love.graphics.print(entity.text.text, entity.position.x, entity.position.y)
        love.graphics.setColor(1, 1, 1, 1)
      end
    })
  end
end

return TextSystem
