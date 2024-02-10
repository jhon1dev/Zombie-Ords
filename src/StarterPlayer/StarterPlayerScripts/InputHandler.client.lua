-- Services
local UserInputService = game:GetService("UserInputService")
local RP = game:GetService("ReplicatedStorage")

-- Events
local hasMatchStartedEvent = RP:WaitForChild("hasMatchStarted", 10)
local dropBombEvent = game:GetService("ReplicatedStorage").DropBomb

-- Variables and Constants
local ACTION__KEY = Enum.KeyCode.E
local KEY__DELAY = 1.5
local canAttack:boolean = true
local matchStarted:boolean

-- Functions

local function dropBomb()
	dropBombEvent:FireServer()
	canAttack = false
	task.delay(KEY__DELAY, function()
		canAttack = true
	end)
end

hasMatchStartedEvent.OnClientEvent:Connect(function()
	matchStarted = true
end)

UserInputService.InputEnded:Connect(function(input:InputObject, gameProcessedEvent:boolean)
	if input.KeyCode == ACTION__KEY and canAttack and matchStarted then
		dropBomb()
	end
end)

