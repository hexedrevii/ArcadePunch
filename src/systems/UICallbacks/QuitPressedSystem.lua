local System = require 'lib.Concord.concord.system'

local QuitPressedSystem = System.new({ pool = { 'QuitPressed' } })

function QuitPressedSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    love.event.quit(-1)
  end
end

return QuitPressedSystem
