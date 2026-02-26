local Component = require 'lib.Concord.concord.component'

Component.new('UIManager', function(c, direction, maxIndex)
  c.direction = direction
  c.max = maxIndex
  c.active = 1
end)
