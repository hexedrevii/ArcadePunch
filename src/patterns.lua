---@type Pattern[]
local patterns = {
  {
    type = 'random',
    enemies = {
      { timeout = 0.75 },
    }
  },
  {
    type = 'random',
    enemies = {
      { timeout = 0.75 },
      { timeout = 0.75 },
    }
  },
  {
    type = 'coordinated',
    enemies = {
      { x = 1, y = 2 },
      { x = 2, y = 2 },
      { x = 5, y = 2 },
      { x = 6, y = 2 },
    }
  },
  {
    type = 'coordinated',
    enemies = {
      { x = 3, y = 1 },
      { x = 4, y = 1 },
      { x = 3, y = 3 },
      { x = 4, y = 3 },
      { x = 2, y = 2 },
      { x = 5, y = 2 },
    }
  },
  {
    type = 'coordinated',
    enemies = {
      { x = 2, y = 1 },
      { x = 5, y = 1 },
      { x = 2, y = 3 },
      { x = 5, y = 3 },
    }
  },
  {
    type = 'coordinated',
    enemies = {
      { x = 1, y = 1 },
      { x = 6, y = 1 },
      { x = 1, y = 3 },
      { x = 6, y = 3 },
    }
  },
  {
    type = 'coordinated',
    enemies = {
      { x = 1, y = 3 },
      { x = 2, y = 3 },
      { x = 3, y = 2 },
      { x = 4, y = 2 },
      { x = 5, y = 1 },
      { x = 6, y = 1 },
      { x = 5, y = 3 },
      { x = 6, y = 3 },
      { x = 1, y = 1 },
      { x = 2, y = 1 },
    }
  },
}

---@class Pattern
---@field type 'random'|'coordinated'
---@field enemies {timeout: number, x: integer?, y: integer?}[]
local _pattern = {}

return patterns
