-- Services
local Players = game:GetService("Players")
local RP = game:GetService("ReplicatedStorage")

-- Events
local requestMatchStart = RP.requestMatchStart

-- Variables
local starterPoint = workspace:WaitForChild("starterPoint", 10)
local npc = starterPoint:WaitForChild("scaredPeople", 10)
local dialog:Dialog = npc:WaitForChild("Head").Dialog

-- Functions
local function startMatch()
	requestMatchStart:Fire()
end

-- Listeners
dialog.DialogChoiceSelected:Connect(startMatch)