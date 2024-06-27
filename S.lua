local player = game.Players.LocalPlayer
repeat 
	wait()
until player.Character

local char = player.Character
local OnUse = false
local AlreadyDes = false
local KillRadius = 50

local Range = Instance.new("Part",player.Character)
Range.CastShadow = false
Range.Material = Enum.Material.Neon
Range.Shape = Enum.PartType.Cylinder
Range.CanCollide = false
Range.Size = Vector3.new(0.1, KillRadius*2, KillRadius*2)
Range.Color = Color3.fromRGB(255, 0, 0)
Range.Massless = true
Range.Transparency = 1 
local Weld = Instance.new("Weld",player.Character.HumanoidRootPart)
Weld.Part0 = player.Character.HumanoidRootPart
Weld.Part1 = Range
Weld.C1 = CFrame.new(-2,0,0) * CFrame.Angles(0, 0, math.rad(90))

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player.PlayerGui

local TextButton = Instance.new("TextButton")
TextButton.Parent = ScreenGui
TextButton.Position = UDim2.new(0.862, 0, 0.735, 0)
TextButton.Size = UDim2.new(0, 88, 0, 82)
TextButton.TextScaled = true
TextButton.Text = "Kill NPCs"
TextButton.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
TextButton.TextColor3 = Color3.fromRGB(85, 255, 0)

TextButton.MouseButton1Click:Connect(function()
	if OnUse == false then
		OnUse = true
	else
		OnUse = false
	end
end)

game:GetService("RunService").Heartbeat:Connect(function()
	local playerPosition = player.Character.HumanoidRootPart.Position
	local humanoidPosition = nil

	for i, descendant in pairs(workspace:GetDescendants()) do
		if descendant:IsA("Humanoid") and descendant.Parent:FindFirstChild("HumanoidRootPart") and OnUse == true then
			humanoidPosition = descendant.Parent.HumanoidRootPart.Position
			local distance = (playerPosition - humanoidPosition).magnitude
			if distance <= KillRadius and descendant.Parent.Name ~= player.Name then
				descendant.Health = 0
			end
		end

		if OnUse == false then
			TextButton.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
			TextButton.TextColor3 = Color3.fromRGB(85, 255, 0)
			AlreadyDes = false
			Range.Transparency = 1
		elseif OnUse == true then
			Range.Transparency = 0.7
			TextButton.BackgroundColor3 = Color3.fromRGB(85, 255, 0)
			TextButton.TextColor3 = Color3.fromRGB(255, 0, 4)
			if not AlreadyDes then
				AlreadyDes = true
				if OnUse == false then
					break
				end
			end
		end
	end
end)
