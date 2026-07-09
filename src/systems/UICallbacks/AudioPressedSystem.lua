local System             = require "lib.Concord.concord.system"
local Resources          = require "src.Resources"
local Saver              = require "src.Saver"

local AudioPressedSystem = System.new({ pool = { "audio", "pressed", "text" } })

function AudioPressedSystem:update()
  for _, entity in ipairs(self.pool) do
    Resources.saveData.options.audio = not Resources.saveData.options.audio
    Saver.save(Resources.saveData)

    entity.text.text = "Toggle Audio" .. (Resources.saveData.options.audio and " (on)" or " (off)")

    entity:remove("pressed")
  end
end

return AudioPressedSystem
