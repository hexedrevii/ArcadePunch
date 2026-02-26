local Component = require 'lib.Concord.concord.component'

Component.new('Offset', function(c, ox, oy)
  c.x = ox
  c.y = oy
end)
