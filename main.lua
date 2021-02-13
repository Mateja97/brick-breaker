local Player = require('models.player')
local Key = require("libs.keyboard")
local Ball = require("models.ball")
local Menu = require("states.menu")
local Gameover = require("states.gameover")
local LM = require("states.levelmaker")
local modes = require("states.modes")
local Win = require("states.win")

local player  = Player(200,20)
local ball = Ball(10,0)
local speed = 5
local bricks = LM.get_level().bricks
local brick_num = LM.get_level().brick_num
local state = "menu"
local background
local game_background
function love.load()
    love.window.setTitle ("BRICK BREAKER")
    Key:hook_love_events()
    love.graphics.setFont(love.graphics.newFont(24))
    background = love.graphics.newImage("/assets/forest.png")
    game_background = love.graphics.newImage("/assets/sky.jpg")

end

function love.update(dt)

    if dt > 0.035 then return end

    if state == "quit" then love.event.quit() end

    if Key:key_down("escape") then
        state = "menu"
    elseif Key:key_down("space") and state =="game" then
        player:shot(ball,speed)

    elseif Key:key_down("r") and (state == "game"  or state == "gameover") then
       Reset()
       state ="game"
    end
    if state == "game" and player.life == 0 then
        state = "gameover"
    end
    
    Key:update(dt)
    if state == "game" then

        player:update(dt)
        ball:update(dt,player,bricks)
        LM:get_level():update(dt,player)
    end
    if ball:level_completed(bricks,brick_num) == true and state == "game" then
        state = "win"
    end
    
end
function love.mousereleased(x,y,button)
    if  state == "menu" then

        state = Menu:what_is_clicked(x,y,state)
        Reset() --reset if some gameplay left from level

    elseif  state == "LM" then

        bricks, brick_num = LM:choose_level(x,y)
        state = "menu"
        Reset() --reset if some gameplay left from other level

    elseif  state == "modes" then
        -- mode defines speed of the ball
        local mode = modes:choose_mode(x,y)
        if mode == "easy" then speed = 5
        elseif mode == "medium" then speed = 8
        elseif mode == "hard" then speed = 12
        end
        state = "menu"
        Reset()
    end
end
function love.draw()
    --checking which state is active
    if state == "game" or state == "gameover" or state == "win" then 
        love.graphics.setColor(1,1,1)
        love.graphics.draw(game_background)
    else
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(background)
    end
    if state == "win" then
        Win:draw()
    elseif state == "gameover" then
        Gameover:draw()
    elseif state == "game" then
        player:draw()
        ball:draw()
        LM:get_level():draw()
    elseif state == "menu" then
        Menu:draw()
    elseif state == "LM" then
        LM:draw()
    elseif state == "modes" then
        modes:draw()
    end
  
end

function Reset()
    --reset game
    player.life = 3
    ball:reset()
    for i= 0,brick_num-1,1
    do
        bricks[i].health = 3
        bricks[i].destroyed = false
    end
end