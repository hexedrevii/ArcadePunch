local System               = require "lib.Concord.concord.system"
local Upgrades             = require "src.Upgrades"
local Resources            = require "src.Resources"
local Shop                 = require "src.worlds.Shop"
local Saver                = require "src.Saver"

local UpgradePressedButton = System.new({ pool = { "upgrade", "pressed", "text" }, shop = { "shopui" } })

function UpgradePressedButton:update(delta)
  for _, entity in ipairs(self.pool) do
    local upgrade = entity.upgrade
    local data = Upgrades[upgrade.index]

    if Resources.saveData.tickets >= data.price then
      Resources.playAudio("buy")
      Resources.saveData.tickets = Resources.saveData.tickets - data.price

      if data.type == "leveled" then
        local currentLevel = Resources.saveData.upgrades[data.id] or 0
        local nextLevel = currentLevel + 1

        if data.data[nextLevel] then
          data.data[nextLevel](data, Resources.saveData)
        end

        Resources.saveData.upgrades[data.id] = nextLevel
      else
        data.data(data, Resources.saveData)
        Resources.saveData.upgrades[data.id] = 1
      end

      for _, shop in ipairs(self.shop) do
        shop:destroy()
      end

      Shop:rebuild()

      Saver.save(Resources.saveData)
    else
      Resources.playAudio("reject")
    end

    entity:remove("pressed")
  end
end

return UpgradePressedButton
