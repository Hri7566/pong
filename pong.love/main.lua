require('game')
require('game1p')
require('button')
require('ball')
require('player')
require('config')
require('colors')

gamemode = "menu"
font = love.graphics.newFont("bit5x3.ttf", 72)
buttonfont = love.graphics.newFont("bit5x5.ttf", 25)
titlefont = love.graphics.newFont("bit5x5.ttf", 72)

font:setFilter("nearest", "nearest")
buttonfont:setFilter("nearest", "nearest")
titlefont:setFilter("nearest", "nearest")

p = Player:new(32, 0, 16, 96, 5, 0)

p2 = Player:new(0, 0, 16, 96, 5, 0)

ball = Ball:new(love.graphics.getWidth()/2 - 16, love.graphics.getHeight()/2 - 16, 16, 16, -3, 3)

debug = false

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        if gamemode == "1p" or gamemode == "2p" or gamemode == "config" then
            gamemode = "menu"
            mode = false
        elseif gamemode == "menu" then
            love.event.quit(0)
        end
    end
    config.keypressed(key)
end

function love.load()
    color = colors.white
    love.window.setTitle('Pong')
    buttons = {}
    buttons["2p"] = Button:new("2P", 16, love.graphics.getHeight()-180, 128, 32, function()
        gamemode = "2p" game.load()
    end, nil, colors.white, buttonfont)
    buttons["1p"] = Button:new("1P", 16, love.graphics.getHeight()-136, 128, 32, function()
        gamemode = "1p" game1p.load()
    end, nil, colors.white, buttonfont)
    buttons["config"] = Button:new("Config", 16, love.graphics.getHeight()-92, 128, 32, function()
        gamemode = "config"
    end, nil, colors.blue, buttonfont)
    buttons["quit"] = Button:new("Quit", 16, love.graphics.getHeight()-48, 128, 32, function()
        love.event.quit(0)
    end, nil, colors.red, buttonfont)

    cbuttons = {}
    cbuttons["back"] = Button:new("Back", 16, love.graphics.getHeight()-48, 128, 32, function()
        gamemode = "menu"
    end, nil, colors.red, buttonfont)
    cbuttons["pup"] = Button:new(config.controls.player1.up, love.graphics.getWidth()/4 - 128/2, 128 + 32, 128, 32, function()
        config.currentText = "Press a key"
        config.currentKey = "pup"
        config.configMode = true
    end, nil, colors.blue, buttonfont)
    cbuttons["pdown"] = Button:new(config.controls.player1.down, love.graphics.getWidth()/4 - 128/2, 128 + 80, 128, 32, function()
        config.currentText = "Press a key"
        config.currentKey = "pdown"
        config.configMode = true
    end, nil, colors.blue, buttonfont)
    cbuttons["p2up"] = Button:new(config.controls.player2.up, love.graphics.getWidth()/4*3 - 128/2, 128 + 32, 128, 32, function()
        config.currentText = "Press a key"
        config.currentKey = "p2up"
        config.configMode = true
    end, nil, colors.blue, buttonfont)
    cbuttons["p2down"] = Button:new(config.controls.player2.down, love.graphics.getWidth()/4*3 - 128/2, 128 + 80, 128, 32, function()
        config.currentText = "Press a key"
        config.currentKey = "p2down"
        config.configMode = true
    end, nil, colors.blue, buttonfont)
end

function love.update(dt)
    mx, my = love.mouse.getPosition()
    for i,button in pairs(buttons) do
        if (mx > button.x and mx < button.x + button.width) and (my > button.y and my < button.y + button.height) then
            if button.width < 128 * 5 then
                button.width = button.width - math.tan(math.rad(button.width))*10
            end
        else
            if button.width > 128 then
                button.width = button.width + math.cos(math.rad(button.width))*5
            end
        end
    end

    for i,button in pairs(cbuttons) do
        if (mx > button.x and mx < button.x + button.width) and (my > button.y and my < button.y + button.height) then
            if button.width < 128 * 5 then
                button.width = button.width - math.tan(math.rad(button.width))*10
            end
        else
            if button.width > 128 then
                button.width = button.width + math.cos(math.rad(button.width))*5
            end
        end
    end

    if gamemode == "2p" then
        game.update(dt)
    elseif gamemode == "1p" then
        game1p.update(dt)
    elseif gamemode == "menu" or gamemode == "config" then
        ballspeed = ball.velx * dt*50
        ball.x = ball.x + ball.velx * dt*50
        ball.y = ball.y + ball.vely * dt*50

        if (ball.x + ball.width > love.graphics.getWidth() and ball.velx > 0) or (ball.x < 0 and ball.velx < 0) then
            ball.velx = -ball.velx
        end

        if (ball.y + ball.height > love.graphics.getHeight() and ball.vely > 0) or (ball.y < 0 and ball.vely < 0) then
            ball.vely = -ball.vely
        end
        config.update(dt, cbuttons)
    end

    if config.colorblind == true then
        for i,button in pairs(buttons) do
            if button.color == colors.blue then
                button.color = colors.green
            end
        end
        for i,button in pairs(cbuttons) do
            if button.color == colors.blue then
                button.color = colors.green
            end
        end
    else
        for i,button in pairs(buttons) do
            if button.color == colors.green then
                button.color = colors.blue
            end
        end
        for i,button in pairs(cbuttons) do
            if button.color == colors.green then
                button.color = colors.blue
            end
        end
    end
end

function love.mousepressed(x, y, key, istouch, presses)
    if gamemode == "menu" then
        for i,button in pairs(buttons) do
            if x > button.x and x < button.x + button.width then
                if y > button.y and y < button.y + button.height then
                    button.func()
                end
            end
        end
    elseif gamemode == "config" then
        for i,button in pairs(cbuttons) do
            if x > button.x and x < button.x + button.width then
                if y > button.y and y < button.y + button.height then
                    button.func()
                end
            end
        end
    end

    if (mx > ball.x and mx < ball.x + ball.width) and (my > ball.y and my < ball.y + ball.height) then
        if debug then
            debug = false
            color = colors.white
        else
            debug = true
            if config.colorblind then
                color = colors.lgreen
            else
                color = colors.lblue
            end
        end
    end
end

function love.draw()
    if gamemode == "2p" then
        game.draw()
    elseif gamemode == "1p" then
        game1p.draw()
    elseif gamemode == "config" then
        ball:draw()
        love.graphics.setColor(colors.white)
        love.graphics.printf(config.currentText, titlefont, 0, 16, love.graphics.getWidth(), "center")
        love.graphics.printf("Left Side", buttonfont, 0, 128, love.graphics.getWidth()/2, "center")
        love.graphics.printf("Right Side", buttonfont, love.graphics.getWidth()/2, 128, love.graphics.getWidth()/2, "center")
        for i,button in pairs(cbuttons) do
            love.graphics.setColor(button.color)
            love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)
            love.graphics.setColor(colors.black)
            love.graphics.printf(button.text, buttonfont, button.x, button.y + buttonfont:getHeight(button.text)/2, button.width, "center")
        end
    elseif gamemode == "menu" then
        love.graphics.setColor(colors.gray)
        for i=0,love.graphics.getHeight() do
            love.graphics.rectangle("fill", love.graphics.getWidth()/2-8, i*32, 8, 16)
        end
        love.graphics.setColor(colors.white)
        love.graphics.printf("PONG", titlefont, 16, 16, 1000)
        love.graphics.rectangle("fill", 16 * 5, 4, 8, 8)
        love.graphics.rectangle("fill", 16 * 6, 4, 8, 8)
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("Written by Hri7566", buttonfont, love.graphics.getWidth() - buttonfont:getWidth("Written") - 16, love.graphics.getHeight() - buttonfont:getHeight("W")*3 - 16, 150, "center")
        love.graphics.setColor(color)
        ball:draw()
        for i,button in pairs(buttons) do
            love.graphics.setColor(button.color)
            love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)
            love.graphics.setColor(colors.black)
            love.graphics.printf(button.text, buttonfont, button.x, button.y + buttonfont:getHeight(button.text)/2, button.width, "center")
        end
    end
    if debug then
        love.graphics.setColor(color)
        love.graphics.print("Debug enabled", 0, 0)
        love.graphics.print("FPS: " .. love.timer.getFPS(), 0, 10)
        love.graphics.print("Gamemode: " .. gamemode, 0, 20)
        love.graphics.print("Game speed: " .. gamespeed, 0, 30)
        love.graphics.print("Ball speed: " .. ball.velx .. ", " .. ball.vely, 0, 40)
    end
end