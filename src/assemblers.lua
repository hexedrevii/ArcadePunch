local resources = require 'src.resources'

local Assemblers = {}

function Assemblers.Mole(world, x, y, timeout)
  world:newEntity()
      :give('Position', x, y)
      :give('Health', 2)
      :give('Drop', 25)
      :give('AnimatedSprite', resources.manager:get('mole'), 16, 16, 0.2, false)
      :give('MoleBehaviour', timeout)
      :give('Enemy')
end

return Assemblers
