task.wait(0.5)

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "CLSTAntiAFK"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = game.CoreGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Parent = gui
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.new(0.5, 0, 0.25, 0)
main.Size = UDim2.new(0, 420, 0, 180)
main.BackgroundColor3 = Color3.fromRGB(15, 18, 30)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(65, 105, 225)
mainStroke.Thickness = 1.5
mainStroke.Transparency = 0.25
mainStroke.Parent = main

local mainGradient = Instance.new("UIGradient")
mainGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 28, 48)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 12, 22))
})
mainGradient.Rotation = 90
mainGradient.Parent = main

local header = Instance.new("Frame")
header.Name = "Header"
header.Parent = main
header.Size = UDim2.new(1, 0, 0, 58)
header.BackgroundColor3 = Color3.fromRGB(35, 65, 150)
header.BorderSizePixel = 0

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 14)
headerCorner.Parent = header

local headerFix = Instance.new("Frame")
headerFix.Parent = header
headerFix.Position = UDim2.new(0, 0, 1, -14)
headerFix.Size = UDim2.new(1, 0, 0, 14)
headerFix.BackgroundColor3 = Color3.fromRGB(35, 65, 150)
headerFix.BorderSizePixel = 0

local headerGradient = Instance.new("UIGradient")
headerGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(72, 105, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(34, 59, 150))
})
headerGradient.Parent = header

local title = Instance.new("TextLabel")
title.Parent = header
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 20, 0, 6)
title.Size = UDim2.new(1, -40, 0, 28)
title.Font = Enum.Font.GothamBold
title.Text = "ULTIMATE ANTI-AFK"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 21
title.TextXAlignment = Enum.TextXAlignment.Left

local subtitle = Instance.new("TextLabel")
subtitle.Parent = header
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.new(0, 20, 0, 32)
subtitle.Size = UDim2.new(1, -40, 0, 18)
subtitle.Font = Enum.Font.Gotham
subtitle.Text = "CLST Protection System"
subtitle.TextColor3 = Color3.fromRGB(190, 205, 255)
subtitle.TextSize = 12
subtitle.TextXAlignment = Enum.TextXAlignment.Left

local statusFrame = Instance.new("Frame")
statusFrame.Parent = main
statusFrame.Position = UDim2.new(0, 18, 0, 75)
statusFrame.Size = UDim2.new(1, -36, 0, 55)
statusFrame.BackgroundColor3 = Color3.fromRGB(21, 26, 42)
statusFrame.BorderSizePixel = 0

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 10)
statusCorner.Parent = statusFrame

local statusStroke = Instance.new("UIStroke")
statusStroke.Color = Color3.fromRGB(60, 75, 110)
statusStroke.Transparency = 0.45
statusStroke.Thickness = 1
statusStroke.Parent = statusFrame

local indicator = Instance.new("Frame")
indicator.Parent = statusFrame
indicator.Position = UDim2.new(0, 16, 0.5, -5)
indicator.Size = UDim2.new(0, 10, 0, 10)
indicator.BackgroundColor3 = Color3.fromRGB(75, 255, 145)
indicator.BorderSizePixel = 0

local indicatorCorner = Instance.new("UICorner")
indicatorCorner.CornerRadius = UDim.new(1, 0)
indicatorCorner.Parent = indicator

local status = Instance.new("TextLabel")
status.Parent = statusFrame
status.BackgroundTransparency = 1
status.Position = UDim2.new(0, 38, 0, 0)
status.Size = UDim2.new(1, -50, 1, 0)
status.Font = Enum.Font.GothamMedium
status.Text = "Protection Active"
status.TextColor3 = Color3.fromRGB(220, 225, 240)
status.TextSize = 17
status.TextXAlignment = Enum.TextXAlignment.Left

local footer = Instance.new("TextLabel")
footer.Parent = main
footer.BackgroundTransparency = 1
footer.Position = UDim2.new(0, 18, 1, -37)
footer.Size = UDim2.new(1, -36, 0, 22)
footer.Font = Enum.Font.Gotham
footer.Text = "Made by CLST Corporation"
footer.TextColor3 = Color3.fromRGB(115, 125, 155)
footer.TextSize = 12
footer.TextXAlignment = Enum.TextXAlignment.Center

-- Anti-AFK Logic
player.Idled:Connect(function()
	status.Text = "AFK detected • Preventing disconnect..."
	status.TextColor3 = Color3.fromRGB(255, 215, 100)
	indicator.BackgroundColor3 = Color3.fromRGB(255, 190, 60)

	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new(0, 0))

	task.wait(2)

	status.Text = "Protection Active"
	status.TextColor3 = Color3.fromRGB(220, 225, 240)
	indicator.BackgroundColor3 = Color3.fromRGB(75, 255, 145)
end)