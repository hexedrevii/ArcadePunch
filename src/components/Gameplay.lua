local Component = require "lib.Concord.concord.component"

Component.new("damage", function(c, damage, x, y)
  c.damage = damage
  c.x = x
  c.y = y
end)

Component.new("health", function(c, hp)
  c.hp = hp
  c.maxHp = hp
end)

Component.new("drop", function(c, score)
  c.score = score or 25
end)

Component.new("game_data", function(c, score, kills)
  c.score = score or 0
  c.kills = kills or 0
end)

Component.new("game_time", function(c, timeout)
  c.timeout = timeout
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

Component.new("rectangle", function(c, w, h)
  c.w = w
  c.h = h
end)

Component.new("transition", function(c, what)
  c.what = what
end)

Component.new("paused", function(c)
  c.running = true
end)

-- Tag to see which entity to kill when unpausing
Component.new("pause")

Component.new("mole", function(c, imageIdle, imageLeave)
  c.imageIdle = imageIdle
  c.imageLeave = imageLeave
end)

Component.new("watch", function(c, target)
  c.target = target
end)
