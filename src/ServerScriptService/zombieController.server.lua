-- Services
local Players = game:GetService("Players")
local RP = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- Events
local requestPlayerPower = RP:WaitForChild("requestPlayerPower", 1)
local requestMatchStart = RP:WaitForChild("requestMatchStart", 1)
local requestNewWave = RP:WaitForChild("requestNewWave", 1)

-- Variables
local enemies = game:GetService("ServerStorage"):FindFirstChild("Enemies")
local normalZombie:Model = enemies:WaitForChild("normalZombie", 1)
local insectZombie:Model = enemies:WaitForChild("insectZombie", 1)
local popStarZombie:Model = enemies:WaitForChild("popStarZombie", 1)
local summerZombie:Model = enemies:WaitForChild("summerZombie", 1)
local spawnedEnemies = workspace:WaitForChild("SpawnedEnemies", 1)
local mobSpawnerPositions = workspace:WaitForChild("mobSpawnerPositions", 1):GetChildren()
local enemyPopulation = 3
local waveNumber = workspace:WaitForChild("waveNumber")

-- Functions

local function setRandomPosition(zombie:Model) 
	local randInt = math.random(4)
	local mob:Model = mobSpawnerPositions[randInt]
	zombie.Parent = spawnedEnemies
	print(mob)
	zombie.PrimaryPart.CFrame = mob.CFrame
end

local function spawnZombie()
	if waveNumber.Value <= 5 then
		local normalZombieCloned = normalZombie:Clone()
		setRandomPosition(normalZombieCloned)
	elseif waveNumber.Value >= 5 and waveNumber.Value <= 10 then
		local normalZombieCloned = normalZombie:Clone()
		setRandomPosition(normalZombieCloned)
		local summerZombieCloned = summerZombie:Clone()
		setRandomPosition(summerZombieCloned)
	elseif waveNumber.Value >= 10 and waveNumber.Value <= 15 then
		local normalZombieCloned = normalZombie:Clone()
		setRandomPosition(normalZombieCloned)
		local summerZombieCloned = summerZombie:Clone()
		setRandomPosition(summerZombieCloned)
		local insectZombieCloned = insectZombie:Clone()
		setRandomPosition(insectZombieCloned)
	elseif waveNumber.Value >= 15 and waveNumber.Value <= 20 then
		local normalZombieCloned = normalZombie:Clone()
		setRandomPosition(normalZombieCloned)
		local summerZombieCloned = summerZombie:Clone()
		setRandomPosition(summerZombieCloned)
		local insectZombieCloned = insectZombie:Clone()
		setRandomPosition(insectZombieCloned)
		local popStarZombieCloned = popStarZombie:Clone()
		setRandomPosition(popStarZombieCloned)
	end
end

local function setEnemyPopulation()
	waveNumber.Value += 1
	if waveNumber.Value <= 5 then
		enemyPopulation += 1
	elseif  waveNumber.Value >= 5 and waveNumber.Value <= 10 then
		enemyPopulation += 2
	elseif waveNumber.Value >= 10 and waveNumber.Value <= 15 then
		enemyPopulation += 3
	elseif waveNumber.Value >= 15 and waveNumber.Value <= 20 then
		enemyPopulation += 4
	end
	repeat
		spawnZombie()
		task.wait()
	until #spawnedEnemies:GetChildren() == enemyPopulation
end

requestNewWave.Event:Connect(setEnemyPopulation)
