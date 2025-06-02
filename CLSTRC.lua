warn("Anti afk running")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    warn("Anti afk ran")
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Marco8642/science/main/ui%20libs2"))()
local example = library:CreateWindow({
    text = "EnzoHub Private"
})

example:AddToggle("Auto farm", function(state)
    getfenv().test = state and true or false
    local speed = 55
    local delay = 0.5
    local plr = game.Players.LocalPlayer
    while getfenv().test do
        task.wait()
        local chr = plr.Character
        if not chr or not chr:FindFirstChild("HumanoidRootPart") then
            task.wait(1)
            continue
        end
        local car = chr.Humanoid.SeatPart and chr.Humanoid.SeatPart.Parent
        if not car then
            task.wait(1)
            continue
        end
        if not workspace:FindFirstChild("justanormalpart") then
            local new = Instance.new("Part", workspace)
            new.Name = "justanormalpart"
            new.Anchored = true
            new.Size = Vector3.new(10000, 10, 10000)
            new.Position = chr.HumanoidRootPart.Position + Vector3.new(0, 5000, 0)
        end
        car.PrimaryPart = car.Body["#Weight"]
        car.PrimaryPart.Velocity = car.PrimaryPart.CFrame.LookVector * speed
        task.wait(delay)
        car:PivotTo(workspace.justanormalpart.CFrame + Vector3.new(0, 7, 0))
    end
end)
