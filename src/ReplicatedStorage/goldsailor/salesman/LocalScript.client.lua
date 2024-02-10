local npc = script.Parent
local humanoid = npc:WaitForChild("Humanoid")
local animation = Instance.new("Animation")
animation.AnimationId = ("rbxassetid://%d"):format(15945770836)
local animationTrack = humanoid.Animator:LoadAnimation(animation)
animationTrack.Looped = true
animationTrack:Play()