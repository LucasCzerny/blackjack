Suits = {
  "Clubs",
  "Diamonds",
  "Hearts",
  "Spades"
}

Ranks = {
  ace = 1,
  two = 2,
  three = 3,
  four = 4,
  five = 5,
  six = 6,
  seven = 7,
  eight = 8,
  nine = 9,
  ten = 10,
  jade = 11,
  queen = 12,
  king = 13
}

function Card(suit, rank)
  return {
    suit = suit,
    rank = rank
  }
end
