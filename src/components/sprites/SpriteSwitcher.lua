local Component = require 'lib.Concord.concord.component'

Component.new('SpriteSwitcher', function(c, newImage)
  c.newImage = newImage
end)
