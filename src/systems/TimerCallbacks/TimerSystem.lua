local System = require 'lib.Concord.concord.system'

local TimerSystem = System.new({ pool = { 'Timer' } })

function TimerSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local timer = entity.Timer

    timer.time = timer.time + delta
    if timer.time >= timer.timeout then
      entity:remove('Timer')
      entity:give(timer.tag)
    end
  end
end

return TimerSystem
