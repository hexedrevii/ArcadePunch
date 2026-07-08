local System = require "lib.Concord.concord.system"
local Resources = require "src.Resources"

local SkullTextSystem = System.new({ pool = { "text", "skull_text", "colour", "position" }, data = { "game_data" } })

function SkullTextSystem:update(delta)
  local data = self.data[1]

  for _, entity in ipairs(self.pool) do
    if data then
      if data.game_data.kills > 50 then
        local colour = entity.colour
        colour.r = 0.85
        colour.g = 0.34
        colour.b = 0.38
      end

      local text = tostring(data.game_data.kills)
      local width = entity.text.font:getWidth(text)

      entity.text.text = text
      entity.position.x = Resources.cx - width - 15
    end
  end
end

return SkullTextSystem
