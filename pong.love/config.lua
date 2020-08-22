config = {}

config.controls = {}

config.controls.player1 = {
    up = "w",
    down = "s"
}

config.controls.player2 = {
    up = "up",
    down = "down"
}

config.currentText = "Controls"
config.configMode = false
config.currentKey = ""
config.cbdisplay = "Off"

function config.keypressed(key)
    if config.configMode == true then
        if config.currentKey == "pup" then
            config.controls.player1.up = key
        elseif config.currentKey == "pdown" then
            config.controls.player1.down = key
        elseif config.currentKey == "p2up" then
            config.controls.player2.up = key
        elseif config.currentKey == "p2down" then
            config.controls.player2.down = key
        end
        config.currentText = "Controls"
        config.configMode = false
    end
end

function config.update(dt, cbuttons)
    if cbuttons["pup"].text ~= config.controls.player1.up then
        cbuttons["pup"].text = config.controls.player1.up
    end
    if cbuttons["pdown"].text ~= config.controls.player1.down then
        cbuttons["pdown"].text = config.controls.player1.down
    end
    if cbuttons["p2up"].text ~= config.controls.player2.up then
        cbuttons["p2up"].text = config.controls.player2.up
    end
    if cbuttons["p2down"].text ~= config.controls.player2.down then
        cbuttons["p2down"].text = config.controls.player2.down
    end
end