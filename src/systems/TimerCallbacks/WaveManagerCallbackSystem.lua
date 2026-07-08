local System = require "lib.Concord.concord.system"
local Patterns = require "src.Patterns"
local Resources = require "src.Resources"
local Assemblers = require "src.Assemblers"

local WaveManagerCallbackSystem = System.new({ pool = { "wave_manager", "timer_complete" } })

function WaveManagerCallbackSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local pattern = Patterns[love.math.random(1, #Patterns)]

    if pattern.type == "random" then
      for _ = 1, pattern.enemies do
        local x, y =
            love.math.random(1, Resources.cols),
            love.math.random(1, Resources.rows)

        Assemblers.mole(self:getWorld(), x, y)
      end
    elseif pattern.type == "coordinated" then
      ---@diagnostic disable-next-line: param-type-mismatch
      for _, enemy in ipairs(pattern.enemies) do
        Assemblers.mole(self:getWorld(), enemy.x, enemy.y)
      end
    end

    entity:remove("timer_complete")
  end
end

return WaveManagerCallbackSystem
