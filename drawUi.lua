function DrawHands(ui, state, cardImages, revealDealerCards)
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
    local img
    if revealDealerCards then
      img = cardImages[card.suit][card.rank]
    else
      img = cardImages.deckDealer
    end

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

function DrawControls(ui, state, buttons, roundIsOngoing)
  local start = ui.sections.bottomLeftSecondary.start
  local size = ui.sections.bottomLeftSecondary.size

  local buttonSize = (size[1] - 4 * ui.gapX) / 3
  local currentX = start[1] + ui.gapX

  local imgWidth, imgHeight = 500, 500
  local scaleX = buttonSize / imgWidth
  local scaleY = buttonSize / imgHeight

  for _, button in ipairs(buttons) do
    local img
    if button.isDown then
      img = button.imageDown
      button.downTimer = button.downTimer - 1

      if button.downTimer == 0 then
        button.isDown = false
      end
    else
      img = button.image
    end

    love.graphics.draw(img, currentX, start[2], 0, scaleX, scaleY)
    button.position = { start = { currentX, start[2] }, size = buttonSize }

    currentX = currentX + buttonSize + ui.gapX
  end
end

function DrawResult(ui, state, results)
  local start = ui.sections.topLeftSecondary.start
  local size = ui.sections.topLeftSecondary.size

  love.graphics.print(state.playerSum, start[1], start[2])

  local result = state.result
  if state.result == results.none then
    return
  end

  local text = "why is there no text"
  if result == results.playerBlackjack then
    text = "nice coc--- ugh i meant blackjack bro"
  elseif result == results.dealerBlackjack then
    text = "that stupid fucking dealer got a fucking blackjack"
  elseif result == results.playerSumWin then
    text = "you're just better"
  elseif result == results.dealerSumWin then
    text = "he's just better"
  elseif result == results.playerSumTooHigh then
    text = "icarus moment"
  elseif result == results.dealerSumTooHigh then
    text = "lmao he can't count"
  end

  love.graphics.print(text, start[1], start[2] + size[2] / 2)
end
