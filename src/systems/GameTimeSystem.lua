local System = require "lib.Concord.concord.system"

local GameTimeSystem = System.new({ pool = { "game_time" } })

function GameTimeSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local time = entity.game_time

    time.timeout = time.timeout - delta
    if time.timeout <= 0 then
      time.timeout = 0

      -- TODO: End Game
    end
  end
end

return GameTimeSystem
