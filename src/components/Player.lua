local Component = require 'lib.Concord.concord.component'

Component.new('Player', function(c, tickets)
  c.score = 0
  c.tickets = tickets or 0

  c.kills = 0

  c.moveTimer = 0
  c.moveDelay = 0.15
end)
