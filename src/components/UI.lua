local Component = require "lib.Concord.concord.component"

Component.new("button", function(c, index)
  c.index = index
end)

Component.new("button_manager", function(c, direction, indices)
  c.direction = direction
  c.indices = indices
  c.active = 1
end)

Component.new("virtual_button", function(c, name)
  c.name = name
  c.down = false
end)

Component.new("upgrade", function(c, index)
  c.index = index
end)

Component.new("pressed")

-- Misc button tags
Component.new("retry")
Component.new("mainmenu")
Component.new("shop")
Component.new("options")
Component.new("quit")

-- Option tags
Component.new("fullscreen")
Component.new("audio")
Component.new("screenshake")
Component.new("showline")

-- Shop tags
Component.new("ticket")
Component.new("shopui")
