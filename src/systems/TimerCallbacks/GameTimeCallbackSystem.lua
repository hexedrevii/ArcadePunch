local System                 = require "lib.Concord.concord.system"
local Entity                 = require "lib.Concord.concord.entity"
local Resources              = require "src.Resources"
local Ending                 = require "src.worlds.Ending"

local GameTimeCallbackSystem = System.new({ pool = { "game_time", "timer_complete" } })

function GameTimeCallbackSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local world = self:getWorld()
    Entity.new(world)
        :give("position", 0, 0)
        :give("sprite", Resources.Manager:get("backgroundEmpty"))
        :give("colour", 0, 0, 0, 0)
        :give("fade", 1, false)
        :give("transition", Ending)
        :give("layer", 67)

    entity:remove("timer_complete")
  end
end

return GameTimeCallbackSystem
