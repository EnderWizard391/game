function love.load() --best score 28
  love.window.setFullscreen(true)
  tick = require "tick"
  bomb_c = love.graphics.newImage("bomb.png")
  player_c = love.graphics.newImage("panda.png")
  bullet_c = love.graphics.newImage("bullet.png")
  
  bullet_speed_up = 25
  max_player_speed = 400
  max_bullet_speed = max_player_speed + 50
  max_bomb_speed = max_bullet_speed / 2.5
  init_speed = 150
  score = 0
  player = {
      x = 0,
      y = 0,
      speed = init_speed,
      wid = player_c:getWidth(),
      hei = player_c:getHeight()
  }
  bullet = {
      x = 1500,
      y = 200,
      speed = init_speed, 
      wid = bullet_c:getWidth(),
      hei = bullet_c:getHeight(),
      x_orig = 1500, --used to reset x
  }
  bomb = {
    x = 1500,
    y = 100,
    speed = init_speed,
    wid = bomb_c:getWidth(),
    hei = bomb_c:getHeight(),
    x_orig = 1500, --also used to reset x
  }
  update = true
  sound2 = love.audio.newSource("boom.mp3", "static")
  sound = love.audio.newSource("pling.mp3", "static")
end

function love.draw()
    love.graphics.print("Score = ", 0, 0)
    love.graphics.print(score, 50, 0)
    -- love.graphics.rectangle("line", player.x-1, player.y-1, player.wid+1, player.hei+1)
    love.graphics.draw(player_c, player.x, player.y, 0, wid, hei)
          
    love.graphics.draw(bullet_c, bullet.x, bullet.y)
    -- love.graphics.rectangle("line", bullet.x-1, bullet.y-1, bullet.wid+1, bullet.hei+1)
    
    love.graphics.draw(bomb_c, bomb.x, bomb.y)
end


function love.update(dt)
  if love.keyboard.isDown("right") then
      player.x = player.x + player.speed * dt
  elseif love.keyboard.isDown("left") then
     player.x = player.x - player.speed * dt
  elseif love.keyboard.isDown("up") then
      player.y = player.y - player.speed * dt
  elseif love.keyboard.isDown("down") then
      player.y = player.y + player.speed * dt
  --elseif love.keyboard.isDown("space") then
  elseif esc == " " then
          if love.window.setFullscreen(true) then
                love.window.setFullscreen(false)
                else love.window.setFullscreen(true)
          end
        end

    --  update = not update
   -- else update = update
    
    
  -- if update then
  bomb.x = bomb.x - bomb.speed * dt
  bullet.x = bullet.x - bullet.speed * dt
  if checkCollision(player, bullet) then
    bullet.x = bullet.x_orig
    bullet.y = love.math.random(0, 500)
    sound:play()
    score = score + 1
    bullet.speed = bullet.speed + bullet_speed_up - .5
    if bullet.speed > max_bullet_speed then
        bullet.speed = max_bullet_speed
    end

  end
  player.speed = player.speed + 20
  if player.speed > max_player_speed then
      player.speed = max_player_speed
  end
  if bomb.speed > max_bomb_speed then
      bomb.speed = max_bomb_speed
  end
  if bullet.x < 0 then
      bullet.x = bullet.x_orig
      bomb.x = bomb.x_orig
      score = 0
      bullet.speed = init_speed
      sound2:play()
  end
  if bomb.x < -500 then
    bomb.x = bomb.x_orig
  end
  if checkCollision2(player, bomb) then
    bomb.x = bomb.x_orig
    bullet.speed = init_speed
    bomb.speed = init_speed
    player.speed = init_speed
    bomb.speed = bomb.speed + 25
    bomb.x = bomb.x_orig
    bullet.x = bullet.x_orig
    bomb.y = love.math.random(0 ,700)
    score = score - score
    sound2:play()
  end
end



function checkCollision(a, b)
    local a_left = a.x
    local a_right = a.x + a.wid
    local a_top = a.y
    local a_bottom = a.y + a.hei
    
    local b_left = b.x
    local b_right = b.x + b.wid
    local b_top = b.y
    local b_bottom = b.y + b.hei
    
    
     return a_right > b_left
        and a_left < b_right
        and a_bottom > b_top
        and a_top < b_bottom
        
        
        
end 

function checkCollision2(a, b)
    local a_left = a.x
    local a_right = a.x + a.wid
    local a_top = a.y
    local a_bottom = a.y + a.hei
    
    local b_left = b.x
    local b_right = b.x + b.wid
    local b_top = b.y
    local b_bottom = b.y + b.hei
    
    
     return a_right > b_left
        and a_left < b_right
        and a_bottom > b_top
        and a_top < b_bottom
        
        
end