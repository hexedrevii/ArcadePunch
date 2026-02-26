local resources = require "src.resources"
local over = {}

function over:init()

end

function over:update(delta)

end

function over:draw()
  resources.renderer:set()
  love.graphics.clear(1, 1, 1)
  resources.renderer:render()
end

return over
