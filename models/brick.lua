local class = require("libs.class")
local Brick = class:derive("Brick")
local brick1 = love.graphics.newImage("/assets/brick-01.png")
local brick2 = love.graphics.newImage("/assets/brick-02.png")
local brick3 = love.graphics.newImage("/assets/brick-03.png")

function Brick:new(x,y,w,h)
   self.x = x
   self.y = y 
   self.height = h 
   self.width = w
   self.destroyed = false
   self.health = 3
   self.Bonus = nil
end


function Brick:draw()
   love.graphics.setColor(1,1,1)
   if self.destroyed then return end
   if self.health == 3 then 
      love.graphics.draw(brick1, self.x, self.y)
   elseif self.health == 2 then 
      love.graphics.draw(brick2, self.x, self.y)
   elseif self.health == 1 then
       love.graphics.draw(brick3, self.x, self.y)
   end
end

return Brick