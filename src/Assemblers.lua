local Resources = require "src.Resources"

local Assemblers = {}

local pool = {
  { type = "mole",    weight = 80 },
  { type = "moleRed", weight = 20 }
}

local cumulative = {}
local weights = 0

for _, spawn in ipairs(pool) do
  weights = weights + spawn.weight
  table.insert(cumulative, { type = spawn.type, treshold = weights })
end

function Assemblers.spawnWeighted(world, x, y)
  local roll = love.math.random() * weights

  -- Default (basic, weak, chud, mole)
  local chosen = "mole"

  for _, option in ipairs(cumulative) do
    if roll <= option.treshold then
      chosen = option.type
      break
    end
  end

  Assemblers[chosen](world, x, y)
end

function Assemblers.mole(world, x, y)
  world:newEntity()
      :give("position", x, y)
      :give("grid", Resources.startX, Resources.startY)
      :give("sprite", Resources.Manager:get("moleIdle"))
      :give("spritesheet", Resources.Manager:get("moleEnter"), 16, 16, 1, true, "mole_enter")
      :give("layer", 2)
      :give("health", 2)
      :give("drop", 25)
      :give("mole", Resources.Manager:get("moleIdle"), Resources.Manager:get("moleLeave"))
end

function Assemblers.moleRed(world, x, y)
  world:newEntity()
      :give("position", x, y)
      :give("grid", Resources.startX, Resources.startY)
      :give("sprite", Resources.Manager:get("moleIdleRed"))
      :give("spritesheet", Resources.Manager:get("moleEnterRed"), 16, 16, 1, true, "mole_enter")
      :give("layer", 2)
      :give("health", 3)
      :give("drop", 25)
      :give("mole", Resources.Manager:get("moleIdleRed"), Resources.Manager:get("moleLeaveRed"))
end

return Assemblers
