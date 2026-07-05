local System = require 'lib.Concord.concord.system'
local Resources = require 'src.Resources'

local PlayerSpriteSwitchSystem = System.new({ pool = { 'PlayerSpriteSwitch' } })

function PlayerSpriteSwitchSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    entity:give('SpriteSwitcher', Resources.Manager:get('hammerUp'))

    entity:remove('PlayerSpriteSwitch')
  end
end

return PlayerSpriteSwitchSystem
