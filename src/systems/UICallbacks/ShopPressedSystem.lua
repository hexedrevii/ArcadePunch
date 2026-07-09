local System            = require "lib.Concord.concord.system"
local Shop              = require "src.worlds.Shop"
local Resources         = require "src.Resources"

local ShopPressedSystem = System.new({ pool = { "shop", "pressed" } })

function ShopPressedSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local world = self:getWorld()
    world:newEntity()
        :give("position", 0, 0)
        :give("colour", 0, 0, 0, 0)
        :give("fade", 1, false)
        :give("sprite", Resources.Manager:get("backgroundEmpty"))
        :give("transition", Shop)
        :give("layer", 98)

    entity:remove("pressed")
  end
end

return ShopPressedSystem
