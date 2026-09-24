--========================================================
-- CLST HUB
-- Made by CLST Corporation
-- Kavo UI Library
--========================================================

local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"
))()

--========================================================
-- SERVICES
--========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--========================================================
-- CUSTOM PREMIUM THEME
--========================================================

local colors = {
    SchemeColor = Color3.fromRGB(70, 105, 255),
    Background = Color3.fromRGB(14, 16, 24),
    Header = Color3.fromRGB(20, 23, 34),
    TextColor = Color3.fromRGB(235, 238, 255),
    ElementColor = Color3.fromRGB(25, 29, 43)
}

local Window = Library.CreateLib(
    "CLST Hub | Universal",
    colors
)

--========================================================
-- VARIABLES
--========================================================

local noclipEnabled = false
local infiniteJumpEnabled = false
local fullbrightEnabled = false
local noFogEnabled = false

local smoothTeleport = false
local teleportSpeed = 250

local savedPosition = nil
local customTeleportPosition = nil
local selectedPlayer = nil
local selectedLocation = nil

local originalCollisions = {}

local OriginalLighting = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd,
    FogStart = Lighting.FogStart,
    GlobalShadows = Lighting.GlobalShadows,
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient
}

--========================================================
-- FUNCTIONS
--========================================================

local function getCharacter()
    return Player.Character
end

local function getHumanoid()
    local character = getCharacter()
    if not character then
        return nil
    end
    return character:FindFirstChildOfClass("Humanoid")
end

local function getRoot()
    local character = getCharacter()
    if not character then
        return nil
    end
    return character:FindFirstChild("HumanoidRootPart")
end

local function teleportTo(targetCFrame)
    local root = getRoot()
    if not root then
        return
    end
    if smoothTeleport then
        local distance = (root.Position - targetCFrame.Position).Magnitude
        local duration = distance / teleportSpeed
        duration = math.clamp(
            duration,
            0.1,
            10
        )
        local tween = TweenService:Create(
            root,
            TweenInfo.new(
                duration,
                Enum.EasingStyle.Linear
            ),
            {
                CFrame = targetCFrame
            }
        )
        tween:Play()
    else
        root.CFrame = targetCFrame
    end
end

local function getPlayerNames()
    local names = {}
    for _, player in ipairs(Players:GetPlayers()) do

        if player ~= Player then
            table.insert(
                names,
                player.Name
            )
        end
    end
    table.sort(names)
    return names
end

--========================================================
-- TELEPORT LOCATIONS
--
-- Change these coordinates depending on your game.
--========================================================

local TeleportLocations = {
    ["Spawn"] = CFrame.new(
        0,
        5,
        0
    ),
    ["Location 1"] = CFrame.new(
        100,
        10,
        100
    ),
    ["Location 2"] = CFrame.new(
        -150,
        10,
        250
    ),
    ["Location 3"] = CFrame.new(
        300,
        20,
        -200
    )
}

local locationNames = {}

for name in pairs(TeleportLocations) do
    table.insert(
        locationNames,
        name
    )
end

table.sort(locationNames)

--========================================================
-- HOME TAB
--========================================================

local HomeTab = Window:NewTab("Home")

local HomeSection = HomeTab:NewSection(
    "CLST Hub"
)

HomeSection:NewLabel(
    "Universal Utility Hub"
)

HomeSection:NewLabel(
    "Made by CLST Corporation"
)

local StatusLabel = HomeSection:NewLabel(
    "Status: Ready"
)

local function setStatus(text)

    StatusLabel:UpdateLabel(
        "Status: " .. text
    )

end

HomeSection:NewButton(
    "Show Current Position",
    "Displays your XYZ position",
    function()
        local root = getRoot()
        if root then
            local position = root.Position
            setStatus(
                string.format(
                    "X: %.1f | Y: %.1f | Z: %.1f",
                    position.X,
                    position.Y,
                    position.Z
                )
            )
        end
    end
)

HomeSection:NewButton(
    "Reset Character",
    "Resets your character",
    function()
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.Health = 0
        end
    end
)

--========================================================
-- TELEPORT TAB
--========================================================

local TeleportTab = Window:NewTab(
    "Teleports"
)

--========================================================
-- PRESET TELEPORTS
--========================================================

local PresetSection = TeleportTab:NewSection(
    "Preset Locations"
)

PresetSection:NewDropdown(
    "Select Location",
    "Choose a teleport location",
    locationNames,
    function(option)
        selectedLocation = option
        setStatus(
            "Selected " .. option
        )
    end
)

PresetSection:NewButton(
    "Teleport",
    "Teleport to selected location",
    function()
        if selectedLocation
        and TeleportLocations[selectedLocation] then
            teleportTo(
                TeleportLocations[selectedLocation]
            )
            setStatus(
                "Teleported to " .. selectedLocation
            )
        else
            setStatus(
                "Select a location first"
            )
        end
    end
)

--========================================================
-- TELEPORT SETTINGS
--========================================================

local TPSettings = TeleportTab:NewSection(
    "Teleport Settings"
)

TPSettings:NewToggle(
    "Smooth Teleport",
    "Tween instead of instantly teleporting",
    function(state)
        smoothTeleport = state
    end
)

TPSettings:NewSlider(
    "Teleport Speed",
    "Smooth teleport speed",
    500,
    50,
    function(value)
        teleportSpeed = value
    end
)

--========================================================
-- SAVE POSITION
--========================================================

local PositionSection = TeleportTab:NewSection(
    "Saved Position"
)

PositionSection:NewButton(
    "Save Current Position",
    "Save your current location",
    function()
        local root = getRoot()
        if root then
            savedPosition = root.CFrame
            setStatus(
                "Position saved"
            )
        end
    end
)

PositionSection:NewButton(
    "Return to Saved Position",
    "Teleport back to your saved location",
    function()
        if savedPosition then
            teleportTo(
                savedPosition
            )
            setStatus(
                "Returned to saved position"
            )
        else
            setStatus(
                "No position saved"
            )
        end
    end
)

--========================================================
-- MOUSE TELEPORT
--========================================================

local MouseSection = TeleportTab:NewSection(
    "Quick Teleport"
)

MouseSection:NewKeybind(
    "Teleport to Mouse",
    "Press T while pointing somewhere",
    Enum.KeyCode.T,
    function()
        local mouse = Player:GetMouse()
        if mouse
        and mouse.Hit then
            teleportTo(
                mouse.Hit + Vector3.new(
                    0,
                    3,
                    0
                )
            )
        end
    end
)

--========================================================
-- PLAYER TELEPORTS
--========================================================

local PlayerTPSection = TeleportTab:NewSection(
    "Player Teleport"
)

local PlayerDropdown = PlayerTPSection:NewDropdown(
    "Select Player",
    "Choose another player",
    getPlayerNames(),
    function(option)

        selectedPlayer = option

    end
)

PlayerTPSection:NewButton(
    "Teleport to Player",
    "Teleport to selected player",
    function()
        if not selectedPlayer then
            setStatus(
                "Select a player first"
            )
            return
        end
        local targetPlayer =
            Players:FindFirstChild(
                selectedPlayer
            )
        if targetPlayer
        and targetPlayer.Character then
            local targetRoot =
                targetPlayer.Character:FindFirstChild(
                    "HumanoidRootPart"
                )
            if targetRoot then
                teleportTo(
                    targetRoot.CFrame
                    * CFrame.new(
                        0,
                        0,
                        3
                    )
                )
                setStatus(
                    "Teleported to "
                    .. selectedPlayer
                )
            end
        end
    end
)

PlayerTPSection:NewButton(
    "Refresh Player List",
    "Refresh the dropdown",
    function()
        PlayerDropdown:Refresh(
            getPlayerNames()
        )
        setStatus(
            "Player list refreshed"
        )

    end
)

--========================================================
-- MOVEMENT TAB
--========================================================

local MovementTab = Window:NewTab(
    "Movement"
)

local SpeedSection = MovementTab:NewSection(
    "Movement Settings"
)

SpeedSection:NewSlider(
    "Walk Speed",
    "Change movement speed",
    150,
    8,
    function(value)
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.WalkSpeed = value
        end
    end
)

SpeedSection:NewSlider(
    "Jump Power",
    "Change jumping power",
    200,
    25,
    function(value)
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.UseJumpPower = true
            humanoid.JumpPower = value
        end
    end
)

SpeedSection:NewButton(
    "Reset Movement",
    "Restore normal movement",
    function()
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.WalkSpeed = 16
            humanoid.UseJumpPower = true
            humanoid.JumpPower = 50
        end
    end
)

--========================================================
-- INFINITE JUMP
--========================================================

local ExtraMovement = MovementTab:NewSection(
    "Extra Movement"
)

ExtraMovement:NewToggle(
    "Infinite Jump",
    "Jump while in the air",
    function(state)
        infiniteJumpEnabled = state
    end
)

UserInputService.JumpRequest:Connect(
    function()
        if infiniteJumpEnabled then
            local humanoid = getHumanoid()
            if humanoid then
                humanoid:ChangeState(
                    Enum.HumanoidStateType.Jumping
                )
            end
        end
    end
)

--========================================================
-- NOCLIP
--========================================================

ExtraMovement:NewToggle(
    "Noclip",
    "Walk through objects",
    function(state)
        noclipEnabled = state
        if not state then
            for part, oldState in pairs(
                originalCollisions
            ) do
                if part
                and part.Parent then
                    part.CanCollide =
                        oldState
                end
            end
            table.clear(
                originalCollisions
            )
        end
    end
)

RunService.Stepped:Connect(
    function()
        if not noclipEnabled then
            return
        end
        local character = getCharacter()
        if not character then
            return
        end
        for _, object in ipairs(
            character:GetDescendants()
        ) do
            if object:IsA("BasePart") then
                if originalCollisions[object]
                == nil then
                    originalCollisions[object] =
                        object.CanCollide
                end
                object.CanCollide = false
            end
        end
    end
)

--========================================================
-- PLAYER TAB
--========================================================

local PlayerTab = Window:NewTab(
    "Player"
)

local PlayerSection = PlayerTab:NewSection(
    "Player Utilities"
)

--========================================================
-- CLST ANTI-AFK
--========================================================

local antiAFKLoaded = false

PlayerSection:NewButton(
    "Enable CLST Anti-AFK",
    "Loads the official CLST Anti-AFK",
    function()
        if antiAFKLoaded then
            setStatus("CLST Anti-AFK is already active")
            return
        end
        setStatus("Loading CLST Anti-AFK...")
        local success, result = pcall(function()
            loadstring(game:HttpGet(
                "https://raw.githubusercontent.com/ENxYN/CLST/refs/heads/main/CLST%20Anti-AFK.lua"
            ))()
        end)
        if success then
            antiAFKLoaded = true
            setStatus("CLST Anti-AFK enabled")
        else
            setStatus("Failed to load CLST Anti-AFK")
            warn("[CLST Hub] Anti-AFK Error:", result)
        end
    end
)

PlayerSection:NewToggle(
    "Sit",
    "Make your character sit",
    function(state)
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.Sit = state
        end
    end
)

--========================================================
-- SERVER UTILITIES
--========================================================

local ServerSection = PlayerTab:NewSection(
    "Server"
)

ServerSection:NewButton(
    "Rejoin Server",
    "Reconnect to the current server",
    function()
        if game.JobId ~= "" then
            TeleportService:TeleportToPlaceInstance(
                game.PlaceId,
                game.JobId,
                Player
            )
        else
            TeleportService:Teleport(
                game.PlaceId,
                Player
            )
        end
    end
)

ServerSection:NewButton(
    "Copy Job ID",
    "Copy current server JobId",
    function()
        if setclipboard then
            setclipboard(
                game.JobId
            )
            setStatus(
                "Job ID copied"
            )
        else
            setStatus(
                "Clipboard unavailable"
            )
        end
    end
)

ServerSection:NewButton(
    "Copy Place ID",
    "Copy current PlaceId",
    function()
        if setclipboard then
            setclipboard(
                tostring(
                    game.PlaceId
                )
            )
            setStatus(
                "Place ID copied"
            )
        end
    end
)

--========================================================
-- VISUALS TAB
--========================================================

local VisualTab = Window:NewTab(
    "Visuals"
)

local LightingSection = VisualTab:NewSection(
    "Lighting"
)

LightingSection:NewToggle(
    "Fullbright",
    "Brightens the map",
    function(state)
        fullbrightEnabled = state
        if state then
            Lighting.Brightness = 3
            Lighting.ClockTime = 14
            Lighting.GlobalShadows = false
            Lighting.Ambient =
                Color3.fromRGB(
                    180,
                    180,
                    180
                )
            Lighting.OutdoorAmbient =
                Color3.fromRGB(
                    180,
                    180,
                    180
                )
        else
            Lighting.Brightness =
                OriginalLighting.Brightness
            Lighting.ClockTime =
                OriginalLighting.ClockTime
            Lighting.GlobalShadows =
                OriginalLighting.GlobalShadows
            Lighting.Ambient =
                OriginalLighting.Ambient
            Lighting.OutdoorAmbient =
                OriginalLighting.OutdoorAmbient
        end
    end
)

LightingSection:NewToggle(
    "Remove Fog",
    "Increase visibility",
    function(state)
        noFogEnabled = state
        if state then
            Lighting.FogStart = 0
            Lighting.FogEnd = 100000
        else
            Lighting.FogStart =
                OriginalLighting.FogStart
            Lighting.FogEnd =
                OriginalLighting.FogEnd
        end
    end
)

--========================================================
-- CAMERA
--========================================================

local CameraSection = VisualTab:NewSection(
    "Camera"
)

CameraSection:NewSlider(
    "Field of View",
    "Change camera FOV",
    120,
    40,
    function(value)
        Camera.FieldOfView = value
    end
)

CameraSection:NewButton(
    "Reset FOV",
    "Restore normal camera FOV",
    function()
        Camera.FieldOfView = 70
    end
)

--========================================================
-- SETTINGS TAB
--========================================================

local SettingsTab = Window:NewTab(
    "Settings"
)

local UISection = SettingsTab:NewSection(
    "Interface"
)

UISection:NewKeybind(
    "Toggle UI",
    "Show or hide CLST Hub",
    Enum.KeyCode.RightShift,
    function()
        Library:ToggleUI()
    end
)

UISection:NewColorPicker(
    "Accent Color",
    "Change the UI accent",
    Color3.fromRGB(
        70,
        105,
        255
    ),
    function(color)
        Library:ChangeColor(
            "SchemeColor",
            color
        )
    end
)

UISection:NewColorPicker(
    "Background Color",
    "Change the background",
    Color3.fromRGB(
        14,
        16,
        24
    ),
    function(color)
        Library:ChangeColor(
            "Background",
            color
        )
    end
)

UISection:NewColorPicker(
    "Element Color",
    "Change button/element color",
    Color3.fromRGB(
        25,
        29,
        43
    ),
    function(color)
        Library:ChangeColor(
            "ElementColor",
            color
        )
    end
)

--========================================================
-- ABOUT
--========================================================

local AboutSection = SettingsTab:NewSection(
    "About"
)

AboutSection:NewLabel(
    "CLST CDID Hub"
)

AboutSection:NewLabel(
    "Made by CLST Corporation"
)

setStatus("CLST CDID Hub Loaded")
