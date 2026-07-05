---@class ResourceManager
---@field private resources table<string, any>
local ResourceManager = {}
ResourceManager.__index = ResourceManager

function ResourceManager.new()
  local resourcemanager = {
    resources = {}
  }

  return setmetatable(resourcemanager, ResourceManager)
end

---@param name string
---@param resource any
function ResourceManager:set(name, resource)
  self.resources[name] = resource

  -- Method chaining lol
  return self
end

---@param name string
---@return any
function ResourceManager:get(name)
  assert(self.resources[name] ~= nil, 'A resource by the name ' .. name .. ' does not exist.')
  return self.resources[name]
end

return ResourceManager
