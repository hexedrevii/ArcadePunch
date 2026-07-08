local System = require "lib.Concord.concord.system"

local TimerSystem = System.new({ pool = { "timer" } })

function TimerSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local timer = entity.timer

    timer.time = timer.time - delta
    if timer.time <= 0 then
      timer.time = timer.timeout
      entity:give("timer_complete")

      if timer.oneshot then
        entity:remove("timer")
      end
    end
  end
end

return TimerSystem
