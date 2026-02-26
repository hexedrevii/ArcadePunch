local System = require 'lib.Concord.concord.system'
local resources = require 'src.resources'

local PlayerSpriteSwitchSystem = System.new({ pool = { 'PlayerSpriteSwitch' } })

function PlayerSpriteSwitchSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    entity:give('SpriteSwitcher', resources.manager:get('hammerUp'))

    entity:remove('PlayerSpriteSwitch')
  end
end

return PlayerSpriteSwitchSystem
