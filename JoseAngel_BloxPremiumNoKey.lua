-- ==========================================
-- Script: JoseAngel_Blox premium no key
-- Creador: JoseAngel_Blox
-- Versión: 2.7 | Fecha: 02/08/2026
-- UPDATE: Fix de resolución (700x700) + VirtualInputManager (Simulación táctil para Delta)
-- ==========================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ==========================================
-- 1. CACHÉ DE REMOTOS Y VARIABLES GLOBALES
-- ==========================================
local Network = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network")
local KickEvent = Network:WaitForChild("rev_KickEvent")
local MultiplierEvent = Network:WaitForChild("rev_TaviMishkal")
local CollectEvent = Network:WaitForChild("rev_B_Collect")
local kickArgs = {1, 1}

getgenv().AutoKick = false
getgenv().AutoFarm = false
getgenv().VelocidadFarm = 500
getgenv().MultiplierX2 = false
getgenv().AutoClickX2 = false
getgenv().AutoTrainX2 = false
getgenv().AutoCollectCash = false

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

-- ==========================================
-- 2. FUNCIONES DE AUTOCLICK Y AUTOCOLLECT
-- ==========================================

-- Clic Universal (VirtualInputManager + getconnections para Móvil/Delta)
local function ForzarClicUI(target)
    if not target or not target:IsA("GuiObject") or not target.Visible then return end

    -- 1. Simular Toque Táctil Real en las coordenadas de la pantalla (100% compatible con Delta)
    pcall(function()
        local pos = target.AbsolutePosition
        local size = target.AbsoluteSize
        local centerX = pos.X + (size.X / 2)
        local centerY = pos.Y + (size.Y / 2)

        VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
        task.wait(0.02)
        VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
    end)

    -- 2. Disparar conexiones internas por si el juego usa señales directas
    if type(getconnections) == "function" then
        local eventos = {"Activated", "MouseButton1Click", "MouseButton1Down", "TouchTap"}
        for _, ev in pairs(eventos) do
            pcall(function()
                if target[ev] then
                    for _, conn in pairs(getconnections(target[ev])) do
                        conn:Fire()
                    end
                end
            end)
        end
        pcall(function()
            if target.InputBegan then
                for _, conn in pairs(getconnections(target.InputBegan)) do
                    conn:Fire({UserInputType = Enum.UserInputType.Touch, UserInputState = Enum.UserInputState.Begin})
                    conn:Fire({UserInputType = Enum.UserInputType.MouseButton1, UserInputState = Enum.UserInputState.Begin})
                end
            end
        end)
    end
end

local function procesarBonos()
    local kickUpgrades = PlayerGui:FindFirstChild("KickUpgrades")
    if kickUpgrades then
        for _, bonus in pairs(kickUpgrades:GetChildren()) do
            if (bonus.Name == "Bonus" or bonus.Name == "PopBonus") and bonus:IsA("GuiObject") and bonus.Visible then
                ForzarClicUI(bonus)
                for _, desc in pairs(bonus:GetDescendants()) do
                    if desc:IsA("GuiObject") and desc.Visible then
                        ForzarClicUI(desc)
                    end
                end
            end
        end
    end
end

-- A) AUTO CLICK X2 SOLO BONOS
local function startAutoClickX2()
    task.spawn(function()
        while getgenv().AutoClickX2 do
            pcall(procesarBonos)
            task.wait(0.25)
        end
    end)
end

-- B) AUTO TRAIN & X2 (Equipa pesa + Entrena + Clic a Bonos)
local function startAutoTrainX2()
    trainTick = trainTick + 1
    local currentTick = trainTick

    task.spawn(function()
        while getgenv().AutoTrainX2 and (currentTick == trainTick) do
            -- 1. Auto Equipar y Entrenar con Pesa
            pcall(function()
                local char = LocalPlayer.Character
                local hum = char and char:FindFirstChild("Humanoid")
                local backpack = LocalPlayer:FindFirstChild("Backpack")
                local currentTool = char and char:FindFirstChildOfClass("Tool")
                local isHoldingValidWeight = currentTool and validWeights[currentTool.Name]

                if not isHoldingValidWeight then
                    if currentTool and hum then hum:UnequipTools() end
                    
                    local slot1 = PlayerGui:FindFirstChild("Backpack") and PlayerGui.Backpack:FindFirstChild("Bar") and PlayerGui.Backpack.Bar:FindFirstChild("Slot1")
                    if slot1 then ForzarClicUI(slot1) end
                    task.wait(0.1)
                    
                    if not char:FindFirstChildOfClass("Tool") and backpack and hum then
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
                        if type(getconnections) == "function" then
                            for _, c in pairs(getconnections(currentTool.Activated)) do c:Fire() end
                        end
                    end
                end
            end)

            -- 2. Auto-click para los bonos de KickUpgrades
            pcall(procesarBonos)
            
            task.wait(0.15)
        end
    end)
end

-- C) AUTO COLLECT CASH
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

-- ==========================================
-- 3. CREACIÓN DE LA INTERFAZ
-- ==========================================
if CoreGui:FindFirstChild("JoseAngel_Blox_GUI") then
    CoreGui.JoseAngel_Blox_GUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_GUI"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 430, 0, 320)
MainFrame.Position = UDim2.new(0.5, -215, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

-- Imagen de fondo con resolución corregida (700x700 en lugar de 720x720)
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
SubTitleLabel.Text = "Creado por JoseAngel_Blox"
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
MainPage.CanvasSize = UDim2.new(0, 0, 0, 360)
MainPage.ZIndex = 4
MainPage.Parent = ContentContainer

local function switchTab(tab)
    InfoPage.Visible = (tab == "Info")
    MainPage.Visible = (tab == "Main")
end

local InfoBtn = Instance.new("TextButton")
InfoBtn.Size = UDim2.new(1, -16, 0, 35)
InfoBtn.Position = UDim2.new(0, 8, 0, 10)
InfoBtn.BackgroundColor3 = Color3.fromRGB(48, 48, 62)
InfoBtn.Text = "Info"
InfoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoBtn.Font = Enum.Font.GothamBold
InfoBtn.TextSize = 14
InfoBtn.ZIndex = 4
InfoBtn.Parent = TabContainer
Instance.new("UICorner", InfoBtn).CornerRadius = UDim.new(0, 8)
InfoBtn.MouseButton1Click:Connect(function() switchTab("Info") end)

local MainBtn = Instance.new("TextButton")
MainBtn.Size = UDim2.new(1, -16, 0, 35)
MainBtn.Position = UDim2.new(0, 8, 0, 55)
MainBtn.BackgroundColor3 = Color3.fromRGB(48, 48, 62)
MainBtn.Text = "Main"
MainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MainBtn.Font = Enum.Font.GothamBold
MainBtn.TextSize = 14
MainBtn.ZIndex = 4
MainBtn.Parent = TabContainer
Instance.new("UICorner", MainBtn).CornerRadius = UDim.new(0, 8)
MainBtn.MouseButton1Click:Connect(function() switchTab("Main") end)

-- Info Text
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
InfoText.Text = "Creador: JoseAngel_Blox\n\nVersión: 2.7\n\nUPDATE: Corregido error de miniatura en consola y agregado soporte táctil (VirtualInputManager) para Delta."
InfoText.Parent = InfoPage

-- Generador de Toggles
local function createToggle(name, posY, callback)
    local container = Instance.new("TextButton")
    container.Size = UDim2.new(1, 0, 0, 38)
    container.Position = UDim2.new(0, 0, 0, posY)
    container.BackgroundColor3 = Color3.fromRGB(42, 42, 54)
    container.BackgroundTransparency = 0.15
    container.Text = ""
    container.AutoButtonColor = false
    container.ZIndex = 4
    container.Parent = MainPage
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

-- ==========================================
-- 4. REGISTRO DE TOGGLES EN MAIN
-- ==========================================

createToggle("Auto Kick", 0, function(state)
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

createToggle("Auto Farm (Safe Zone)", 44, function(state)
    getgenv().AutoFarm = state
    if state then
        task.spawn(function()
            while getgenv().AutoFarm do
                pcall(function()
                    KickEvent:FireServer(unpack(kickArgs))
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

createToggle("Multiplier x2", 88, function(state)
    getgenv().MultiplierX2 = state
    if state then
        task.spawn(function()
            while getgenv().MultiplierX2 do
                pcall(function() MultiplierEvent:FireServer() end)
                task.wait(2)
            end
        end)
    end
end)

createToggle("Auto Click x2 (Bonos)", 132, function(state)
    getgenv().AutoClickX2 = state
    if state then
        startAutoClickX2()
    end
end)

createToggle("Auto Train & x2 (Pesas + Bonos)", 176, function(state)
    getgenv().AutoTrainX2 = state
    if state then
        startAutoTrainX2()
    end
end)

createToggle("Auto Collect Cash", 220, function(state)
    getgenv().AutoCollectCash = state
    if state then
        startAutoCollectCash()
    end
end)

print("[JoseAngel_B
