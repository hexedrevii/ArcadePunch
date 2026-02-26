local System = require 'lib.Concord.concord.system'

local SpriteSwitchSystem = System.new({ pool = { 'SpriteSwitcher', 'Sprite' } })

function SpriteSwitchSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local sprite = entity.Sprite
    local switcher = entity.SpriteSwitcher

    sprite.image = switcher.newImage
    entity:remove('SpriteSwitcher')
  end
end

return SpriteSwitchSystem
