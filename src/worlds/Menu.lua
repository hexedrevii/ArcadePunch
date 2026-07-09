local World = require "lib.Concord.concord.world"
local Utils = require "lib.Concord.concord.utils"
local Entity = require "lib.Concord.concord.entity"
local Resources = require "src.Resources"

local Menu = {}

function Menu:init()
  local Systems = {}

  Utils.loadNamespace("src/systems", Systems)

  self.world = World.new()

  self.world:addSystems(
    Systems.SpriteSystem,

    Systems.TextSystem,

    Systems.TransitionSystem,
    Systems.FadeSystem,

    Systems.ButtonManagerSystem,
    Systems.UICallbacks.RetryPressedSystem,
    Systems.UICallbacks.QuitPressedSystem,
    Systems.UICallbacks.OptionsPressedSystem,

    Systems.VirtualButtonSystem
  )

  if self.fromTransition then
    Entity.new(self.world)
        :give("position", 0, 0)
        :give("colour", 0, 0, 0, 1)
        :give("sprite", Resources.Manager:get("backgroundEmpty"))
        :give("fade", 1, true)
        :give("layer", 98)

    self.fromTransition = false
  end

  if Resources.isMobile() or Resources.showTouch then
    Entity.new(self.world)
        :give("position", 40, 90)
        :give("virtual_button", "vup")
        :give("rectangle", 32, 32)
        :give("colour", 1, 1, 1, 0.4)
        :give("sprite", Resources.Manager:get("up"))
        :give("layer", 97)

    Entity.new(self.world)
        :give("position", 40, 140)
        :give("virtual_button", "vdown")
        :give("rectangle", 32, 32)
        :give("colour", 1, 1, 1, 0.4)
        :give("sprite", Resources.Manager:get("down"))
        :give("layer", 97)

    Entity.new(self.world)
        :give("position", 10, 115)
        :give("virtual_button", "vleft")
        :give("rectangle", 32, 32)
        :give("colour", 1, 1, 1, 0.4)
        :give("sprite", Resources.Manager:get("left"))
        :give("layer", 97)

    Entity.new(self.world)
        :give("position", 70, 115)
        :give("virtual_button", "vright")
        :give("rectangle", 32, 32)
        :give("colour", 1, 1, 1, 0.4)
        :give("sprite", Resources.Manager:get("right"))
        :give("layer", 97)

    Entity.new(self.world)
        :give("position", 270, 115)
        :give("virtual_button", "vhit")
        :give("rectangle", 32, 32)
        :give("colour", 1, 1, 1, 0.4)
        :give("sprite", Resources.Manager:get("action"))
        :give("layer", 97)
  end

  Entity.new(self.world)
      :give("position", 0, 0)
      :give("sprite", Resources.Manager:get("backgroundEmpty"))
      :give("layer", 0)

  local font = Resources.Manager:get("fontNormal")
  Entity.new(self.world)
      :give("position", 0, 25)
      :give("text", "Arcade Punch!", font)
      :give("centered")
      :give("colour", 1, 1, 1, 1)
      :give("layer", 2)

  Entity.new(self.world)
      :give("button_manager", "vertical", 4)

  Entity.new(self.world)
      :give("position", 0, 100)
      :give("text", "Play", font)
      :give("colour", 1, 1, 1, 1)
      :give("centered")
      :give("layer", 1)
      :give("button", 1)
      :give("retry")

  Entity.new(self.world)
      :give("position", 0, 115)
      :give("text", "Shop", font)
      :give("colour", 1, 1, 1, 1)
      :give("centered")
      :give("layer", 1)
      :give("button", 2)
      :give("shop")

  Entity.new(self.world)
      :give("position", 0, 130)
      :give("text", "Options", font)
      :give("colour", 1, 1, 1, 1)
      :give("centered")
      :give("layer", 1)
      :give("button", 3)
      :give("options")

  Entity.new(self.world)
      :give("position", 0, 145)
      :give("text", "Quit", font)
      :give("colour", 1, 1, 1, 1)
      :give("centered")
      :give("layer", 1)
      :give("button", 4)
      :give("quit")
end

function Menu:update(delta)
  self.world:emit("update", delta)
end

function Menu:draw()
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

return Menu
