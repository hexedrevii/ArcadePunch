local System = require 'lib.Concord.concord.system'
local resources = require 'src.resources'

local SpriteSystem = System.new({ pool = { 'Sprite', 'Position' } })

function SpriteSystem:draw()
  for _, entity in ipairs(self.pool) do
    local sprite = entity.Sprite
    local position = entity.Position

    local ox = resources.sx
    local oy = resources.sy
    if entity:has('Offset') then
      local offset = entity.Offset
      love.graphics.draw(sprite.image,
        (ox + position.x) * resources.tileSize + offset.x,
        (oy + position.y) * resources.tileSize + offset.y
      )
    else
      love.graphics.draw(sprite.image, (ox + position.x) * resources.tileSize, (oy + position.y) * resources.tileSize)
    end
  end
end

return SpriteSystem
