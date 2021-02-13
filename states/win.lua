local win = {}

function win:draw()
    love.graphics.setColor(0,1,0)
    love.graphics.rectangle("fill",love.graphics.getWidth()*0.3 -100,love.graphics.getHeight()*0.3,750,300)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Congratulations you have passed the level!" , love.graphics.getWidth()*0.3,love.graphics.getHeight()*0.4)
    love.graphics.print("Press R to restart the game or Esc to menu" , love.graphics.getWidth()*0.3,love.graphics.getHeight()*0.5)
end

return win