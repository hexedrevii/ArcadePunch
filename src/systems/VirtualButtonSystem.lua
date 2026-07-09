local System = require "lib.Concord.concord.system"
local Resources = require "src.Resources"

local VirutalButtonSystem = System.new({ pool = { "virtual_button", "position", "rectangle" } })

function VirutalButtonSystem:update()
  local touches = love.touch.getTouches()

  for _, entity in ipairs(self.pool) do
    local button = entity.virtual_button
    local position = entity.position
    local rectangle = entity.rectangle

    local was = button.down
    button.down = false

    for _, id in ipairs(touches) do
      local tx, ty = love.touch.getPosition(id)
      local x, y = Resources.Renderer:getCoordsWorld(tx, ty)

      if x > position.x and x <= position.x + rectangle.w and y > position.y and y <= position.y + rectangle.h then
        button.down = true
      else
        button.down = false
      end
    end

    if button.down and not was then
      Resources.Input:virtualpressed(button.name)
    elseif not button.down and was then
      Resources.Input:virtualreleased(button.name)
    end
  end
end

return VirutalButtonSystem
