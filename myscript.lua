local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Zloki Hub",
   LoadingTitle = "Zloki Hub Loading...",
   LoadingSubtitle = "By Zloki",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = Femmy, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },
   Discord = {
      Enabled = false,
      Invite = "EPfpgkg6", -- The Discord invite code, do not include discordgg
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },
   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Zloki Hub",
      Subtitle = "Zloki Hub Key System",
      Note = "Key is in the Discord!",
      FileName = "Key123", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key ="Zloki" -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})
local Tab = Window:CreateTab("Main", nil) -- Title, Image
local Section = Tab:CreateSection("Aimbot")
--Aimbot free here below
local predictmovementtoggle = true
local cannotifytoggle = true

local toggleaimlock = false
local AimlockToggle = Tab:CreateToggle({
    Name = "Aimlock",
    CurrentValue = false,
    Flag = "", 
    Callback = function(Value)
    toggleaimlock = Value
    Aimlock = toggleaimlock

getgenv().AimPart = "Head"
getgenv().AimRadius = 100
getgenv().FirstPerson = true 
getgenv().TeamCheck = false
getgenv().PredictMovement = predictmovementtoggle
getgenv().PredictionVelocity = 16 

local Players, Uis, RService, SGui = game:GetService"Players", game:GetService"UserInputService", game:GetService"RunService", game:GetService"StarterGui";
local Client, Mouse, Camera, CF, RNew, Vec3, Vec2 = Players.LocalPlayer, Players.LocalPlayer:GetMouse(), workspace.CurrentCamera, CFrame.new, Ray.new, Vector3.new, Vector2.new;
local Aimlock, MousePressed, CanNotify = true, false, false;
local AimlockTarget;
local aimlockrunservice
getgenv().CiazwareUniversalAimbotLoaded = true

getgenv().SeparateNotify = function(title, text, icon, time) 
    SGui:SetCore("SendNotification",{
        Title = title;
        Text = text;
        Duration = time;
    })
end

getgenv().Notify = function(title, text, icon, time)
    if CanNotify == true then 
        if not time or not type(time) == "number" then time = 3 end
        SGui:SetCore("SendNotification",{
            Title = title;
            Text = text;
            Duration = time;
        }) 
    end
end

getgenv().WorldToViewportPoint = function(P)
    return Camera:WorldToViewportPoint(P)
end

getgenv().WorldToScreenPoint = function(P)
    return Camera.WorldToScreenPoint(Camera, P)
end

getgenv().GetObscuringObjects = function(T)
    if T and T:FindFirstChild(getgenv().AimPart) and Client and Client.Character:FindFirstChild("Head") then 
        local RayPos = workspace:FindPartOnRay(RNew(
            T[getgenv().AimPart].Position, Client.Character.Head.Position)
        )
        if RayPos then return RayPos:IsDescendantOf(T) end
    end
end

getgenv().GetNearestTarget = function()
    -- Credits to whoever made this, i didnt make it, and my own mouse2plr function kinda sucks
    local players = {}
    local PLAYER_HOLD  = {}
    local DISTANCES = {}
    for i, v in pairs(Players:GetPlayers()) do
        if v ~= Client then
            table.insert(players, v)
        end
    end
    for i, v in pairs(players) do
        if v.Character then
            if v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("Humanoid") then
                if v.Character:FindFirstChild("Humanoid").Health > 0 then
                    local AIM = v.Character:FindFirstChild("Head")
                    if getgenv().TeamCheck == true and v.Team ~= Client.Team then
                        local DISTANCE = (v.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
                        local RAY = Ray.new(game.Workspace.CurrentCamera.CFrame.p, (Mouse.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * DISTANCE)
                        local HIT,POS = game.Workspace:FindPartOnRay(RAY, game.Workspace)
                        local DIFF = math.floor((POS - AIM.Position).magnitude)
                        PLAYER_HOLD[v.Name .. i] = {}
                        PLAYER_HOLD[v.Name .. i].dist= DISTANCE
                        PLAYER_HOLD[v.Name .. i].plr = v
                        PLAYER_HOLD[v.Name .. i].diff = DIFF
                        table.insert(DISTANCES, DIFF)
                    elseif getgenv().TeamCheck == false and v.Team == Client.Team then 
                        local DISTANCE = (v.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
                        local RAY = Ray.new(game.Workspace.CurrentCamera.CFrame.p, (Mouse.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * DISTANCE)
                        local HIT,POS = game.Workspace:FindPartOnRay(RAY, game.Workspace)
                        local DIFF = math.floor((POS - AIM.Position).magnitude)
                        PLAYER_HOLD[v.Name .. i] = {}
                        PLAYER_HOLD[v.Name .. i].dist= DISTANCE
                        PLAYER_HOLD[v.Name .. i].plr = v
                        PLAYER_HOLD[v.Name .. i].diff = DIFF
                        table.insert(DISTANCES, DIFF)
                    end
                end
            end
        end
    end
    
    if unpack(DISTANCES) == nil then
        return nil
    end
    
    local L_DISTANCE = math.floor(math.min(unpack(DISTANCES)))
    if L_DISTANCE > getgenv().AimRadius then
        return nil
    end
    
    for i, v in pairs(PLAYER_HOLD) do
        if v.diff == L_DISTANCE then
            return v.plr
        end
    end
    return nil
end

--[[getgenv().CheckTeamsChildren = function()
    if workspace and workspace:FindFirstChild"Teams" then 
        if getgenv().TeamCheck == true then
            if #workspace.Teams:GetChildren() == 0 then 
                getgenv().TeamCheck = false 
                SeparateNotify("Ciazware", "TeamCheck set to: "..tostring(getgenv().TeamCheck).." because there are no teams!", "", 3)
            end
        end
    end
end
CheckTeamsChildren()
]]--

--[[getgenv().GetNearestTarget = function()
    local T;
    for _, p in next, Players:GetPlayers() do 
        if p ~= Client then 
            if p.Character and p.Character:FindFirstChild(getgenv().AimPart) then 
                if getgenv().TeamCheck == true and p.Team ~= Client.Team then 
                    local Pos, ScreenCheck = WorldToScreenPoint(p.Character[getgenv().AimPart].Position)
                    Pos = Vec2(Pos.X, Pos.Y)
                    local MPos = Vec2(Mouse.X, Mouse.Y) -- Credits to CriShoux for this
                    local Distance = (Pos - MPos).Magnitude;
                    if Distance < getgenv().AimRadius then 
                        T = p 
                    end
                elseif getgenv().TeamCheck == false and p.Team == Client.Team then 
                    local Pos, ScreenCheck = WorldToScreenPoint(p.Character[getgenv().AimPart].Position)
                    Pos = Vec2(Pos.X, Pos.Y)
                    local MPos = Vec2(Mouse.X, Mouse.Y) -- Credits to CriShoux for this
                    local Distance = (Pos - MPos).Magnitude;
                    if Distance < getgenv().AimRadius then 
                        T = p 
                    end
                end
            end
        end
    end
    if T then 
        return T
    end
end]]--

local checkifmouse2button = Uis.InputBegan:Connect(function(Key)
    if not (Uis:GetFocusedTextBox()) then 
        if Key.UserInputType == Enum.UserInputType.MouseButton2 then 
            MousePressed = true 
            local Target;Target = GetNearestTarget()
            if Target ~= nil then 
                print(Target)
                AimlockTarget = Target
                if cannotifytoggle then
                    Notify("Zloki Hub", "Aimlock Target: "..tostring(AimlockTarget), "", 3)
                end
            end   
        end
    end
end)

local checkifmouse2button2 = Uis.InputEnded:Connect(function(Key)
    if Value and toggleaimlock then
        if not (Uis:GetFocusedTextBox()) then 
            if Key.UserInputType == Enum.UserInputType.MouseButton2 then 
                if AimlockTarget ~= nil then AimlockTarget = nil end
                if MousePressed ~= false then 
                    MousePressed = false 
                end
            end
        end
    else
        if checkifmouse2button then
            checkifmouse2button:Disconnect()
            checkifmouse2button = nil
        end
    end
end)

if Value then
    aimlockrunservice = RService.RenderStepped:Connect(function()
        getgenv().PredictMovement = predictmovementtoggle 
        if toggleaimlock and Value then
            if getgenv().FirstPerson == true then 
                if 0 == 0 then 
                    CanNotify = true 
                else 
                    CanNotify = false
                end
            end
            if Aimlock == true and MousePressed == true then 
                if AimlockTarget and AimlockTarget.Character and AimlockTarget.Character:FindFirstChild(getgenv().AimPart) then 
                    if getgenv().FirstPerson == true then
                        if CanNotify == true then
                            if getgenv().PredictMovement == true then 
                                if AimlockTarget then
                                    if AimlockTarget.Character then
                                        if AimlockTarget.Character:FindFirstChild(getgenv().AimPart) then
                                            Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position + AimlockTarget.Character[getgenv().AimPart].Velocity/PredictionVelocity)
                                        end
                                    end
                                end
                            elseif getgenv().PredictMovement == false then 
                                if AimlockTarget then
                                    if AimlockTarget.Character then
                                        if AimlockTarget.Character:FindFirstChild(getgenv().AimPart) then
                                            Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            if aimlockrunservice then
                aimlockrunservice:Disconnect()
            end
        end
    end)
else
    if not Value and not toggleaimlock then 
        if aimlockrunservice then
            aimlockrunservice:Disconnect()
        end
        if checkifmouse2button then
            checkifmouse2button:Disconnect()
            checkifmouse2button = nil
        end
        if checkifmouse2button2 then
            checkifmouse2button2:Disconnect()
            checkifmouse2button2 = nil
        end
    end
end

end,
})

local predictmovementtogglechanger = Tab:CreateToggle({
   Name = "Predict movement",
   CurrentValue = true,
   Flag = "", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(v)
        predictmovementtoggle = v
   end,
})

local cannotifytogglechanger = Tab:CreateToggle({
   Name = "Notify aimlock's target",
   CurrentValue = true,
   Flag = "",
   Callback = function(v)
    cannotifytoggle = v
   end,
})
--All esp's
-- Create section for Player ESP settings
local Section1 = Tab:CreateSection("Player ESP")

-- Initialize default values
local textSize = 14
local currentColor = Color3.fromRGB(255, 255, 255)
local isVisible = false -- Initially turned off
local showHealth = false
local rainbowText = false
local highlightPlayers = false
local highlightTransparency = 0.5

-- Create Toggle for showing player names
local Toggle = Tab:CreateToggle({
    Name = "Player ESP",
    CurrentValue = isVisible,  -- Default value (false = disabled initially)
    Flag = "Toggle1", -- Identifier for the configuration file
    Callback = function(Value)
        isVisible = Value
        -- Toggle visibility of player names based on the toggle state
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") then
                local billboard = player.Character.Head:FindFirstChild("UsernameBillboard")
                if billboard then
                    billboard.Enabled = Value
                    local textLabel = billboard:FindFirstChild("InfoLabel")
                    if textLabel then
                        textLabel.Visible = Value
                    end
                end
            end
        end
    end,
})

-- Create a new section for additional settings
local Section2 = Tab:CreateSection("Settings")

-- Create Toggle for showing player health
local HealthToggle = Tab:CreateToggle({
    Name = "Show Health",
    CurrentValue = showHealth,  -- Default value (false = disabled initially)
    Flag = "Toggle2", -- Identifier for the configuration file
    Callback = function(Value)
        showHealth = Value
        -- Update health display in all existing billboards
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") then
                local billboard = player.Character.Head:FindFirstChild("UsernameBillboard")
                if billboard then
                    local textLabel = billboard:FindFirstChild("InfoLabel")
                    if textLabel then
                        textLabel.Text = showHealth and ("Name: " .. player.Name .. " | Health: " .. math.floor(player.Character.Humanoid.Health)) or ("Name: " .. player.Name)
                    end
                end
            end
        end
    end,
})

-- Create Toggle for Highlight
local HighlightToggle = Tab:CreateToggle({
    Name = "Highlight",
    CurrentValue = highlightPlayers,  -- Default value (false = disabled initially)
    Flag = "Toggle4", -- Identifier for the configuration file
    Callback = function(Value)
        highlightPlayers = Value
        -- Apply or remove highlight effect based on the toggle state
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
                local character = player.Character
                local highlight = character:FindFirstChild("Highlight")

                if highlightPlayers then
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "Highlight"
                        highlight.Adornee = character
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.Parent = character
                    end
                    -- Set highlight color and transparency
                    highlight.OutlineColor = rainbowText and Color3.fromHSV(tick() % 360 / 360, 1, 1) or currentColor
                    highlight.FillColor = highlight.OutlineColor
                    highlight.FillTransparency = highlightTransparency
                else
                    if highlight then
                        highlight:Destroy()
                    end
                end
            end
        end
    end,
})

-- Create Toggle for rainbow text effect
local RainbowToggle = Tab:CreateToggle({
    Name = "Rainbow Text",
    CurrentValue = rainbowText,  -- Default value (false = disabled initially)
    Flag = "Toggle3", -- Identifier for the configuration file
    Callback = function(Value)
        rainbowText = Value
        -- Update the color of the highlight based on the rainbow effect
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
                local character = player.Character
                local highlight = character:FindFirstChild("Highlight")
                if highlight then
                    highlight.OutlineColor = rainbowText and Color3.fromHSV(tick() % 360 / 360, 1, 1) or currentColor
                    highlight.FillColor = highlight.OutlineColor
                end
            end
        end

        -- Update text color in all billboards
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") then
                local billboard = player.Character.Head:FindFirstChild("UsernameBillboard")
                if billboard then
                    local textLabel = billboard:FindFirstChild("InfoLabel")
                    if textLabel then
                        -- Start coroutine to update text color in a rainbow effect
                        if rainbowText then
                            coroutine.wrap(function()
                                while rainbowText do
                                    for i = 1, 360, 10 do
                                        local hue = i / 360
                                        textLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
                                        wait(0.1)
                                    end
                                end
                            end)()
                        else
                            textLabel.TextColor3 = currentColor
                        end
                    end
                end
            end
        end
    end,
})

-- Create Color Picker
local ColorPicker = Tab:CreateColorPicker({
    Name = "Text Color Picker",
    Color = currentColor, -- Default color (white)
    Flag = "ColorPicker1", -- Identifier for the configuration file
    Callback = function(Value)
        currentColor = Value
        -- Change the color of the text in all BillboardGui instances
        if not rainbowText then
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("Head") then
                    local billboard = player.Character.Head:FindFirstChild("UsernameBillboard")
                    if billboard then
                        local textLabel = billboard:FindFirstChild("InfoLabel")
                        if textLabel then
                            textLabel.TextColor3 = Value
                        end
                    end
                end
            end
        end

        -- Change the color of the highlight in all characters
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
                local character = player.Character
                local highlight = character:FindFirstChild("Highlight")
                if highlight then
                    highlight.OutlineColor = rainbowText and Color3.fromHSV(tick() % 360 / 360, 1, 1) or currentColor
                    highlight.FillColor = highlight.OutlineColor
                end
            end
        end
    end,
})

-- Create Slider for text size
local Slider = Tab:CreateSlider({
    Name = "Text Size",
    Range = {10, 20},
    Increment = 1,
    Suffix = "Size",
    CurrentValue = textSize,
    Flag = "Slider1", -- Identifier for the configuration file
    Callback = function(Value)
        textSize = Value
        -- Update text size in all existing billboards
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") then
                local billboard = player.Character.Head:FindFirstChild("UsernameBillboard")
                if billboard then
                    local textLabel = billboard:FindFirstChild("InfoLabel")
                    if textLabel then
                        textLabel.TextSize = textSize
                    end
                end
            end
        end
    end,
})

-- Create Slider for highlight fill transparency
local TransparencySlider = Tab:CreateSlider({
    Name = "Highlight Fill Transparency",
    Range = {0, 1},
    Increment = 0.05,
    Suffix = "Transparency",
    CurrentValue = highlightTransparency,
    Flag = "Slider2", -- Identifier for the configuration file
    Callback = function(Value)
        highlightTransparency = Value
        -- Update fill transparency in all existing highlights
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
                local character = player.Character
                local highlight = character:FindFirstChild("Highlight")
                if highlight then
                    highlight.FillTransparency = highlightTransparency
                end
            end
        end
    end,
})

-- Function to create the BillboardGui
local function createBillboard(player)
    -- Avoid creating a BillboardGui for the local player
    if player == game.Players.LocalPlayer then
        return
    end

    local character = player.Character
    if not character then return end

    local head = character:WaitForChild("Head")
    if not head then return end

    -- Check if BillboardGui already exists
    local existingBillboard = head:FindFirstChild("UsernameBillboard")
    if existingBillboard then
        existingBillboard:Destroy()
    end

    -- Create BillboardGui
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "UsernameBillboard"
    billboard.Adornee = head
    billboard.Size = UDim2.new(6, 0, 1, 0)  -- Adjust the size as needed for longer usernames
    billboard.StudsOffset = Vector3.new(0, 3, 0)  -- Offset from the head
    billboard.AlwaysOnTop = true
    billboard.Enabled = isVisible  -- Set initial visibility based on the toggle

    -- Create TextLabel for username and health
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "InfoLabel"
    textLabel.Parent = billboard
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = currentColor
    textLabel.TextStrokeTransparency = 0.5
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextSize = textSize
    textLabel.TextWrapped = false
    textLabel.TextTruncate = Enum.TextTruncate.None
    textLabel.Text = showHealth and ("Name: " .. player.Name .. " | Health: " .. math.floor(character.Humanoid.Health)) or ("Name: " .. player.Name)

    -- Parent the BillboardGui to the character's head
    billboard.Parent = head

    -- Update health label when health changes
    if showHealth then
        character.Humanoid.HealthChanged:Connect(function()
            if textLabel then
                textLabel.Text = "Name: " .. player.Name .. " | Health: " .. math.floor(character.Humanoid.Health)
            end
        end)
    end

    -- Apply highlight if enabled
    if highlightPlayers then
        local highlight = character:FindFirstChild("Highlight")
        if not highlight then
            highlight = Instance.new("Highlight")
            highlight.Name = "Highlight"
            highlight.Adornee = character
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = character
        end
        -- Set highlight color and transparency
        highlight.OutlineColor = rainbowText and Color3.fromHSV(tick() % 360 / 360, 1, 1) or currentColor
        highlight.FillColor = highlight.OutlineColor
        highlight.FillTransparency = highlightTransparency
    end
end

-- Function to handle player addition
local function onPlayerAdded(player)
    -- Wait for the character to load
    player.CharacterAdded:Connect(function(character)
        -- Create the BillboardGui when the character spawns
        createBillboard(player)
    end)
end

-- Loop through all existing players
for _, player in pairs(game.Players:GetPlayers()) do
    -- Create BillboardGui for each player
    createBillboard(player)
    -- Connect to CharacterAdded event in case the character respawns
    player.CharacterAdded:Connect(function()
        createBillboard(player)
    end)
end

-- Connect the PlayerAdded event
game.Players.PlayerAdded:Connect(onPlayerAdded)



local Section = Tab:CreateSection("Other ESP's")

local lplr = game.Players.LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local RunService = game:GetService("RunService")

local Tracers = {}
local TracerEnabled = false -- This will be controlled by the toggle

-- Function to create a tracer for a player
local function createTracer(player)
    local Tracer = Drawing.new("Line")
    Tracer.Visible = false
    Tracer.Color = Color3.new(1, 1, 1)
    Tracer.Thickness = 1
    Tracer.Transparency = 1
    Tracers[player.UserId] = Tracer
end

-- Function to update tracers
local function updateTracers()
    if not TracerEnabled then
        for _, tracer in pairs(Tracers) do
            tracer.Visible = false
        end
        return
    end

    for _, player in pairs(game.Players:GetPlayers()) do
        local tracer = Tracers[player.UserId]
        if not tracer then
            createTracer(player)
            tracer = Tracers[player.UserId]
        end

        if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("HumanoidRootPart") and player ~= lplr and player.Character.Humanoid.Health > 0 then
            local Vector, OnScreen = camera:worldToViewportPoint(player.Character.HumanoidRootPart.Position)

            if OnScreen then
                tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
                tracer.To = Vector2.new(Vector.X, Vector.Y)

                if _G.TeamCheck and player.TeamColor == lplr.TeamColor then
                    tracer.Visible = false
                else
                    tracer.Visible = true
                end
            else
                tracer.Visible = false
            end
        else
            tracer.Visible = false
        end
    end
end

-- Connection to update tracers every frame
RunService.RenderStepped:Connect(updateTracers)

-- Handle player added and removed
game.Players.PlayerAdded:Connect(function(player)
    createTracer(player)
end)

game.Players.PlayerRemoving:Connect(function(player)
    if Tracers[player.UserId] then
        Tracers[player.UserId]:Remove()
        Tracers[player.UserId] = nil
    end
end)

-- Initial tracer creation for existing players
for _, player in pairs(game.Players:GetPlayers()) do
    createTracer(player)
end

-- Toggle creation and callback
local Toggle = Tab:CreateToggle({
    Name = "Toggle Tracers",
    CurrentValue = false,
    Flag = "Toggle1", -- A flag is the identifier for the configuration file
    Callback = function(Value)
        TracerEnabled = Value
        -- Optionally update tracers immediately when toggle is changed
        updateTracers()
    end,
})












local toggleespsafe = false
local Toggle = Tab:CreateToggle({
    Name = "Safe ESP",
    CurrentValue = false,
    Flag = "", 
    Callback = function(Value)
        toggleespsafe = Value

        local function create(safe)
            pcall(function() 
                if safe:FindFirstChild("SafeESP") then 
                    if safe:FindFirstChild("Values") then
                        if safe:FindFirstChild("Values"):FindFirstChild("Broken") then
                            if safe:FindFirstChild("SafeESP"):FindFirstChild("name") then
                                if safe.Values.Broken.Value == true then
                                    safe:FindFirstChild("SafeESP"):FindFirstChild("name").TextColor3 = Color3.fromRGB(255,0,0)
                                    safe:FindFirstChild("SafeESP"):FindFirstChild("health").Visible = false 
                                else
                                    safe:FindFirstChild("SafeESP"):FindFirstChild("health").Text = "Health: "..safe:FindFirstChild("Values"):FindFirstChild("Health").Value
                                    safe:FindFirstChild("SafeESP"):FindFirstChild("health").Visible = true
                                    safe:FindFirstChild("SafeESP"):FindFirstChild("name").TextColor3 = Color3.fromRGB(0,255,0) 
                                end
                            end
                        end
                    end
                else
                    local x = Instance.new('BillboardGui',safe)
                    x.Name = "SafeESP"
                    x.AlwaysOnTop = true
                    x.Size = UDim2.new(1.2,0,1.2,0)

                    local name = Instance.new('TextLabel',x)
                    name.Size = UDim2.new(1,0,0.3,0) 
                    name.Name = "name"
                    name.Font = Enum.Font.SourceSans
                    name.FontSize = Enum.FontSize.Size18 
                    name.TextStrokeTransparency = 0
                    name.TextStrokeColor3 = Color3.fromRGB(0,0,0)
                    name.BackgroundTransparency = 1

                    local health = Instance.new('TextLabel',x)
                    health.Size = UDim2.new(1,0,0.3,0) 
                    health.Name = "health"
                    health.Font = Enum.Font.SourceSans
                    health.FontSize = Enum.FontSize.Size18 
                    health.TextStrokeTransparency = 0
                    health.TextStrokeColor3 = Color3.fromRGB(0,0,0)
                    health.Position = UDim2.new()
                    health.BackgroundTransparency = 1
                    health.TextColor3 = Color3.fromRGB(0,255,0) 
                    health.Position = UDim2.new(0, 0, 0, 17)
                    health.Text = "Health: "

                    if safe:FindFirstChild("Values") then
                        if safe:FindFirstChild("Values"):FindFirstChild("Broken") then
                            if safe.Values.Broken.Value == true then
                                name.TextColor3 = Color3.fromRGB(255,0,0)  
                            else
                                name.TextColor3 = Color3.fromRGB(0,255,0) 
                            end
                        end
                    end

                    if safe.Name:lower():find("smallsafe") then
                        name.Text = "Small Safe"
                    elseif safe.Name:lower():find("mediumsafe") then
                        name.Text = "Medium Safe"
                    elseif safe.Name:lower():find("register") then
                        name.Text = "Register"
                    elseif safe.Name:lower():find("cash") then
                        name.Text = "Register"
                    end
                end
            end)
        end

        if Value then
            while toggleespsafe do
            wait(1)
                if toggleespsafe then
                    for _, v in pairs(game:GetService("Workspace").Map.BredMakurz:GetChildren()) do
                        if v then
                            create(v)
                        end
                    end
                end
            end
        else
            if not Value and not toggleespsafe then 
                for _, v in pairs(game:GetService("Workspace").Map.BredMakurz:GetChildren()) do
                    if v:FindFirstChild("SafeESP") then
                        v.SafeESP:Destroy()
                    end
                end
            end
        end
end,
})
local toggleesptool = false
local Toggle = Tab:CreateToggle({
    Name = "Tool ESP",
    CurrentValue = false,
    Flag = "", 
    Callback = function(Value)
        toggleesptool = Value

        local function gettools(char)
            for _, tool in pairs(char:GetChildren()) do
                if tool:IsA("Tool") then
                    return tostring(tool.Name)
                end
            end
            return ""
        end

        if Value then
            while toggleesptool do
                wait(0)
                if toggleesptool then
                    for _, player in next, game:GetService("Players"):GetPlayers() do
                        if player ~= game:GetService("Players").LocalPlayer then 
                            if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("Head") then
                                if not player.Character.Head:FindFirstChild("ToolsESP") then
                                    local bill = Instance.new('BillboardGui', player.Character.Head)
                                    bill.Name = "ToolsESP"
                                    bill.AlwaysOnTop = true
                                    bill.Size = UDim2.new(1.2,0,1.2,0)

                                    local text = Instance.new('TextLabel', bill)
                                    text.Size = UDim2.new(1,0,0.3,0) 
                                    text.Font = Enum.Font.SourceSans
                                    text.FontSize = Enum.FontSize.Size18 
                                    text.TextStrokeTransparency = 0
                                    text.TextStrokeColor3 = Color3.new(0,0,0)
                                    text.BackgroundTransparency = 1
                                    text.Text = gettools(player.Character)
                                    text.TextColor3 = Color3.new(1, 0.6470588235294118, 0)
                                else
                                    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("Head") then
                                        if player.Character:FindFirstChild("Head"):FindFirstChild("ToolsESP") then
                                            player.Character:FindFirstChild("Head"):FindFirstChild("ToolsESP").TextLabel.Text = gettools(player.Character)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            if not Value and not toggleesptool then
                for _, player in next, game:GetService("Players"):GetPlayers() do
                    if player ~= game:GetService("Players").LocalPlayer then 
                        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("Head") then
                            if player.Character.Head:FindFirstChild("ToolsESP") then
                                player.Character.Head.ToolsESP:Destroy()
                            end
                        end
                    end
                end
            end
        end
end,
})
local toggle1 = false
local Toggle = Tab:CreateToggle({
   Name = "Crate ESP",
   CurrentValue = false,
   Flag = "",
   Callback = function(yee)
        toggle1 = yee
        if yee then 
            while toggle1 do
                wait(1)
                if toggle1 then
                    local goldencrateparticlecolor = {
                        ColorSequenceKeypoint.new(0, Color3.new(1, 0.666667, 0)),
                        ColorSequenceKeypoint.new(0, Color3.new(1, 0.666667, 0))
                    }
                    for _, v in pairs(game.Workspace.Filter.SpawnedPiles:GetChildren()) do 
                        if v.Name == "C1" then 
                            if v:FindFirstChild("MeshPart") then 
                                if v.MeshPart.TextureID == "rbxassetid://11157915894" then 
                                    if not v:FindFirstChild("ESP") then 
                                        local highlight = Instance.new("Highlight") 
                                        highlight.Name = "ESP"
                                        highlight.FillColor = Color3.fromRGB(255,0,0) 
                                        highlight.OutlineColor = Color3.fromRGB(255,0,0) 
                                        highlight.Parent = v
                                    end
                                elseif v.MeshPart.TextureID == "rbxassetid://11157911882" then 
                                    if not v:FindFirstChild("ESP") then 
                                        local highlight = Instance.new("Highlight")
                                        highlight.Name = "ESP"
                                        highlight.FillColor = Color3.fromRGB(0,255,0) 
                                        highlight.OutlineColor = Color3.fromRGB(0,255,0) 
                                        highlight.Parent = v
                                    end
                                elseif tostring(v.MeshPart.Particle.Color) == "0 1 0.666667 0 0 1 1 0.666667 0 0 " then 
                                    if not v:FindFirstChild("ESP") then 
                                        local highlight = Instance.new("Highlight")
                                        highlight.Name = "ESP"
                                        highlight.FillColor = Color3.fromRGB(255,255,0) 
                                        highlight.OutlineColor = Color3.fromRGB(255,255,0) 
                                        highlight.Parent = v
                                    end
                                end
                            end
                        end
                    end
                    for _, airdrop in pairs(workspace.Debris.VParts:GetChildren()) do
                        if airdrop then
                            if airdrop.Name == "SupplyCrate" then 
                                if airdrop then 
                                    if not airdrop:FindFirstChild("ESP") then 
                                        local highlight = Instance.new("Highlight")
                                        highlight.Name = "ESP"
                                        highlight.FillColor = Color3.fromRGB(255,255,0) 
                                        highlight.OutlineColor = Color3.fromRGB(255,255,0) 
                                        highlight.Parent = airdrop
                                    end
                                end
                            end
                        end
                    end
                    for _, mysterybox in pairs(workspace.Map.MysteryBoxes:GetChildren()) do
                        if mysterybox then
                            if mysterybox.Name == "MysteryBox" then 
                                if mysterybox then 
                                    if not mysterybox:FindFirstChild("ESP") then 
                                        local highlight = Instance.new("Highlight")
                                        highlight.Name = "ESP"
                                        highlight.FillColor = Color3.fromRGB(0,255,255) 
                                        highlight.OutlineColor = Color3.fromRGB(0,255,255) 
                                        highlight.Parent = mysterybox
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            if not toggle1 and not yee then
                for _, crate in pairs(game.Workspace.Filter.SpawnedPiles:GetChildren()) do
                    if crate.Name == "C1" then 
                        if crate:FindFirstChild("ESP") then
                            crate.ESP:Destroy()
                        end
                    end
                end
                for _, airdrop in pairs(workspace.Debris.VParts:GetChildren()) do
                    if airdrop then
                        if airdrop.Name == "SupplyCrate" then 
                            if airdrop then 
                                if airdrop:FindFirstChild("ESP") then
                                    airdrop.ESP:Destroy()
                                end 
                            end
                        end
                    end
                end
                for _, mysterybox in pairs(workspace.Map.MysteryBoxes:GetChildren()) do
                    if mysterybox then
                        if mysterybox.Name == "MysteryBox" then 
                            if mysterybox then
                                if mysterybox:FindFirstChild("ESP") then
                                    mysterybox.ESP:Destroy()
                                end 
                            end
                        end
                    end
                end
            end
        end
    end,
})
local toggleespdealer = false
local Toggle = Tab:CreateToggle({
    Name = "Dealer ESP",
    CurrentValue = false,
    Flag = "", 
    Callback = function(Value)
        toggleespdealer = Value

        local function create(dealer)
            if toggleespdealer and Value and not dealer:FindFirstChild("DealerESP") then
                local highlight = Instance.new('Highlight')
                highlight.Parent = dealer
                highlight.FillColor = Color3.new(1, 1, 1) 
                highlight.Name = "DealerESP"

                if dealer.Name == "ArmoryDealer" then
                    highlight.FillColor = Color3.fromRGB(153, 204, 255) 
                    highlight.OutlineColor = Color3.fromRGB(153, 204, 255) 
                elseif dealer.Name == "Dealer" then
                    highlight.FillColor = Color3.fromRGB(153, 255, 153) 
                    highlight.OutlineColor = Color3.fromRGB(153, 255, 153) 
                end
            end
        end

        if Value then
            while toggleespdealer do
            wait(0.01)
                if Value then
                    for _, d in pairs(workspace.Map.Shopz:GetChildren()) do
                        if d.Name == "Dealer" or d.Name == "ArmoryDealer" then 
                            create(d)
                        end
                    end
                end
            end
        else
            for _, d in pairs(workspace.Map.Shopz:GetChildren()) do
                if d.Name == "Dealer" or d.Name == "ArmoryDealer" then 
                    if d:FindFirstChild("DealerESP") then
                        d:FindFirstChild("DealerESP"):Destroy()
                    end
                end
            end
        end
end,
})
local toggleespscrap = false
local Toggle = Tab:CreateToggle({
   Name = "Scrap ESP",
   CurrentValue = false,
   Flag = "",
   Callback = function(yee)
        toggleespscrap = yee
        if yee then 
            while toggleespscrap do
                wait(1)
                if toggleespscrap then
                    for i, v in pairs(game.Workspace.Filter.SpawnedPiles:GetChildren()) do 
                        if v.Name == "S1" or v.Name == "S2" then 
                            if v:FindFirstChild("MeshPart") then 
                                if not v:FindFirstChild("ESP") then 
                                    local highlight = Instance.new("Highlight") 
                                    highlight.Name = "ESP"
                                    highlight.FillColor = Color3.fromRGB(150,150,150) 
                                    highlight.OutlineColor = Color3.fromRGB(150,150,150) 
                                    highlight.Parent = v
                                end
                            end
                        end
                    end
                end
            end
        else
            if not toggleespscrap and not yee then
                for _, crate in pairs(game.Workspace.Filter.SpawnedPiles:GetChildren()) do
                    if crate.Name == "S1" or crate.Name == "S2" then 
                        if crate:FindFirstChild("ESP") then
                            crate.ESP:Destroy()
                        end
                    end
                end
            end
        end
    end,
})
local Button = Tab:CreateButton({
   Name = "Player detection (Stays until leave)",
   Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/arVatYFs",true))()
   end,
})
--All esp's end here
local Tab = Window:CreateTab("Misc", nil) -- Title, Image
local Section = Tab:CreateSection("Strafe")
-- Variables
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local strafeRadius = 4 -- Default radius of strafing around the target player
local strafeSpeed = 5 -- Default speed of strafing around the target player
local isActive = false -- Control the state of the toggle
local targetPlayer = nil -- The player currently being followed
local connection -- Store the RenderStepped connection

-- Function to find the nearest player
local function findNearestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge -- Start with an infinitely large distance

    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - otherPlayer.Character.HumanoidRootPart.Position).magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestPlayer = otherPlayer
            end
        end
    end

    return closestPlayer
end

-- Function to strafe around the target player
local function strafeAroundPlayer()
    if connection then
        connection:Disconnect() -- Disconnect any previous connections
    end

    local angle = 0
    connection = RunService.RenderStepped:Connect(function(deltaTime)
        if isActive and targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetHumanoidRootPart = targetPlayer.Character.HumanoidRootPart
            local centerPosition = targetHumanoidRootPart.Position

            -- Update angle for strafing movement
            angle = angle + (strafeSpeed * deltaTime)
            local xOffset = strafeRadius * math.cos(angle)
            local zOffset = strafeRadius * math.sin(angle)

            -- Position the character to strafe around the target player
            player.Character.HumanoidRootPart.CFrame = CFrame.new(centerPosition + Vector3.new(xOffset, 0, zOffset), centerPosition)

            -- Disable player movement
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.PlatformStand = true
            end

            -- Check target player's health
            local targetHumanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
            if targetHumanoid and targetHumanoid.Health < 15 then
                isActive = false -- Stop following if the player is below 15 health
                targetPlayer = nil
                print("Target player's health is below 15. Stopping.")
            end
        else
            -- Re-enable movement when toggle is off or no valid target
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
            end
            if connection then
                connection:Disconnect() -- Stop strafing when toggle is off
                connection = nil
            end
        end
    end)
end

-- Create Toggle for Strafing Around Nearest Player
local Toggle = Tab:CreateToggle({
    Name = "Strafe Around Nearest Player",
    CurrentValue = false,
    Flag = "Toggle1", -- Unique flag for configuration saving
    Callback = function(Value)
        isActive = Value
        print("Strafing around nearest player:", isActive)
        if isActive then
            targetPlayer = findNearestPlayer() -- Set the target player
            if targetPlayer then
                strafeAroundPlayer()
            else
                isActive = false
                print("No valid target player found.")
            end
        else
            if connection then
                connection:Disconnect() -- Stop strafing when toggle is off
                connection = nil
            end
        end
    end,
})

-- Create Slider for Strafe Radius
local RadiusSlider = Tab:CreateSlider({
    Name = "Strafe Radius",
    Range = {1, 10},
    Increment = 1,
    Suffix = "Units",
    CurrentValue = strafeRadius,
    Flag = "RadiusSlider", -- Unique flag for configuration saving
    Callback = function(Value)
        strafeRadius = Value
        print("Strafe radius set to:", strafeRadius)
    end,
})

-- Create Slider for Strafe Speed
local SpeedSlider = Tab:CreateSlider({
    Name = "Strafe Speed",
    Range = {1, 10},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = strafeSpeed,
    Flag = "SpeedSlider", -- Unique flag for configuration saving
    Callback = function(Value)
        strafeSpeed = Value
        print("Strafe speed set to:", strafeSpeed)
    end,
})

-- Handle respawns
player.CharacterAdded:Connect(function(character)
    -- Wait for the character to load properly
    character:WaitForChild("HumanoidRootPart")
    if isActive then
        targetPlayer = findNearestPlayer() -- Reassign the target player on respawn
        if targetPlayer then
            strafeAroundPlayer()
        end
    end
end)

print("Strafe script with toggle and sliders loaded")

--strafe end here
local Section = Tab:CreateSection("FollowPlayer")
-- Slider for follow distance
local followDistance = 3 -- Default value
local FollowDistanceSlider = Tab:CreateSlider({
    Name = "Follow Distance",
    Range = {1, 5},  -- Set the range from 1 to 5
    Increment = 0.1,  -- Set the increment to 0.1
    Suffix = "Units",  -- Optional: Adds a suffix to the slider value
    CurrentValue = followDistance,  -- Default value of the slider
    Flag = "Slider1",  -- Unique identifier for the configuration file
    Callback = function(Value)
        followDistance = Value
    end,
})

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local isFollowing = false
local updateInterval = 0.001
local followPlayer = nil

-- Function to handle respawning
local function onCharacterAdded(newCharacter)
    character = newCharacter
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
end

player.CharacterAdded:Connect(onCharacterAdded)

-- Function to position the player behind the nearest player
local function positionBehindNearestPlayer()
    local nearestPlayer = nil
    local nearestDistance = math.huge

    -- Find the nearest player
    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local otherHRP = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            local humanoid = otherPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health >= 15 then
                local distance = (humanoidRootPart.Position - otherHRP.Position).magnitude
                if distance < nearestDistance then
                    nearestDistance = distance
                    nearestPlayer = otherPlayer
                end
            end
        end
    end

    if nearestPlayer then
        followPlayer = nearestPlayer
        local otherHRP = nearestPlayer.Character:FindFirstChild("HumanoidRootPart")
        local behindPosition = otherHRP.Position - otherHRP.CFrame.LookVector * followDistance
        humanoidRootPart.CFrame = CFrame.new(behindPosition, otherHRP.Position)
    end
end

-- Function to position the player on top of the nearest player's head
local function positionOnTopOfPlayerHead()
    if followPlayer and followPlayer.Character and followPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local otherHRP = followPlayer.Character:FindFirstChild("HumanoidRootPart")
        local head = followPlayer.Character:FindFirstChild("Head")
        if head then
            humanoidRootPart.CFrame = CFrame.new(head.Position + Vector3.new(0, 3, 0), otherHRP.Position)
        end
    end
end

-- Toggle to enable/disable the feature
local Toggle = Tab:CreateToggle({
    Name = "Enable Follow from Behind",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        if Value then
            isFollowing = true
            while isFollowing do
                if followPlayer and followPlayer.Character and followPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    local humanoid = followPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid and humanoid.Health < 15 then
                        -- Stop following and position on top of the player's head
                        isFollowing = false
                        positionOnTopOfPlayerHead()
                    else
                        -- Continue following
                        positionBehindNearestPlayer()
                    end
                else
                    -- No valid followPlayer, find the nearest player
                    positionBehindNearestPlayer()
                end
                wait(updateInterval)
            end
        else
            isFollowing = false
        end
    end
})

-- Function to keep the player behind the nearest player while the feature is enabled
game:GetService("RunService").RenderStepped:Connect(function()
    if isFollowing and followPlayer then
        if followPlayer.Character and followPlayer.Character:FindFirstChildOfClass("Humanoid") then
            local humanoid = followPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health < 15 then
                -- Stop following and position on top of the player's head
                isFollowing = false
                positionOnTopOfPlayerHead()
            else
                -- Continue following
                positionBehindNearestPlayer()
            end
        end
    end
end)
local Section = Tab:CreateSection("Bang")

-- Set default follow distance and range
local followDistance = 3
local minDistance = 1.3
local maxDistance = 4

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local isFollowing = false
local followPlayer = nil
local distanceFlowing = false
local flowDirection = 1
local speed = 0.1 -- Default speed

-- Create and configure the Sound objects
local sound1 = Instance.new("Sound")
sound1.SoundId = "rbxassetid://6892830182"
sound1.Volume = 1
sound1.Parent = character

local sound2 = Instance.new("Sound")
sound2.SoundId = "rbxassetid://9125702141"
sound2.Volume = 1
sound2.Parent = character

-- Function to handle respawning
local function onCharacterAdded(newCharacter)
    character = newCharacter
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    sound1.Parent = character
    sound2.Parent = character
end

player.CharacterAdded:Connect(onCharacterAdded)

-- Function to position the player behind the followPlayer
local function positionBehindFollowPlayer()
    if followPlayer and followPlayer.Character and followPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local otherHRP = followPlayer.Character:FindFirstChild("HumanoidRootPart")
        local behindPosition = otherHRP.Position - otherHRP.CFrame.LookVector * followDistance
        humanoidRootPart.CFrame = CFrame.new(behindPosition, otherHRP.Position)
    end
end

-- Function to position the player on top of the followPlayer's head
local function positionOnTopOfPlayerHead()
    if followPlayer and followPlayer.Character and followPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local otherHRP = followPlayer.Character:FindFirstChild("HumanoidRootPart")
        local head = followPlayer.Character:FindFirstChild("Head")
        if head then
            humanoidRootPart.CFrame = CFrame.new(head.Position + Vector3.new(0, 3, 0), otherHRP.Position)
        end
    end
end

-- Toggle to enable/disable the feature
local Toggle = Tab:CreateToggle({
    Name = "Bang",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        if Value then
            isFollowing = true
            distanceFlowing = true
            -- Find and set the followPlayer
            local nearestPlayer = nil
            local nearestDistance = math.huge
            for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
                if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local otherHRP = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local humanoid = otherPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid and humanoid.Health >= 15 then
                        local distance = (humanoidRootPart.Position - otherHRP.Position).magnitude
                        if distance < nearestDistance then
                            nearestDistance = distance
                            nearestPlayer = otherPlayer
                        end
                    end
                end
            end
            followPlayer = nearestPlayer
            
            -- Coroutine for flowing distance
            coroutine.wrap(function()
                while distanceFlowing do
                    if isFollowing then
                        followDistance = followDistance + (speed * flowDirection) -- Adjust increment based on speed
                        if followDistance >= maxDistance then
                            followDistance = maxDistance
                            flowDirection = -1
                        elseif followDistance <= minDistance then
                            followDistance = minDistance
                            flowDirection = 1
                            sound2:Play() -- Play sound when the distance reaches 1.3 units
                            sound1:Play()
                        end
                    end
                    wait(0.001) -- Decrease the wait time for smoother and faster transitions
                end
            end)()
        else
            isFollowing = false
            distanceFlowing = false
        end
    end
})

-- Slider to control the speed of the flowing distance
local Slider = Tab:CreateSlider({
    Name = "Bang Speed",
    Range = {0.1, 1}, -- Set a reasonable range for speed
    Increment = 0.1, -- Set the increment to 0.1 for precise control
    Suffix = "Speed", -- Optional: Adds a suffix to the slider value
    CurrentValue = speed, -- Default value of the slider
    Flag = "Slider1", -- Unique identifier for the configuration file
    Callback = function(Value)
        speed = Value -- Adjust speed multiplier as needed
    end,
})

-- Update the player’s position based on the toggle state
game:GetService("RunService").RenderStepped:Connect(function()
    if isFollowing then
        if followPlayer and followPlayer.Character and followPlayer.Character:FindFirstChildOfClass("Humanoid") then
            local humanoid = followPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health < 15 then
                -- Stop following and position on top of the player's head
                isFollowing = false
                positionOnTopOfPlayerHead()
            else
                -- Continue following
                positionBehindFollowPlayer()
            end
        else
            -- No valid followPlayer, stop following
            isFollowing = false
        end
    end
end)

local Section = Tab:CreateSection("Spin")
-- Variables for spinning
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Initialize spin speed and status
local spinSpeed = 30 -- Default spin speed
local spinning = false -- Control spinning status

-- Function to initialize spinning logic
local function initializeSpinning()
    -- Wait until the character and parts are fully loaded
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    local angle = 0

    print("Initializing spinning logic...")

    -- Function to handle spinning
    local connection
    connection = RunService.RenderStepped:Connect(function(deltaTime)
        if spinning then
            angle = angle + (spinSpeed * deltaTime)
            humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position) * CFrame.Angles(0, angle, 0)
        end
        
        -- Check if health is below 15 and stop spinning if so
        if humanoid.Health < 15 then
            spinning = false
        end
    end)

    -- Disconnect the connection on character removal
    character.AncestryChanged:Connect(function(_, parent)
        if not parent then
            connection:Disconnect()
        end
    end)
end

-- Function to handle character respawn
local function onCharacterAdded(character)
    print("Character added, initializing spinning...")
    -- Wait for HumanoidRootPart to be available
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    -- Ensure initialization of spinning logic
    initializeSpinning()
end

-- Connect to CharacterAdded to handle respawn
player.CharacterAdded:Connect(onCharacterAdded)

-- Initialize spinning for the current character if already loaded
if player.Character then
    onCharacterAdded(player.Character)
end

-- Create Toggle for Spin Control
local Toggle = Tab:CreateToggle({
    Name = "Spin Toggle",
    CurrentValue = false,
    Flag = "Toggle1", -- Unique flag for configuration saving
    Callback = function(Value)
        spinning = Value
        print("Spinning set to:", spinning)
    end,
})

-- Create Slider for Spin Speed
local Slider = Tab:CreateSlider({
    Name = "Spin Speed",
    Range = {1, 100}, -- Minimum and maximum values for spin speed
    Increment = 1,
    Suffix = "degrees/sec", -- Display suffix for the slider value
    CurrentValue = spinSpeed, -- Initial value of the slider
    Flag = "Slider1", -- Unique flag for configuration saving
    Callback = function(Value)
        spinSpeed = Value
        print("Spin speed set to:", spinSpeed)
    end,
})

-- Ensure the spinning starts
print("Script is running")

local Section = Tab:CreateSection("Movement")
local speedslider = 1.1
local togglespeed = false
local Speedtoggle = Tab:CreateToggle({
    Name = "Speed",
    CurrentValue = false,
    Flag = "", 
    Callback = function(Value)
    togglespeed = Value

        getgenv().Speed = speedslider

        local speaker = game:GetService("Players").LocalPlayer
        local chr = speaker.Character
        local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
        local hb = game:GetService("RunService").Heartbeat
        if Value then
            while togglespeed and chr and hum and hum.Parent do
                wait()
                if togglespeed and Value then
                    getgenv().Speed = speedslider
                    if speaker.Character and speaker.Character:FindFirstChildWhichIsA("Humanoid") then 
                        chr = speaker.Character
                    end
                    local delta = hb:Wait()
                    if hum.MoveDirection.Magnitude > 0 then
                        chr:TranslateBy(hum.MoveDirection * tonumber(getgenv().Speed) * delta * 10)
                    else
                        chr:TranslateBy(hum.MoveDirection * delta * 10)
                    end
                end
            end
        end
end,
})

local speedsliderchanger = Tab:CreateSlider({
   Name = "Speed",
   Range = {1, 7},
   Increment = 0.1,
   Suffix = "Speed",
   CurrentValue = 1.1,
   Flag = "", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(v)
    speedslider = v
   end,
})
local Slider = Tab:CreateSlider({
   Name = "Gravity (196 Normal 75 is highest jump)",
   Range = {196, 75},
   Increment = 1,
   Suffix = "Gravity",
   CurrentValue = 196.2,
   Flag = "SliderGravity", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
workspace.Gravity = (Value)
   end,
})
local repStorage = game:GetService("ReplicatedStorage")
local valuesFolder = repStorage:FindFirstChild("Values")
local FinishSpeedMult = valuesFolder:FindFirstChild("FinishSpeedMulti")


local Slider = Tab:CreateSlider({
    Name = "Finish/Stomp Speed",
    Range = {0, 1.8},  -- Adjust this range as needed
    Increment = 0.1,
    Suffix = "Speed",
    CurrentValue = FinishSpeedMult.Value,
    Flag = "FinishSpeedMultiplier",
    Callback = function(Value)
        FinishSpeedMult.Value = Value
    end,
})
local Section = Tab:CreateSection("Vision")
local Slider = Tab:CreateSlider({
   Name = "Custom Day Time",
   Range = {1, 24},
   Increment = 1,
   Suffix = ": 00",
   CurrentValue = 12,
   Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
local repStorage = game:GetService("ReplicatedStorage")
    local valuesFolder = repStorage:FindFirstChild("Values")

    local TimeState = valuesFolder:FindFirstChild("TimeState")
    TimeState.Value = (Value)
    TimeState.Enabled.Value = true
   end,
})
local Slider = Tab:CreateSlider({
   Name = "Max CameraZoom Distance",
   Range = {10, 250},
   Increment = 2,
   Suffix = "Distance",
   CurrentValue = 10,
   Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
game.Players.LocalPlayer.CameraMaxZoomDistance = Value
   end,
})
local Dropdown = Tab:CreateDropdown({
   Name = "Camera Mode",
   Options = {"Zoom","Invisicam"},
   CurrentOption = {"Zoom"},
   MultipleOptions = false,
   Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Option)
for _, option in Option do
game.Players.LocalPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode[option]
end
   end,
})
-- Function to create and set up the ScreenGui and ImageLabel
local function createCrosshair()
    -- Create a ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ExampleGui"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Create an ImageLabel (initially hidden)
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Name = "ExampleImage"
    imageLabel.Size = UDim2.new(0.03, 0, 0.03, 0) -- Set size to 3% width and height of the screen (smaller crosshair size)
    imageLabel.Position = UDim2.new(0.5, 0, 0.4775, 0) -- Centered horizontally, positioned in between the old and new vertical positions
    imageLabel.AnchorPoint = Vector2.new(0.5, 0.5) -- Center anchor
    imageLabel.Image = "rbxassetid://1827745860" -- Updated image ID
    imageLabel.BackgroundTransparency = 1 -- Transparent background
    imageLabel.Visible = false -- Initially hidden
    imageLabel.Parent = screenGui
end

-- Create initial crosshair
createCrosshair()

-- Recreate crosshair on respawn
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    -- Remove old ScreenGui if it exists
    local oldGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("ExampleGui")
    if oldGui then
        oldGui:Destroy()
    end
    -- Create new crosshair
    createCrosshair()
end)

-- Create a toggle using 'Tab:CreateToggle'
local Toggle = Tab:CreateToggle({
    Name = "Crosshair", -- Renamed the toggle
    CurrentValue = false, -- Initial state of the toggle
    Flag = "Toggle1", -- Unique flag for configuration
    Callback = function(Value)
        -- Toggle the visibility of the image based on the toggle value
        local imageLabel = game.Players.LocalPlayer.PlayerGui:FindFirstChild("ExampleGui") and game.Players.LocalPlayer.PlayerGui.ExampleGui:FindFirstChild("ExampleImage")
        if imageLabel then
            imageLabel.Visible = Value
        end
    end,
})
local Section = Tab:CreateSection("Chat")
local Button2 = Tab:CreateButton({
   Name = "Chat Spy",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/LisSploit/FemboysHubChat/main/Spy"))()
   end,
})
local Section = Tab:CreateSection("Combat")
local Button3 = Tab:CreateButton({
   Name = "WallBang",
   Callback = function()
        game:service[[Workspace]]:FindFirstChild('Map'):FindFirstChild('Parts'):FindFirstChild('M_Parts').Parent =
game:service[[Workspace]]:FindFirstChild('Characters')
   end,
})
local Button3 = Tab:CreateButton({
   Name = "Admin Protection (Auto leave when Staff joins the server)",
   Callback = function()
local blacklist = {"tabootvcat", "Revenantic", "Saabor", "MoIitor", "IAmUnderAMask", "SheriffGorji", "xXFireyScorpionXx", "LoChips", "DeliverCreations", "TDXiswinning", "TZZV", "FelixVenue", "SIEGFRlED", "ARRYvvv", "z_papermoon", "Malpheasance", "ModHandIer", "valphex", "J_anday", "tvdisko", "yIlehs", "DeliverCreations", "COLOSSUSBUILTOFSTEEL", "SeizedHolder", "r3shape", "RVVZ", "adurize", "codedcosmetics", "QuantumCaterpillar", "FractalHarmonics", "GalacticSculptor", "oTheSilver", "Kretacaous", "icarus_xs1goliath", "GlamorousDradon", "rainjeremy", "parachuter2000", "faintermercury", "harht", "Sansek1252", "Snorpuwu", "BenAzoten", "Cand1ebox", "KeenlyAware", "mrzued", "BruhmanVIII", "Nystesia", "fausties", "zateopp", "Iordnabi", "ReviveTheDevil", "jake_jpeg", "UncrossedMeat3888", "realpenyy", "karateeeh", "JayyMlg", "Lo_Chips", "Avelosky", "king_ab09", "TigerLe123", "Dalvanuis", "MoIitor", "FelixVenue", "iSonMillions"}

-- Convert blacklist to lowercase for consistent comparison
for i = 1, #blacklist do
    blacklist[i] = string.lower(blacklist[i])
end

local function checkPlayer(player)
    if table.find(blacklist, string.lower(player.Name)) then
        game.Players.LocalPlayer:Kick("Stinky Staff joined the server - Femboyshub")
    end
end

local function check()
    for _, player in ipairs(game.Players:GetPlayers()) do
        checkPlayer(player)
    end
end

-- Connect to the PlayerAdded event to check for new players joining the game
game.Players.PlayerAdded:Connect(checkPlayer)

-- Run the check function initially to cover players already in the game
check()
   end,
})
local Button = Tab:CreateButton({
   Name = "RPG-7 rocket control",
   Callback = function()
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local CurrentCamera = workspace.CurrentCamera
local Debris = workspace.Debris
local VParts = Debris.VParts

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Forward = 0
local Sideways = 0
local RocketSpeed = 300
local Break = false

VParts.ChildAdded:Connect(function(RPG_Rocket)
    if not Players.LocalPlayer.Character:FindFirstChild("RPG-7") then
        return
    end
    
    task.wait()

    if RPG_Rocket.Name == "RPG_Rocket" then
        CurrentCamera.CameraSubject = RPG_Rocket

        LocalPlayer.Character.HumanoidRootPart.Anchored = true

        pcall(function()
            RPG_Rocket.BodyForce:Destroy()
            RPG_Rocket.RotPart.BodyAngularVelocity:Destroy()
            RPG_Rocket.Sound:Destroy()
        end)
        
        local BV = Instance.new("BodyVelocity", RPG_Rocket)
        BV.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        BV.Velocity = Vector3.new()
        
        local BG = Instance.new("BodyGyro", RPG_Rocket)
        BG.P = 9e4
        BG.MaxTorque = Vector3.new(1e9, 1e9, 1e9)

        task.spawn(function()
            while true do
                RunService.RenderStepped:Wait()

                TweenService:Create(BV, TweenInfo.new(0.2), {Velocity = ((CurrentCamera.CFrame.LookVector * Forward) + (CurrentCamera.CFrame.RightVector * Sideways)) * RocketSpeed}):Play()
                BG.CFrame = CurrentCamera.CoordinateFrame
                workspace.CurrentCamera.CFrame = RPG_Rocket.CFrame * CFrame.new(Vector3.new(0, 1, 1))
                
                if Break then
                    Break = false
                    break
                end
            end
            
            CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
            LocalPlayer.Character.HumanoidRootPart.Anchored = false
        end)    

        UserInputService.InputBegan:Connect(function(Key)
            if Key.KeyCode == Enum.KeyCode.W then
                Forward = 1
            elseif Key.KeyCode == Enum.KeyCode.S then
                Forward = -1
            elseif Key.KeyCode == Enum.KeyCode.D then
                Sideways = 1
            elseif Key.KeyCode == Enum.KeyCode.A then
                Sideways = -1
            end
        end)

        UserInputService.InputEnded:Connect(function(Key)
            if Key.KeyCode == Enum.KeyCode.W or Key.KeyCode == Enum.KeyCode.S then
                Forward = 0
            elseif Key.KeyCode == Enum.KeyCode.D or Key.KeyCode == Enum.KeyCode.A then
                Sideways = 0
            end
        end)
    end
end)

Debris.ChildAdded:Connect(function(A)
    task.wait()
    pcall(function()
        Break = ((A.Name == "RPG_Explosion_Long" or A.Name == "RPG_Explosion_Short"))
    end)
end)
   end,
})
--Melee Aura Start.
local meleeaurahitpart = "Head"
local range = 30
local togglemeleeaura = false
local AimlockToggle = Tab:CreateToggle({
    Name = "Melee aura",
    CurrentValue = false,
    Flag = "", 
    Callback = function(Value)
    togglemeleeaura = Value

    local function GetClosest()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local Character = LocalPlayer.Character
        local HitPartTarget = Character and Character:FindFirstChild(meleeaurahitpart)
        if not (Character or HumanoidRootPart) then return end

        local TargetDistance = math.huge
        local Target

        for i,v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild(meleeaurahitpart) then
                local TargetHRP = v.Character:FindFirstChild(meleeaurahitpart)
                local mag = (HitPartTarget.Position - TargetHRP.Position).magnitude
                if mag < TargetDistance then
                    TargetDistance = mag
                    Target = v
                end
            end
        end
        if TargetDistance <= range then
            return Target
        else
            return nil
        end
    end

    if Value then
        meleeaurarunservice = game:GetService("RunService").RenderStepped:Connect(function()
            if togglemeleeaura and Value then
                for _, item in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                    if item then
                        if item:IsA("Tool") then
                            if item.Name ~= "Fists" then
                                if item.Name ~= "Sledgehammer" then
                                    if item:FindFirstChild("WeaponHandle") then
                                        if item:FindFirstChild("WeaponHandle"):FindFirstChild("Swing1") or item:FindFirstChild("WeaponHandle"):FindFirstChild("Swing2") then
                                            local HitTarget = GetClosest()
                                            if HitTarget then
                                                if HitTarget.Character then
                                                    if HitTarget.Character:FindFirstChild("Humanoid") and HitTarget.Character:FindFirstChild(meleeaurahitpart) then
                                                        if HitTarget.Character:FindFirstChild("Humanoid").Health > 0 then
                                                            for _, a in pairs(item.WeaponHandle:GetChildren()) do
                                                                if a then
                                                                    if a.Name == "DmgPoint" then
                                                                        local part = HitTarget.Character:FindFirstChild(meleeaurahitpart)
                                                                        a.CFrame = CFrame.new(0, 0, 0)
                                                                        local x = part.Position.X + math.random(-part.Size.X,part.Size.X)/10
                                                                        local y = part.Position.Y + math.random(-part.Size.Y,part.Size.Y)/10
                                                                        local z = part.Position.Z + math.random(-part.Size.Z,part.Size.Z)/10
                                                                        a.WorldCFrame = CFrame.new(x, y, z) * CFrame.new(0, 0.54, 0)
                                                                    end
                                                                end
                                                            end 
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    if item:FindFirstChild("Handle") then
                                        if item:FindFirstChild("Handle"):FindFirstChild("Swing1") or item:FindFirstChild("Handle"):FindFirstChild("Swing2") then
                                            local HitTarget = GetClosest()
                                            if HitTarget then
                                                if HitTarget.Character then
                                                    if HitTarget.Character:FindFirstChild("Humanoid") and HitTarget.Character:FindFirstChild(meleeaurahitpart) then
                                                        if HitTarget.Character:FindFirstChild("Humanoid").Health > 0 then
                                                            for _, a in pairs(item.Handle:GetChildren()) do
                                                                if a then
                                                                    if a.Name == "DmgPoint" then
                                                                        local part = HitTarget.Character:FindFirstChild(meleeaurahitpart)
                                                                        a.CFrame = CFrame.new(0, 0, 0)
                                                                        local x = part.Position.X + math.random(-part.Size.X,part.Size.X)/10
                                                                        local y = part.Position.Y + math.random(-part.Size.Y,part.Size.Y)/10
                                                                        local z = part.Position.Z + math.random(-part.Size.Z,part.Size.Z)/10
                                                                        a.WorldCFrame = CFrame.new(x, y, z) * CFrame.new(0, 0.4, 0)
                                                                    end
                                                                end
                                                            end 
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                for _, arms in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                                    if arms then
                                        if arms.Name == "Left Arm" or arms.Name == "Right Arm" then 
                                            if arms then
                                                local HitTarget = GetClosest()
                                                if HitTarget then
                                                    if HitTarget.Character then
                                                        if HitTarget.Character:FindFirstChild("Humanoid") and HitTarget.Character:FindFirstChild(meleeaurahitpart) then
                                                            if HitTarget.Character:FindFirstChild("Humanoid").Health > 0 then
                                                                if arms then
                                                                    for _, a in pairs(arms:GetChildren()) do
                                                                        if a then
                                                                            if a.Name == "DmgPoint" then
                                                                                local part = HitTarget.Character:FindFirstChild(meleeaurahitpart)
                                                                                a.CFrame = CFrame.new(0, 0, 0)
                                                                                local x = part.Position.X + math.random(-part.Size.X,part.Size.X)/10
                                                                                local y = part.Position.Y + math.random(-part.Size.Y,part.Size.Y)/10
                                                                                local z = part.Position.Z + math.random(-part.Size.Z,part.Size.Z)/10
                                                                                a.WorldCFrame = CFrame.new(x, y, z) * CFrame.new(0, 0.5, 0)
                                                                                -- a.WorldCFrame = HitTarget.Character:FindFirstChild(meleeaurahitpart).CFrame * CFrame.new(0, 0, 0)
                                                                            end
                                                                        end
                                                                    end 
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            else
                if meleeaurarunservice then
                    meleeaurarunservice:Disconnect()
                end
            end
        end)
    else
        if not Value and not togglemeleeaura then 
            if meleeaurarunservice then
                meleeaurarunservice:Disconnect()
            end
        end
    end
end,
})
local Button = Tab:CreateButton({
   Name = "Fling",
   Callback = function()
 loadstring(game:HttpGet'https://raw.githubusercontent.com/sauga77kjk/RobloxExploitRepository/main/TouchFLING')()
   end,
})



-- Function to apply changes to a door model
local function applyDoorChanges(door)
    -- Keep track of the original materials of the parts
    local originalMaterials = {}

    -- Iterate through all descendants of the model
    for _, part in ipairs(door:GetDescendants()) do
        if part:IsA("BasePart") then
            -- Store the original material before changing it
            if not originalMaterials[part] then
                originalMaterials[part] = part.Material
            end

            -- Set the transparency of each part to 0.5 (semi-transparent)
            part.Transparency = 0.5
            -- Set the material to SmoothPlastic to better handle transparency
            part.Material = Enum.Material.SmoothPlastic
            -- Disable collisions for each part
            part.CanCollide = false

            -- Make the DFrame parts invisible
            if part.Name == "DFrame" then
                part.Transparency = 1
                part.CanCollide = false -- Ensure no collisions
            end
        end
    end

    -- Restore the original material of the parts
    for part, material in pairs(originalMaterials) do
        if part and part:IsA("BasePart") then
            part.Material = material
        end
    end
end

-- Function to handle newly added doors
local function onNewDoorAdded(newDoor)
    if newDoor:IsA("Model") then
        applyDoorChanges(newDoor)
    end
end

-- Create the button and define its behavior
local Button = Tab:CreateButton({
    Name = "Anti Doors",  -- Set the button text to "Anti Doors"
    Callback = function()
        -- Access the Doors folder within the Map
        local doorsFolder = game.Workspace.Map:FindFirstChild("Doors")

        -- Check if the Doors folder exists
        if doorsFolder then
            -- Apply changes to existing doors
            for _, door in ipairs(doorsFolder:GetChildren()) do
                if door:IsA("Model") then
                    applyDoorChanges(door)
                end
            end

            -- Connect a function to handle new doors being added
            doorsFolder.ChildAdded:Connect(onNewDoorAdded)

            print("Existing and new doors will now be semi-transparent, non-collidable, and DFrame parts will be invisible.")
        else
            print("No Doors folder found in Map.")
        end
    end,
})

-- Create the button
local Button = Tab:CreateButton({
   Name = "Remove BarbedWire", -- Renamed button
   Callback = function()
      -- Function to delete folders in F_Parts
      local fPartsFolder = game.Workspace.Filter.Parts.F_Parts

      -- Check if F_Parts exists and is a folder
      if fPartsFolder and fPartsFolder:IsA("Folder") then
         -- Iterate through all children of F_Parts
         for _, child in ipairs(fPartsFolder:GetChildren()) do
            -- Check if the child is a Folder
            if child:IsA("Folder") then
               -- Remove the folder
               child:Destroy()
            end
         end
         print("Folders in F_Parts have been deleted.")
      else
         warn("F_Parts folder does not exist or is not a folder.")
      end
   end,
})

local Tab = Window:CreateTab("Teleports", nil) -- Title, Image
local Section = Tab:CreateSection("Main Teleports")
-- Define the button
local Button = Tab:CreateButton({
   Name = "Tower", -- Updated button name
   Callback = function()
       local player = game.Players.LocalPlayer
       local character = player.Character or player.CharacterAdded:Wait()

       -- Original target CFrame (updated)
       local originalCFrame = CFrame.new(-4513.34766, 149.349609, -879.456604, 
                                          -0.0525398403, 8.26210389e-09, -0.998618841, 
                                          -1.27831257e-07, 1, 1.49990527e-08, 
                                          0.998618841, 1.28442736e-07, -0.0525398403)

       -- Adjusted target CFrame (2 studs higher)
       local targetCFrame = originalCFrame + Vector3.new(0, 2, 0)

       -- Calculate the distance between original and target position
       local originalPosition = originalCFrame.Position
       local targetPosition = targetCFrame.Position
       local distance = (targetPosition - originalPosition).Magnitude

       -- Determine sticking time based on distance
       local stayDuration = distance > 500 and 9 or (distance > 150 and 7 or 5) -- seconds
       local refreshRate = 0.01 -- seconds (10 milliseconds)

       -- Get the character's PrimaryPart
       local primaryPart = character.PrimaryPart

       -- Ensure the PrimaryPart is available
       if not primaryPart then
           warn("PrimaryPart not set for character")
           return
       end

       -- Time tracking
       local startTime = tick()

       -- Loop to refresh position every 10 milliseconds
       while tick() - startTime < stayDuration do
           -- Set the character's PrimaryPart CFrame
           primaryPart.CFrame = targetCFrame
           
           -- Wait for the next refresh
           wait(refreshRate)
       end
   end,
})
-- Define the button
local Button = Tab:CreateButton({
   Name = "Motel", -- Updated button name
   Callback = function()
       local player = game.Players.LocalPlayer
       local character = player.Character or player.CharacterAdded:Wait()

       -- Original target CFrame (updated)
       local originalCFrame = CFrame.new(-4671.03076, 3.29673862, -905.132507, 
                                          0.00827909447, 2.12039741e-09, -0.999965727, 
                                          6.93145878e-08, 1, 2.69435185e-09, 
                                          0.999965727, -6.93345186e-08, 0.00827909447)

       -- Adjusted target CFrame (2 studs higher)
       local targetCFrame = originalCFrame + Vector3.new(0, 2, 0)

       -- Calculate the distance between original and target position
       local originalPosition = originalCFrame.Position
       local targetPosition = targetCFrame.Position
       local distance = (targetPosition - originalPosition).Magnitude

       -- Determine sticking time based on distance
       local stayDuration = distance > 500 and 9 or (distance > 150 and 7 or 5) -- seconds
       local refreshRate = 0.01 -- seconds (10 milliseconds)

       -- Get the character's PrimaryPart
       local primaryPart = character.PrimaryPart

       -- Ensure the PrimaryPart is available
       if not primaryPart then
           warn("PrimaryPart not set for character")
           return
       end

       -- Time tracking
       local startTime = tick()

       -- Loop to refresh position every 10 milliseconds
       while tick() - startTime < stayDuration do
           -- Set the character's PrimaryPart CFrame
           primaryPart.CFrame = targetCFrame
           
           -- Wait for the next refresh
           wait(refreshRate)
       end
   end,
})
-- Define the button
local Button = Tab:CreateButton({
   Name = "Cafe", -- Updated button name
   Callback = function()
       local player = game.Players.LocalPlayer
       local character = player.Character or player.CharacterAdded:Wait()

       -- Original target CFrame (updated)
       local originalCFrame = CFrame.new(-4630.45752, 6.05001259, -269.560516, 
                                          0.0246613994, 4.06907468e-08, -0.999695837, 
                                          8.68120509e-08, 1, 4.2844686e-08, 
                                          0.999695837, -8.78422597e-08, 0.0246613994)

       -- Adjusted target CFrame (2 studs higher)
       local targetCFrame = originalCFrame + Vector3.new(0, 2, 0)

       -- Calculate the distance between original and target position
       local originalPosition = originalCFrame.Position
       local targetPosition = targetCFrame.Position
       local distance = (targetPosition - originalPosition).Magnitude

       -- Determine sticking time based on distance
       local stayDuration = distance > 500 and 9 or (distance > 150 and 7 or 5) -- seconds
       local refreshRate = 0.01 -- seconds (10 milliseconds)

       -- Get the character's PrimaryPart
       local primaryPart = character.PrimaryPart

       -- Ensure the PrimaryPart is available
       if not primaryPart then
           warn("PrimaryPart not set for character")
           return
       end

       -- Time tracking
       local startTime = tick()

       -- Loop to refresh position every 10 milliseconds
       while tick() - startTime < stayDuration do
           -- Set the character's PrimaryPart CFrame
           primaryPart.CFrame = targetCFrame
           
           -- Wait for the next refresh
           wait(refreshRate)
       end
   end,
})
-- Define the button
local Button = Tab:CreateButton({
   Name = "Illegal Pizza", -- Updated button name
   Callback = function()
       local player = game.Players.LocalPlayer
       local character = player.Character or player.CharacterAdded:Wait()

       -- Original target CFrame (updated)
       local originalCFrame = CFrame.new(-4419.31836, 5.19999504, -124.549927, 
                                          0.0327239819, -3.50398643e-08, -0.999464452, 
                                          1.76940649e-08, 1, -3.44793101e-08, 
                                          0.999464452, -1.65562888e-08, 0.0327239819)

       -- Adjusted target CFrame (2 studs higher)
       local targetCFrame = originalCFrame + Vector3.new(0, 2, 0)

       -- Calculate the distance between original and target position
       local originalPosition = originalCFrame.Position
       local targetPosition = targetCFrame.Position
       local distance = (targetPosition - originalPosition).Magnitude

       -- Determine sticking time based on distance
       local stayDuration = distance > 500 and 9 or (distance > 150 and 7 or 5) -- seconds
       local refreshRate = 0.01 -- seconds (10 milliseconds)

       -- Get the character's PrimaryPart
       local primaryPart = character.PrimaryPart

       -- Ensure the PrimaryPart is available
       if not primaryPart then
           warn("PrimaryPart not set for character")
           return
       end

       -- Time tracking
       local startTime = tick()

       -- Loop to refresh position every 10 milliseconds
       while tick() - startTime < stayDuration do
           -- Set the character's PrimaryPart CFrame
           primaryPart.CFrame = targetCFrame
           
           -- Wait for the next refresh
           wait(refreshRate)
       end
   end,
})
-- Define the button
local Button = Tab:CreateButton({
   Name = "JunkYard", -- Updated button name
   Callback = function()
       local player = game.Players.LocalPlayer
       local character = player.Character or player.CharacterAdded:Wait()

       -- Updated target CFrame
       local targetCFrame = CFrame.new(-3919.51733, 3.79995584, -448.998413, 
                                       0.0113751534, 1.73916492e-09, -0.999935329, 
                                       -9.92708848e-08, 1, 6.09982898e-10, 
                                       0.999935329, 9.92575195e-08, 0.0113751534)

       -- Calculate the distance between original and target position
       local originalPosition = character.PrimaryPart.Position
       local targetPosition = targetCFrame.Position
       local distance = (targetPosition - originalPosition).Magnitude

       -- Determine sticking time based on distance
       local stayDuration = distance > 500 and 9 or (distance > 150 and 7 or 5) -- seconds
       local refreshRate = 0.01 -- seconds (10 milliseconds)

       -- Get the character's PrimaryPart
       local primaryPart = character.PrimaryPart

       -- Ensure the PrimaryPart is available
       if not primaryPart then
           warn("PrimaryPart not set for character")
           return
       end

       -- Time tracking
       local startTime = tick()

       -- Loop to refresh position every 10 milliseconds
       while tick() - startTime < stayDuration do
           -- Set the character's PrimaryPart CFrame
           primaryPart.CFrame = targetCFrame
           
           -- Wait for the next refresh
           wait(refreshRate)
       end
   end,
})
-- Define the button
local Button = Tab:CreateButton({
   Name = "Sewer", -- Updated button name
   Callback = function()
       local player = game.Players.LocalPlayer
       local character = player.Character or player.CharacterAdded:Wait()

       -- Original target CFrame (updated)
       local originalCFrame = CFrame.new(-4658.19092, -69.365921, -871.911499, 
                                          -0.0228894278, -7.16986825e-09, -0.999737978, 
                                          -1.95281991e-09, 1, -7.12703629e-09, 
                                          0.999737978, 1.78917448e-09, -0.0228894278)

       -- Adjusted target CFrame (2 studs higher)
       local targetCFrame = originalCFrame + Vector3.new(0, 2, 0)

       -- Calculate the distance between original and target position
       local originalPosition = originalCFrame.Position
       local targetPosition = targetCFrame.Position
       local distance = (targetPosition - originalPosition).Magnitude

       -- Determine sticking time based on distance
       local stayDuration = distance > 500 and 9 or (distance > 150 and 7 or 5) -- seconds
       local refreshRate = 0.01 -- seconds (10 milliseconds)

       -- Get the character's PrimaryPart
       local primaryPart = character.PrimaryPart

       -- Ensure the PrimaryPart is available
       if not primaryPart then
           warn("PrimaryPart not set for character")
           return
       end

       -- Time tracking
       local startTime = tick()

       -- Loop to refresh position every 10 milliseconds
       while tick() - startTime < stayDuration do
           -- Set the character's PrimaryPart CFrame
           primaryPart.CFrame = targetCFrame
           
           -- Wait for the next refresh
           wait(refreshRate)
       end
   end,
})

-- Define the button
local Button = Tab:CreateButton({
    Name = "Vibe Check down",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        -- Original target CFrame (updated)
        local originalCFrame = CFrame.new(-4780.96729, -200.964722, -895.44696, 
                                          0.999941528, 6.56086208e-09, 0.0108164698, 
                                          -5.23050447e-09, 1, -1.23021962e-07, 
                                          -0.0108164698, 1.22958184e-07, 0.999941528)

        -- Adjusted target CFrame (2 studs higher)
        local targetCFrame = originalCFrame + Vector3.new(0, 2, 0)

        -- Calculate the distance between original and target position
        local originalPosition = originalCFrame.Position
        local targetPosition = targetCFrame.Position
        local distance = (targetPosition - originalPosition).Magnitude

        -- Determine sticking time based on distance
        local stayDuration = distance > 500 and 9 or (distance > 150 and 7 or 5) -- seconds
        local refreshRate = 0.01 -- seconds (10 milliseconds)

        -- Get the character's PrimaryPart
        local primaryPart = character.PrimaryPart

        -- Ensure the PrimaryPart is available
        if not primaryPart then
            warn("PrimaryPart not set for character")
            return
        end

        -- Time tracking
        local startTime = tick()

        -- Loop to refresh position every 10 milliseconds
        while tick() - startTime < stayDuration do
            -- Set the character's PrimaryPart CFrame
            primaryPart.CFrame = targetCFrame
            
            -- Wait for the next refresh
            wait(refreshRate)
        end
    end,
})


-- Define the button
local Button = Tab:CreateButton({
    Name = "Vibe Check Up",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        -- Original target CFrame (updated)
        local originalCFrame = CFrame.new(-4776.97803, -34.7683716, -788.092468, 
                                          0.999498069, -5.97677996e-08, 0.0316800252, 
                                          6.05885475e-08, 1, -2.49475054e-08, 
                                          -0.0316800252, 2.68544298e-08, 0.999498069)

        -- Adjusted target CFrame (2 studs higher)
        local targetCFrame = originalCFrame + Vector3.new(0, 2, 0)

        -- Calculate the distance between original and target position
        local originalPosition = originalCFrame.Position
        local targetPosition = targetCFrame.Position
        local distance = (targetPosition - originalPosition).Magnitude

        -- Determine sticking time based on distance
        local stayDuration = distance > 500 and 9 or (distance > 150 and 7 or 5) -- seconds
        local refreshRate = 0.01 -- seconds (10 milliseconds)

        -- Get the character's PrimaryPart
        local primaryPart = character.PrimaryPart

        -- Ensure the PrimaryPart is available
        if not primaryPart then
            warn("PrimaryPart not set for character")
            return
        end

        -- Time tracking
        local startTime = tick()

        -- Loop to refresh position every 10 milliseconds
        while tick() - startTime < stayDuration do
            -- Set the character's PrimaryPart CFrame
            primaryPart.CFrame = targetCFrame
            
            -- Wait for the next refresh
            wait(refreshRate)
        end
    end,
})

local Section = Tab:CreateSection("Misc Teleports")
-- Function to initialize player-related variables
local function initializePlayer()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    return player, character, humanoidRootPart
end

-- Initialize player and humanoidRootPart
local player, character, humanoidRootPart = initializePlayer()

-- Listen for respawn event
player.CharacterAdded:Connect(function(char)
    character = char
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
end)

-- Function to find the nearest ScreenMesh part
local function findNearestScreenMeshPart()
    local vendingMachinesFolder = game.Workspace.Map:FindFirstChild("VendingMachines")
    local nearestScreenMesh = nil
    local shortestDistance = math.huge

    if vendingMachinesFolder then
        for _, vendingMachine in pairs(vendingMachinesFolder:GetChildren()) do
            local partsFolder = vendingMachine:FindFirstChild("Parts")
            if partsFolder then
                local screenMesh = partsFolder:FindFirstChild("ScreenMesh")
                if screenMesh and screenMesh:IsA("BasePart") then
                    local distance = (humanoidRootPart.Position - screenMesh.Position).magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        nearestScreenMesh = screenMesh
                    end
                end
            end
        end
    end

    return nearestScreenMesh
end

-- Function to teleport slightly in front of the nearest ScreenMesh and face it
local function teleportToFrontOfNearestScreenMesh()
    local screenMeshPart = findNearestScreenMeshPart()

    if screenMeshPart then
        -- Calculate the distance to the ScreenMesh part
        local distance = (humanoidRootPart.Position - screenMeshPart.Position).magnitude
        -- Set duration based on distance
        local duration = distance > 150 and 7 or 5
        local startTime = tick()  -- Record the start time

        while tick() - startTime < duration do
            -- Calculate a position slightly in front of the ScreenMesh part
            local direction = screenMeshPart.CFrame.LookVector -- Forward direction of ScreenMesh
            local offset = direction * 3  -- Move 3 studs in front of the ScreenMesh
            
            -- Position the player slightly in front of the ScreenMesh and face it
            local newPosition = screenMeshPart.Position + offset
            humanoidRootPart.CFrame = CFrame.new(newPosition, screenMeshPart.Position)

            wait(0.01)  -- Wait for 10 milliseconds
        end
    else
        warn("No ScreenMesh part found.")
    end
end

-- Create the button and assign the teleport function to it
local Button = Tab:CreateButton({
    Name = "Teleport to Nearest VendingMachine",
    Callback = function()
        teleportToFrontOfNearestScreenMesh()  -- Call the teleport function when the button is pressed
    end,
})

-- Define the player
local player = game.Players.LocalPlayer

-- Function to get the character, wait if necessary
local function getCharacter()
    return player.Character or player.CharacterAdded:Wait()
end

-- Define the target locations
local shopz = game.Workspace.Map.Shopz

-- Function to find the nearest 'MainPart' inside 'ArmoryDealer' or 'Dealer'
local function findNearestMainPart(character)
    local nearestMainPart = nil
    local shortestDistance = math.huge
    
    -- Iterate through the children of 'shopz'
    for _, child in ipairs(shopz:GetChildren()) do
        if child:IsA("Model") and (child.Name == "ArmoryDealer" or child.Name == "Dealer") then
            local mainPart = child:FindFirstChild("MainPart")
            if mainPart then
                local distance = (character.PrimaryPart.Position - mainPart.Position).Magnitude
                if distance < shortestDistance then
                    nearestMainPart = mainPart
                    shortestDistance = distance
                end
            end
        end
    end
    
    return nearestMainPart
end

-- Function to teleport the player to a position in front of the nearest 'MainPart'
local function teleportToPositionInFrontOfMainPart()
    local character = getCharacter()
    local nearestMainPart = findNearestMainPart(character)
    if nearestMainPart then
        -- Define the distance in front of the MainPart where the player will be teleported
        local distanceInFront = 3 -- You can adjust this distance as needed

        -- Calculate the new position in front of the MainPart
        local newPosition = nearestMainPart.Position + nearestMainPart.CFrame.LookVector * distanceInFront

        -- Teleport the player to the calculated position
        character:SetPrimaryPartCFrame(CFrame.new(newPosition, nearestMainPart.Position))

        -- Stick the player to the new position for 6 seconds
        local startTime = tick()
        while tick() - startTime < 6 do
            -- Continuously set the character's PrimaryPart CFrame to the new position
            character:SetPrimaryPartCFrame(CFrame.new(newPosition, nearestMainPart.Position))
            -- Yield for a short time to avoid freezing the game
            wait(0.01) -- Approximately 10 milliseconds
        end
    else
        warn("No 'MainPart' found inside 'ArmoryDealer' or 'Dealer'.")
    end
end

-- Create the button
local Button = Tab:CreateButton({
    Name = "Teleport to Nearest Dealer",
    Callback = function()
        -- Call the function to teleport the player when the button is pressed
        teleportToPositionInFrontOfMainPart()
    end,
})

-- Handle respawn
player.CharacterAdded:Connect(function()
    -- Wait for the character to be fully loaded
    local character = player.Character or player.CharacterAdded:Wait()
    -- Call the function to teleport the player when they respawn
    teleportToPositionInFrontOfMainPart()
end)


-- Function to initialize player-related variables
local function initializePlayer()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    return player, character, humanoidRootPart
end

-- Initialize player and humanoidRootPart
local player, character, humanoidRootPart = initializePlayer()

-- Listen for respawn event
player.CharacterAdded:Connect(function(char)
    character = char
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
end)

-- Define the target path and safe types
local targetFolder = game.Workspace.Map.BredMakurz
local safeTypes = {
    "SmallSafe_SW_11", "SmallSafe_FA_34", "SmallSafe_C_3", "SmallSafe_HO_37",
    "SmallSafe_SU_22", "SmallSafe_SU_15", "MediumSafe_VC_30", "MediumSafe_T_45",
    "SmallSafe_SW_26", "MediumSafe_SU_32", "MediumSafe_TS_20", "MediumSafe_SEW_8",
    "SmallSafe_TO_43", "SmallSafe_FA_36", "MediumSafe_HO_24", "SmallSafe_TO_42",
    "SmallSafe_BD_18", "MediumSafe_HO_39", "MediumSafe_VC_21", "MediumSafe_SEW_2",
    "SmallSafe_M_17", "SmallSafe_BD_12", "SmallSafe_WH_28", "MediumSafe_HO_41",
    "MediumSafe_T_46", "SmallSafe_FA_35", "MediumSafe_VC_38", "MediumSafe_SW_9",
    "MediumSafe_TS_20", "SmallSafe_TO_44", "Register_TS_27", "Register_BS_47",
    "Register_C_1", "Register_TS_4", "Register_B_10", "Register_HO_23",
    "Register_M_31", "Register_B_40", "Register_GS_16", "Register_M_25",
    "Register_P_13", "Register_P_14", "Register_VI_29", "Register_B_7",
    "Register_M_6", "Register_M_5", "Register_B_19", "Register_B_33"
}

-- Function to find the nearest safe or register of the specified types
local function findNearestSafe()
    local nearestMainPart = nil
    local shortestDistance = math.huge

    for _, obj in pairs(targetFolder:GetDescendants()) do
        if obj:IsA("Model") and table.find(safeTypes, obj.Name) then
            local mainPart = obj:FindFirstChild("MainPart")
            local safeValues = obj:FindFirstChild("Values")
            if mainPart and mainPart:IsA("BasePart") and safeValues then
                local brokenValue = safeValues:FindFirstChild("Broken")
                if brokenValue and brokenValue:IsA("BoolValue") and not brokenValue.Value then
                    local distance = (humanoidRootPart.Position - mainPart.Position).magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        nearestMainPart = mainPart
                    end
                end
            end
        end
    end

    return nearestMainPart
end

-- Function to teleport slightly in front of the nearest MainPart and face it
local function teleportToFrontOfMainPart()
    local nearestMainPart = findNearestSafe()

    if nearestMainPart then
        -- Calculate the distance to the nearest MainPart
        local distance = (humanoidRootPart.Position - nearestMainPart.Position).magnitude
        -- Set duration based on distance
        local duration = distance > 150 and 7 or 5
        local startTime = tick()  -- Record the start time

        while tick() - startTime < duration do
            -- Calculate a position slightly in front of the MainPart
            local direction = nearestMainPart.CFrame.LookVector -- Forward direction of MainPart
            local offset = direction * 3  -- Move 3 studs in front of the MainPart (closer than before)
            
            -- Position the player slightly in front of the MainPart and face it
            local newPosition = nearestMainPart.Position + offset
            humanoidRootPart.CFrame = CFrame.new(newPosition, nearestMainPart.Position)

            wait(0.01)  -- Wait for 10 milliseconds
        end
    else
        warn("No usable safe found or all are broken.")
    end
end

-- Create the button and assign the teleport function to it
local Button = Tab:CreateButton({
    Name = "Teleport to Nearest Safe/Register",
    Callback = function()
        teleportToFrontOfMainPart()  -- Call the teleport function when the button is pressed
    end,
})
-- Define the function to teleport the player to a position in front of the nearest 'atm'
local function teleportToPositionInFrontOfATM()
    -- Services
    local Players = game:GetService("Players")
    local Workspace = game:GetService("Workspace")

    -- Define the player and character
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    -- Define the target path to 'atm'
    local atmFolder = Workspace:WaitForChild("Map"):WaitForChild("ATMz"):WaitForChild("ATM"):WaitForChild("Parts"):WaitForChild("Main")

    -- Function to find the nearest 'atm' part inside 'Main'
    local function findNearestATM()
        local nearestATM = nil
        local shortestDistance = math.huge
        
        -- Iterate through the children of 'Main'
        for _, atm in ipairs(atmFolder:GetChildren()) do
            if atm:IsA("BasePart") and atm.Name == "atm" then
                local distance = (humanoidRootPart.Position - atm.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestATM = atm
                end
            end
        end
        
        return nearestATM
    end

    -- Calculate the new position in front of the ATM
    local nearestATM = findNearestATM()
    if nearestATM then
        -- Define the distance in front of the ATM where the player will be teleported
        local distanceInFront = -3 -- Adjust this distance as needed

        -- Calculate the new position in front of the ATM
        local atmCFrame = nearestATM.CFrame
        local newPosition = atmCFrame.Position + atmCFrame.LookVector * distanceInFront

        -- Debug output to verify calculations
        print("ATM Position:", atmCFrame.Position)
        print("LookVector:", atmCFrame.LookVector)
        print("New Position:", newPosition)

        -- Calculate the distance from the original position
        local originalPosition = humanoidRootPart.Position
        local teleportDistance = (newPosition - originalPosition).Magnitude

        -- Determine the wait time based on the distance
        local waitTime = (teleportDistance > 200) and 7 or 5

        -- Teleport the player to the calculated position
        humanoidRootPart.CFrame = CFrame.new(newPosition, atmCFrame.Position)

        -- Stick the player to the new position for the determined wait time
        local startTime = tick()
        while tick() - startTime < waitTime do
            -- Continuously set the character's CFrame to the new position
            humanoidRootPart.CFrame = CFrame.new(newPosition, atmCFrame.Position)
            -- Yield for a short time to avoid freezing the game
            wait(0.1) -- 100 milliseconds
        end
    else
        warn("No 'atm' found inside 'Main'.")
    end
end

-- Cooldown variables
local cooldownDuration = 30
local isOnCooldown = false

-- Create the teleport button in the existing tab
local Button = Tab:CreateButton({
    Name = "Teleport to ATM", -- Updated button name
    Callback = function()
        if not isOnCooldown then
            teleportToPositionInFrontOfATM()
            isOnCooldown = true
            
            -- Start the cooldown timer
            local startTime = tick()
            local cooldownEnd = startTime + cooldownDuration

            -- Cooldown logic
            spawn(function()
                while tick() < cooldownEnd do
                    wait(1) -- Update every second
                end
                isOnCooldown = false
            end)
        end
    end
})
local Section = Tab:CreateSection("Temporary Teleports")
-- Define the player
local player = game.Players.LocalPlayer

-- Function to get the character, wait if necessary
local function getCharacter()
    return player.Character or player.CharacterAdded:Wait()
end

-- Define the target locations
local shopz = game.Workspace.Map.Shopz

-- Function to find the 'MainPart' inside 'RebelDealer'
local function findRebelDealerMainPart(character)
    for _, child in ipairs(shopz:GetChildren()) do
        if child:IsA("Model") and child.Name == "RebelDealer" then
            return child:FindFirstChild("MainPart")
        end
    end
    return nil
end

-- Function to teleport the player to a position in front of the 'MainPart' of 'RebelDealer'
local function teleportToPositionInFrontOfRebelDealer()
    local character = getCharacter()
    local mainPart = findRebelDealerMainPart(character)
    
    if mainPart then
        -- Define the distance in front of the MainPart where the player will be teleported
        local distanceInFront = 3 -- You can adjust this distance as needed

        -- Calculate the new position in front of the MainPart
        local newPosition = mainPart.Position + mainPart.CFrame.LookVector * distanceInFront

        -- Teleport the player to the calculated position
        character:SetPrimaryPartCFrame(CFrame.new(newPosition, mainPart.Position))

        -- Stick the player to the new position for 4 seconds
        local startTime = tick()
        while tick() - startTime < 4 do
            -- Continuously set the character's PrimaryPart CFrame to the new position
            character:SetPrimaryPartCFrame(CFrame.new(newPosition, mainPart.Position))
            -- Yield for a short time to avoid freezing the game
            wait(0.01) -- Approximately 10 milliseconds
        end
    else
        -- Notify the player if 'RebelDealer' is not found
        Rayfield:Notify({
            Title = "RebelDealer Not Found",
            Content = "No 'RebelDealer' found inside 'shopz'.",
            Duration = 6.5,
            Image = 4483362458,
            Actions = { 
                Ignore = {
                    Name = "Okay!",
                    Callback = function()
                        print("The user tapped Okay!")
                    end
                },
            },
        })
    end
end

-- Create the button
local Button = Tab:CreateButton({
    Name = "Teleport to RebelDealer",
    Callback = function()
        -- Call the function to teleport the player when the button is pressed
        teleportToPositionInFrontOfRebelDealer()
    end,
})

-- Handle respawn
player.CharacterAdded:Connect(function()
    -- Wait for the character to be fully loaded
    local character = player.Character or player.CharacterAdded:Wait()
    -- Call the function to teleport the player when they respawn
    teleportToPositionInFrontOfRebelDealer()
end)
-- Define the player
local player = game.Players.LocalPlayer

-- Function to get the character, wait if necessary
local function getCharacter()
    return player.Character or player.CharacterAdded:Wait()
end

-- Define the target locations
local mysteryBoxPath = game.Workspace.Map.MysteryBoxes:FindFirstChild("MysteryBox")

-- Function to find the 'MainPart' inside 'MysteryBox'
local function findMysteryBoxMainPart(character)
    if mysteryBoxPath then
        return mysteryBoxPath:FindFirstChild("MainPart")
    end
    return nil
end

-- Function to teleport the player to a position in front of the 'MainPart' of 'MysteryBox'
local function teleportToPositionInFrontOfMysteryBox()
    local character = getCharacter()
    local mainPart = findMysteryBoxMainPart(character)
    
    if mainPart then
        -- Define the distance in front of the MainPart where the player will be teleported
        local distanceInFront = 3 -- You can adjust this distance as needed

        -- Calculate the new position in front of the MainPart
        local newPosition = mainPart.Position + mainPart.CFrame.LookVector * distanceInFront

        -- Teleport the player to the calculated position
        character:SetPrimaryPartCFrame(CFrame.new(newPosition, mainPart.Position))

        -- Stick the player to the new position for 4 seconds
        local startTime = tick()
        while tick() - startTime < 4 do
            -- Continuously set the character's PrimaryPart CFrame to the new position
            character:SetPrimaryPartCFrame(CFrame.new(newPosition, mainPart.Position))
            -- Yield for a short time to avoid freezing the game
            wait(0.01) -- Approximately 10 milliseconds
        end
    else
        -- Notify the player if 'MysteryBox' is not found
        Rayfield:Notify({
            Title = "MysteryBox Not Found",
            Content = "No 'MysteryBox' found inside 'MysteryBoxes'.",
            Duration = 6.5,
            Image = 4483362458,
            Actions = { 
                Ignore = {
                    Name = "Okay!",
                    Callback = function()
                        print("The user tapped Okay!")
                    end
                },
            },
        })
    end
end

-- Create the button
local Button = Tab:CreateButton({
    Name = "Teleport to MysteryBox",
    Callback = function()
        -- Call the function to teleport the player when the button is pressed
        teleportToPositionInFrontOfMysteryBox()
    end,
})

-- Handle respawn
player.CharacterAdded:Connect(function()
    -- Wait for the character to be fully loaded
    local character = player.Character or player.CharacterAdded:Wait()
    -- Call the function to teleport the player when they respawn
    teleportToPositionInFrontOfMysteryBox()
end)
-- Define the player
local player = game.Players.LocalPlayer

-- Function to get the character, wait if necessary
local function getCharacter()
    return player.Character or player.CharacterAdded:Wait()
end

-- Function to find the nearest MeshPart in 'SpawnedBread'
local function findNearestMeshPart()
    local spawnedBreadFolder = game.Workspace.Filter.SpawnedBread
    local meshParts = {}
    local playerPosition = getCharacter().HumanoidRootPart.Position

    -- Iterate through all children in the folder and collect MeshParts
    for _, obj in pairs(spawnedBreadFolder:GetChildren()) do
        if obj:IsA("MeshPart") then
            table.insert(meshParts, obj)
        end
    end

    if #meshParts > 0 then
        local nearestMeshPart = nil
        local nearestDistance = math.huge -- Start with a large number

        -- Find the nearest MeshPart
        for _, meshPart in pairs(meshParts) do
            local distance = (meshPart.Position - playerPosition).magnitude
            if distance < nearestDistance then
                nearestDistance = distance
                nearestMeshPart = meshPart
            end
        end

        return nearestMeshPart
    end

    return nil
end

-- Function to teleport the player in front of the nearest MeshPart and 5 studs higher
local function teleportInFrontAndAboveNearestMeshPart()
    local character = getCharacter()
    local nearestMeshPart = findNearestMeshPart()
    
    if nearestMeshPart then
        -- Define the distance in front of the MeshPart where the player will be teleported
        local distanceInFront = 5 -- Distance in front of the MeshPart
        local heightOffset = 5 -- Height offset above the MeshPart

        -- Calculate the new position in front of the nearest MeshPart and 5 studs higher
        local newPosition = nearestMeshPart.Position + nearestMeshPart.CFrame.LookVector * distanceInFront + Vector3.new(0, heightOffset, 0)

        -- Teleport the player to the calculated position in front and above the MeshPart
        character:SetPrimaryPartCFrame(CFrame.new(newPosition, newPosition + nearestMeshPart.CFrame.LookVector))

        -- Stick the player to the new position for 5 seconds
        local startTime = tick()
        while tick() - startTime < 5 do
            -- Continuously set the character's PrimaryPart CFrame to the new position
            character:SetPrimaryPartCFrame(CFrame.new(newPosition, newPosition + nearestMeshPart.CFrame.LookVector))
            -- Yield for a short time to avoid freezing the game
            wait(0.01) -- Approximately 10 milliseconds
        end
    else
        -- Notify the player if no MeshPart is found in 'SpawnedBread'
        Rayfield:Notify({
            Title = "No Cash Found",
            Content = "No Cash found in game.",
            Duration = 6.5,
            Image = 4483362458,
            Actions = { 
                Ignore = {
                    Name = "Okay!",
                    Callback = function()
                        print("The user tapped Okay!")
                    end
                },
            },
        })
    end
end

-- Create the button
local Button = Tab:CreateButton({
    Name = "Spawn to dropped Cash",
    Callback = function()
        -- Call the function to teleport the player when the button is pressed
        teleportInFrontAndAboveNearestMeshPart()
    end,
})

-- Handle respawn
player.CharacterAdded:Connect(function()
    -- Wait for the character to be fully loaded
    local character = player.Character or player.CharacterAdded:Wait()
    -- Call the function to teleport the player when they respawn
    teleportInFrontAndAboveNearestMeshPart()
end)

-- Premium
local Tab = Window:CreateTab("Premium", nil) -- Title, Image
local PremiumSection = Tab:CreateSection("Premium")
local PremiumButton = Tab:CreateButton({
   Name = "Auto Lockpick",
   Callback = function()
   function checkLockpick(...)
    local frames = { ... };
    for i,v in pairs(frames) do
        v.Parent.UIScale.Scale = 10
        if (v.AbsolutePosition.Y >= 450 and v.AbsolutePosition.Y <= 550) then
            mouse1click(); task.wait(0.1); mouse1release();
        end
    end
end

while true do task.wait()
    local pgui = game.Players.LocalPlayer:WaitForChild"PlayerGui"
    local lpgui = pgui:FindFirstChild'LockpickGUI';

    if (lpgui) then

        local B1 = lpgui.MF.LP_Frame.Frames.B1.Bar.Selection;
        local B2 = lpgui.MF.LP_Frame.Frames.B2.Bar.Selection;
        local B3 = lpgui.MF.LP_Frame.Frames.B3.Bar.Selection;

        checkLockpick(B1, B2, B3);
    end
end
   end,
})

local PremiumButton = Tab:CreateButton({
   Name = "FullBright",
   Callback = function()
   if not _G.FullBrightExecuted then

	_G.FullBrightEnabled = false

	_G.NormalLightingSettings = {
		Brightness = game:GetService("Lighting").Brightness,
		ClockTime = game:GetService("Lighting").ClockTime,
		FogEnd = game:GetService("Lighting").FogEnd,
		GlobalShadows = game:GetService("Lighting").GlobalShadows,
		Ambient = game:GetService("Lighting").Ambient
	}

	game:GetService("Lighting"):GetPropertyChangedSignal("Brightness"):Connect(function()
		if game:GetService("Lighting").Brightness ~= 1 and game:GetService("Lighting").Brightness ~= _G.NormalLightingSettings.Brightness then
			_G.NormalLightingSettings.Brightness = game:GetService("Lighting").Brightness
			if not _G.FullBrightEnabled then
				repeat
					wait()
				until _G.FullBrightEnabled
			end
			game:GetService("Lighting").Brightness = 1
		end
	end)

	game:GetService("Lighting"):GetPropertyChangedSignal("ClockTime"):Connect(function()
		if game:GetService("Lighting").ClockTime ~= 12 and game:GetService("Lighting").ClockTime ~= _G.NormalLightingSettings.ClockTime then
			_G.NormalLightingSettings.ClockTime = game:GetService("Lighting").ClockTime
			if not _G.FullBrightEnabled then
				repeat
					wait()
				until _G.FullBrightEnabled
			end
			game:GetService("Lighting").ClockTime = 12
		end
	end)

	game:GetService("Lighting"):GetPropertyChangedSignal("FogEnd"):Connect(function()
		if game:GetService("Lighting").FogEnd ~= 786543 and game:GetService("Lighting").FogEnd ~= _G.NormalLightingSettings.FogEnd then
			_G.NormalLightingSettings.FogEnd = game:GetService("Lighting").FogEnd
			if not _G.FullBrightEnabled then
				repeat
					wait()
				until _G.FullBrightEnabled
			end
			game:GetService("Lighting").FogEnd = 786543
		end
	end)

	game:GetService("Lighting"):GetPropertyChangedSignal("GlobalShadows"):Connect(function()
		if game:GetService("Lighting").GlobalShadows ~= false and game:GetService("Lighting").GlobalShadows ~= _G.NormalLightingSettings.GlobalShadows then
			_G.NormalLightingSettings.GlobalShadows = game:GetService("Lighting").GlobalShadows
			if not _G.FullBrightEnabled then
				repeat
					wait()
				until _G.FullBrightEnabled
			end
			game:GetService("Lighting").GlobalShadows = false
		end
	end)

	game:GetService("Lighting"):GetPropertyChangedSignal("Ambient"):Connect(function()
		if game:GetService("Lighting").Ambient ~= Color3.fromRGB(178, 178, 178) and game:GetService("Lighting").Ambient ~= _G.NormalLightingSettings.Ambient then
			_G.NormalLightingSettings.Ambient = game:GetService("Lighting").Ambient
			if not _G.FullBrightEnabled then
				repeat
					wait()
				until _G.FullBrightEnabled
			end
			game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
		end
	end)

	game:GetService("Lighting").Brightness = 1
	game:GetService("Lighting").ClockTime = 12
	game:GetService("Lighting").FogEnd = 786543
	game:GetService("Lighting").GlobalShadows = false
	game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)

	local LatestValue = true
	spawn(function()
		repeat
			wait()
		until _G.FullBrightEnabled
		while wait() do
			if _G.FullBrightEnabled ~= LatestValue then
				if not _G.FullBrightEnabled then
					game:GetService("Lighting").Brightness = _G.NormalLightingSettings.Brightness
					game:GetService("Lighting").ClockTime = _G.NormalLightingSettings.ClockTime
					game:GetService("Lighting").FogEnd = _G.NormalLightingSettings.FogEnd
					game:GetService("Lighting").GlobalShadows = _G.NormalLightingSettings.GlobalShadows
					game:GetService("Lighting").Ambient = _G.NormalLightingSettings.Ambient
				else
					game:GetService("Lighting").Brightness = 1
					game:GetService("Lighting").ClockTime = 12
					game:GetService("Lighting").FogEnd = 786543
					game:GetService("Lighting").GlobalShadows = false
					game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
				end
				LatestValue = not LatestValue
			end
		end
	end)
end

_G.FullBrightExecuted = true
_G.FullBrightEnabled = not _G.FullBrightEnabled
   end,
})

local PremiumButton = Tab:CreateButton({
   Name = "NoClip",
   Callback = function()
   local Noclip = nil
local Clip = nil

function noclip()
	Clip = false
	local function Nocl()
		if Clip == false and game.Players.LocalPlayer.Character ~= nil then
			for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
				if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
					v.CanCollide = false
				end
			end
		end
		wait(0.21) -- basic optimization
	end
	Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
end

function clip()
	if Noclip then Noclip:Disconnect() end
	Clip = true
end

noclip() -- to toggle noclip() and clip()
   end,
})

local PremiumButton = Tab:CreateButton({
   Name = "Click Tp[Q]",
   Callback = function()
plr = game.Players.LocalPlayer
 
hum = plr.Character.HumanoidRootPart
 
mouse = plr:GetMouse()
 
 
 
mouse.KeyDown:connect(function(key)
 
if key == "q" then
 
if mouse.Target then
 
hum.CFrame = CFrame.new(mouse.Hit.x, mouse.Hit.y + 5, mouse.Hit.z)
 
end
 
end
end)
   end,
})

local Tab = Window:CreateTab("Credits", nil) -- Title, Image
local CreditsSection = Tab:CreateSection("Credits")
local Button = Tab:CreateButton({
   Name = "Discord Server",
   Callback = function()
   setclipbord("https://discord.gg/Mk22HEzEEu")
   end,
})
