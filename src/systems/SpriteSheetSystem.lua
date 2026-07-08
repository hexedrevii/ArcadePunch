local System = require "lib.Concord.concord.system"

local SpriteSheetSystem = System.new({ pool = { "spritesheet", "sprite" } })

function SpriteSheetSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local sheet = entity.spritesheet
    local sprite = entity.sprite

    if sheet.quads == nil then
      sprite.image = sheet.image
      sheet.quads = {}
      for y = 0, sprite.image:getHeight() - sheet.height, sheet.height do
        for x = 0, sprite.image:getWidth() - sheet.width, sheet.width do
          table.insert(sheet.quads, love.graphics.newQuad(x, y, sheet.width, sheet.height, sprite.image:getDimensions()))
        end
      end
    end

    sheet.timer = sheet.timer + delta
    if sheet.timer >= sheet.duration then
      if sheet.oneshot then
        if sheet.tag then
          entity:give(sheet.tag)
        end

        entity:remove("spritesheet")
      else
        sheet.timer = sheet.timer - sheet.duration
      end
    end

    if entity:has("spritesheet") then
      local spriteNum = math.floor(sheet.timer / sheet.duration * #sheet.quads) + 1
      sheet.quad = sheet.quads[spriteNum]
    end
  end
end

return SpriteSheetSystem
