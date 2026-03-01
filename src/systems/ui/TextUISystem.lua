local System = require 'lib.Concord.concord.system'

local TextUISystem = System.new({ pool = { 'Text', 'Position' } })

function TextUISystem:draw()
  for _, entity in ipairs(self.pool) do
    local pos = entity.Position
    local text = entity.Text

    if text.font then
      love.graphics.setFont(text.font)
    end

    if entity:has('UI') then
      local ui = entity.UI
      if ui.active then
        love.graphics.setColor(text.active)
      else
        love.graphics.setColor(text.idle)
      end
    else
      love.graphics.setColor(text.idle)
    end

    love.graphics.printf(text.text, math.floor(pos.x), math.floor(pos.y), 320, text.center)

    love.graphics.setColor(1, 1, 1, 1)
  end
end

return TextUISystem
