require('game')
require('game1p')
require('button')

gamemode = "menu"
font = love.graphics.newFont("bit5x5.ttf", 72)
buttonfont = love.graphics.newFont("bit5x5.ttf", 25)

local ball = {
    x = love.graphics.getWidth()/2 - 16,
    y = love.graphics.getHeight()/2 - 16,
    width = 16,
    height = 16,
    velx = -3,
    vely = 3
}

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        if gamemode == "1p" or gamemode == "2p" then
            gamemode = "menu"
            mode = false
        elseif gamemode == "menu" then
            love.event.quit(0)
        end
    end
end

function love.load()
    color = {1, 1, 1}
    love.window.setTitle('Pong')
    buttons = {}
    buttons["2p"] = Button:new("2P", 16, love.graphics.getHeight()-136, 128, 32, function() gamemode = "2p"
        game.load() end)
    buttons["1p"] = Button:new("1P", 16, love.graphics.getHeight()-92, 128, 32, function() gamemode = "1p"
        game1p.load() end)
    buttons["quit"] = Button:new("Quit", 16, love.graphics.getHeight()-48, 128, 32, function() love.event.quit(0) end)
end

function love.update(dt)
    mx, my = love.mouse.getPosition()
    for i,button in pairs(buttons) do
        if (mx > button.x and mx < button.x + button.width) and (my > button.y and my < button.y + button.height) then
            if button.width < 128 + 32 then
                button.width = button.width + math.sin(math.rad(button.width))*5
            end
        else
            if button.width > 128 then
                button.width = button.width + math.cos(math.rad(button.width))
            end
        end
    end

    if gamemode == "2p" then
        game.update(dt)
    elseif gamemode == "1p" then
        game1p.update(dt)
    else
        ballspeed = ball.velx * dt*50
        ball.x = ball.x + ball.velx * dt*50
        ball.y = ball.y + ball.vely * dt*50

        if (ball.x + ball.width > love.graphics.getWidth() and ball.velx > 0) or (ball.x < 0 and ball.velx < 0) then
            ball.velx = -ball.velx
        end

        if (ball.y + ball.height > love.graphics.getHeight() and ball.vely > 0) or (ball.y < 0 and ball.vely < 0) then
            ball.vely = -ball.vely
        end
    end
end

function love.mousepressed(x, y, key, istouch, presses)
    for i,button in pairs(buttons) do
        if x > button.x and x < button.x + button.width then
            if y > button.y and y < button.y + button.height then
                button.func()
            end
        end
    end

    if (mx > ball.x and mx < ball.x + ball.width) and (my > ball.y and my < ball.y + ball.height) then
        color = {love.math.random(0, 255)/255, love.math.random(0, 255)/255, love.math.random(0, 255)/255}
    end
end

function love.draw()
    if gamemode == "2p" then
        game.draw()
    elseif gamemode == "1p" then
        game1p.draw()
    else
        love.graphics.setColor(.5, .5, .5)
        for i=0,love.graphics.getHeight() do
            love.graphics.rectangle("fill", love.graphics.getWidth()/2-8, i*32, 8, 16)
        end
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("PONG", font, 16, 16, 1000)
        love.graphics.printf("Written by Hri7566", buttonfont, love.graphics.getWidth() - buttonfont:getWidth("Written") - 16, love.graphics.getHeight() - buttonfont:getHeight("W")*3 - 16, 150, "center")
        love.graphics.setColor(color)
        love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
        for i,button in pairs(buttons) do
            love.graphics.setColor(1, 1, 1)
            love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)
            love.graphics.setColor(0, 0, 0)
            love.graphics.printf(button.text, buttonfont, button.x, button.y + buttonfont:getHeight(button.text)/2, button.width, "center")
        end
    end
end