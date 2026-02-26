local System = require 'lib.Concord.concord.system'

local DamageSystem = System.new({ pool = { 'Damage' }, enemy = { 'Enemy', 'Position', 'Health' } })

function DamageSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local damage = entity.Damage

    for _, enemy in ipairs(self.enemy) do
      local position = enemy.Position
      local health = enemy.Health

      if damage.x == position.x and damage.y == position.y and not enemy:has('Invincible') then
        health.hp = health.hp - damage.dmg
        if health.hp < 1 then
          enemy:give('Dead')
        end

        entity:remove('Damage')
      end
    end

    if entity:has('Damage') then
      entity:remove('Damage')
    end
  end
end

return DamageSystem
