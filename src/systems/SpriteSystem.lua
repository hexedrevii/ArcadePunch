local System = require 'lib.Concord.concord.system'
local Resources = require 'src.Resources'

local SpriteSystem = System.new({ pool = { 'Sprite', 'Position' } })

function SpriteSystem:draw()
  for _, entity in ipairs(self.pool) do
    local sprite = entity.Sprite
    local position = entity.Position

    local ox = Resources.sx
    local oy = Resources.sy
    if entity:has('Offset') then
      local offset = entity.Offset
      love.graphics.draw(sprite.image,
        (ox + position.x) * Resources.tileSize + offset.x,
        (oy + position.y) * Resources.tileSize + offset.y
      )
    else
      love.graphics.draw(sprite.image, (ox + position.x) * Resources.tileSize, (oy + position.y) * Resources.tileSize)
    end
  end
end

return SpriteSystem
