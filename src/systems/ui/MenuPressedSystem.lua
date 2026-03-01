local System = require 'lib.Concord.concord.system'
local resources = require 'src.resources'

local MenuPressedSystem = System.new({ pool = { 'MenuPressed' } })

function MenuPressedSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local menu = require 'src.worlds.menu'
    resources.worlds:set(menu)

    entity:remove('MenuPressed')
  end
end

return MenuPressedSystem
