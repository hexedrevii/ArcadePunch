local ResourceManager = require "src.ResourceManager"
local Input           = require "lib.marshmallow.Input"
local Controller      = require "src.worlds.Controller"

local Resources = {
  Manager = ResourceManager.new(),
  Input = Input.new(),

  Worlds = Controller.new()
}

return Resources
