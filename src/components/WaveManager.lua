local Component = require 'lib.Concord.concord.component'

Component.new('WaveManager', function(c, spawnTime)
  c.spawnTime = spawnTime or 1.5

  c.time = 0
end)
