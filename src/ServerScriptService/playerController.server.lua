-- Services
local DataStoreService = game:GetService("DataStoreService")
local dataBase = DataStoreService:GetDataStore("zombieData")
local ServerStorage = game:GetService("ServerStorage")
local Players:Players = game:GetService("Players")
local RP = game:GetService("ReplicatedStorage")
local marketPlaceService = game:GetService("MarketplaceService")
local proximityPromptService = game:GetService("ProximityPromptService")

-- Variables and Constants
local playerLoadedRemoteEvent = RP.PlayerLoaded
local requestSpeedUpgrade = RP.RequestSpeedUpgrade
local requestPowerUpgrade = RP.RequestPowerUpgrade
local EARNED__GOLD = 25
local UPGRADE__COST = 10
local playersData = {}
local playerDefaultData = {
	gold = 0,
	power = 5,
	speed = 16,
}

-- Events
local zombieDefeated = ServerStorage.Network.ZombieDefeated
local playerLoadedRemoteEvent = game:GetService("ReplicatedStorage").PlayerLoaded

-- Function
local function onRequestSpeedUpgrade(player)
	local data = playersData[player.UserId]
	if data.gold < UPGRADE__COST then
		marketPlaceService:PromptProductPurchase(player, 1729289306)
		print("not enough gold")
		return
	end
	playersData[player.UserId].gold -= UPGRADE__COST
	playersData[player.UserId].speed += 0.5
	local character = player.Character
	if character then
		local humanoid:Humanoid = character:FindFirstChild("Humanoid")
		humanoid.WalkSpeed = playersData[player.UserId].speed
	end
	playerLoadedRemoteEvent:FireClient(player, playersData[player.UserId])
end

local function onRequestPowerUpgrade(player:Player)
	local data = playersData[player.UserId]
	if data.gold < UPGRADE__COST then
		marketPlaceService:PromptProductPurchase(player, 1729289306)
		print("not enough gold")
		return
	end
	playersData[player.UserId].gold -= UPGRADE__COST
	playersData[player.UserId].power += 0.5
	playerLoadedRemoteEvent:FireClient(player, playersData[player.UserId])
end

local function onPlayerRemoving(player)
	dataBase:SetAsync(player.userId, playersData[player.UserId])
	playersData[player.UserId] = nil
end

local function onPlayerAdded(player:Player)
	local data = dataBase:GetAsync(player.UserId)	
	if not data then
		data = playerDefaultData
	end
	playersData[player.UserId] = data
	player:SetAttribute("Power", data.power)
	while not player.Character do wait(1) end
	local character = player.Character
	if character then
		local humanoid:Humanoid = character:FindFirstChild("Humanoid")
		humanoid.WalkSpeed = data.speed
	end
	playerLoadedRemoteEvent:FireClient(player, playersData[player.UserId])
end

local function onEnemyDefeated(playerID)
	local player = Players:GetPlayerByUserId(playerID)
	playersData[player.UserId].gold += EARNED__GOLD
	local sound = Instance.new("Sound")
	sound.SoundId = ("rbxassetid://%d"):format(5852497507)
	sound.Parent = workspace
	sound:Play()
	sound.Ended:Connect(function()
		sound:Destroy()
	end)
	playerLoadedRemoteEvent:FireClient(player, playersData[player.UserId])
end

-- Listeners
marketPlaceService.ProcessReceipt = function(receiptInfo)
	if receiptInfo.ProductId == 1729289306 then
		local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
		playersData[player.UserId].gold += 1000
		playerLoadedRemoteEvent:FireClient(player, playersData[player.UserId])
	end
end

proximityPromptService.PromptTriggered:Connect(function(proximityPrompt, player)
	if proximityPrompt.Name == "goldProximityPrompt" then
		marketPlaceService:PromptProductPurchase(player, 1729289306)
	elseif proximityPrompt.Name == "bombProximityPrompt" then
		print("COMPRE BOMBA!")
	else
		return
	end
end)

-- Listeners
requestPowerUpgrade.OnServerEvent:Connect(onRequestPowerUpgrade)
requestSpeedUpgrade.OnServerEvent:Connect(onRequestSpeedUpgrade)
zombieDefeated.Event:Connect(onEnemyDefeated)
Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)
