local System               = require "lib.Concord.concord.System"
local Resources            = require "src.Resources"
local Saver                = require "src.Saver"

local OutlinePressedSystem = System.new({ pool = { "showline", "pressed", "text" } })

function OutlinePressedSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    Resources.saveData.options.outline = not Resources.saveData.options.outline
    Saver.save(Resources.saveData)

    entity.text.text = "Toggle Outline" .. (Resources.saveData.options.outline and " (on)" or " (off)")

    entity:remove("pressed")
  end
end

function OutlinePressedSystem:draw() end

return OutlinePressedSystem
