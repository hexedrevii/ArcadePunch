local System = require 'lib.Concord.concord.system'
local resources = require 'src.resources'

local RetryPressedSystem = System.new({ pool = { 'RetryPressed' } })

function RetryPressedSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local game = require 'src.worlds.game'
    resources.worlds:set(game)

    entity:remove('RetryPressed')
  end
end

return RetryPressedSystem
