local player = game.Players.LocalPlayer
local KillRadius = 50
local OnUse = false
local AlreadyDes = false

-- Create Range Part under player's Character
local Range = Instance.new("Part", player.Character)
Range.Name = "Range"
Range.CastShadow = false
Range.Material = Enum.Material.Neon
Range.Shape = Enum.PartType.Cylinder
Range.CanCollide = false
Range.Size = Vector3.new(0.1, KillRadius * 2, KillRadius * 2)
Range.Color = Color3.fromRGB(255, 0, 0)
Range.Massless = true
Range.Transparency = 1

-- Position Range Part under player's feet
local humanoidRootPart = player.Character.HumanoidRootPart
Range.Position = humanoidRootPart.Position + Vector3.new(0, -humanoidRootPart.Size.Y / 2, 0)

-- Create Weld Constraint between HumanoidRootPart and Range
local Weld = Instance.new("Weld")
Weld.Part0 = humanoidRootPart
Weld.Part1 = Range
Weld.C1 = CFrame.new(-2, 0, 0) * CFrame.Angles(0, 0, math.rad(90))
Weld.Parent = humanoidRootPart

-- GUI setup
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
    OnUse = not OnUse
    if OnUse then
        TextButton.BackgroundColor3 = Color3.fromRGB(85, 255, 0)
        TextButton.TextColor3 = Color3.fromRGB(255, 0, 4)
    else
        TextButton.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
        TextButton.TextColor3 = Color3.fromRGB(85, 255, 0)
        AlreadyDes = false
        Range.Transparency = 1
    end
end)

-- Heartbeat function
game:GetService("RunService").Heartbeat:Connect(function()
    if OnUse then
        Range.Transparency = 0.7
        local playerPosition = player.Character.HumanoidRootPart.Position
        
        -- Iterate through NPCs once if OnUse is true
        for _, descendant in ipairs(workspace:GetDescendants()) do
            if descendant:IsA("Humanoid") and descendant.Parent:FindFirstChild("HumanoidRootPart") then
                local humanoidPosition = descendant.Parent.HumanoidRootPart.Position
                local distance = (playerPosition - humanoidPosition).magnitude
                if distance <= KillRadius and descendant.Parent.Name ~= player.Name then
                    descendant.Health = 0
                end
            end
        end
    end
end)
