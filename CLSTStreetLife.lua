local player = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ActionRecorderGui"
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 600)  -- Réduit à 400x600 pixels
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -300)
mainFrame.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local dragging = false
local dragInput, mousePos, framePos

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        mainFrame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
    end
end)

local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(0, 100, 1, 0)
tabFrame.Position = UDim2.new(0, 0, 0, 0)
tabFrame.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
tabFrame.BorderSizePixel = 0
tabFrame.Parent = mainFrame

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -100, 1, 0)
contentFrame.Position = UDim2.new(0, 100, 0, 0)
contentFrame.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

local function createTabButton(name, position)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 50)
    button.Position = UDim2.new(0, 0, 0, position)
    button.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 24
    button.Text = name
    button.Parent = tabFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = button
    
    return button
end

local playerTabButton = createTabButton("Player", 0)
local recordTabButton = createTabButton("Record", 50)

local playerTab = Instance.new("Frame")
playerTab.Size = UDim2.new(1, 0, 1, 0)
playerTab.Position = UDim2.new(0, 0, 0, 0)
playerTab.BackgroundTransparency = 1
playerTab.Visible = true
playerTab.Parent = contentFrame

local recordTab = Instance.new("Frame")
recordTab.Size = UDim2.new(1, 0, 1, 0)
recordTab.Position = UDim2.new(0, 0, 0, 0)
recordTab.BackgroundTransparency = 1
recordTab.Visible = false
recordTab.Parent = contentFrame

local function switchTab(tab)
    playerTab.Visible = false
    recordTab.Visible = false
    tab.Visible = true
end

playerTabButton.MouseButton1Click:Connect(function() switchTab(playerTab) end)
recordTabButton.MouseButton1Click:Connect(function() switchTab(recordTab) end)

local function executeExternalScript()
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    print("Script exécuté")
end

local buttonFly = Instance.new("TextButton")
buttonFly.Size = UDim2.new(0, 200, 0, 50)
buttonFly.Position = UDim2.new(0.5, -100, 0.1, -25)
buttonFly.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
buttonFly.TextColor3 = Color3.fromRGB(255, 255, 255)
buttonFly.Font = Enum.Font.SourceSans
buttonFly.TextSize = 24
buttonFly.Text = "Execute Script"
buttonFly.Parent = playerTab

local buttonFlyCorner = Instance.new("UICorner")
buttonFlyCorner.CornerRadius = UDim.new(0, 12)
buttonFlyCorner.Parent = buttonFly

buttonFly.MouseButton1Click:Connect(executeExternalScript)

local function executeAFKScript()
    wait(0.5)
    local ba = Instance.new("ScreenGui")
    local ca = Instance.new("TextLabel")
    local da = Instance.new("Frame")
    local _b = Instance.new("TextLabel")
    local ab = Instance.new("TextLabel")
    ba.Parent = game.CoreGui
    ba.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ca.Parent = ba
    ca.Active = true
    ca.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
    ca.Draggable = true
    ca.Position = UDim2.new(0.698610067, 0, 0.098096624, 0)
    ca.Size = UDim2.new(0, 370, 0, 52)
    ca.Font = Enum.Font.SourceSansSemibold
    ca.Text = "Anti Afk"
    ca.TextColor3 = Color3.new(0, 1, 1)
    ca.TextSize = 22
    da.Parent = ca
    da.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
    da.Position = UDim2.new(0, 0, 1.0192306, 0)
    da.Size = UDim2.new(0, 370, 0, 107)
    _b.Parent = da
    _b.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
    _b.Position = UDim2.new(0, 0, 0.800455689, 0)
    _b.Size = UDim2.new(0, 370, 0, 21)
    _b.Font = Enum.Font.Arial
    _b.Text = "Made by Headshot#5868"
    _b.TextColor3 = Color3.new(0, 1, 1)
    _b.TextSize = 20
    ab.Parent = da
    ab.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
    ab.Position = UDim2.new(0, 0, 0.158377, 0)
    ab.Size = UDim2.new(0, 370, 0, 44)
    ab.Font = Enum.Font.ArialBold
    ab.Text = "Status: Active"
    ab.TextColor3 = Color3.new(0, 1, 1)
    ab.TextSize = 20
    
    local bb = game:service('VirtualUser')
    game:service('Players').LocalPlayer.Idled:connect(function()
        bb:CaptureController()
        bb:ClickButton2(Vector2.new())
        ab.Text = "Roblox kicked you but we didn't let them!"
        wait(2)
        ab.Text = "Status : Active"
    end)
end

local buttonAFK = Instance.new("TextButton")
buttonAFK.Size = UDim2.new(0, 200, 0, 50)
buttonAFK.Position = UDim2.new(0.5, -100, 0.25, -25)
buttonAFK.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
buttonAFK.TextColor3 = Color3.fromRGB(255, 255, 255)
buttonAFK.Font = Enum.Font.SourceSans
buttonAFK.TextSize = 24
buttonAFK.Text = "AFK SCRIPT"
buttonAFK.Parent = playerTab

local buttonAFKCorner = Instance.new("UICorner")
buttonAFKCorner.CornerRadius = UDim.new(0, 12)
buttonAFKCorner.Parent = buttonAFK

buttonAFK.MouseButton1Click:Connect(executeAFKScript)

-- Création des boutons pour l'onglet Record
local buttonStartRecording = Instance.new("TextButton")
buttonStartRecording.Size = UDim2.new(0, 200, 0, 50)
buttonStartRecording.Position = UDim2.new(0.5, -100, 0.3, -25)
buttonStartRecording.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
buttonStartRecording.TextColor3 = Color3.fromRGB(255, 255, 255)
buttonStartRecording.Font = Enum.Font.SourceSans
buttonStartRecording.TextSize = 24
buttonStartRecording.Text = "Start Recording"
buttonStartRecording.Parent = recordTab

local buttonStartRecordingCorner = Instance.new("UICorner")
buttonStartRecordingCorner.CornerRadius = UDim.new(0, 12)
buttonStartRecordingCorner.Parent = buttonStartRecording

local buttonStopRecording = Instance.new("TextButton")
buttonStopRecording.Size = UDim2.new(0, 200, 0, 50)
buttonStopRecording.Position = UDim2.new(0.5, -100, 0.45, -25)
buttonStopRecording.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
buttonStopRecording.TextColor3 = Color3.fromRGB(255, 255, 255)
buttonStopRecording.Font = Enum.Font.SourceSans
buttonStopRecording.TextSize = 24
buttonStopRecording.Text = "Stop Recording"
buttonStopRecording.Parent = recordTab

local buttonStopRecordingCorner = Instance.new("UICorner")
buttonStopRecordingCorner.CornerRadius = UDim.new(0, 12)
buttonStopRecordingCorner.Parent = buttonStopRecording

local buttonStartReplay = Instance.new("TextButton")
buttonStartReplay.Size = UDim2.new(0, 200, 0, 50)
buttonStartReplay.Position = UDim2.new(0.5, -100, 0.6, -25)
buttonStartReplay.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
buttonStartReplay.TextColor3 = Color3.fromRGB(255, 255, 255)
buttonStartReplay.Font = Enum.Font.SourceSans
buttonStartReplay.TextSize = 24
buttonStartReplay.Text = "Start Replay"
buttonStartReplay.Parent = recordTab

local buttonStartReplayCorner = Instance.new("UICorner")
buttonStartReplayCorner.CornerRadius = UDim.new(0, 12)
buttonStartReplayCorner.Parent = buttonStartReplay

local buttonStopReplay = Instance.new("TextButton")
buttonStopReplay.Size = UDim2.new(0, 200, 0, 50)
buttonStopReplay.Position = UDim2.new(0.5, -100, 0.75, -25)
buttonStopReplay.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
buttonStopReplay.TextColor3 = Color3.fromRGB(255, 255, 255)
buttonStopReplay.Font = Enum.Font.SourceSans
buttonStopReplay.TextSize = 24
buttonStopReplay.Text = "Stop Replay"
buttonStopReplay.Parent = recordTab

local buttonStopReplayCorner = Instance.new("UICorner")
buttonStopReplayCorner.CornerRadius = UDim.new(0, 12)
buttonStopReplayCorner.Parent = buttonStopReplay

local recording = false
local actions = {}
local replaying = false
local replayIndex = 1

local function recordAction(actionType, data)
    table.insert(actions, {actionType = actionType, data = data, time = tick()})
end

local function startRecording()
    recording = true
    actions = {}
    print("Enregistrement démarré")
end

local function stopRecording()
    recording = false
    print("Enregistrement arrêté")
end

local function stopReplay()
    replaying = false
end

local function replayActions()
    replaying = true
    local startTime = tick()
    while replaying do
        local currentTime = tick()
        local action = actions[replayIndex]
        if action then
            local delay = (action.time - startTime) / 4
            if currentTime - startTime >= delay then
                if action.actionType == "Move" and player.Character and player.Character.PrimaryPart then
                    player.Character:SetPrimaryPartCFrame(action.data)
                elseif action.actionType == "KeyPress" then
                    local VirtualInputManager = game:GetService("VirtualInputManager")
                    VirtualInputManager:SendKeyEvent(true, action.data.KeyCode, false, game)
                    wait(action.data.Duration)
                    VirtualInputManager:SendKeyEvent(false, action.data.KeyCode, false, game)
                end
                replayIndex = replayIndex + 1
                if replayIndex > #actions then
                    replayIndex = 1
                    startTime = tick()
                end
            end
        end
        RunService.Heartbeat:Wait()
    end
end

buttonStartRecording.MouseButton1Click:Connect(startRecording)
buttonStopRecording.MouseButton1Click:Connect(stopRecording)
buttonStartReplay.MouseButton1Click:Connect(function()
    if not replaying then
        replayActions()
    end
end)
buttonStopReplay.MouseButton1Click:Connect(stopReplay)

RunService.Stepped:Connect(function()
    if recording and player.Character and player.Character.PrimaryPart then
        recordAction("Move", player.Character.PrimaryPart.CFrame)
    end
end)

UserInputService.InputBegan:Connect(function(input)
    if recording and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.E then
        recordAction("KeyPress", {KeyCode = input.KeyCode, Duration = 4})
    end
end)

local rainbowText = Instance.new("TextLabel")
rainbowText.Size = UDim2.new(1, 0, 0, 40)
rainbowText.Position = UDim2.new(0, 0, 0, 0)
rainbowText.BackgroundTransparency = 1
rainbowText.TextColor3 = Color3.fromRGB(255, 0, 0)
rainbowText.Font = Enum.Font.SourceSansBold
rainbowText.TextSize = 24
rainbowText.Text = "AUTOFARM BY https://discord.gg/atbk7jvtdm"
rainbowText.TextStrokeTransparency = 0.5
rainbowText.TextXAlignment = Enum.TextXAlignment.Center
rainbowText.Parent = screenGui

local function animateRainbowText()
    local hue = tick() % 1
    local color = Color3.fromHSV(hue, 1, 1)
    rainbowText.TextColor3 = color
end

RunService.RenderStepped:Connect(animateRainbowText)
