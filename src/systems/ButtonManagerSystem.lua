local System = require "lib.Concord.concord.system"
local Resources = require "src.Resources"

local ButtonManagerSystem = System.new({ pool = { "button", "colour" }, manager = { "button_manager" } })

function ButtonManagerSystem:update(delta)
  local manager = self.manager[1]
  if not manager then return end

  manager = manager.button_manager

  local negative = manager.direction == 'vertical' and 'up' or 'left'
  local positive = manager.direction == 'vertical' and 'down' or 'right'

  if Resources.Input:isPressed(negative) then
    manager.active = manager.active - 1
  elseif Resources.Input:isPressed(positive) then
    manager.active = manager.active + 1
  end

  manager.active = math.max(1, math.min(manager.active, manager.indices))

  local interacted = Resources.Input:isPressed("hit")

  for _, entity in ipairs(self.pool) do
    local button = entity.button
    local colour = entity.colour

    if manager.active == button.index then
      if interacted then
        entity:give("pressed")
      end

      colour.r = 0.85
      colour.g = 0.34
      colour.b = 0.38
    else
      colour.r = 1
      colour.g = 1
      colour.b = 1
    end
  end
end

return ButtonManagerSystem
