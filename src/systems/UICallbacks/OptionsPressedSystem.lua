local System               = require "lib.Concord.concord.system"
local Options              = require "src.worlds.Options"
local Resources            = require "src.Resources"

local OptionsPressedSystem = System.new({ pool = { "options", "pressed" } })

function OptionsPressedSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local world = self:getWorld()
    world:newEntity()
        :give("position", 0, 0)
        :give("colour", 0, 0, 0, 0)
        :give("fade", 1, false)
        :give("sprite", Resources.Manager:get("backgroundEmpty"))
        :give("transition", Options)
        :give("layer", 98)

    entity:remove("pressed")
  end
end

return OptionsPressedSystem
