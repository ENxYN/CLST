task.wait(0.5)

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")

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
main.Size = UDim2.new(0, 420, 0, 300)
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
footer.Position = UDim2.new(0, 18, 1, -28)
footer.Size = UDim2.new(1, -36, 0, 22)
footer.Font = Enum.Font.Gotham
footer.Text = "Made by CLST Corporation"
footer.TextColor3 = Color3.fromRGB(115, 125, 155)
footer.TextSize = 12
footer.TextXAlignment = Enum.TextXAlignment.Center


local unloaded = false
local idleConnection = nil

local autoMoveEnabled = false
local movementBindName = "CLST_AutoMove"
local jumpGeneration = 0

local autoMoveButton = Instance.new("TextButton")
autoMoveButton.Parent = main
autoMoveButton.Position = UDim2.new(0, 18, 0, 142)
autoMoveButton.Size = UDim2.new(1, -36, 0, 42)
autoMoveButton.BackgroundColor3 = Color3.fromRGB(26, 32, 52)
autoMoveButton.BorderSizePixel = 0
autoMoveButton.AutoButtonColor = false
autoMoveButton.Font = Enum.Font.GothamBold
autoMoveButton.Text = "AUTO MOVE + JUMP: OFF"
autoMoveButton.TextColor3 = Color3.fromRGB(185, 195, 220)
autoMoveButton.TextSize = 14

local autoMoveCorner = Instance.new("UICorner")
autoMoveCorner.CornerRadius = UDim.new(0, 10)
autoMoveCorner.Parent = autoMoveButton

local autoMoveStroke = Instance.new("UIStroke")
autoMoveStroke.Color = Color3.fromRGB(65, 105, 225)
autoMoveStroke.Transparency = 0.45
autoMoveStroke.Thickness = 1
autoMoveStroke.Parent = autoMoveButton

local function getHumanoidAndRoot()
    local character = player.Character
    if not character then
        return nil, nil
    end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")
    return humanoid, root
end

local function stopAutoMove()
    autoMoveEnabled = false
    jumpGeneration = jumpGeneration + 1
    pcall(function()
        RunService:UnbindFromRenderStep(movementBindName)
    end)
    local humanoid = select(1, getHumanoidAndRoot())
    if humanoid then
        humanoid:Move(Vector3.zero, false)
    end
end

local function startAutoMove()
    autoMoveEnabled = true
    jumpGeneration = jumpGeneration + 1
    local myGeneration = jumpGeneration
    pcall(function()
        RunService:UnbindFromRenderStep(movementBindName)
    end)
    RunService:BindToRenderStep(
        movementBindName,
        Enum.RenderPriority.Character.Value + 1,
        function()
            if not autoMoveEnabled then
                return
            end
            local humanoid, root = getHumanoidAndRoot()
            if humanoid and root and humanoid.Health > 0 then
                local forward = root.CFrame.LookVector
                local flatForward = Vector3.new(forward.X, 0, forward.Z)
                if flatForward.Magnitude > 0 then
                    humanoid:Move(flatForward.Unit, false)
                end
            end
        end
    )
    task.spawn(function()
        while autoMoveEnabled and myGeneration == jumpGeneration do
            local humanoid = select(1, getHumanoidAndRoot())
            if humanoid and humanoid.Health > 0 then
                humanoid.Jump = true
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
            task.wait(1.5)
        end
    end)
end

autoMoveButton.MouseButton1Click:Connect(function()
    if autoMoveEnabled then
        stopAutoMove()
        autoMoveButton.Text = "AUTO MOVE + JUMP: OFF"
        autoMoveButton.TextColor3 = Color3.fromRGB(185, 195, 220)
        autoMoveButton.BackgroundColor3 = Color3.fromRGB(26, 32, 52)
        autoMoveStroke.Color = Color3.fromRGB(65, 105, 225)
        status.Text = "Protection Active"
        status.TextColor3 = Color3.fromRGB(220, 225, 240)
        indicator.BackgroundColor3 = Color3.fromRGB(75, 255, 145)
    else
        startAutoMove()
        autoMoveButton.Text = "AUTO MOVE + JUMP: ON"
        autoMoveButton.TextColor3 = Color3.fromRGB(120, 255, 165)
        autoMoveButton.BackgroundColor3 = Color3.fromRGB(22, 55, 43)
        autoMoveStroke.Color = Color3.fromRGB(75, 255, 145)
        status.Text = "Protection Active • Auto movement ON"
        status.TextColor3 = Color3.fromRGB(180, 255, 205)
        indicator.BackgroundColor3 = Color3.fromRGB(75, 255, 145)
    end
end)


local unloadButton = Instance.new("TextButton")
unloadButton.Parent = main
unloadButton.Position = UDim2.new(0, 18, 0, 196)
unloadButton.Size = UDim2.new(1, -36, 0, 42)
unloadButton.BackgroundColor3 = Color3.fromRGB(65, 28, 35)
unloadButton.BorderSizePixel = 0
unloadButton.AutoButtonColor = false
unloadButton.Font = Enum.Font.GothamBold
unloadButton.Text = "UNLOAD ANTI-AFK"
unloadButton.TextColor3 = Color3.fromRGB(255, 170, 180)
unloadButton.TextSize = 14

local unloadCorner = Instance.new("UICorner")
unloadCorner.CornerRadius = UDim.new(0, 10)
unloadCorner.Parent = unloadButton

local unloadStroke = Instance.new("UIStroke")
unloadStroke.Color = Color3.fromRGB(220, 75, 95)
unloadStroke.Transparency = 0.35
unloadStroke.Thickness = 1
unloadStroke.Parent = unloadButton

unloadButton.MouseButton1Click:Connect(function()
	if unloaded then
		return
	end
	unloaded = true
	stopAutoMove()
	if idleConnection then
		idleConnection:Disconnect()
		idleConnection = nil
	end
	if gui then
		gui:Destroy()
	end
end)

-- Anti-AFK Logic
idleConnection = player.Idled:Connect(function()
	status.Text = "AFK detected • Preventing disconnect..."
	status.TextColor3 = Color3.fromRGB(255, 215, 100)
	indicator.BackgroundColor3 = Color3.fromRGB(255, 190, 60)
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new(0, 0))
	task.wait(2)
	if unloaded or not gui.Parent then
		return
	end
	if autoMoveEnabled then
		status.Text = "Protection Active • Auto movement ON"
		status.TextColor3 = Color3.fromRGB(180, 255, 205)
	else
		status.Text = "Protection Active"
		status.TextColor3 = Color3.fromRGB(220, 225, 240)
	end
	indicator.BackgroundColor3 = Color3.fromRGB(75, 255, 145)
end)
