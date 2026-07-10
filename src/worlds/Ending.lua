local World     = require "lib.Concord.concord.world"
local Utils     = require "lib.Concord.concord.utils"
local Entity    = require "lib.Concord.concord.entity"
local Resources = require "src.Resources"
local Saver     = require "src.Saver"

local Ending    = {
  score = 0, kills = 0
}

function Ending:init()
  local Systems = {}
  Utils.loadNamespace("src/systems", Systems)

  if self.score > Resources.saveData.highScore then
    Resources.saveData.highScore = self.score
  end

  local ticketsEarned = math.floor(self.kills / 10) * Resources.saveData.ticketsPer
  Resources.saveData.tickets = Resources.saveData.tickets + ticketsEarned

  Saver.save(Resources.saveData)

  self.world = World.new()

  self.world:addSystems(
    Systems.SpriteSystem,
    Systems.FadeSystem,

    Systems.TransitionSystem,

    Systems.TextSystem,
    Systems.TextAppearSystem,

    Systems.ScreenShakeSystem,

    Systems.TimerSystem,
    Systems.TimerCallbacks.PlaceTextCallbackSystem,

    Systems.ButtonManagerSystem,
    Systems.UICallbacks.RetryPressedSystem,
    Systems.UICallbacks.MainMenuPressedSystem,
    Systems.VirtualButtonSystem
  )

  if self.fromTransition then
    Entity.new(self.world)
        :give("position", 0, 0)
        :give("sprite", Resources.Manager:get("backgroundEmpty"))
        :give("fade", 1, true)
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

  -- Background
  Entity.new(self.world)
      :give("position", 0, 0)
      :give("sprite", Resources.Manager:get("backgroundEmpty"))
      :give("layer", 0)

  if Resources.saveData.options.shake then
    -- Camera
    Entity.new(self.world)
        :give("camera")
        :give("layer", 99)
  end

  -- Creates all the text entities after a bit
  Entity.new(self.world)
      :give("timer", 0.75, true)
      :give("place_text")

  -- Data to pass to the text system
  Entity.new(self.world)
      :give("game_data", self.score, self.kills)

  -- UI
  local font = Resources.Manager:get("fontNormal")
  Entity.new(self.world)
      :give("button_manager", "vertical", 2)

  Entity.new(self.world)
      :give("position", 0, 130)
      :give("text", "Retry", font)
      :give("centered")
      :give("layer", 5)
      :give("colour", 1, 1, 1, 1)
      :give("button", 1)
      :give("retry")

  Entity.new(self.world)
      :give("position", 0, 145)
      :give("text", "Main Menu", font)
      :give("centered")
      :give("layer", 5)
      :give("colour", 1, 1, 1, 1)
      :give("button", 2)
      :give("mainmenu")
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
