local class = require("libs.class")
local Level = class:derive("level")
local Brick = require("models.brick")
local Bonus = require("models.bonus")

function Level:new(i,x,y)
    self.number = i
    self.x = x
    self.y = y
    self.bricks = {}
    self.brick_num = 10 + 10*(self.number-1)
    for i = 0,self.brick_num-1,1
    do 
        local brick = Brick(100 +110*(i%10),50 + 40*math.floor(i/ 10),100,30)
        local rand = math.random(0,100)
        -- we dont want all bricks to have a bonus, we are generating approx. bonus at every 4th brick
        if rand < 25 then
            -- randomize which bonus is given to the brick
            brick.Bonus = Bonus(brick,rand%3+1)
        end
        self.bricks[i]= brick
    end

end

function Level:update(dt,player)
    for i =0,self.brick_num-1,1
    do 
        if self.bricks[i].Bonus ~= nil then 
            self.bricks[i].Bonus:update(dt,player)
        end
    end

end

function Level:draw()
    for i =0,self.brick_num-1,1
    do 
        self.bricks[i]:draw()
        if self.bricks[i].Bonus ~= nil and self.bricks[i].Bonus.live == true then
            self.bricks[i].Bonus:draw()
        end
     end

end
return Level