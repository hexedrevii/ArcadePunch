local World = require "lib.Concord.concord.world"
local Entity = require "lib.Concord.concord.entity"
local Utils = require "lib.Concord.concord.utils"
local Resources = require "src.Resources"

local Game = {}

function Game:init()
  self.world = World.new()

  local Systems = {}
  Utils.loadNamespace("src/systems", Systems)

  self.world:addSystems(
    Systems.SpriteSystem
  )

  -- Background (No longer hardcoded (what the fuck was i thinking))
  Entity.new(self.world)
      :give("position", 0, 0)
      :give("sprite", Resources.Manager:get("background"))
      :give("layer", 0)

  -- Player
  Entity.new(self.world)
      :give("position", 0, 0)
      :give("grid", Resources.startX, Resources.startY)
      :give("offset", -4, -1)
      :give("colour", 1, 1, 1, 0.7)
      :give("sprite", Resources.Manager:get("hammerUp"))
      :give("layer", 2)
      :give("player")
end

function Game:update(delta)
  self.world:emit("update", delta)
end

function Game:draw()
  Resources.Renderer:set()
  love.graphics.clear(0, 0, 0)
  self.world:emit("draw")
  Resources.Renderer:render()
end

return Game
