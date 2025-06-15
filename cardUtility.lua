require("card")

function CreateDeck()
  local deck = {}

  for rank=1,13 do
    for i, suit in ipairs(Suits) do
      deck[13 * (i - 1) + rank] = Card(suit, rank)
    end
  end

  return deck
end

function ShuffleDeck(deck)
  for i = #deck, 1, -1 do
    local randomIndex = math.random(1, i)
    deck[randomIndex], deck[i] = deck[i], deck[randomIndex]
  end

  return deck
end

function DrawCard(hand, deck, count)
  if count ~= 1 and count ~= 2 then
    print("Dumbass you can only draw 1 or 2 cards")
    return { sum = 0, notEnoughCards = true }
  end

  if (#deck < 1) or (count == 2 and #deck < 2) then
    return { sum = 0, notEnoughCards = true }
  end

  for _ = 1, count do
    local card = table.remove(deck)
    table.insert(hand, card)
  end

  return { sum = SumHand(hand), notEnoughCards = false }
end

function SumHand(hand)
  local sum = 0
  local hasAce = false

  for _, card in ipairs(hand) do
    -- jack, queen and king have rank 11, 12, 13 in the code
    -- but they only score 10
    local value = math.min(card.rank, 10)
    sum = sum + value

    if card.rank == Ranks.ace then
      hasAce = true
    end
  end

  if hasAce and sum <= 11 then
    sum = sum + 10
  end

  return sum
end

function LoadCardImages()
  local images = {}

  for rank = 1, 13 do
    for _, suit in ipairs(Suits) do
      local filename = string.format("images/cards/%d%s.png", rank, suit)
      images[suit] = images[suit] or {}
      images[suit][rank] = love.graphics.newImage(filename)
    end
  end

  images.deckPlayer = love.graphics.newImage(
    string.format("images/deckplayer.png")
  )
  images.deckDealer = love.graphics.newImage(
    string.format("images/deckdealer.png")
  )

  return images
end
