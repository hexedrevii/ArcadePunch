local System = require "lib.Concord.concord.system"
local Resources = require "src.Resources"

local TimeTextSystem = System.new({ pool = { "text", "time_text", "position" }, data = { "game_time" } })

function TimeTextSystem:update(delta)
  local data = self.data[1]

  for _, entity in ipairs(self.pool) do
    if data then
      local text = string.format("%.2f", data.game_time.timeout)
      local width = entity.text.font:getWidth(text)

      entity.text.text = text
      entity.position.x = Resources.cx - width - 15
    end
  end
end

return TimeTextSystem
