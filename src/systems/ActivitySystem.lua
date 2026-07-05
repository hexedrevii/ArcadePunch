local System = require 'lib.Concord.concord.system'
local Resources = require 'src.Resources'

local ActivitySystem = System.new({ pool = { 'Activity', 'Position' } })

function ActivitySystem:draw()
  for _, entity in ipairs(self.pool) do
    local position = entity.Position
    local activity = entity.Activity

    local x, y =
        (Resources.sx + position.x) * Resources.tileSize,
        (Resources.sy + position.y) * Resources.tileSize

    love.graphics.setColor(activity.r, activity.g, activity.b, activity.a)
    love.graphics.setLineWidth(1)
    love.graphics.rectangle('line', x, y, Resources.tileSize, Resources.tileSize)
    love.graphics.setColor(1, 1, 1, 1)
  end
end

return ActivitySystem
