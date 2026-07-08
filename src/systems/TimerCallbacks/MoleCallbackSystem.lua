local System = require "lib.Concord.concord.system"
local Resources = require "src.Resources"

local MoleCallbackSystem = System.new({ pool = { "mole", "timer_complete", "sprite" } })

function MoleCallbackSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    entity:give("spritesheet", Resources.Manager:get("moleLeave"), 16, 16, 1, true, "mole_leave")

    entity:remove("timer_complete")
  end
end

return MoleCallbackSystem
