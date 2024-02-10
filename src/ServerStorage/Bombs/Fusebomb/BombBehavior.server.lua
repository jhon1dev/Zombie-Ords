-- Variables and Constants
local bomb = script.Parent
local EXPLOSION__TIME = 1
local owner = bomb:GetAttribute("Owner")
local power = bomb:GetAttribute("Power")

-- Functions
function PlaySound(Id, destination)
	local Sound = Instance.new("Sound")
	local random = Random.new()
	Sound.Pitch = random:NextNumber(0.5, 1)
	Sound.SoundId = Id
	Sound.Parent = destination
	Sound:Play()
	task.delay(EXPLOSION__TIME, function()
		Sound:Destroy()
		bomb:Destroy()
	end)
end

-- Bomb behavior
task.delay(EXPLOSION__TIME, function()
	local explosion = Instance.new("Explosion")
	explosion.BlastPressure = 0
	explosion.BlastRadius = 20
	explosion.DestroyJointRadiusPercent = 0
	explosion.Position = bomb.Position
	
	local colisionMask = bomb.ColisionMask
	colisionMask.Position = bomb.Position
	colisionMask.Touched:Connect(function(hit) end)
	
	local parts = colisionMask:GetTouchingParts()
	local humanoids = {}
	
	for _, part in parts  do
		local success, message = pcall(function()
			local character:Model = part.Parent
			if character then
				local humanoid:Humanoid = character:FindFirstChild("Humanoid")
				if humanoid then
					humanoids[humanoid] = true
					humanoid.Health -= power
					humanoid:SetAttribute("LastDamage", owner)
				end
				
			end	
		end)
		if not success then
			warn(message)
		end
	end
	explosion.Parent = workspace
	PlaySound("rbxassetid://5801257793", workspace)
end)