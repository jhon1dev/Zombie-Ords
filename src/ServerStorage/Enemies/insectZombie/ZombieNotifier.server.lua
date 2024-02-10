-- Variables
local zombie = script.Parent
local humanoid:Humanoid = zombie:WaitForChild("Humanoid")
local connection:RBXScriptSignal

-- Events
local ZombieDied = game:GetService("ServerStorage").Network.ZombieDefeated

connection = humanoid.Died:Connect(function()
	local playerId = humanoid:GetAttribute("LastDamage")
	ZombieDied:Fire(playerId)
	connection:Disconnect()
end)