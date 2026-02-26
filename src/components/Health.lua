local Component = require 'lib.Concord.concord.component'

Component.new('Health', function(c, hp)
  c.hp = hp
  c.maxHp = hp
end)
