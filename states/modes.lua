local modes = {} 
local mode = "Easy"
function modes:draw()
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", love.graphics.getWidth()*0.5-100, love.graphics.getHeight()*0.4, 200,40)
    love.graphics.setColor(0,0,0)
    love.graphics.print("Easy", love.graphics.getWidth()*0.5-30, love.graphics.getHeight()*0.4 + 5)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", love.graphics.getWidth()*0.5-100, love.graphics.getHeight()*0.4 + 60, 200,40)
    love.graphics.setColor(0,0,0)
    love.graphics.print("Medium", love.graphics.getWidth()*0.5-30, love.graphics.getHeight()*0.4 + 65)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", love.graphics.getWidth()*0.5-100, love.graphics.getHeight()*0.4 + 120, 200,40)
    love.graphics.setColor(0,0,0)
    love.graphics.print("Hard", love.graphics.getWidth()*0.5-30, love.graphics.getHeight()*0.4 + 125)
end
function modes:get_mode()
    return mode
end
function modes:choose_mode(mx,my)

    if mx > love.graphics.getWidth()*0.5  -100  and mx  < love.graphics.getWidth()*0.5 +100
    and my> love.graphics.getHeight()*0.4 and my < love.graphics.getHeight()*0.4 + 40 then
        mode = "Easy"
        return "easy"
    elseif mx > love.graphics.getWidth()*0.5-100 and mx < love.graphics.getWidth()*0.5 + 100
        and my > love.graphics.getHeight()*0.4 + 60 and my < love.graphics.getHeight()*0.4 + 100 then
        mode ="Medium"
        return "medium"
    elseif mx > love.graphics.getWidth()*0.5-100 and mx < love.graphics.getWidth()*0.5+ 100
    and  love.graphics.getHeight()*0.4 + 120  and my <  love.graphics.getHeight()*0.4 + 160 then
        mode = "Hard"
        return "hard"
    end
 end

return modes