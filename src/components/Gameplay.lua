local Component = require "lib.Concord.concord.component"

Component.new("damage", function(c, damage, x, y)
  c.damage = damage
  c.x = x
  c.y = y
end)

Component.new("timer", function(c, timeout, oneshot)
  c.time = timeout
  c.timeout = timeout

  c.oneshot = oneshot
end)

Component.new("shake", function(c, duration, magnitude)
  c.duration = duration
  c.magnitude = magnitude
end)
