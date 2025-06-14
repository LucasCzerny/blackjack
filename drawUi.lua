function DrawHands(ui, state, cardImages)
  local start = ui.sections.bottomPrimary.start
  local size = ui.sections.bottomPrimary.size

  local matHeight = (size[2] - ui.gapY) / 2

  love.graphics.rectangle("fill", start[1], start[2], size[1], matHeight)
  love.graphics.rectangle("fill", start[1], start[2] + matHeight + ui.gapY, size[1], matHeight)

  local cardMargin = 0.05 * matHeight;
  local cardHeight = 0.9 * matHeight
  local cardWidth = cardHeight * 2 / 3;

  local dealerHandWidth = #state.dealerHand * cardWidth + (#state.dealerHand - 1) * cardMargin
  local currentX = start[1] + (size[1] - dealerHandWidth) / 2

  local imgWidth, imgHeight = 500, 750
  local scaleX = cardWidth / imgWidth
  local scaleY = cardHeight / imgHeight

  love.graphics.setColor(1, 1, 1)

  for _, card in ipairs(state.dealerHand) do
    local img = cardImages[card.suit][card.rank]
    love.graphics.draw(img, currentX, start[2] + cardMargin, 0, scaleX, scaleY)
    currentX = currentX + cardWidth + cardMargin
  end

  local playerHandWidth = #state.playerHand * cardWidth + (#state.playerHand - 1) * cardMargin
  currentX = start[1] + (size[1] - playerHandWidth) / 2

  for _, card in ipairs(state.playerHand) do
    local img = cardImages[card.suit][card.rank]
    love.graphics.draw(img, currentX, start[2] + matHeight + 2 * cardMargin, 0, scaleX, scaleY)
    currentX = currentX + cardWidth + cardMargin
  end
end

function DrawControls(ui, state, buttonImages, buttons)
  local start = ui.sections.bottomLeftSecondary.start
  local size = ui.sections.bottomLeftSecondary.size

  local buttonSize = (size[1] - 4 * ui.gapX) / 3
  local currentX = start[1] + ui.gapX

  local imgWidth, imgHeight = 500, 500
  local scaleX = buttonSize / imgWidth
  local scaleY = buttonSize / imgHeight

  love.graphics.draw(buttonImages.start, currentX, start[2], 0, scaleX, scaleY)
  buttons.start = { start = { currentX, start[2] }, size = buttonSize }

  currentX = currentX + buttonSize + ui.gapX
  love.graphics.draw(buttonImages.draw, currentX, start[2], 0, scaleX, scaleY)
  buttons.draw = { start = { currentX, start[2] }, size = buttonSize }

  currentX = currentX + buttonSize + ui.gapX
  love.graphics.draw(buttonImages.stand, currentX, start[2], 0, scaleX, scaleY)
  buttons.stand = { start = { currentX, start[2] }, size = buttonSize }
end
