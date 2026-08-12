-- ==========================================
-- Script: JoseAngel_Blox premium no key
-- Versión: 1.2 (Script reparado corregido los Bugs y con más compatibilidad y optimización)
-- ==========================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- 1. CACHÉ DE REMOTOS Y VARIABLES (Seguro)
-- ==========================================
local Network = ReplicatedStorage:WaitForChild("Shared", 3) and ReplicatedStorage.Shared:WaitForChild("Packages", 3) and ReplicatedStorage.Shared.Packages:WaitForChild("Network", 3)

local KickEvent = Network and Network:WaitForChild("rev_KickEvent", 3)
local MultiplierEvent = Network and Network:WaitForChild("rev_TaviMishkal", 3)
local kickArgs = {1, 1}

-- Variables globales
getgenv().AutoKick = false
getgenv().AutoFarm = false
getgenv().VelocidadFarm = 500
getgenv().MultiplierX2 = false
getgenv().AutoCollectCash = false

-- Variables globales (Pestaña Player)
getgenv().InfiniteJump = false
getgenv().AntiLag = false
getgenv().ShowFPS = false

-- ==========================================
-- 2. AUTO COLLECT CASH
-- ==========================================
local lockedPlot = nil

local function ForcedTP(targetCFrame)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        hrp.CFrame = targetCFrame
    end
end

local function collectCash()
    if not lockedPlot then
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local closestDist = math.huge
            local plots = Workspace:FindFirstChild("Plots")
            if plots then
                for _, plot in pairs(plots:GetChildren()) do
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
    end

    if lockedPlot then
        local buttonsFolder = lockedPlot:FindFirstChild("Buttons")
        if buttonsFolder and Network and Network:FindFirstChild("rev_B_Collect") then
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
                            Network.rev_B_Collect:FireServer(i)
                        end)
                    end
                end
            end
        end
    end
end

-- ==========================================
-- 3. CREACIÓN DE LA GUI Y BOTÓN FLOTANTE
-- ==========================================
if CoreGui:FindFirstChild("JoseAngel_Blox_GUI") then
    CoreGui.JoseAngel_Blox_GUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_GUI"
ScreenGui.Parent = CoreGui

-- Botón Flotante para Abrir / Cerrar menú
local ToggleMenuBtn = Instance.new("TextButton")
ToggleMenuBtn.Name = "ToggleMenuBtn"
ToggleMenuBtn.Size = UDim2.new(0, 48, 0, 48)
ToggleMenuBtn.Position = UDim2.new(0, 15, 0, 85)
ToggleMenuBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
ToggleMenuBtn.Text = "JB"
ToggleMenuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleMenuBtn.Font = Enum.Font.GothamBold
ToggleMenuBtn.TextSize = 16
ToggleMenuBtn.Active = true
ToggleMenuBtn.Draggable = true
ToggleMenuBtn.ZIndex = 15
ToggleMenuBtn.Parent = ScreenGui

Instance.new("UICorner", ToggleMenuBtn).CornerRadius = UDim.new(1, 0)
local BtnStroke = Instance.new("UIStroke")
BtnStroke.Color = Color3.fromRGB(45, 200, 75)
BtnStroke.Thickness = 2.5
BtnStroke.Parent = ToggleMenuBtn

-- Marco Principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 430, 0, 320)
MainFrame.Position = UDim2.new(0.5, -215, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

-- Funcionalidad del Botón Flotante
ToggleMenuBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    if MainFrame.Visible then
        BtnStroke.Color = Color3.fromRGB(45, 200, 75)
    else
        BtnStroke.Color = Color3.fromRGB(190, 45, 45)
    end
end)

-- Fondo y Estética
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
TitleLabel.Text = "JoseAngel_Blox premium v1.2"
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
        offsetHue = (offsetHue + 0.020) % 1
        local keypoints = {}
        for i = 0, 10 do
            local time = i / 10
            local hue = (time + offsetHue) % 1
            table.insert(keypoints, ColorSequenceKeypoint.new(time, Color3.fromHSV(hue, 0.85, 1)))
        end
        TitleGradient.Color = ColorSequence.new(keypoints)
    end
end)

-- Contenedores de Pestañas
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

-- Páginas
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
MainPage.CanvasSize = UDim2.new(0, 0, 0, 200)
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

local function createTabButton(name, posY, tabName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -16, 0, 35)
    btn.Position = UDim2.new(0, 8, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(48, 48, 62)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.ZIndex = 4
    btn.Parent = TabContainer
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(function() switchTab(tabName) end)
end

createTabButton("Info", 10, "Info")
createTabButton("Main", 55, "Main")
createTabButton("Player", 100, "Player")

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
InfoText.Text = "Creador: JoseAngel_Blox\n\n" ..
                "Versión: 1.2\n\n" ..
                "Update: Script reparado corregido los Bugs y con más compatibilidad y optimización\n\n" ..
                "• Ejecutor compatible: Delta Executor."
InfoText.Parent = InfoPage

-- ==========================================
-- 4. GENERADOR DE TOGGLES
-- ==========================================
local function createToggle(parent, name, posY, callback)
    local container = Instance.new("TextButton")
    container.Size = UDim2.new(1, 0, 0, 38)
    container.Position = UDim2.new(0, 0, 0, posY)
    container.BackgroundColor3 = Color3.fromRGB(42, 42, 54)
    container.BackgroundTransparency = 0.15
    container.Text = ""
    container.AutoButtonColor = false
    container.ZIndex = 4
    container.Parent = parent
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
end

-- ==========================================
-- 5. TOGGLES: MAIN & PLAYER
-- ==========================================

createToggle(MainPage, "Auto Kick", 0, function(state)
    getgenv().AutoKick = state
    if state then
        task.spawn(function()
            while getgenv().AutoKick do
                pcall(function()
                    if KickEvent then KickEvent:FireServer(unpack(kickArgs)) end
                end)
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
                    if KickEvent then KickEvent:FireServer(unpack(kickArgs)) end
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("Humanoid") then
                        char.Humanoid.WalkSpeed = getgenv().VelocidadFarm
                        local areas = Workspace:FindFirstChild("Areas")
                        if areas and areas:FindFirstChild("KickReady") then
                            local safeZone = areas.KickReady
                            if safeZone:IsA("BasePart") then
                                char.Humanoid:MoveTo(safeZone.Position)
                            elseif safeZone:IsA("Model") and safeZone.PrimaryPart then
                                char.Humanoid:MoveTo(safeZone.PrimaryPart.Position)
                            end
                        end
                    end
                end)
                task.wait(0.05)
            end
        end)
    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

createToggle(MainPage, "Multiplier x2", 88, function(state)
    getgenv().MultiplierX2 = state
    if state then
        task.spawn(function()
            while getgenv().MultiplierX2 do
                pcall(function()
                    if MultiplierEvent then MultiplierEvent:FireServer() end
                end)
                task.wait(2)
            end
        end)
    end
end)

createToggle(MainPage, "Auto Collect Cash 💰", 132, function(state)
    getgenv().AutoCollectCash = state
    if state then
        task.spawn(function()
            while getgenv().AutoCollectCash do
                pcall(collectCash)
                task.wait(1.5)
            end
        end)
    else
        lockedPlot = nil
    end
end)

createToggle(PlayerPage, "Infinite Jump", 0, function(state)
    getgenv().InfiniteJump = state
end)

UserInputService.JumpRequest:Connect(function()
    if getgenv().InfiniteJump then
        local char = LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

createToggle(PlayerPage, "Anti Lag", 44, function(state)
    getgenv().AntiLag = state
    if state then
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Material = Enum.Material.SmoothPlastic
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
                    v.Enabled = false
                end
            end
        end)
    end
end)

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Name = "FPSDisplay"
fpsLabel.Size = UDim2.new(0, 90, 0, 26)
fpsLabel.Position = UDim2.new(0, 15, 0, 15)
fpsLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
fpsLabel.BackgroundTransparency = 0.3
fpsLabel.TextColor3 = Color3.fromRGB(100, 255, 120)
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 12
fpsLabel.Visible = false
fpsLabel.ZIndex = 10
fpsLabel.Parent = ScreenGui
Instance.new("UICorner", fpsLabel).CornerRadius = UDim.new(0, 6)

createToggle(PlayerPage, "Mostrar FPS", 88, function(state)
    getgenv().ShowFPS = state
    fpsLabel.Visible = state
end)

local lastTick = tick()
local frameCount = 0

RunService.RenderStepped:Connect(function()
    if getgenv().ShowFPS then
        frameCount = frameCount + 1
        local currentTick = tick()
        if currentTick - lastTick >= 1 then
            fpsLabel.Text = "FPS: " .. frameCount
            frameCount = 0
            lastTick = currentTick
        end
    end
end)
