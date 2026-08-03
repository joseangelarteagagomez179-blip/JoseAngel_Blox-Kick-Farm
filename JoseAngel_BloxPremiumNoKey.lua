-- =========================================================================
-- Script: JoseAngel_Blox premium no key
-- Creador: JoseAngel_Blox
-- Versión: 3.1 | Fecha: 03/08/2026
-- UPDATE: Auto Farm usa la velocidad natural del juego + Pestaña Player
-- =========================================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer

-- =========================================================================
-- 1. CACHÉ DE REMOTOS Y VARIABLES GLOBALES
-- =========================================================================
local Network = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network")
local KickEvent = Network:WaitForChild("rev_KickEvent")
local MultiplierEvent = Network:WaitForChild("rev_TaviMishkal")
local CollectEvent = Network:WaitForChild("rev_B_Collect")
local kickArgs = {1, 1}

getgenv().AutoKick = false
getgenv().AutoFarm = false
getgenv().MultiplierX2 = false
getgenv().AutoTrain = false
getgenv().AutoCollectCash = false
getgenv().InfiniteJump = false
getgenv().ShowFPS = false

local lockedPlot = nil
local trainTick = 0

-- Lista de pesas válidas para el Auto Train
local validWeights = {
    ["Wooden Stick"] = true, ["Copper Plate"] = true, ["Stone Block"] = true,
    ["Bone Barbell"] = true, ["Donut Barbell"] = true, ["Ice Barbell"] = true,
    ["Iron Plate"] = true, ["Heaven Plate"] = true, ["Gold Barbell"] = true,
    ["Golden Barbell"] = true, ["Giant Gold Star Barbell"] = true, ["Neon Pulse"] = true,
    ["Mega Gold Barbell"] = true, ["Mega Golden Barbell"] = true, ["Emerald Barbell"] = true,
    ["Planet Barbell"] = true
}

-- =========================================================================
-- 2. FUNCIONES PRINCIPALES (FARM Y PLAYER)
-- =========================================================================

-- A) AUTO TRAIN
local function startAutoTrain()
    trainTick = trainTick + 1
    local currentTick = trainTick

    task.spawn(function()
        while getgenv().AutoTrain and (currentTick == trainTick) do
            pcall(function()
                local char = LocalPlayer.Character
                local hum = char and char:FindFirstChild("Humanoid")
                local backpack = LocalPlayer:FindFirstChild("Backpack")
                local currentTool = char and char:FindFirstChildOfClass("Tool")
                local isHoldingValidWeight = currentTool and validWeights[currentTool.Name]

                if not isHoldingValidWeight then
                    if currentTool and hum then hum:UnequipTools() end
                    task.wait(0.1)
                    if not (char and char:FindFirstChildOfClass("Tool")) and backpack and hum then
                        for _, tool in pairs(backpack:GetChildren()) do
                            if tool:IsA("Tool") and validWeights[tool.Name] then
                                hum:EquipTool(tool)
                                break
                            end
                        end
                    end
                else
                    if currentTool then
                        currentTool:Activate()
                    end
                end
            end)
            task.wait(0.15)
        end
    end)
end

-- B) AUTO COLLECT CASH
local function ForcedTP(targetCFrame)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.Velocity = Vector3.new(0, 0, 0)
        hrp.CFrame = targetCFrame
    end
end

local function collectCash()
    if not lockedPlot then
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local closestDist = math.huge
            for _, plot in pairs(Workspace:WaitForChild("Plots"):GetChildren()) do
                if (plot:IsA("Model") or plot:IsA("Folder")) then
                    local dist = (hrp.Position - plot:GetPivot().Position).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        lockedPlot = plot
                    end
                end
            end
        end
    end

    if lockedPlot then
        local buttonsFolder = lockedPlot:FindFirstChild("Buttons")
        if buttonsFolder then
            for i = 1, 30 do
                if not getgenv().AutoCollectCash then break end
                local slotPart = buttonsFolder:FindFirstChild("Slot" .. i)
                if slotPart then
                    local targetCFrame
                    if slotPart:IsA("BasePart") then
                        targetCFrame = slotPart.CFrame
                    elseif (slotPart:IsA("Model") and slotPart.PrimaryPart) then
                        targetCFrame = slotPart.PrimaryPart.CFrame
                    elseif slotPart:FindFirstChildWhichIsA("BasePart") then
                        targetCFrame = slotPart:FindFirstChildWhichIsA("BasePart").CFrame
                    end
                    
                    if targetCFrame then
                        pcall(function()
                            ForcedTP(targetCFrame + Vector3.new(0, 1.5, 0))
                            task.wait(0.1)
                            CollectEvent:FireServer(i)
                        end)
                    end
                end
            end
        end
    end
end

local function startAutoCollectCash()
    task.spawn(function()
        while getgenv().AutoCollectCash do
            pcall(collectCash)
            task.wait(1.5)
        end
    end)
end

-- C) INFINITE JUMP
UserInputService.JumpRequest:Connect(function()
    if getgenv().InfiniteJump then
        pcall(function()
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end)

-- D) ANTI LAG
local function activarAntiLag()
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.Brightness = 2
        for _, effect in pairs(Lighting:GetChildren()) do
            if effect:IsA("PostProcessingEffect") or effect:IsA("BloomEffect") or effect:IsA("SunRaysEffect") or effect:IsA("BlurEffect") then
                effect.Enabled = false
            end
        end
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.SmoothPlastic
                obj.Reflectance = 0
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj.Transparency = 1
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                obj.Enabled = false
            end
        end
    end)
end

-- =========================================================================
-- 3. INTERFAZ GRÁFICA (CON BOTÓN ON/OFF Y NUEVA PESTAÑA PLAYER)
-- =========================================================================
if CoreGui:FindFirstChild("JoseAngel_Blox_GUI") then
    CoreGui.JoseAngel_Blox_GUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_GUI"
ScreenGui.Parent = CoreGui

-- Botón Flotante para Activar/Desactivar Menú en Celular (Arriba a la Derecha)
local ToggleMenuBtn = Instance.new("TextButton")
ToggleMenuBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleMenuBtn.Position = UDim2.new(1, -60, 0, 15)
ToggleMenuBtn.BackgroundColor3 = Color3.fromRGB(45, 200, 75)
ToggleMenuBtn.Text = "JA"
ToggleMenuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleMenuBtn.Font = Enum.Font.GothamBold
ToggleMenuBtn.TextSize = 16
ToggleMenuBtn.ZIndex = 10
ToggleMenuBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleMenuBtn).CornerRadius = UDim.new(0, 10)

-- Contador de FPS Flotante
local FPSLabel = Instance.new("TextLabel")
FPSLabel.Size = UDim2.new(0, 80, 0, 25)
FPSLabel.Position = UDim2.new(1, -150, 0, 25)
FPSLabel.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
FPSLabel.BackgroundTransparency = 0.3
FPSLabel.Text = "FPS: 60"
FPSLabel.TextColor3 = Color3.fromRGB(100, 255, 120)
FPSLabel.Font = Enum.Font.GothamBold
FPSLabel.TextSize = 13
FPSLabel.Visible = false
FPSLabel.ZIndex = 10
FPSLabel.Parent = ScreenGui
Instance.new("UICorner", FPSLabel).CornerRadius = UDim.new(0, 6)

local lastUpdate = tick()
local frameCount = 0
RunService.RenderStepped:Connect(function()
    if getgenv().ShowFPS then
        frameCount = frameCount + 1
        local now = tick()
        if now - lastUpdate >= 0.5 then
            local fps = math.floor(frameCount / (now - lastUpdate))
            FPSLabel.Text = "FPS: " .. tostring(fps)
            frameCount = 0
            lastUpdate = now
        end
    end
end)

-- Marco Principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 430, 0, 320)
MainFrame.Position = UDim2.new(0.5, -215, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

-- Lógica del botón Toggle Menu
local menuVisible = true
ToggleMenuBtn.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    MainFrame.Visible = menuVisible
    ToggleMenuBtn.BackgroundColor3 = menuVisible and Color3.fromRGB(45, 200, 75) or Color3.fromRGB(190, 45, 45)
end)

-- Imagen de fondo
local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = "rbxthumb://type=Asset&id=130801971957660&w=700&h=700"
BackgroundImage.ScaleType = Enum.ScaleType.Crop
BackgroundImage.ZIndex = 1
BackgroundImage.Parent = MainFrame
Instance.new("UICorner", BackgroundImage).CornerRadius = UDim.new(0, 14)

local DarkOverlay = Instance.new("Frame")
DarkOverlay.Size = UDim2.new(1, 0, 1, 0)
DarkOverlay.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
DarkOverlay.BackgroundTransparency = 0.45
DarkOverlay.ZIndex = 2
DarkOverlay.Parent = MainFrame
Instance.new("UICorner", DarkOverlay).CornerRadius = UDim.new(0, 14)

-- Cabecera
local HeaderFrame = Instance.new("Frame")
HeaderFrame.Size = UDim2.new(1, 0, 0, 50)
HeaderFrame.BackgroundTransparency = 1
HeaderFrame.ZIndex = 3
HeaderFrame.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 28)
TitleLabel.Position = UDim2.new(0, 0, 0, 4)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "JoseAngel_Blox premium no key"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 18
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.ZIndex = 3
TitleLabel.Parent = HeaderFrame

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Parent = TitleLabel

task.spawn(function()
    local offsetHue = 0
    while task.wait() do
        offsetHue = (offsetHue + 0.006) % 1
        local keypoints = {}
        for i = 0, 10 do
            local time = i / 10
            local hue = (time + offsetHue) % 1
            table.insert(keypoints, ColorSequenceKeypoint.new(time, Color3.fromHSV(hue, 0.85, 1)))
        end
        TitleGradient.Color = ColorSequence.new(keypoints)
    end
end)

local SubTitleLabel = Instance.new("TextLabel")
SubTitleLabel.Size = UDim2.new(1, 0, 0, 18)
SubTitleLabel.Position = UDim2.new(0, 0, 0, 28)
SubTitleLabel.BackgroundTransparency = 1
SubTitleLabel.Text = "Creado por JoseAngel_Blox | v3.1 Mobile"
SubTitleLabel.TextColor3 = Color3.fromRGB(190, 190, 200)
SubTitleLabel.Font = Enum.Font.Gotham
SubTitleLabel.TextSize = 12
SubTitleLabel.ZIndex = 3
SubTitleLabel.Parent = HeaderFrame

-- Contenedores
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 110, 1, -60)
TabContainer.Position = UDim2.new(0, 10, 0, 55)
TabContainer.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
TabContainer.BackgroundTransparency = 0.25
TabContainer.ZIndex = 3
TabContainer.Parent = MainFrame
Instance.new("UICorner", TabContainer).CornerRadius = UDim.new(0, 10)

local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -140, 1, -60)
ContentContainer.Position = UDim2.new(0, 130, 0, 55)
ContentContainer.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
ContentContainer.BackgroundTransparency = 0.25
ContentContainer.ZIndex = 3
ContentContainer.Parent = MainFrame
Instance.new("UICorner", ContentContainer).CornerRadius = UDim.new(0, 10)

-- Páginas (Info, Main, Player)
local InfoPage = Instance.new("ScrollingFrame")
InfoPage.Size = UDim2.new(1, -16, 1, -16)
InfoPage.Position = UDim2.new(0, 8, 0, 8)
InfoPage.BackgroundTransparency = 1
InfoPage.Visible = true
InfoPage.ScrollBarThickness = 3
InfoPage.ZIndex = 4
InfoPage.Parent = ContentContainer

local MainPage = Instance.new("ScrollingFrame")
MainPage.Size = UDim2.new(1, -16, 1, -16)
MainPage.Position = UDim2.new(0, 8, 0, 8)
MainPage.BackgroundTransparency = 1
MainPage.Visible = false
MainPage.ScrollBarThickness = 3
MainPage.CanvasSize = UDim2.new(0, 0, 0, 280)
MainPage.ZIndex = 4
MainPage.Parent = ContentContainer

local PlayerPage = Instance.new("ScrollingFrame")
PlayerPage.Size = UDim2.new(1, -16, 1, -16)
PlayerPage.Position = UDim2.new(0, 8, 0, 8)
PlayerPage.BackgroundTransparency = 1
PlayerPage.Visible = false
PlayerPage.ScrollBarThickness = 3
PlayerPage.CanvasSize = UDim2.new(0, 0, 0, 180)
PlayerPage.ZIndex = 4
PlayerPage.Parent = ContentContainer

local function switchTab(tab)
    InfoPage.Visible = (tab == "Info")
    MainPage.Visible = (tab == "Main")
    PlayerPage.Visible = (tab == "Player")
end

-- Botones de Pestaña
local InfoBtn = Instance.new("TextButton")
InfoBtn.Size = UDim2.new(1, -16, 0, 32)
InfoBtn.Position = UDim2.new(0, 8, 0, 10)
InfoBtn.BackgroundColor3 = Color3.fromRGB(48, 48, 62)
InfoBtn.Text = "Info"
InfoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoBtn.Font = Enum.Font.GothamBold
InfoBtn.TextSize = 13
InfoBtn.ZIndex = 4
InfoBtn.Parent = TabContainer
Instance.new("UICorner", InfoBtn).CornerRadius = UDim.new(0, 8)
InfoBtn.MouseButton1Click:Connect(function() switchTab("Info") end)

local MainBtn = Instance.new("TextButton")
MainBtn.Size = UDim2.new(1, -16, 0, 32)
MainBtn.Position = UDim2.new(0, 8, 0, 50)
MainBtn.BackgroundColor3 = Color3.fromRGB(48, 48, 62)
MainBtn.Text = "Main"
MainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MainBtn.Font = Enum.Font.GothamBold
MainBtn.TextSize = 13
MainBtn.ZIndex = 4
MainBtn.Parent = TabContainer
Instance.new("UICorner", MainBtn).CornerRadius = UDim.new(0, 8)
MainBtn.MouseButton1Click:Connect(function() switchTab("Main") end)

local PlayerBtn = Instance.new("TextButton")
PlayerBtn.Size = UDim2.new(1, -16, 0, 32)
PlayerBtn.Position = UDim2.new(0, 8, 0, 90)
PlayerBtn.BackgroundColor3 = Color3.fromRGB(48, 48, 62)
PlayerBtn.Text = "Player"
PlayerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerBtn.Font = Enum.Font.GothamBold
PlayerBtn.TextSize = 13
PlayerBtn.ZIndex = 4
PlayerBtn.Parent = TabContainer
Instance.new("UICorner", PlayerBtn).CornerRadius = UDim.new(0, 8)
PlayerBtn.MouseButton1Click:Connect(function() switchTab("Player") end)

-- Texto en Info
local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(1, 0, 1, 0)
InfoText.BackgroundTransparency = 1
InfoText.TextXAlignment = Enum.TextXAlignment.Left
InfoText.TextYAlignment = Enum.TextYAlignment.Top
InfoText.TextColor3 = Color3.fromRGB(230, 230, 240)
InfoText.Font = Enum.Font.Gotham
InfoText.TextSize = 12
InfoText.TextWrapped = true
InfoText.ZIndex = 4
InfoText.Text = "Creador: JoseAngel_Blox\n\nVersión: 3.1 Mobile\n\n- Auto Farm usa tu velocidad natural del juego.\n- Botón 'JA' en pantalla para ocultar/mostrar la GUI.\n- Pestaña 'Player' con Anti Lag, Infinite Jump y Mostrar FPS."
InfoText.Parent = InfoPage

-- Generador de Toggles Universal
local function createToggle(parentPage, name, posY, callback)
    local container = Instance.new("TextButton")
    container.Size = UDim2.new(1, -1, 0, 38)
    container.Position = UDim2.new(0, 0, 0, posY)
    container.BackgroundColor3 = Color3.fromRGB(42, 42, 54)
    container.BackgroundTransparency = 0.15
    container.Text = ""
    container.AutoButtonColor = false
    container.ZIndex = 4
    container.Parent = parentPage
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 8)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -65, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(230, 230, 230)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 5
    label.Parent = container
    
    local switchBG = Instance.new("Frame")
    switchBG.Size = UDim2.new(0, 46, 0, 24)
    switchBG.Position = UDim2.new(1, -56, 0.5, -12)
    switchBG.BackgroundColor3 = Color3.fromRGB(190, 45, 45)
    switchBG.ZIndex = 5
    switchBG.Parent = container
    Instance.new("UICorner", switchBG).CornerRadius = UDim.new(1, 0)
    
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new(0, 3, 0.5, -9)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.ZIndex = 6
    knob.Parent = switchBG
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    
    local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local state = false
    
    container.MouseButton1Click:Connect(function()
        state = not state
        if state then
            TweenService:Create(switchBG, tweenInfo, {BackgroundColor3 = Color3.fromRGB(45, 200, 75)}):Play()
            TweenService:Create(knob, tweenInfo, {Position = UDim2.new(1, -21, 0.5, -9)}):Play()
            label.TextColor3 = Color3.fromRGB(100, 255, 120)
        else
            TweenService:Create(switchBG, tweenInfo, {BackgroundColor3 = Color3.fromRGB(190, 45, 45)}):Play()
            TweenService:Create(knob, tweenInfo, {Position = UDim2.new(0, 3, 0.5, -9)}):Play()
            label.TextColor3 = Color3.fromRGB(230, 230, 230)
        end
        callback(state)
    end)
    
    return container
end

-- =========================================================================
-- 4. REGISTRO DE BOTONES EN PESTAÑA MAIN
-- =========================================================================

createToggle(MainPage, "Auto Kick", 0, function(state)
    getgenv().AutoKick = state
    if state then
        task.spawn(function()
            while getgenv().AutoKick do
                pcall(function() KickEvent:FireServer(unpack(kickArgs)) end)
                task.wait(0.05)
            end
        end)
    end
end)

createToggle(MainPage, "Auto Farm (Safe Zone)", 44, function(state)
    getgenv().AutoFarm = state
    if state then
        task.spawn(function()
            while getgenv().AutoFarm do
                pcall(function()
                    KickEvent:FireServer(unpack(kickArgs))
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("Humanoid") then
                        -- Corremos con la velocidad natural que tenga tu personaje en ese momento
                        local areas = Workspace:FindFirstChild("Areas")
                        if areas and areas:FindFirstChild("KickReady") then
                            local safeZone = areas.KickReady
                            if safeZone:IsA("BasePart") then
                                char.
