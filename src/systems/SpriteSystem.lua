local System = require "lib.Concord.concord.system"
local Resources = require "src.Resources"

local SpriteSystem = System.new({ pool = { "sprite", "position" } })

function SpriteSystem:draw(renderQueue)
  for _, entity in ipairs(self.pool) do
    table.insert(renderQueue, {
      layer = entity:has("layer") and entity.layer.depth or 1,
      draw = function()
        local x = entity.position.x
        local y = entity.position.y

        if entity:has("grid") then
          x = (entity.grid.x + entity.position.x) * Resources.tileSize
          y = (entity.grid.y + entity.position.y) * Resources.tileSize
        end

        if entity:has("colour") then
          love.graphics.setColor(entity.colour.r, entity.colour.g, entity.colour.b, entity.colour.a)
        end

        if entity:has("spritesheet") and entity.spritesheet.quad then
          love.graphics.draw(
            entity.sprite.image,
            entity.spritesheet.quad,
            x, y,
            nil, nil, nil,
            entity:has("offset") and entity.offset.x or nil,
            entity:has("offset") and entity.offset.y or nil
          )
        else
          love.graphics.draw(
            entity.sprite.image,
            x, y,
            nil, nil, nil,
            entity:has("offset") and entity.offset.x or nil,
            entity:has("offset") and entity.offset.y or nil
          )
        end
        love.graphics.setColor(1, 1, 1, 1)
      end
    })
  end
end

return SpriteSystem
