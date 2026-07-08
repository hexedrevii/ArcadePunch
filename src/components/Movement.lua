local Component = require "lib.Concord.concord.component"

Component.new("position", function(c, x, y)
  c.x = x
  c.y = y
end)

Component.new("timed_movement", function(c, delay)
  c.timer = 0
  c.delay = delay
end)
