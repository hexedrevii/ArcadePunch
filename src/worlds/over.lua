local resources          = require "src.resources"
local scrambler          = require "src.scrambler"
local json               = require "lib.json"
local World              = require "lib.Concord.concord.world"
local TextUISystem       = require "src.systems.ui.TextUISystem"
local UIManagerSystem    = require "src.systems.ui.UIManagerSystem"
local RetryPressedSystem = require "src.systems.ui.RetryPressedSystem"
local ScreenShakeSystem  = require "src.systems.ScreenShakeSystem"


local wordPlacer = {
  words = {}
}

local function addWord(text, x, y, delay, colour, r)
  r = r or 0
  table.insert(wordPlacer.words,
    { skip = false, colour = colour, text = text, x = x, y = y, r = r, delay = delay, time = 0, draw = false })
end

local function updateWords(delta, over)
  for _, word in ipairs(wordPlacer.words) do
    if not word.skip then
      word.time = word.time + delta

      if word.time >= word.delay then
        word.draw = true
        word.skip = true

        over.camera:give('ScreenShake', 0.2, 1)
      end
    end
  end
end

local function drawWords()
  for _, word in ipairs(wordPlacer.words) do
    love.graphics.setFont(resources.manager:get('fontNormal'))

    if word.draw then
      love.graphics.setColor(word.colour)

      love.graphics.printf(word.text, word.x, word.y, 320, 'center', word.r)
      love.graphics.setColor(1, 1, 1, 1)
    end
  end
end

local over = {
  score = 0,
  kills = 0,
}

function over:init()
  self.special = { 217 / 255, 87 / 255, 99 / 255 }
  self.high = { 253 / 255, 209 / 255, 121 / 255 }

  wordPlacer.words = {}
  self.newHigh = false

  -- 3 tickets per 10 kills!
  local ticketsEarned = math.floor(self.kills / 10) * 3
  resources.saveData.tickets = resources.saveData.tickets + ticketsEarned

  if self.score > resources.saveData.highScore then
    resources.saveData.highScore = self.score
    self.newHigh = true
  end

  scrambler:save(json.encode(resources.saveData))

  self.world = World.new()
  self.world:addSystems(ScreenShakeSystem, RetryPressedSystem, UIManagerSystem, TextUISystem)

  self.world:newEntity()
      :give('UIManager', 'vertical', 2)

  self.world:newEntity()
      :give('Position', 0, 130)
      :give('Text', 'Retry', { 1, 1, 1, 1 }, self.high, true)
      :give('UI', 1, 'RetryPressed')

  self.world:newEntity()
      :give('Position', 0, 145)
      :give('Text', 'Main Menu', { 1, 1, 1, 1 }, self.high, true)
      :give('UI', 2, 'MenuPressed')

  self.camera = self.world:newEntity()
      :give('Position')
      :give('Camera')

  addWord('You ran out of time!', 0, 10, 0, self.special)
  addWord('Score: ' .. self.score, 0, 50, 0.5, { 1, 1, 1 })

  addWord('High Score: ' .. resources.saveData.highScore, 0, 65, 0.75, { 1, 1, 1 })
  if self.newHigh then
    local width = resources.manager:get('fontNormal'):getWidth('High Score: ' .. resources.saveData.highScore)
    addWord('New High!', width - 9, 65, 0.85, self.high)
  end

  addWord('Tickets: ' .. ticketsEarned, 0, 80, 1, { 1, 1, 1 })
  addWord('Kills: ' .. self.kills, 0, 95, 1.20, { 1, 1, 1 })

  self.opacity = 1
end

function over:update(delta)
  self.world:emit('update', delta)
  if self.opacity ~= 0 then
    self.opacity = self.opacity - delta
    if self.opacity <= 0 then
      self.opacity = 0
    end

    return
  end

  updateWords(delta, self)
end

function over:draw()
  resources.renderer:set()
  love.graphics.clear(1, 1, 1)
  love.graphics.draw(resources.manager:get('backgroundEmpty'), 0, 0)

  self.world:emit('draw')

  if self.opacity == 0 then
    drawWords()
  end

  love.graphics.setColor(0, 0, 0, self.opacity)
  love.graphics.rectangle('fill', 0, 0, 320, 180)

  love.graphics.setColor(1, 1, 1, 1)
  resources.renderer:render()
end

return over
