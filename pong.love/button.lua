Button = {}

function Button:new(t, x, y, w, h, f, a)
    local self = setmetatable({}, Button)
    self.text = t
    self.x = x
    self.y = y
    self.width = w
    self.height = h
    self.func = f
    self.args = a
    return self
end