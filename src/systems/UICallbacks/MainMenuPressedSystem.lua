local System                = require "lib.Concord.concord.system"
local Menu                  = require "src.worlds.Menu"
local Resources             = require "src.Resources"

local MainMenuPressedSystem = System.new({ pool = { "mainmenu", "pressed" } })

function MainMenuPressedSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local world = self:getWorld()
    world:newEntity()
        :give("position", 0, 0)
        :give("colour", 0, 0, 0, 0)
        :give("fade", 1, false)
        :give("sprite", Resources.Manager:get("backgroundEmpty"))
        :give("transition", Menu)
        :give("layer", 98)

    entity:remove("pressed")
  end
end

return MainMenuPressedSystem
