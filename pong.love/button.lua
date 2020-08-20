Button = {}

function Button:new(t, x, y, w, h, f, a, c, font)
    local self = setmetatable({}, Button)
    self.text = t
    self.x = x
    self.y = y
    self.width = w
    self.height = h
    self.func = f
    self.args = a
    self.color = c
    self.font = font
    return self
end

function Button:render()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf(self.text, buttonfont, self.x, self.y + self.font:getHeight(self.text)/2, self.width, "center")
end