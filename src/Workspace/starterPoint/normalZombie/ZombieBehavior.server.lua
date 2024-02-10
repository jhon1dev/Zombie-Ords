-- Services
local Players = game:GetService("Players")

-- Variables
local zombie = script.Parent
local humanoid = zombie.Humanoid
local TOTAL__HEALTH = humanoid.Health
local TASK__DELAY = 5
local CurrentHealth
local LastHealth
local soundId = {
	normalGrunt = "rbxassetid://449759304",
	angryGrunt = "rbxassetid://8224799480",
	rageGrunt = "rbxassetid://1456258813",
	dieGrunt = "rbxassetid://6108616307"
}

-- Functions

local function getHealth()
	return humanoid.Health
end

local function checkHealth()
	CurrentHealth = getHealth()
	if not LastHealth then
		LastHealth = CurrentHealth
	end
end

-- ZombieLoop

while TOTAL__HEALTH > 0 or CurrentHealth > 0  do
	task.wait()
	checkHealth()
end
