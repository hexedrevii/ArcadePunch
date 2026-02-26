local Component = require 'lib.Concord.concord.component'

Component.new('Activity', function(c, r, g, b, a)
  c.r = r
  c.g = g
  c.b = b
  c.a = a
end)
