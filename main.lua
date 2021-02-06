-- https://github.com/Ulydev/push PUSH LINRARY-GITHUB REPO
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216
-- PADDLES
PADDLE_WIDTH = 8
PADDLE_HEIGHT = 32
PADDLE_SPEED = 140

BALL_SIZE = 4

gameState = 'title'

LARGE_FONT = love.graphics.newFont(32)
SMALL_FONT = love.graphics.newFont(22)
-- array like
player1 = {
 x = 10, y = 10
}

player2 = {
   x = VIRTUAL_WIDTH - PADDLE_WIDTH - 10,
    y = VIRTUAL_HEIGHT - PADDLE_HEIGHT - 10,
}

ball = {
   x = VIRTUAL_HEIGHT/2 - BALL_SIZE / 2,
   y = VIRTUAL_HEIGHT/2 + BALL_SIZE /2,
   dx= 0, dy = 0
}

function love.load()
   math.randomseed(os.time())
   love.graphics.setDefaultFilter('nearest', 'nearest')
   push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT)

   ball.dx = 60 + math.random(60)
   if math.random(2) == 1 then
      ball.dx = -ball.dx
end
   ball.dy = 30 + math.random(60)
   if math.random(2) ==1  then
   ball.dy = -ball.dy
   end
end
-- 'delta time' an empty amount of time between frames (last and current) multply dt by 
 
function love.update(dt)
    if love.keyboard.isDown('w') then
        player1.y = player1.y - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        player1.y = player1.y + PADDLE_SPEED * dt
    end

    if love.keyboard.isDown('up') then
        player2.y = player2.y - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        player2.y = player2.y + PADDLE_SPEED * dt
    end

      if gameState == 'play' then
        ball.x = ball.x + ball.dx * dt
        ball.y = ball.y + ball.dy * dt

        if ball.y <= 0 then
            ball.dy = -ball.dy
        elseif ball.y >= VIRTUAL_HEIGHT - BALL_SIZE then
            ball.dy = -ball.dy
           end

         end
      end
   

function love.keypressed(key)
   if key == 'escape' then
   love.event.quit()
   end
 

    if key == 'enter' or key == 'return' then
        if gameState == 'title' then
            gameState = 'serve'
        elseif gameState == 'serve' then
            gameState = 'play'
      end
   end
end

function love.draw()
    push:start()
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    if gameState == 'title' then
        love.graphics.setFont(LARGE_FONT)
        love.graphics.printf('Pre50 Pong', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(SMALL_FONT)
        love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT - 32, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'serve' then
        love.graphics.setFont(SMALL_FONT)
        love.graphics.printf('Press Enter to Serve!', 0, 10, VIRTUAL_WIDTH, 'center')
    end


    love.graphics.rectangle('fill', player1.x, player1.y, PADDLE_WIDTH, PADDLE_HEIGHT)
    love.graphics.rectangle('fill', player2.x, player2.y, PADDLE_WIDTH, PADDLE_HEIGHT)
    love.graphics.rectangle('fill', ball.x, ball.y, BALL_SIZE, BALL_SIZE)
    push:finish()
end

 