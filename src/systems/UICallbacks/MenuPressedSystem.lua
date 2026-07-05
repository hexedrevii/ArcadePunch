local System = require 'lib.Concord.concord.system'
local Resources = require 'src.Resources'

local Menu = require "src.worlds.Menu"

local MenuPressedSystem = System.new({ pool = { 'MenuPressed' } })

function MenuPressedSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    Resources.Worlds:set(Menu)

    entity:remove('MenuPressed')
  end
end

return MenuPressedSystem
