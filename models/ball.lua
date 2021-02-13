local class = require("libs.class")
local Ball = class:derive("Ball")

--starting ball position
local b_pos_x  = love.graphics.getWidth()*0.5
local b_pos_y = love.graphics.getHeight()*0.7

function Ball:new(r,speed)
    self.r = r
    self.x =  b_pos_x
    self.y = b_pos_y
    self.speed = speed
end


local dir_x = 1
local dir_y = 1

function Ball:update(dt,player,bricks)
    if dt > 0.035 then return end

    self.x = self.x + self.speed*dir_x
    self.y = self.y + self.speed*dir_y

    self:player_hit(player)
    self:brick_hit(bricks)
    self:bounderies_hit(player)
    
end
function Ball:bounderies_hit(player)
    --Collision with right/left 
    if (self.x + dir_x*self.speed ) >= love.graphics.getWidth()-self.r  or (self.x + dir_x*self.speed) <= self.r then
        dir_x = dir_x * -1
    --Collison with top
    elseif  (self.y + dir_y*self.speed) <= self.r then
        dir_y = dir_y * -1
    --Collision with bottom
    elseif (self.y + self.r) >= love.graphics.getHeight() then
        self:reset()
        player.life = player.life -1 
    end
end
-- Changing direction on brick hit
function Ball:brick_hit(bricks)
    for i,brick in pairs(bricks) 
    do 
        local test_x = self.x + self.speed*dir_x
        --test if in next moment will hit brick from sides
        if self:collision(brick,test_x,self.y) and not brick.destroyed then
            dir_x = dir_x* -1
            brick.health = brick.health -1
            if brick.health == 0 then
                if brick.Bonus ~= nil then brick.Bonus.live = true end
                brick.destroyed = true
            end
        end

        local test_y = self.y + self.speed*dir_y
        --test if in next moment will hit brick from top/bottom
        if self:collision(brick,self.x,test_y) and not brick.destroyed then
            dir_y = dir_y* -1
            brick.health = brick.health -1
            if brick.health == 0 then
                if brick.Bonus ~= nil then brick.Bonus.live = true end
                brick.destroyed = true
            end
        end
    end

end


function Ball:reset()
    self.speed = 0
    self.x = b_pos_x
    self.y = b_pos_y
    dir_y = 1
    dir_x = 1
end

function Ball:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("fill", self.x, self.y, self.r, 100)
end
-- Changing direction on player hit
function Ball:player_hit(player)

    local test_x = self.x + self.speed*dir_x
    --test if in next moment will hit player from sides
    if self:collision(player,test_x,self.y) then
        dir_x = dir_x* -1
        dir_y = dir_y*-1
    end
    --test if in next moment will hit player from top
    local test_y = self.y + self.speed*dir_y
    if self:collision(player,self.x,test_y) then
        dir_y = dir_y* -1
    end
end
--Detecting collision of an item(player/brick) and the ball
function Ball:collision(item,tx,ty)
    local test_x = tx
    --Check from which edge is the closest
    if tx < item.x then test_x  = item.x 
    elseif tx > item.x + item.width then test_x = item.x + item.width end

    local test_y = ty
    if ty < item.y then test_y = item.y 
    elseif ty > item.y + item.height then test_y = item.y + item.height end

    local dist_x = tx - test_x
    local dist_y = ty - test_y

    local dist = math.sqrt(dist_x*dist_x + dist_y*dist_y)

    return dist <= self.r
end
--distance between two points 
function Ball:distance ( x1, y1, x2, y2 )
    local dx = x1 - x2
    local dy = y1 - y2
    return math.sqrt ( dx * dx + dy * dy )
  end

--fif all brick are destroyed then level is completed
  function Ball:level_completed(bricks,brick_num)
    if brick_num == 0 then return false end
    for i= 0,brick_num-1,1
    do 
        if bricks[i].destroyed == false then
             return false
        end
     end
     return true
  end

return Ball