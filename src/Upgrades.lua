local Upgrades = {
  {
    name = "Extended Time",
    id = "extended",
    type = "leveled",
    max = 3,
    price = 70,
    data = {
      function(self, data)
        data.timeout = 50.0
        self.price = 100
      end,
      function(self, data)
        data.timeout = 60.0
        self.price = 150
      end,
      function(self, data)
        data.timeout = 80.0
      end
    }
  },
  {
    name = "Berserk",
    id = "berserk",
    type = "single",
    price = 1000,
    data = function(self, data)
      data.damage = 2
    end
  },
}

return Upgrades
