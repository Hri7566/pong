Player = {}

function Player:new(x, y, w, h, sp, sc)
    local self = setmetatable({}, Player)
    self.x = x
    self.y = y
    self.width = w
    self.height = h
    self.speed = sp
    self.score = sc

    function self:draw()
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    end

    return self
end