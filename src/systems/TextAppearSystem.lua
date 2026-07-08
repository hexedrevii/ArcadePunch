local System = require "lib.Concord.concord.system"

local TextAppearSystem = System.new({ pool = { "text_appear" }, camera = { "camera" } })

function TextAppearSystem:update(delta)
  local camera = self.camera[1]

  for _, entity in ipairs(self.pool) do
    local appear = entity.text_appear

    appear.timer = appear.timer + delta
    if appear.timer >= appear.delay then
      entity:give("text", appear.text, appear.font)

      if camera then
        camera:give("shake", 0.2, 1)
      end

      entity:remove("text_appear")
    end
  end
end

return TextAppearSystem
