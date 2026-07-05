local System = require 'lib.Concord.concord.system'
local Resources = require 'src.Resources'

local Game = require "src.worlds.Game"

local RetryPressedSystem = System.new({ pool = { 'RetryPressed' } })

function RetryPressedSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    Resources.Worlds:set(Game)

    entity:remove('RetryPressed')
  end
end

return RetryPressedSystem
