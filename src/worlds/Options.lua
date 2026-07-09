local World     = require "lib.Concord.concord.world"
local Utils     = require "lib.Concord.concord.utils"
local Entity    = require "lib.Concord.concord.entity"
local Resources = require "src.Resources"
local Saver     = require "src.Saver"

local Options   = {}

function Options:init()
  local Systems = {}
  Utils.loadNamespace("src/systems", Systems)

  self.world = World.new()

  self.world:addSystems(
    Systems.SpriteSystem,
    Systems.RectangleSystem,

    Systems.TextSystem,

    Systems.FadeSystem,
    Systems.TransitionSystem,

    Systems.ButtonManagerSystem,
    Systems.UICallbacks.MainMenuPressedSystem,
    Systems.UICallbacks.FullscreenPressedSystem,
    Systems.UICallbacks.AudioPressedSystem,
    Systems.UICallbacks.ShakePressedSystem,

    Systems.VirtualButtonSystem
  )

  if self.fromTransition then
    Entity.new(self.world)
        :give("position", 0, 0)
        :give("sprite", Resources.Manager:get("backgroundEmpty"))
        :give("fade", 3, true)
        :give("layer", 98)
        :give("colour", 0, 0, 0, 1)

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

  -- Background (sprite and rect)
  Entity.new(self.world)
      :give("position", 0, 0)
      :give("sprite", Resources.Manager:get("backgroundEmpty"))
      :give("layer", -1)

  Entity.new(self.world)
      :give("position", 0, 0)
      :give("rectangle", Resources.cx, Resources.cy)
      :give("colour", 0, 0, 0, 0.75)
      :give("fillmode", "fill")
      :give("layer", 0)

  -- Header
  local font = Resources.Manager:get("fontNormal")
  Entity.new(self.world)
      :give("position", 0, 5)
      :give("text", "Options", font)
      :give("colour", 1, 1, 1, 1)
      :give("centered")
      :give("layer", 1)

  -- UI
  Entity.new(self.world)
      :give("button_manager", "vertical", 4)

  local opts = Resources.saveData.options

  local base = 60
  Entity.new(self.world)
      :give("position", 5, base)
      :give("text", "Toggle Fullscreen", font)
      :give("colour", 1, 1, 1, 1)
      :give("button", 1)
      :give("layer", 2)
      :give("fullscreen")

  base = base + 20
  Entity.new(self.world)
      :give("position", 5, base)
      :give("text", "Toggle Audio" .. (opts.audio and " (on)" or " (off)"), font)
      :give("colour", 1, 1, 1, 1)
      :give("button", 2)
      :give("layer", 2)
      :give("audio")

  base = base + 20
  Entity.new(self.world)
      :give("position", 5, base)
      :give("text", "Toggle Screen Shake" .. (opts.shake and " (on)" or " (off)"), font)
      :give("colour", 1, 1, 1, 1)
      :give("button", 3)
      :give("layer", 2)
      :give("screenshake")

  Entity.new(self.world)
      :give("position", 0, 150)
      :give("text", "Return", font)
      :give("colour", 1, 1, 1, 1)
      :give("button", 4)
      :give("layer", 2)
      :give("centered")
      :give("mainmenu")
end

function Options:update(delta)
  self.world:emit("update", delta)
end

function Options:draw()
  Resources.Renderer:set()
  love.graphics.clear(0, 0, 0)

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

return Options
