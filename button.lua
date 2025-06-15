function CreateButton(filepath, facedownFilepath, stage)
  return {
    image = love.graphics.newImage(filepath),
    imageDown = love.graphics.newImage(facedownFilepath),
    isDown = false,
    downTimer = 0,
    position = nil,
    nextStage = stage
  }
end

function CheckButtonIntersection(x, y, button)
  local startX = button.position.start[1]
  local startY = button.position.start[2]
  local size = button.position.size

  return x > startX and y > startY and x < startX + size and y < startY + size
end

function LoadButtons(stages)
  return {
    CreateButton("images/start.png", "images/startFacedown.png", stages.setupRound),
    CreateButton("images/stand.png", "images/standFacedown.png", stages.dealerDraw),
    CreateButton("images/draw.png", "images/drawFacedown.png", stages.draw),
  }
end

