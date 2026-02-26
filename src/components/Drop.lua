local Component = require 'lib.Concord.concord.component'

Component.new('Drop', function(c, score)
  c.score = score or 25
end)
