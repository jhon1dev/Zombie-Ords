-- Services
local Players = game:GetService("Players")
local RP = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- Events
local playerLoadedRemoteEvent = RP:WaitForChild("PlayerLoaded", 10)
local requestSpeedUpgrade = RP:WaitForChild("RequestSpeedUpgrade", 10)
local requestPowerUpgrade = RP:WaitForChild("RequestPowerUpgrade", 10)
local sendPlayerPower = RP:WaitForChild("requestPlayerPower", 10)
local enableWaveGui = RP:WaitForChild("enableWaveGui", 10)
local requestWaveHudChange = RP:WaitForChild("requestWaveHudChange", 10)

-- Variables
local playerGUI = Players.LocalPlayer.PlayerGui
local hud = playerGUI:WaitForChild("Hud")
local powerLimit = 10
local waveNumber = workspace:WaitForChild("waveNumber")

local addPowerButton:TextButton = hud:WaitForChild("upgradeFolder").upgradePower
local addSpeedButton:TextButton = hud:WaitForChild("upgradeFolder").upgradeSpeed

local powerTag:TextLabel = hud:WaitForChild("powerFolder").power
local speedTag:TextLabel = hud:WaitForChild("speedFolder").speed
local goldTag:TextLabel = hud:WaitForChild("goldFolder").gold

-- Listeners

playerLoadedRemoteEvent.OnClientEvent:Connect(function(data)
	goldTag.Text = data.gold
	powerTag.Text = data.power
	speedTag.Text = data.speed
end)

addPowerButton.MouseButton1Click:Connect(function()
	requestPowerUpgrade:FireServer()
end)

addSpeedButton.MouseButton1Click:Connect(function()
	requestSpeedUpgrade:FireServer()
end)

enableWaveGui.OnClientEvent:Connect(function()
	local screenGUI = playerGUI.Hud.matchFolder.ScreenGui
	screenGUI.Enabled = true
end)

requestWaveHudChange.OnClientEvent:Connect(function()
	local screenGUI = playerGUI.Hud.matchFolder.ScreenGui
	local waveLabel = screenGUI.Frame.TextLabel
	waveLabel.Text = "Wave " .. tostring(waveNumber.Value)
end)
