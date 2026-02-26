local System = require 'lib.Concord.concord.system'
local resources = require 'src.resources'

local AnimatedSpriteSystem = System.new({ pool = { 'AnimatedSprite', 'Position' } })

function AnimatedSpriteSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local anim = entity.AnimatedSprite
    -- Hack around Components not having logic lmao
    if anim.quads == nil then
      anim.quads = {}

      local tw, th = anim.texture:getDimensions()

      local cols = math.floor(tw / anim.width)
      local rows = math.floor(th / anim.height)

      for y = 0, rows - 1 do
        for x = 0, cols - 1 do
          table.insert(anim.quads, love.graphics.newQuad(
            x * anim.width, y * anim.height,
            anim.height, anim.width,
            tw, th
          ))
        end
      end
    end

    if not anim.finished then
      anim.timer = anim.timer + delta
      if anim.timer > anim.duration then
        anim.timer = 0

        anim.frame = anim.frame + 1
        if anim.frame > #anim.quads then
          if anim.loop then
            anim.frame = 1
          else
            anim.frame = #anim.quads
            anim.finished = true
          end
        end
      end
    end
  end
end

function AnimatedSpriteSystem:draw()
  for _, entity in ipairs(self.pool) do
    local anim = entity.AnimatedSprite
    local position = entity.Position

    local quad = anim.quads[anim.frame]
    local x, y =
        (resources.sx + position.x) * resources.tileSize,
        (resources.sy + position.y) * resources.tileSize

    if entity:has('Offset') then
      local offset = entity.Offset
      x = x + offset.x
      y = y + offset.y
    end

    love.graphics.draw(anim.texture, quad, x, y)
  end
end

return AnimatedSpriteSystem
