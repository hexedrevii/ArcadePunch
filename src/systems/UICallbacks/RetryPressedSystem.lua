local System             = require "lib.Concord.concord.system"
local Resources          = require "src.Resources"
local Game               = require "src.worlds.Game"

local RetryPressedSystem = System.new({ pool = { "retry", "pressed" } })

function RetryPressedSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local world = self:getWorld()
    world:newEntity()
        :give("position", 0, 0)
        :give("colour", 0, 0, 0, 0)
        :give("fade", 1, false)
        :give("sprite", Resources.Manager:get("backgroundEmpty"))
        :give("transition", Game)
        :give("layer", 98)

    entity:remove("pressed")
  end
end

return RetryPressedSystem
