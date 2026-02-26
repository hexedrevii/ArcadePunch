local Component = require 'lib.Concord.concord.component'

Component.new('UI', function(c, index, tag, active)
  if active == nil then
    c.active = false
  else
    c.active = active
  end

  c.tag = tag
  c.index = index
end)
