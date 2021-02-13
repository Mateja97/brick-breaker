local class = require("libs.class")
local Bonus = class:derive("bonus")

local heart = love.graphics.newImage("/assets/heart.png")
local garrow = love.graphics.newImage("/assets/arrows-01.png")
local rarrow = love.graphics.newImage("/assets/arrows-02.png")
function Bonus:new(brick,t)
    self.x = brick.x + brick.width/2
    self.y = brick.y + brick.height/2
    self.type = t
    self.live = false
    self.timer = 0
    self.activated = false
end
function Bonus:update(dt,player)
    self:player_collect(player)
    self:activate_bonus(player,dt)

    if self.live then
        self.y = self.y + 2
    end
    if self.y >= love.graphics.getHeight() then
        self.y = 0
        self.live = false
    end
end
function Bonus:draw()
    if self.type == 1 then
        love.graphics.draw(garrow,self.x,self.y)
    elseif self.type == 2 then
        love.graphics.draw(rarrow,self.x,self.y)
    elseif self.type == 3 then
        love.graphics.draw(heart,self.x,self.y,0,0.02,0.02)
    end
end
function Bonus:player_collect(player)
    --checking if bonus is collected from player
    if self.x >= player.x and self.x <= player.x + player.width 
    and self.y >= player.y and self.y <= player.y + player.height and self.live then
        self.activated= true
        self.live = false
    end
end

function Bonus:activate_bonus(player,dt)
    --if bonus is collected, activate it
    if  self.activated then
        if self.type == 1 and player.width < 400 then
            player.width = player.width + 200
        elseif self.type == 2 and player.width > 100 then
            player.width = player.width - 100
        elseif self.type == 3 then
            player.life  = player.life + 1
            self.activated = false
        end
    end
    if self.activated then self.timer = self.timer + dt end
    -- when 10 seconds expire, return old width
    if self.timer > 10 then
        if self.type == 1 then
            player.width = player.width - 200
        elseif self.type ==2 then
            player.width = player.width + 100
        end
        self.timer = 0
        self.activated = false
    end
end
return Bonus