local System = require "lib.Concord.concord.system"
local Resources = require "src.Resources"

local SpriteSystem = System.new({ pool = { "sprite", "position" } })

function SpriteSystem:draw()
  local entities = {}
  for _, entity in ipairs(self.pool) do
    table.insert(entities, entity)
  end

  table.sort(entities, function(a, b)
    local layerA = a:has("layer") and a.layer.depth or 1
    local layerB = b:has("layer") and b.layer.depth or 1

    return layerA < layerB
  end)

  for _, entity in ipairs(entities) do
    local x = entity.position.x
    local y = entity.position.y

    if entity:has("grid") then
      x = (entity.grid.x + entity.position.x) * Resources.tileSize
      y = (entity.grid.y + entity.position.y) * Resources.tileSize
    end

    if entity:has("colour") then
      love.graphics.setColor(entity.colour.r, entity.colour.g, entity.colour.b, entity.colour.a)
    end

    love.graphics.draw(
      entity.sprite.image,
      x, y,
      nil, nil, nil,
      entity:has("offset") and entity.offset.x or nil,
      entity:has("offset") and entity.offset.y or nil
    )

    love.graphics.setColor(1, 1, 1, 1)
  end
end

return SpriteSystem
