local Component = require 'lib.Concord.concord.component'

Component.new('Text', function(c, text, idle, active, center)
  c.text = text
  c.idle = idle
  c.active = active

  if center ~= nil then
    c.center = 'center'
  else
    c.center = nil
  end
end)
