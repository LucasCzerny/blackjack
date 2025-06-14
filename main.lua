require("sections")
require("cardUtility")
require("drawUi")
require("button")

local ui = {
  width = 800,
  height = 600,
  isLandscape = true,
  needsResize = true,
  sections = {},
  gapX = nil,
  gapY = nil
}

local cardImages = {}
local buttonImages = {}
local buttons = {}

local state = {
  chips = 1000,
  --
  playerDeck = CreateDeck(),
  playerHand = {},
  playerSum = 0,
  --
  dealerDeck = CreateDeck(),
  dealerHand = {},
  dealerSum = 0,
  --
  revealDealerCards = false,
  roundIsOngoing = false,
}

local Stages = {
  setupRound = 1,
  draw = 2,
  dealerDraw = 3,
  score = 4
}

function love.load()
  love.window.setMode(ui.width, ui.height, {resizable = true, fullscreen = true})
  CalculateSections(ui)

  cardImages = LoadCardImages()
  buttonImages = LoadButtonImages()

  math.randomseed(os.time())

  ShuffleDeck(state.playerDeck)
  ShuffleDeck(state.dealerDeck)
end

function love.mousepressed(x, y)
  local clicked = CheckButtonIntersections(x, y, buttons)
  if clicked == nil then return end

  if clicked == "start" then
    
  elseif clicked == "draw" then

  elseif clicked == "stand" then

  end
end

function love.draw()
  DrawEmptySections()

  DrawHands(ui, state, cardImages)
  DrawControls(ui, state, buttonImages, buttons)
end

function DrawEmptySections()
  local red = 0.4
  local green = 0.05
  local blue = 0.2

  local sections = {
    ui.sections.topLeftSecondary,
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
