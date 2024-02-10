-- Services
local Players = game:GetService("Players")
local RP = game:GetService("ReplicatedStorage")
local proximityPromptService = game:GetService("ProximityPromptService")

-- Events
local enableWaveGui = RP:WaitForChild("enableWaveGui", 10)
local requestNewWave = RP:WaitForChild("requestNewWave", 10)
local requestWaveHudChange = RP:WaitForChild("requestWaveHudChange", 10)
local hasMatchStartedEvent = RP:WaitForChild("hasMatchStarted", 10)

-- Variables
local spawnedEnemies = workspace:WaitForChild("SpawnedEnemies", 10)
local sensor = workspace:WaitForChild("sensor", 10)
local bombSailor = RP:WaitForChild("bombsailor", 10)
local goldSailor = RP:WaitForChild("goldsailor", 10)
local starterPoint = workspace:WaitForChild("starterPoint", 10)
local interactionPart = starterPoint:WaitForChild("interactionPart", 10)
local npc = starterPoint:WaitForChild("scaredPeople", 10)
local breathSound = npc:WaitForChild("Sound", 10)
local startMatchDebouncing = false
local newWaveDebouncing = false
local inGamePlayers = {}
breathSound:Play()

-- Functions

local function waveController()
	while true do
		task.wait(0.1)
		if #spawnedEnemies:GetChildren() == 0 and not newWaveDebouncing then
			newWaveDebouncing = true
			requestNewWave:Fire()
			local sound = Instance.new("Sound")
			sound.SoundId = ("rbxassetid://%d"):format(5563980633)
			sound.Parent = workspace
			sound:Play()
			sound.Ended:Connect(function()
				sound:Destroy()
			end)
			for _, player in inGamePlayers do
				requestWaveHudChange:FireClient(player)
			end
			task.delay(1, function()
				newWaveDebouncing = false
			end)
		end
	end
end

local function startMatch()
	starterPoint.Parent = RP
	goldSailor.Parent = workspace
	breathSound:Pause()
	sensor.Touched:Connect(function(hit)
		local character = hit.Parent
		local player = Players:GetPlayerFromCharacter(character)
		if not player then
			return
		end
		if not inGamePlayers[player] then
			inGamePlayers[-1] = player
		end
		hasMatchStartedEvent:FireClient(player)
		enableWaveGui:FireClient(player)
	end)
	waveController()
end

-- Listeners
proximityPromptService.PromptTriggered:Connect(function(prompt)
	if prompt.Name == "startGame" and not startMatchDebouncing then
		startMatchDebouncing = true
		startMatch()
	end
end)
