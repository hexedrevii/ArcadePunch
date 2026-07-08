local Component = require "lib.Concord.concord.component"

Component.new("button", function(c, index)
  c.index = index
end)

Component.new("button_manager", function(c, direction, indices)
  c.direction = direction
  c.indices = indices
  c.active = 1
end)

Component.new("pressed")

Component.new("retry")
Component.new("mainmenu")
Component.new("shop")
Component.new("options")
Component.new("quit")
