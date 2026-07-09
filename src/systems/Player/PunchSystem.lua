local System = require "lib.Concord.concord.system"
local Resources = require "src.Resources"

local PunchSystem = System.new({ pool = { "player", "position", "sprite" }, camera = { "camera" } })

function PunchSystem:update(delta)
  local camera = self.camera[1]

  for _, entity in ipairs(self.pool) do
    local position = entity.position
    local sprite = entity.sprite

    if Resources.Input:isPressed("hit") and not entity:has("timer") then
      sprite.image = Resources.Manager:get("hammerDown")

      -- Cooldown + Hammer lifts up
      entity:give("timer", 0.1, true)

      entity:give("damage", 1, position.x, position.y)

      ---@type love.ParticleSystem
      local dust = Resources.Manager:get("dustParticles")
      local x, y =
          (Resources.startX + position.x + 1) * Resources.tileSize - 6,
          (Resources.startY + position.y + 1) * Resources.tileSize - 3
      dust:setPosition(x, y)
      dust:emit(4)

      if camera then
        camera:give("shake", 0.2, 1)
      end

      Resources.playAudio("hit", true)
    end
  end
end

return PunchSystem
