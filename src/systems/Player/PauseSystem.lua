local System = require "lib.Concord.concord.system"
local Resources = require "src.Resources"

local PauseSystem = System.new({ pool = { "paused" }, paused = { "pause" } })

local systemsToPause = {
  require "src.systems.TimerSystem",
  require "src.systems.SpriteSheetSystem",
  require "src.systems.GameTimeSystem",
  require "src.systems.TimerCallbacks.WaveManagerCallbackSystem",
  require "src.systems.Player.PunchSystem",
  require "src.systems.Player.MovementSystem"
}

function PauseSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    if Resources.Input:isPressed("pause") then
      entity.paused.running = not entity.paused.running

      -- Disable systems
      local world = self:getWorld()
      for _, system in ipairs(systemsToPause) do
        world:getSystem(system):setEnabled(entity.paused.running)
      end

      if entity.paused.running then
        for _, pause in ipairs(self.paused) do
          pause:destroy()
        end
      else
        world:newEntity()
            :give("position", 0, 0)
            :give("layer", 10)
            :give("colour", 0, 0, 0, 0.75)
            :give("rectangle", Resources.cx, Resources.cy)
            :give("fillmode", "fill")
            :give("pause")

        local font = Resources.Manager:get("fontNormal")
        world:newEntity()
            :give("position", 0, 15)
            :give("text", "Paused", font)
            :give("centered")
            :give("layer", 11)
            :give("colour", 1, 1, 1, 1)
            :give("pause")

        world:newEntity()
            :give("button_manager", "vertical", 1)
            :give("pause")

        world:newEntity()
            :give("position", 0, 90)
            :give("text", "Main Menu", font)
            :give("colour", 1, 1, 1, 1)
            :give("centered")
            :give("button", 1)
            :give("layer", 11)
            :give("mainmenu")
            :give("pause")
      end
    end
  end
end

return PauseSystem
