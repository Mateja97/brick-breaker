local Menu = {}
local LM = require ("states.levelmaker")
local modes = require("states.modes")
function Menu:draw()
    --drawing menu page
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("WELCOME TO BRICK BREAKER", love.graphics.getWidth() * 0.35, 100)
    love.graphics.rectangle("line", love.graphics.getWidth()*0.5-100, love.graphics.getHeight()*0.4, 200,40)
    love.graphics.print("Start", love.graphics.getWidth()*0.5-30, love.graphics.getHeight()*0.4 + 5)
    love.graphics.rectangle("line", love.graphics.getWidth()*0.5-100, love.graphics.getHeight()*0.4 + 60, 200,40)
    love.graphics.print("Select level", love.graphics.getWidth()*0.5-70, love.graphics.getHeight()*0.4 + 65)
    love.graphics.print("Selected level: "..LM.get_level().number, love.graphics.getWidth()*0.5+160, love.graphics.getHeight()*0.4 + 65)
    love.graphics.rectangle("line", love.graphics.getWidth()*0.5-100, love.graphics.getHeight()*0.4 + 120, 200,40)
    love.graphics.print("Select mode", love.graphics.getWidth()*0.5-70, love.graphics.getHeight()*0.4 + 125)
    love.graphics.print("Selected mode: ".. modes.get_mode(), love.graphics.getWidth()*0.5+160, love.graphics.getHeight()*0.4 + 125)
    love.graphics.rectangle("line", love.graphics.getWidth()*0.5-100, love.graphics.getHeight()*0.4 + 180, 200,40)
    love.graphics.print("Quit", love.graphics.getWidth()*0.5-25, love.graphics.getHeight()*0.4 + 185)
end

function Menu:what_is_clicked(mx,my,state)
    if mx > love.graphics.getWidth()*0.5  -100  and mx  < love.graphics.getWidth()*0.5 +100
    and my> love.graphics.getHeight()*0.4 and my < love.graphics.getHeight()*0.4 + 40 then 
        return "game"
    elseif mx > love.graphics.getWidth()*0.5-100 and mx < love.graphics.getWidth()*0.5 + 100
        and my > love.graphics.getHeight()*0.4 + 60 and my < love.graphics.getHeight()*0.4 + 100 then
        return "LM"
    elseif mx > love.graphics.getWidth()*0.5-100 and mx < love.graphics.getWidth()*0.5+ 100
    and  love.graphics.getHeight()*0.4 + 120  and my <  love.graphics.getHeight()*0.4 + 160 then
        return "modes"
    elseif mx > love.graphics.getWidth()*0.5-100 and mx < love.graphics.getWidth()*0.5+ 100 
    and my > love.graphics.getHeight()*0.4 + 180 and my < love.graphics.getHeight()*0.4 + 220 then
        return "quit"
    end
    return state
end
return Menu