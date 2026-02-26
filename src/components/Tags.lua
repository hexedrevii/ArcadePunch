local Component = require 'lib.Concord.concord.component'

Component.new('PlayerSpriteSwitch')
Component.new('EnemyLeave')

Component.new('Camera')
Component.new('Enemy')
Component.new('Dead')
Component.new('Invincible')

Component.new('RetryPressed')
Component.new('MenuPressed')

-- Not a tag, but i cannot be fucked :3
Component.new('GameFinish', function(c)
  c.opacity = 0
end)
