local Component = require 'lib.Concord.concord.component'

Component.new('Position', function(c, x, y)
  c.x = x or 0
  c.y = y or 0
end)
