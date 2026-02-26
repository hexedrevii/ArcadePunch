local Component = require 'lib.Concord.concord.component'

Component.new('Damage', function(c, dmg, x, y)
  c.dmg = dmg

  c.x = x
  c.y = y
end)
