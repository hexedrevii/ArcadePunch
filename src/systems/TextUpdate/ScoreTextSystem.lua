local System = require "lib.Concord.concord.system"

local ScoreTextSystem = System.new({ pool = { "text", "score_text" }, data = { "game_data" } })

function ScoreTextSystem:update(delta)
  local data = self.data[1]

  for _, entity in ipairs(self.pool) do
    if data then
      entity.text.text = tostring(data.game_data.score)
    end
  end
end

return ScoreTextSystem
