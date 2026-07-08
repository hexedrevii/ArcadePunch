local Component = require "lib.Concord.concord.component"

Component.new("sprite", function(c, image)
  c.image = image
end)

Component.new("spritesheet", function(c, image, w, h, duration, oneshot, tag)
  c.image = image
  c.width = w
  c.height = h

  -- Populated inside the system
  c.quads = nil

  c.duration = duration
  c.timer = 0

  c.oneshot = oneshot
  c.tag = tag
end)

Component.new("text", function(c, text, font)
  c.text = text
  c.font = font
end)

Component.new("text_appear", function(c, delay, text, font)
  c.delay = delay
  c.timer = 0

  c.text = text
  c.font = font
end)

Component.new("colour", function(c, r, g, b, a)
  c.r = r
  c.g = g
  c.b = b
  c.a = a or 1
end)

Component.new("fillmode", function(c, mode)
  c.mode = mode
end)

Component.new("offset", function(c, x, y)
  c.x = x
  c.y = y
end)

Component.new("layer", function(c, depth)
  c.depth = depth
end)

-- x/y offset to where the thing is drawn!!!
Component.new("grid", function(c, x, y)
  c.x = x or 0
  c.y = y or 0
end)

Component.new("fade", function(c, speed, reverse)
  c.speed = speed
  c.reverse = reverse
end)
