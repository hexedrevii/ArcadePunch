local System = require "lib.Concord.concord.system"

local QuitPressedSystem = System.new({ pool = { "quit", "pressed" } })

function QuitPressedSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    entity:remove("pressed")
    love.event.quit(0)
  end
end

return QuitPressedSystem
