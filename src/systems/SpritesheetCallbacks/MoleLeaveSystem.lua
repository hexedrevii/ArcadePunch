local System = require "lib.Concord.concord.system"

local MoleLeaveSystem = System.new({ pool = { "mole_leave" } })

function MoleLeaveSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    entity:destroy()
  end
end

return MoleLeaveSystem
