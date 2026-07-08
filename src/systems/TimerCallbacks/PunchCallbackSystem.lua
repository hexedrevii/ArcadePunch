local System = require "lib.Concord.concord.system"
local Resources = require "src.Resources"

local PunchCallbackSystem = System.new({ pool = { "player", "sprite", "timer_complete" } })

function PunchCallbackSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    entity.sprite.image = Resources.Manager:get("hammerUp")
    entity:remove("timer_complete")
  end
end

return PunchCallbackSystem
