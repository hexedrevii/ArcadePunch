local System = require "lib.Concord.concord.system"

local DamageSystem = System.new({ pool = { "damage" }, enemies = { "position", "health" } })

function DamageSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local damage = entity.damage

    for _, enemy in ipairs(self.enemies) do
      local position = enemy.position
      local health = enemy.health

      if damage.x == position.x and damage.y == position.y then
        health.hp = health.hp - damage.damage
        if health.hp < 1 then
          enemy:give("dead")
        end

        entity:remove("damage")
      end
    end

    if entity:has("damage") then
      entity:remove("damage")
    end
  end
end

return DamageSystem
