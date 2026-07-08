---@class WorldController
---@field private active World
local WorldController = {}
WorldController.__index = WorldController

---@class World
---@field init function?
---@field update function
---@field draw function
---@field mousepressed function?
---@field mousereleased function?
local _world = {}

---@return WorldController
function WorldController.new()
  local w = {
    active = nil
  }

  return setmetatable(w, WorldController);
end

---@param new World
function WorldController:set(new)
  self.active = new
  if self.active.init then
    self.active:init()
  end
end

function WorldController:update(dt)
  if self.active then
    self.active:update(dt)
  end
end

function WorldController:draw()
  if self.active then
    self.active:draw()
  end
end

return WorldController
