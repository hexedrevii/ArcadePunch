local System                  = require "lib.Concord.concord.system"
local Resources               = require "src.Resources"
local Saver                   = require "src.Saver"

local FullscreenPressedSystem = System.new({ pool = { "fullscreen", "pressed" } })

function FullscreenPressedSystem:update()
  for _, entity in ipairs(self.pool) do
    Resources.saveData.options.fullscreen = not Resources.saveData.options.fullscreen
    love.window.setFullscreen(Resources.saveData.options.fullscreen, "desktop")

    Saver.save(Resources.saveData)

    entity:remove("pressed")
  end
end

return FullscreenPressedSystem
