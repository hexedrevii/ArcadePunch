local System = require 'lib.Concord.concord.system'
local Resources = require 'src.Resources'

local UIManagerSystem = System.new({ pool = { 'UI' }, controller = { 'UIManager' } })

function UIManagerSystem:update(delta)
  local controller = self.controller[1].UIManager

  local negative = controller.direction == 'vertical' and 'up' or 'left'
  local positive = controller.direction == 'vertical' and 'down' or 'right'

  if Resources.Input:isPressed(negative) then
    controller.active = controller.active - 1
  elseif Resources.Input:isPressed(positive) then
    controller.active = controller.active + 1
  end

  controller.active = math.max(1, math.min(controller.active, controller.max))

  local hitPressed = Resources.Input:isPressed('hit')

  for _, entity in ipairs(self.pool) do
    local ui = entity.UI

    if controller.active == ui.index then
      ui.active = true
      if hitPressed then
        entity:give(ui.tag)
      end
    else
      ui.active = false
    end
  end
end

return UIManagerSystem
