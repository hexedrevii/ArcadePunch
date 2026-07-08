local Component = require "lib.Concord.concord.component"

Component.new("sprite", function (c, image)
  c.image = image
end)

Component.new("colour", function (c, r, g, b, a)
  c.r = r
  c.g = g
  c.b = b
  c.a = a or 1
end)
