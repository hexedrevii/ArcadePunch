local System = require "lib.Concord.concord.system"

local DeathSystem = System.new({ pool = { "dead" }, datas = { "game_data" } })

function DeathSystem:update(delta)
  local data = self.datas[1]

  for _, entity in ipairs(self.pool) do
    if data then
      if entity:has("drop") then
        data.game_data.score = data.game_data.score + entity.drop.score
      end

      data.game_data.kills = data.game_data.kills + 1
    end

    entity:destroy()
  end
end

return DeathSystem
