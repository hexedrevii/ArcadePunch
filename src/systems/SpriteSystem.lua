local System = require "lib.Concord.concord.system"

local SpriteSystem = System.new({ pool = { "sprite", "position" } })

function SpriteSystem:draw()
  for _, entity in ipairs(self.pool) do
    love.graphics.draw(entity.sprite.image, entity.position.x, entity.position.y)
  end
end

return SpriteSystem
