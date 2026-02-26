local Component = require 'lib.Concord.concord.component'

Component.new('AnimatedSprite', function(c, texture, width, height, duration, loop)
  c.texture = texture
  c.duration = duration or 0.1

  if loop == nil then
    c.loop = false
  else
    c.loop = loop
  end

  c.frame = 1
  c.timer = 0
  c.finished = false

  c.quads = nil

  c.width = width
  c.height = height
end)
