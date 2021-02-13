local LM = {} 
local Level = require("models.level")
local levels = {}

local level = Level(1)
function LM:draw()
    for i=0,10,1
    do
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("fill",100+ 300*(i%4),60 + 80*math.floor(i/4),200,40)
        love.graphics.setColor(0,0,0)
        love.graphics.print("level "..i+1,160+ 300*(i%4),65 + 80*math.floor(i/ 4))
        levels[i] = Level(i+1,100+ 300*(i%4),60 + 80*math.floor(i/ 4))
    end

end
function LM:get_level()
    return level
end

function LM:choose_level(mx,my)
    --checking which level is chosen
   for i=0,10,1
   do 
    if mx > levels[i].x and mx < levels[i].x + 200 and
    my > levels[i].y and my < levels[i].y + 40 then
        level = levels[i]
    end
   end
   return level.bricks,level.brick_num
end
return LM