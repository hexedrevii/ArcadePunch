local System = require 'lib.Concord.concord.system'
local resources = require 'src.resources'

local MoleBehaviourSystem = System.new({ pool = { 'MoleBehaviour', 'AnimatedSprite' } })

function MoleBehaviourSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local state = entity.MoleBehaviour
    local anim  = entity.AnimatedSprite

    if state.state == 'emerging' then
      if anim.finished then
        state.state = 'waiting'
      end
    elseif state.state == 'waiting' then
      state.waitTime = state.waitTime + delta
      if state.waitTime >= state.waitTimeout then
        state.state = 'leaving'

        entity:remove('AnimatedSprite')
        entity:give('AnimatedSprite', resources.manager:get('moleLeave'), 16, 16, 0.2, false)
      end
    elseif state.state == 'leaving' then
      if anim.finished then
        entity:destroy()
      end
    end
  end
end

return MoleBehaviourSystem
