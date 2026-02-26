local resources = require 'src.resources'
local System = require 'lib.Concord.concord.system'

local DeathSystem = System.new({ pool = { 'Dead' }, player = { 'Player' } })

function DeathSystem:update(delta)
  local player = self.player[1].Player

  for _, entity in ipairs(self.pool) do
    if entity:has('Drop') then
      local drop = entity.Drop
      player.score = player.score + drop.score
    end

    player.kills = player.kills + 1
    if player.kills ~= 0 and player.kills % 10 == 0 then
      resources.playRandomPitch('power')
    end

    entity:destroy()
    resources.playRandomPitch('death')
  end
end

return DeathSystem
