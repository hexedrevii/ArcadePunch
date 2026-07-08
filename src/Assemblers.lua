local Resources = require "src.Resources"

local Assemblers = {}

function Assemblers.mole(world, x, y)
  world:newEntity()
      :give("position", x, y)
      :give("grid", Resources.startX, Resources.startY)
      :give("sprite", Resources.Manager:get("moleIdle"))
      :give("spritesheet", Resources.Manager:get("moleEnter"), 16, 16, 1, true, "mole_enter")
      :give("layer", 1)
      :give("health", 2)
      :give("drop", 25)
      :give("mole")
end

return Assemblers
