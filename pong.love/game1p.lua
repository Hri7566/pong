game1p = {}

local p = {
    x = 32,
    y = 0,
    width = 16,
    height = 96,
    speed = 5,
    score = 0
}

local p2 = {
    x = 0,
    y = 0,
    width = 16,
    height = love.graphics.getHeight(),
    speed = 5,
    score = 0
}

ball = {
    x = 0,
    y = 0,
    width = 16,
    height = 16,
    velx = -3,
    vely = 3
}

mode = false

gamespeed = 50
local speedup = 5

function game1p.load()
    p.x = 16
    p.y = love.graphics:getHeight()/2 - p.height/2

    p2.x = love.graphics:getWidth() - p.width - 16
    p2.y = love.graphics:getHeight()/2 - p2.height/2

    ball.x = love.graphics:getWidth()/2 - ball.width/2
    ball.y = love.graphics:getHeight()/2 - ball.height/2
end

function game1p.update(dt)
    speedup = love.math.random(0, 5)
    if love.keyboard.isDown("w") and p.y > 0 then
        p.y = p.y - p.speed * dt*gamespeed
        if mode == false then
            mode = true
        end
    elseif love.keyboard.isDown("s") and p.y < love.graphics.getHeight() - p.height then
        p.y = p.y + p.speed * dt*gamespeed
        if mode == false then
            mode = true
        end
    end

    if love.keyboard.isDown("up") and p.y > 0 then
        p.y = p.y - p.speed * dt*gamespeed
        if mode == false then
            mode = true
        end
    elseif love.keyboard.isDown("down") and p.y < love.graphics.getHeight() - p.height then
        p.y = p.y + p.speed * dt*gamespeed
        if mode == false then
            mode = true
        end
    end

    ballspeed = ball.velx * dt*gamespeed

    if mode == true then
        ball.x = ball.x + ball.velx * dt*gamespeed
        ball.y = ball.y + ball.vely * dt*gamespeed
    end

    if ball.x < 0 or ball.x > love.graphics:getWidth() - ball.width then
        ball.x = love.graphics:getWidth()/2 - ball.width/2
        ball.y = love.graphics:getHeight()/2 - ball.height/2
        ball.velx = -ball.velx
        p.score = 0
        mode = false
        gamespeed = 50
    end
    
    if (ball.y < 0 and ball.vely < 0) or (ball.y > love.graphics:getHeight() - ball.height and ball.vely > 0) then
        ball.vely = -ball.vely
    end

    if (ball.x <= p.x + p.width and ball.x >= p.x and ball.y >= p.y and ball.y + ball.height <= p.y + p.height and ball.velx < 0) or (ball.x + ball.width >= p2.x and ball.y >= p2.y and ball.y + ball.height <= p2.y + p2.height and ball.velx > 0) then
        if ball.x < love.graphics.getWidth()/2 then
            p.score = p.score + 1
        end
        ball.velx = -ball.velx
        if ball.vely > 0 then
            ball.vely = love.math.random(0, 5)
        else
            ball.vely = love.math.random(-5, 0)
        end
        gamespeed = gamespeed + speedup
    end
end

function game1p.draw()
    love.graphics.setColor(.5, .5, .5)
    
    for i=0,love.graphics.getHeight() do
        love.graphics.rectangle("fill", love.graphics.getWidth()/2-8, i*32, 8, 16)
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", p.x, p.y, p.width, p.height)
    love.graphics.printf(p.score, font, love.graphics:getWidth()/4-font:getWidth(p.score)/2, 32, 500, "left", 0, 1, 2)
    love.graphics.rectangle("fill", p2.x, p2.y, p2.width, p2.height)
    love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
end