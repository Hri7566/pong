game = {}

function game.load()
    p.score = 0
    p2.score = 0

    mode = false

    gamespeed = 50
    local speedup = 5

    p.x = 16
    p.y = love.graphics:getHeight()/2 - p.height/2

    p2.height = 96
    p2.x = love.graphics:getWidth() - p.width - 16
    p2.y = love.graphics:getHeight()/2 - p2.height/2

    ball.x = love.graphics:getWidth()/2 - ball.width/2
    ball.y = love.graphics:getHeight()/2 - ball.height/2
end

function game.update(dt)
    speedup = love.math.random(0, 5)
    if love.keyboard.isDown(config.controls.player1.up) and p.y > 0 then
        p.y = p.y - p.speed * dt*gamespeed
        if mode == false then
            mode = true
        end
    elseif love.keyboard.isDown(config.controls.player1.down) and p.y < love.graphics.getHeight() - p.height then
        p.y = p.y + p.speed * dt*gamespeed
        if mode == false then
            mode = true
        end
    end

    if love.keyboard.isDown(config.controls.player2.up) and p2.y > 0 then
        p2.y = p2.y - p2.speed * dt*gamespeed
        if mode == false then
            mode = true
        end
    elseif love.keyboard.isDown(config.controls.player2.down) and p2.y < love.graphics.getHeight() - p2.height then
        p2.y = p2.y + p2.speed * dt*gamespeed
        if mode == false then
            mode = true
        end
    end

    ballspeed = ball.velx * dt*gamespeed

    if mode == true then
        ball.x = ball.x + ball.velx * dt*gamespeed
        ball.y = ball.y + ball.vely * dt*gamespeed
    end

    if p.score >= 11 and p.score > p2.score + 2 then
        gamemode = "menu"
        mode = false
    end
    
    if p2.score >= 11 and p2.score > p.score + 2 then
        gamemode = "menu"
        mode = false
    end

    if ball.x < 0 or ball.x > love.graphics:getWidth() - ball.width then
        if ball.x < love.graphics:getWidth()/2 then
            p2.score = p2.score + 1
        else
            p.score = p.score + 1
        end
        ball.x = love.graphics:getWidth()/2 - ball.width/2
        ball.y = love.graphics:getHeight()/2 - ball.height/2
        ball.velx = -ball.velx
        mode = false
        gamespeed = 50
    end
    
    if (ball.y < 0 and ball.vely < 0) or (ball.y > love.graphics:getHeight() - ball.height and ball.vely > 0) then
        ball.vely = -ball.vely
        gamespeed = gamespeed + speedup
    end

    if (ball.x <= p.x + p.width and ball.x >= p.x and ball.y >= p.y and ball.y + ball.height <= p.y + p.height and ball.velx < 0) or (ball.x + ball.width >= p2.x and ball.y >= p2.y and ball.y + ball.height <= p2.y + p2.height and ball.velx > 0) then
        ball.velx = -ball.velx
        if ball.vely > 0 then
            ball.vely = love.math.random(0, 5)
        else
            ball.vely = love.math.random(-5, 0)
        end
        gamespeed = gamespeed + speedup
    end
end

function game.draw()
    love.graphics.setColor(.5, .5, .5)
    
    for i=0,love.graphics.getHeight() do
        love.graphics.rectangle("fill", love.graphics.getWidth()/2-8, i*32, 8, 16)
    end

    p:draw()
    love.graphics.printf(p.score, font, love.graphics:getWidth()/4-font:getWidth(p.score), 32, 500, "left", 0, 2, 2)
    p2:draw()
    love.graphics.printf(p2.score, font, love.graphics:getWidth()/4*3-font:getWidth(p2.score), 32, 500, "left", 0, 2, 2)
    ball:draw()
end