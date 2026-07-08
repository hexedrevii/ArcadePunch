local Component = require "lib.Concord.concord.component"

Component.new("position", function (c, x, y)
  c.x = x
  c.y = y
end)

-- For stuff moving in grids (eg: player, mole)
Component.new("grid")
