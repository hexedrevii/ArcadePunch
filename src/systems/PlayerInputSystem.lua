local System = require 'lib.Concord.concord.system'
local Resources = require 'src.Resources'

local PlayerInputSystem = System.new({ pool = { 'Position', 'Player', 'Offset' }, camera = { 'Camera' } })

function PlayerInputSystem:update(delta)
  local camera = self.camera[1]

  for _, entity in ipairs(self.pool) do
    local position = entity.Position
    local offset = entity.Offset
    local player = entity.Player

    if Resources.Input:isPressed('hit') and not entity:has('Timer') then
      entity:give('SpriteSwitcher', Resources.Manager:get('hammerDown'))
      entity:give('Timer', 0.1, 'PlayerSpriteSwitch')
      entity:give('Damage', 1, position.x, position.y)

      ---@type love.ParticleSystem
      local dust = Resources.Manager:get('dust')
      local x, y =
          (Resources.sx + position.x) * Resources.tileSize + offset.x,
          (Resources.sy + position.y) * Resources.tileSize + offset.y

      dust:setPosition(x + 4, y + 10)
      dust:emit(4)

      camera:give('ScreenShake', 0.2, 1)

      Resources.playRandomPitch('hit')
    end

    if player.moveTimer > 0 then
      player.moveTimer = player.moveTimer - delta
    end

    if player.moveTimer <= 0 then
      local dx, dy = 0, 0

      if Resources.Input:isDown('left') then
        dx = -1
      elseif Resources.Input:isDown('right') then
        dx = 1
      end

      if Resources.Input:isDown('up') then
        dy = -1
      elseif Resources.Input:isDown('down') then
        dy = 1
      end

      if dx ~= 0 or dy ~= 0 then
        position.x = position.x + dx
        position.y = position.y + dy

        position.x = math.max(1, math.min(Resources.cols, position.x))
        position.y = math.max(1, math.min(Resources.rows, position.y))

        player.moveTimer = player.moveDelay
      else
        player.moveTimer = 0
      end
    end
  end
end

return PlayerInputSystem
