local System = require "lib.Concord.concord.system"
local Entity = require "lib.Concord.concord.entity"
local Resources = require "src.Resources"

local PlaceTextCallbackSystem = System.new({ pool = { "place_text", "timer_complete" }, data = { "game_data" } })

function PlaceTextCallbackSystem:update(delta)
  local data = self.data[1]
  if not data then return end

  for _, entity in ipairs(self.pool) do
    local ticketsEarned = math.floor(data.game_data.kills / 10) * 3
    Resources.saveData.tickets = Resources.saveData.tickets + ticketsEarned

    local world = self:getWorld()
    local sr, sg, sb, sa = love.math.colorFromBytes(217, 87, 99)
    local font = Resources.Manager:get("fontNormal")

    Entity.new(world)
        :give("position", 0, 10)
        :give("text_appear", 0, "You ran out of time!", font)
        :give("colour", sr, sg, sb, sa)
        :give("layer", 1)
        :give("centered")

    Entity.new(world)
        :give("position", 0, 50)
        :give("text_appear", 0.5, "Score: " .. data.game_data.score, font)
        :give("colour", 1, 1, 1, 1)
        :give("layer", 1)
        :give("centered")

    Entity.new(world)
        :give("position", 0, 65)
        :give("text_appear", 0.75, "High Score: " .. Resources.saveData.highScore, font)
        :give("colour", 1, 1, 1, 1)
        :give("layer", 1)
        :give("centered")

    Entity.new(world)
        :give("position", 0, 80)
        :give("text_appear", 1, "Tickets: " .. ticketsEarned, font)
        :give("colour", 1, 1, 1, 1)
        :give("layer", 1)
        :give("centered")

    Entity.new(world)
        :give("position", 0, 95)
        :give("text_appear", 1.20, "Kills: " .. data.game_data.kills, font)
        :give("colour", 1, 1, 1, 1)
        :give("layer", 1)
        :give("centered")

    entity:remove("timer_complete")
  end
end

return PlaceTextCallbackSystem
