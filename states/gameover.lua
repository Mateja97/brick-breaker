local Gameover = {}

function Gameover:draw()
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle("fill",love.graphics.getWidth()*0.3,love.graphics.getHeight()*0.3,500,300)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("GAME OVER" , love.graphics.getWidth()*0.4 + 30,love.graphics.getHeight()*0.4)
    love.graphics.print("Press R to restart the game" , love.graphics.getWidth()*0.4-50,love.graphics.getHeight()*0.5)
end

return Gameover