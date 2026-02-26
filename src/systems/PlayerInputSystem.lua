local System = require 'lib.Concord.concord.system'
local resources = require 'src.resources'

local PlayerInputSystem = System.new({ pool = { 'Position', 'Player', 'Offset' }, camera = { 'Camera' } })

function PlayerInputSystem:update(delta)
  local camera = self.camera[1]

  for _, entity in ipairs(self.pool) do
    local position = entity.Position
    local offset = entity.Offset
    local player = entity.Player

    if resources.input:isPressed('hit') and not entity:has('Timer') then
      entity:give('SpriteSwitcher', resources.manager:get('hammerDown'))
      entity:give('Timer', 0.1, 'PlayerSpriteSwitch')
      entity:give('Damage', 1, position.x, position.y)

      ---@type love.ParticleSystem
      local dust = resources.manager:get('dust')
      local x, y =
          (resources.sx + position.x) * resources.tileSize + offset.x,
          (resources.sy + position.y) * resources.tileSize + offset.y

      dust:setPosition(x + 4, y + 10)
      dust:emit(4)

      camera:give('ScreenShake', 0.2, 1)

      resources.playRandomPitch('hit')
    end

    if player.moveTimer > 0 then
      player.moveTimer = player.moveTimer - delta
    end

    if player.moveTimer <= 0 then
      local dx, dy = 0, 0

      if resources.input:isDown('left') then
        dx = -1
      elseif resources.input:isDown('right') then
        dx = 1
      end

      if resources.input:isDown('up') then
        dy = -1
      elseif resources.input:isDown('down') then
        dy = 1
      end

      if dx ~= 0 or dy ~= 0 then
        position.x = position.x + dx
        position.y = position.y + dy

        position.x = math.max(1, math.min(resources.cols, position.x))
        position.y = math.max(1, math.min(resources.rows, position.y))

        player.moveTimer = player.moveDelay
      else
        player.moveTimer = 0
      end
    end
  end
end

return PlayerInputSystem
