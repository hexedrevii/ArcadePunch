local System = require "lib.Concord.concord.system"

local WatchSystem = System.new({ pool = { "watch" } })

function WatchSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local target = entity.watch.target

    if target and not target:inWorld() then
      target:destroy()
    end
  end
end

return WatchSystem
