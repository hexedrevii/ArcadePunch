local Component = require 'lib.Concord.concord.component'

Component.new('Timer', function(c, time, tag)
  c.timeout = time
  c.time = 0

  c.tag = tag
end)
