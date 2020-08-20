Ball = {}

function Ball:new(x, y, w, h, vx, vy)
    local self = setmetatable({}, Ball)
    self.x = x
    self.y = y
    self.width = w
    self.height = h
    self.velx = vx
    self.vely = vy

    function self:draw()
        love.graphics.setColor(color)
        love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
    end

    return self
end