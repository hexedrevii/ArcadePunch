local System = require "lib.Concord.concord.system"

local OutlineSystem = System.new({ pool = { "outline", "position", "watch" } })

function OutlineSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local position = entity.position
    local target = entity.watch.target

    if target then
      position.x = target.position.x
      position.y = target.position.y
    end
  end
end

function OutlineSystem:draw() end

return OutlineSystem
