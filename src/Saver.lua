local json = require "lib.json"
local Saver = {}

function Saver.save(data)
  local toSave = json.encode(data)

  love.filesystem.write("save.json", toSave)
end

function Saver.load()
  if love.filesystem.getInfo("save.json") then
    return json.decode(love.filesystem.read("save.json"))
  end

  return nil
end

return Saver
