local World = require "lib.Concord.concord.world"
local Utils = require "lib.Concord.concord.utils"
local Entity = require "lib.Concord.concord.entity"
local Resources = require "src.Resources"

local Ending = {}

function Ending:init()
  local Systems = {}
  Utils.loadNamespace("src/systems", Systems)

  self.world = World.new()

  self.world:addSystems(
    Systems.SpriteSystem,
    Systems.FadeSystem
  )

  if self.fromTransition then
    Entity.new(self.world)
        :give("position", 0, 0)
        :give("sprite", Resources.Manager:get("backgroundEmpty"))
        :give("fade", 1, true)
        :give("layer", 98)
        :give("colour", 0, 0, 0, 1)
  end

  Entity.new(self.world)
      :give("position", 0, 0)
      :give("sprite", Resources.Manager:get("backgroundEmpty"))
      :give("layer", 0)
end

function Ending:update(delta)
  self.world:emit("update", delta)
end

function Ending:draw()
  Resources.Renderer:set()
  love.graphics.clear(0, 0, 0, 0)

  local renderQueue = {}
  self.world:emit("draw", renderQueue)
  table.sort(renderQueue, function(a, b)
    return a.layer < b.layer
  end)

  for _, command in ipairs(renderQueue) do
    command.draw()
  end

  Resources.Renderer:render()
end

return Ending
