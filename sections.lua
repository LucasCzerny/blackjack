function CalculateSections(ui)
  -- *-------------*
  -- | <s><-p-><s> | idk yet
  -- | <s><-p-><s> | 1st s ... chips and button, p ... player and dealer hand, 2nd s ... idk yet
  -- *-------------*
  -- 
  -- *--------*
  -- | <s><s> | idk yet
  -- | <-p->  | idk yet
  -- | <s><s> | 1st s ... chips and button, 2nd s ... idk yet
  -- | <-p->  | player and dealer hand
  -- *--------*

  local w, h = ui.width, ui.height
  local gapX, gapY = 0.01 * w, 0.01 * h
  ui.gapX, ui.gapY = gapX, gapY

  if ui.isLandscape then
    local totalWidth = w - 4 * gapX
    local secondaryW = totalWidth * 0.2
    local primaryW = totalWidth - 2 * secondaryW
    local sectionH = (h - 3 * gapY) / 2

    ui.sections = {
      topLeftSecondary = {
        start = { gapX, gapY },
        size = { secondaryW, sectionH }
      },
      topPrimary = {
        start = { 2 * gapX + secondaryW, gapY },
        size = { primaryW, sectionH }
      },
      topRightSecondary = {
        start = { 3 * gapX + secondaryW + primaryW, gapY },
        size = { secondaryW, sectionH }
      },
      bottomLeftSecondary = {
        start = { gapX, 2 * gapY + sectionH },
        size = { secondaryW, sectionH }
      },
      bottomPrimary = {
        start = { 2 * gapX + secondaryW, 2 * gapY + sectionH },
        size = { primaryW, sectionH }
      },
      bottomRightSecondary = {
        start = { 3 * gapX + secondaryW + primaryW, 2 * gapY + sectionH },
        size = { secondaryW, sectionH }
      },
    }

  else
    local usableH = h - 5 * gapY
    local secondaryH = usableH * 0.15
    local primaryH = (usableH - 2 * secondaryH) / 2

    local sectionW = (w - 3 * gapX) / 2

    ui.sections = {
      topLeftSecondary = {
        start = { gapX, gapY },
        size = { sectionW, secondaryH }
      },
      topRightSecondary = {
        start = { 2 * gapX + sectionW, gapY },
        size = { sectionW, secondaryH }
      },
      topPrimary = {
        start = { gapX, 2 * gapY + secondaryH },
        size = { w - 2 * gapX, primaryH }
      },
      bottomLeftSecondary = {
        start = { gapX, 3 * gapY + secondaryH + primaryH },
        size = { sectionW, secondaryH }
      },
      bottomRightSecondary = {
        start = { 2 * gapX + sectionW, 3 * gapY + secondaryH + primaryH },
        size = { sectionW, secondaryH }
      },
      bottomPrimary = {
        start = { gapX, 4 * gapY + 2 * secondaryH + primaryH },
        size = { w - 2 * gapX, primaryH }
      },
    }
  end
end
