local System = require "lib.Concord.concord.system"
local Resources = require "src.Resources"

local MoleEnterSystem = System.new({ pool = { "mole", "mole_enter", "sprite" } })

function MoleEnterSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    entity.sprite.image = Resources.Manager:get("moleIdle")
    entity:give("timer", 0.75, true)

    entity:remove("mole_enter")
  end
end

return MoleEnterSystem
