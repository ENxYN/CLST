-- Init

repeat task.wait() until game:IsLoaded()

-- Start of Script
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("[CLST] Island of Vietnam", "Synapse")

-- HomeTab

local HomeTab = Window:NewTab("Home")

local HomeSecton = HomeTab:NewSection("Brand new Release!")

-- Player Tab

local PlayerTab = Window:NewTab("Player")

local PlayerSection = PlayerTab:NewSection("The Player Category")
PlayerSection:NewSlider("Walk-Speed", "Makes you Zoom in the Speed of Light", 500, 0, function(WS)
    game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = WS
end)
PlayerSection:NewSlider("Jump-Power", "Makes you Zoom in the Speed of Light", 500, 0, function(JP)
    game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = JP
end)
PlayerSection:NewSlider("FOV", "Makes you Zoom in the Speed of Light", 500, 0, function(FOV)
    game.Workspace.CurrentCamera.FieldOfView = FOV
end)

-- Visuals Tab

local VisualsTab = Window:NewTab("Visuals")

local VisualsSection = VisualsTab:NewSection("[ONGOING MAINTENANCE]")
VisualsSection:NewToggle("Enable", "", function(state)
end)
VisualsSection:NewToggle("Enable Tracers", "", function(state)
end)
VisualsSection:NewToggle("Enable Outlines", "", function(state)
end)

-- Teleport Tab

local TeleportTab = Window:NewTab("Teleport")

local TeleportSection = TeleportTab:NewSection("[Teleport Locations]")
TeleportSection:NewButton("Get Job Area", "Hit that Brother with a Spin MOVEEE!", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-87.6217117, 226.86203, 81.4634094, 0, 0, -1, 0, 1, 0, 1, 0, 0)
end)
local TeleportSection1 = TeleportTab:NewSection("Pickup Area")
TeleportSection1:NewButton("Boba", "Hit that Brother with a Spin MOVEEE!", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(55.5257607, 227.075455, 136.059631, -0.139203906, 0, 0.99026376, 0, 1, 0, -0.99026376, 0, -0.139203906)
end)
TeleportSection1:NewButton("Pho", "Hit that Brother with a Spin MOVEEE!", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-165.258209, 227.311447, -45.0438957, 0, 0, 1, 0, 1, -0, -1, 0, 0)
end)
local TeleportSection2 = TeleportTab:NewSection("Deliver Area")
TeleportSection2:NewButton("Rami Restaurant", "Hit that Brother with a Spin MOVEEE!", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-194.146683, 227.905106, 128.473251, 0, 0, 1, 0, 1, -0, -1, 0, 0)
end)
TeleportSection2:NewButton("Soccer Field", "Hit that Brother with a Spin MOVEEE!", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(207.529053, 228.116364, 300.336792, 0, 0, 1, 0, 1, -0, -1, 0, 0)
end)
TeleportSection2:NewButton("Beach Club", "Hit that Brother with a Spin MOVEEE!", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2.74926758, 202.130707, -388.868408, 0, 0, 1, 0, 1, -0, -1, 0, 0)
end)
TeleportSection2:NewButton("Gun Shop", "Hit that Brother with a Spin MOVEEE!", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-116.023804, 224.640625, 109.120186, -0.0871383399, 7.61787522e-09, 0.99619621, 1.74513019e-07, 1, 7.61787522e-09, -0.99619621, 1.74513019e-07, -0.0871383399)
end)
TeleportSection2:NewButton("Casino", "Hit that Brother with a Spin MOVEEE!", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-116.023804, 224.640625, 109.120186, -0.0871383399, 7.61787522e-09, 0.99619621, 1.74513019e-07, 1, 7.61787522e-09, -0.99619621, 1.74513019e-07, -0.0871383399)
end)
TeleportSection2:NewButton("Vonda", "Hit that Brother with a Spin MOVEEE!", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(260.432587, 225.878632, 59.8830032, 0, 0, 1, 0, 1, -0, -1, 0, 0)
end)

-- Essential Tab

local EssentialTab = Window:NewTab("Essentials")

local EssentialsSection = EssentialTab:NewSection("The Essentials Category")
EssentialsSection:NewButton("Aimbot", "Makes your game doodoo but with Improved Performance.", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/MyU5hzYQ"))()
end)
EssentialsSection:NewButton("Anti-Lag", "Makes your game doodoo but with Improved Performance.", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EnzoFPS/TukangScripts/main/LYNXAntiLag.lua"))()
end)
EssentialsSection:NewKeybind("Toggle UI", "Pogi Sige Na", Enum.KeyCode.Insert, function()
	Library:ToggleUI()
end)
