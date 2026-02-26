local System = require 'lib.Concord.concord.system'
local patterns = require 'src.patterns'
local resources = require 'src.resources'
local Assemblers = require 'src.assemblers'

local WaveManagerSystem = System.new({ pool = { 'WaveManager' } })

function WaveManagerSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local wave = entity.WaveManager

    wave.time = wave.time + delta
    if wave.time >= wave.spawnTime then
      wave.time = 0
      local pattern = patterns[love.math.random(1, #patterns)]

      for _, enemy in ipairs(pattern.enemies) do
        local x, y
        if pattern.type == 'random' then
          x, y = love.math.random(1, resources.sx), love.math.random(1, resources.sy)
        elseif pattern.type == 'coordinated' then
          x, y = enemy.x, enemy.y
        end

        Assemblers.Mole(self:getWorld(), x, y, enemy.timeout)
      end
    end
  end
end

return WaveManagerSystem
