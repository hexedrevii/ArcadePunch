local System             = require "lib.Concord.concord.system"
local Resources          = require "src.Resources"
local Saver              = require "src.Saver"

local ShakePressedSystem = System.new({ pool = { "screenshake", "pressed", "text" } })

function ShakePressedSystem:update()
  for _, entity in ipairs(self.pool) do
    Resources.saveData.options.shake = not Resources.saveData.options.shake
    Saver.save(Resources.saveData)

    entity.text.text = "Toggle Screen Shake" .. (Resources.saveData.options.shake and " (on)" or " (off)")

    entity:remove("pressed")
  end
end

return ShakePressedSystem
