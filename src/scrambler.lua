local bit = require 'bit'

local scrambler = {
  key = '67coolkey67'
}

function scrambler:scramble(text)
  local result = {}

  for i = 1, #text do
    local cb = string.byte(text, i)
    local kb = string.byte(self.key, ((i - 1) % #self.key) + 1)

    local xor = bit.bxor(cb, kb)
    table.insert(result, string.char(xor))
  end

  return table.concat(result)
end

function scrambler:save(data)
  local bytes = self:scramble(data)
  love.filesystem.write('save.arc', bytes)
end

function scrambler:load()
  if love.filesystem.getInfo('save.arc') then
    local encrypted = love.filesystem.read('save.arc')

    return scrambler:scramble(encrypted)
  end

  return nil
end

return scrambler
