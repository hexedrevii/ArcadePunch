local World     = require "lib.Concord.concord.world"
local Utils     = require "lib.Concord.concord.utils"
local Entity    = require "lib.Concord.concord.entity"
local Resources = require "src.Resources"
local Upgrades  = require "src.Upgrades"

local Shop      = {}

function Shop:rebuild()
  local font = Resources.Manager:get("fontNormal")
  local base = 40
  local totalButtons = #Upgrades

  local skippedCount = 0
  for i, upgrade in ipairs(Upgrades) do
    local skip = false

    local currentLevel = Resources.saveData.upgrades[upgrade.id] or 0

    if upgrade.type == "single" and currentLevel >= 1 then
      skip = true
    elseif upgrade.type == "leveled" and currentLevel >= upgrade.max then
      skip = true
    end

    local btnText = upgrade.name

    if skip then
      btnText = btnText .. "  [MAXED]"
    else
      if upgrade.type == "leveled" then
        btnText = btnText .. " [Buy Lvl " .. tostring(currentLevel + 1) .. "]"
      end
      btnText = btnText .. " (" .. tostring(upgrade.price) .. "T)"
    end

    local btn = Entity.new(self.world)
        :give("position", 15, base)
        :give("text", btnText, font)
        :give("layer", 2)
        :give("colour", 1, 1, 1, (skip and 0.5 or 1))
        :give("upgrade", i)
        :give("shopui")

    if not skip then
      btn:give("button", i - skippedCount)
    else
      skippedCount = skippedCount + 1
    end

    base = base + 20
  end

  Entity.new(self.world)
      :give("position", 0, 150)
      :give("text", "Return", font)
      :give("button", totalButtons - skippedCount + 1)
      :give("colour", 1, 1, 1, 1)
      :give("layer", 2)
      :give("centered")
      :give("mainmenu")
      :give("shopui")

  Entity.new(self.world)
      :give("button_manager", "vertical", totalButtons - skippedCount + 1)
      :give("shopui")

  Entity.new(self.world)
      :give("position", 15, base + 20)
      :give("text", tostring(Resources.saveData.tickets) .. " Tickets", font)
      :give("colour", 1, 1, 1, 1)
      :give("layer", 2)
      :give("ticket")
      :give("shopui")
end

function Shop:init()
  local Systems = {}
  Utils.loadNamespace("src/systems", Systems)

  self.world = World.new()

  self.world:addSystems(
    Systems.SpriteSystem,
    Systems.RectangleSystem,

    Systems.VirtualButtonSystem,

    Systems.FadeSystem,
    Systems.TransitionSystem,

    Systems.TextSystem,

    Systems.ButtonManagerSystem,
    Systems.UICallbacks.MainMenuPressedSystem,
    Systems.UICallbacks.UpgradePressedSystem
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
      :give("text", "The Shop", font)
      :give("colour", 1, 1, 1, 1)
      :give("centered")
      :give("layer", 1)

  self:rebuild()
end

function Shop:update(delta)
  self.world:emit("update", delta)
end

function Shop:draw()
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

return Shop
