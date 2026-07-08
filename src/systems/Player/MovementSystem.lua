local System = require "lib.Concord.concord.system"
local Resources = require "src.Resources"

local MovementSystem = System.new({ pool = { "player", "position", "timed_movement" } })

function MovementSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local timed = entity.timed_movement
    local position = entity.position

    if timed.timer > 0 then
      timed.timer = timed.timer - delta
    end

    if timed.timer <= 0 then
      local dx, dy = 0, 0

      if Resources.Input:isDown("left") then
        dx = -1
      elseif Resources.Input:isDown("right") then
        dx = 1
      end

      if Resources.Input:isDown("up") then
        dy = -1
      elseif Resources.Input:isDown("down") then
        dy = 1
      end

      if dx ~= 0 or dy ~= 0 then
        position.x = position.x + dx
        position.y = position.y + dy

        position.x = math.max(1, math.min(Resources.cols, position.x))
        position.y = math.max(1, math.min(Resources.rows, position.y))

        timed.timer = timed.delay
      else
        timed.timer = 0
      end
    end
  end
end

return MovementSystem
