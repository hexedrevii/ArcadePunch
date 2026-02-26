local Component = require 'lib.Concord.concord.component'

Component.new('ScreenShake', function(c, duration, magnitude)
  c.duration = duration
  c.magnitude = magnitude
end)
