local class = require("libs.class")
local Player = class:derive("Player")

--starting position
local start_pos_x =  love.graphics.getWidth()*0.5
local start_pos_y = love.graphics.getHeight()*0.9 
local heart = love.graphics.newImage("/assets/heart.png")

function Player:new(w,h)
    self.width = w
    self.height = h 
    self.x = start_pos_x  - self.width/2
    self.y = start_pos_y - self.height/2
    self.life = 3
end

function Player:draw()  
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", self.x, self.y,self.width,self.height)
    love.graphics.draw(heart,5,5,0,0.02,0.02)
    love.graphics.print(" : "..self.life, 35,10)
end

function Player:update(dt)
    if dt > 0.035 then return end

    local mouse_x = love.mouse.getX()
    local win_width = love.graphics.getWidth()
    -- player(tile) is following a mouse position
    if (mouse_x + self.width/2) < win_width and (mouse_x - self.width/2)> 0 then

        self.x = mouse_x - self.width/2

    elseif (mouse_x + self.width/2) > win_width then

        self.x = win_width - self.width

    elseif (mouse_x - self.width/2) < 0  then

        self.x = 0
        
    end

end

function Player:shot(ball,speed)
    if ball.speed == 0 then
       ball.speed = speed
    end

end

return Player