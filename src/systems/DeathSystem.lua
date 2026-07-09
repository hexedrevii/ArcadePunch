local System = require "lib.Concord.concord.system"
local Resources = require "src.Resources"

local DeathSystem = System.new({ pool = { "dead" }, data = { "game_data" } })

function DeathSystem:update(delta)
  local data = self.data[1]

  for _, entity in ipairs(self.pool) do
    if data then
      if entity:has("drop") then
        data.game_data.score = data.game_data.score + entity.drop.score
      end

      data.game_data.kills = data.game_data.kills + 1

      if data.game_data.kills ~= 0 and data.game_data.kills % 10 == 0 then
        Resources.playAudio("power")
      end
    end

    entity:destroy()
    Resources.playAudio("death")
  end
end

return DeathSystem
