local System = require "lib.Concord.concord.system"
local Entity = require "lib.Concord.concord.entity"
local Resources = require "src.Resources"

local GameTimeSystem = System.new({ pool = { "game_time" } })

local systemsToDisable = {
  require "src.systems.TimerCallbacks.WaveManagerCallbackSystem",
  require "src.systems.Player.PunchSystem",
  require "src.systems.Player.MovementSystem"
}

function GameTimeSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local time = entity.game_time

    time.timeout = time.timeout - delta
    if time.timeout <= 0 then
      time.timeout = 0

      local world = self:getWorld()

      entity:give("timer", 0.75, false)

      for _, system in ipairs(systemsToDisable) do
        world:getSystem(system):setEnabled(false)
      end

      self:setEnabled(false)
    end
  end
end

return GameTimeSystem
