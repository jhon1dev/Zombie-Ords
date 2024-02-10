-- Event
local dropBombEvent = game:GetService("ReplicatedStorage").DropBomb

-- Variables
local bombFolder = game:GetService("ServerStorage").Bombs
local bombTemplate = bombFolder.Fusebomb

dropBombEvent.OnServerEvent:Connect(function(player)
	local bomb = bombTemplate:Clone()
	bomb.CFrame = player.Character.PrimaryPart.CFrame
	bomb.ColisionMask.CFrame = bomb.CFrame
	bomb:SetAttribute("Owner", player.UserId)
	bomb:SetAttribute("Power", player:GetAttribute("Power"))
	bomb.Parent = workspace.SpawnedBombs
end)