require("Scripts.Levels.Tutorial_Objects.Rocket_Tut")
require("Scripts.Levels.Tutorial_Objects.BloodRain_Tut")

local TankSpeed_Count_Min = { 0.5, 0.5625, 0.625, 0.6875, 0.75, 0.8125, 0.875, 0.9375, 1.0, 1.0625, 1.125, 1.1875, 1.25, 1.3125, 1.375, 1.4375 }
local FD96_Speed_Count = { 0.5, 0.5625, 0.625, 0.6875, 0.75, 0.8125, 0.875, 0.9375, 1.0, 1.0625, 1.125, 1.1875, 1.25, 1.3125, 1.375, 1.4375 }

function SpawnRocket(rockets, all_objects, rockets_length)
    local rnd_Rocket = {"Left", "Right" }
    
    local currentPos = rnd_Rocket[love.math.random(1,2)]

    if currentPos == "Left" then

        table.insert(rockets, Rocket:new(-30,love.math.random(630,800),
        love.math.random(C_GameManager.rocket_Spd_min, C_GameManager.rocket_Spd_max) * 0.05, true))

    elseif currentPos == "Right" then

        table.insert(rockets, Rocket:new(1600,love.math.random(630,800), 
        love.math.random(C_GameManager.rocket_Spd_min, C_GameManager.rocket_Spd_max) * 0.05, false))
    end

    table.insert(all_objects, rockets[#rockets]) -- ������ ������Ʈ ��Ͽ� ���Խ�ŵ�ϴ�.
    table.insert(rockets_length, rockets[#rockets]) -- ������ ������ �뷮�� ���� �߰��ؼ� ���� ���� ���� Ȯ���ϰ� ���ݴϴ�.
end

function SpawnRocket_Tut(rockets, all_objects, rockets_length)
    local rnd_Rocket = {"Left", "Right" }
    
    local currentPos = rnd_Rocket[love.math.random(1,2)]

    if currentPos == "Left" then

        table.insert(rockets, Rocket_Tut:new(-30,love.math.random(630,800),
        love.math.random(4, 7) * 0.05, true))

    elseif currentPos == "Right" then

        table.insert(rockets, Rocket_Tut:new(1600,love.math.random(630,800), 
        love.math.random(4, 7) * 0.05, false))
    end

    table.insert(all_objects, rockets[#rockets]) -- ������ ������Ʈ ��Ͽ� ���Խ�ŵ�ϴ�.
    table.insert(rockets_length, rockets[#rockets]) -- ������ ������ �뷮�� ���� �߰��ؼ� ���� ���� ���� Ȯ���ϰ� ���ݴϴ�.
end

local rndFD96 = { 400, 600, 900, 1200 }

function SpawnFD96(fd96s, all_objects, fd96s_length, playerCore)

    local rndRot = love.math.random(1) + 0
    
    local rndXPos = love.math.random(#rndFD96)
    table.insert(fd96s, FD_96:new(rndFD96[rndXPos], -50, rndRot, playerCore, FD96_Speed_Count[C_GameManager.fd96_Spd_idx]))

    table.insert(all_objects, fd96s[#fd96s])
    table.insert(fd96s_length, fd96s[#fd96s])
end

function SpawnRain(x,y,warRain,all_objects)
    table.insert(warRain, WarRainCore:new(x,y))
    table.insert(all_objects, warRain[#warRain])
end

function SpawnFD96_Bullet(fd96s_Bullet, all_objects, x,y,r)
    table.insert(fd96s_Bullet, FD_96_Bullet:new(x,y,r))
    table.insert(all_objects, fd96s_Bullet[#fd96s_Bullet])
end

function Spawn_K99_Tank(k99Tanks, k99Tanks_length, all_objects)
    local rnd_Tank = {"Left", "Right" }
    local currentPos = rnd_Tank[love.math.random(1,2)]

    if currentPos == "Left" then
        local rndX = {-30, -120}
        local rndXPos = love.math.random(#rndX)

        table.insert(k99Tanks, K99_Tank:new(rndX[rndXPos], true, TankSpeed_Count_Min[C_GameManager.tank_Spd_idx]))
    elseif currentPos == "Right" then
        local rndX = {1600, 1700}
        local rndXPos = love.math.random(#rndX)
        
        table.insert(k99Tanks, K99_Tank:new(rndX[rndXPos], false, TankSpeed_Count_Min[C_GameManager.tank_Spd_idx]))
    end

    table.insert(all_objects, k99Tanks[#k99Tanks]) 
    table.insert(k99Tanks_length, k99Tanks[#k99Tanks]) 
end

function Effect_Explosion(explosions,x,y,w,h,all_objects,r)
    table.insert(explosions, ExplosionEffects:new(x,y,w,h,r))
    table.insert(all_objects, explosions[#explosions])
end

function Effect_Explosion_Tut(explosions,x,y,w,h,all_objects,r)
    table.insert(explosions, ExplosionEffects_Tutorial:new(x,y,w,h,r))
    table.insert(all_objects, explosions[#explosions])
end

function Effect_RocketSmoke(smoke,x,y,w,h,all_objects)
    table.insert(smoke, RocketSmoke:new(x,y,w,h))
    table.insert(all_objects, smoke[#smoke])
end

function Effect_BloodRain_Tok(bloodRain,x,y,w,h,all_objects)
    table.insert(bloodRain, BloodRain_Effect:new(x,y,w,h))
    table.insert(all_objects, bloodRain[#bloodRain])
end

function Effect_BloodRain_Tok_Tut(bloodRain,x,y,w,h,all_objects)
    table.insert(bloodRain, BloodRain_Effect_Tut:new(x,y,w,h))
    table.insert(all_objects, bloodRain[#bloodRain])
end

function Effect_BulletDrop(bulletDrop,x,y,all_objects)
    table.insert(bulletDrop, Bullet_Drop_Effect:new(x + 32,y,math.random(0,360)))
    table.insert(all_objects, bulletDrop[#bulletDrop])
end

function Tank_Destroyed_Drop(tankDrop,tank, all_objects)
    table.insert(tankDrop, Tank_Destroyed:new(tank.x, tank.y, tank.isRight))
    table.insert(all_objects, tankDrop[#tankDrop])
end

function JET_Destroyed_Drop(jetDrop, jet, all_objects)
    table.insert(jetDrop, JET_Destroyed:new(jet.x, jet.y))
    table.insert(all_objects, jetDrop[#jetDrop]) 
end