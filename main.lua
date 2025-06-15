require("sections")
require("cardUtility")
require("drawUi")
require("button")

local ui = {
  -- layout data
  width = 800,
  height = 600,
  isLandscape = true,
  needsResize = true,
  sections = {},
  gapX = nil,
  gapY = nil,
}

local buttons = {}
local cardImages = {}

local stages = {
  wait = 1,
  betweenRounds = 2,
  setupRound = 3,
  draw = 4,
  dealerDraw = 5,
  score = 6
}

local results = {
  none = 1,
  playerBlackjack = 2,
  dealerBlackjack = 3,
  playerSumWin = 4,
  dealerSumWin = 5,
  playerSumTooHigh = 6,
  dealerSumTooHigh = 7,
}

local state = {
  stage = stages.betweenRounds,
  result = results.none,
  --
  chips = 1000,
  --
  playerDeck = CreateDeck(),
  playerHand = {},
  playerSum = 0,
  --
  dealerDeck = CreateDeck(),
  dealerHand = {},
  dealerSum = 0,
}

function love.load()
  love.window.setMode(ui.width, ui.height, {resizable = true, fullscreen = true})
  CalculateSections(ui)

  cardImages = LoadCardImages()
  buttons = LoadButtons(stages)

  math.randomseed(os.time())

  ShuffleDeck(state.playerDeck)
  ShuffleDeck(state.dealerDeck)
end

function love.update()
  local stage = state.stage

  if stage == stages.wait or stage == stages.betweenRounds then
    return
  elseif stage == stages.setupRound then
    state.playerHand = {}
    local result = DrawCard(state.playerHand, state.playerDeck, 2)

    if result.notEnoughCards then
      print("ay caramba")
    end

    state.playerSum = result.sum

    state.dealerHand = {}
    result = DrawCard(state.dealerHand, state.dealerDeck, 2)

    if result.notEnoughCards then
      print("ay caramba")
    end

    state.dealerSum = result.sum

    state.revealDealerCards = true
    state.roundIsOngoing = true

    state.stage = stages.wait
  elseif stage == stages.draw then
    local result = DrawCard(state.playerHand, state.playerDeck, 1)

    if result.notEnoughCards then
      print("ay caramba")
      return
    end

    state.playerSum = result.sum

    if state.playerSum > 21 then
      state.stage = stages.score
    else
      state.stage = stages.wait
    end
  elseif stage == stages.dealerDraw then
    local sum = state.dealerSum

    while sum < 17 do
      local result = DrawCard(state.dealerHand, state.dealerDeck, 1)

      if result.notEnoughCards then
        print("ay caramba")
        break
      end

      sum = result.sum
    end

    state.dealerSum = sum

    state.stage = stages.score
  elseif stage == stages.score then
    if state.playerSum == 21 then
      state.result = results.playerBlackjack
    elseif state.dealerSum == 21 then
      state.result = results.dealerBlackjack
    elseif state.playerSum > 21 then
      state.result = results.playerSumTooHigh
    elseif state.dealerSum > 21 then
      state.result = results.dealerSumTooHigh
    elseif state.playerSum > state.dealerSum then
      state.result = results.playerSumWin
    else
      state.result = results.dealerSumWin
    end

    state.stage = stages.betweenRounds
  end
end

function love.mousepressed(x, y)
  for _, button in ipairs(buttons) do
    local clicked = CheckButtonIntersection(x, y, button)
    if clicked then
      button.isDown = true
      button.downTimer = 20

      state.stage = button.nextStage
    end
  end
end

function love.draw()
  DrawEmptySections()

  local stage = state.stage

  local revealDealerCards = stage == stages.betweenRounds or stage == stages.dealerDraw
  local roundIsOngoing = stage ~= stages.betweenRounds

  DrawHands(ui, state, cardImages, revealDealerCards)
  DrawControls(ui, state, buttons, roundIsOngoing)
  DrawResult(ui, state, results)
end

function DrawEmptySections()
  local red = 0.4
  local green = 0.05
  local blue = 0.2

  local sections = {
    ui.sections.topRightSecondary,
    ui.sections.topPrimary,
    ui.sections.bottomRightSecondary,
  }

  for _, section in ipairs(sections) do
    love.graphics.setColor(red, green, blue)
    love.graphics.rectangle("fill", section.start[1], section.start[2], section.size[1], section.size[2])

    red = red + 0.3
    red = red >= 1.0 and red - 1.0 or red

    green = green + 0.6
    green = green >= 1.0 and green - 1.0 or green

    blue = blue + 0.1
    blue = blue >= 1.0 and blue - 1.0 or blue
  end
end

function love.resize(width, height)
  ui.width = width
  ui.height = height
  ui.isLandscape = ui.width > ui.height

  CalculateSections(ui)
end
