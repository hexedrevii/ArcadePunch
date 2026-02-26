local Component = require 'lib.Concord.concord.component'

Component.new('MoleBehaviour', function(c, timeout)
  c.state = 'emerging'

  c.waitTime = 0
  c.waitTimeout = timeout or 0.75
end)
