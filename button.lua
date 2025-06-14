function CheckButtonIntersections(x, y, buttons)
  for name, button in pairs(buttons) do
    local startX = button.start[1]
    local startY = button.start[2]

    if x > startX and y > startY and x < startX + button.size and y < startY + button.size then
      return name
    end
  end

  return nil
end
