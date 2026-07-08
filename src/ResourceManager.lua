---@class ResourceManager
---@field private resources {name: string, resource: any}
local ResourceManager = {}
ResourceManager.__index = ResourceManager

function ResourceManager.new()
  local rm = {
    resources = {}
  }

  return setmetatable(rm, ResourceManager)
end

---@param name string
---@param resource any
function ResourceManager:add(name, resource)
  assert(self.resources[name] == nil, 'Resource ' .. name .. ' already exists!')

  self.resources[name] = resource
end

---@return any
function ResourceManager:get(name)
  assert(self.resources ~= nil, 'Resource ' .. name .. ' does not exist!')

  return self.resources[name]
end

return ResourceManager
