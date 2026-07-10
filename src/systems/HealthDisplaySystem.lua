local System = require "lib.Concord.concord.System"

local HealthDisplaySystem = System.new({ pool = { "health_display", "position", "watch", "colour", "rectangle" }, enemy = { "mole", "position", "health" } })

function HealthDisplaySystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local position = entity.position
    local target = entity.watch.target
    local colour = entity.colour
    local rectangle = entity.rectangle

    if target then
      position.x = target.position.x
      position.y = target.position.y

      local hover = false
      for _, enemy in ipairs(self.enemy) do
        if position.x == enemy.position.x and position.y == enemy.position.y then
          hover = true
          rectangle.w = (enemy.health.hp / enemy.health.maxHp) * 11
          break
        end
      end

      if hover then
        colour.a = 1
      else
        colour.a = 0
      end
    end
  end
end

function HealthDisplaySystem:draw() end

return HealthDisplaySystem
