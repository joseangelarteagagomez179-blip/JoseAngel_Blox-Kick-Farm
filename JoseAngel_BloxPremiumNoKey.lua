-- ==========================================
-- Script: JoseAngel_Blox premium no key
-- Creador: JoseAngel_Blox
-- Versión: 2.2 | Fecha: 02/08/2026
-- UPDATE: Añadido Auto Collect Cash con ForcedTP + Fix de fondo rbxthumb
-- ==========================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

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
getgenv().AutoCollectCash = false
getgenv().IntervaloX2 = 1

local lockedPlot = nil -- Guarda la parcela (plot) donde estás

-- ==========================================
-- 2. FUNCIONES DE AUTOCLICK Y AUTOCOLLECT
-- ==========================================

-- A) AUTO CLICK X2 (Conexiones remotas de interfaz)
local function clickBonus(bonus)
    if not bonus then return end
    
    if bonus:GetAttribute("AutoClicked") then return end
    bonus:SetAttribute("AutoClicked", true)
    
    task.spawn(function()
        task.wait(0.2)
        
        local imgLabel = bonus:FindFirstChild("ImageLabel")
        local targets = {bonus}
        if imgLabel then table.insert(targets, imgLabel) end
        
        if getconnections then
            for _, target in pairs(targets) do
                pcall(function()
                    for _, conn in pairs(getconnections(target.InputBegan)) do
                        conn:Fire({UserInputType = Enum.UserInputType.MouseButton1, UserInputState = Enum.UserInputState.Begin})
                        conn:Fire({UserInputType = Enum.UserInputType.Touch, UserInputState = Enum.UserInputState.Begin})
                    end
                end)
                pcall(function()
                    for _, conn in pairs(getconnections(target.MouseButton1Down)) do
                        conn:Fire()
                    end
                end)
                pcall(function()
                    for _, conn in pairs(getconnections(target.MouseButton1Up)) do
                        conn:Fire()
                    end
                end)
                pcall(function()
                    for _, conn in pairs(getconnections(target.MouseButton1Click)) do
                        conn:Fire()
                    end
                end)
                pcall(function()
                    for _, conn in pairs(getconnections(target.Activated)) do
                        conn:Fire()
                    end
                end)
            end
        end
    end)
end

local function startAutoClickX2()
    task.spawn(function()
        while getgenv().AutoClickX2 do
            pcall(function()
                local kickUpgrades = PlayerGui:FindFirstChild("KickUpgrades")
                if kickUpgrades then
                    for _, bonus in pairs(kickUpgrades:GetChildren()) do
                        if (bonus.Name == "Bonus" or bonus.Name == "PopBonus") and bonus.Visible then
                            clickBonus(bonus)
                        else
                            bonus:SetAttribute("AutoClicked", nil)
                        end
                    end
                end
            end)
            task.wait(0.1)
        end
    end)
end

-- B) AUTO COLLECT CASH (TP Forzado + Remotos de recolección)
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
-- 3. CREACIÓN DE LA INTERFAZ (GUI COMPACTA CON FONDO)
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

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

-- ==========================================
-- 3.1 IMAGEN DE FONDO (RBXTHUMB FIX)
-- ==========================================
local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.Position = UDim2.new(0, 0, 0, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = "rbxthumb://type=Asset&id=130801971957660&w=720&h=720"
BackgroundImage.ScaleType = Enum.ScaleType.Crop
BackgroundImage.ImageTransparency = 0
BackgroundImage.ZIndex = 1
BackgroundImage.Parent = MainFrame

local BgCorner = Instance.new("UICorner")
BgCorner.CornerRadius = UDim.new(0, 14)
BgCorner.Parent = BackgroundImage

local DarkOverlay = Instance.new("Frame")
DarkOverlay.Size = UDim2.new(1, 0, 1, 0)
DarkOverlay.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
DarkOverlay.BackgroundTransparency = 0.45
DarkOverlay.ZIndex = 2
DarkOverlay.Parent = MainFrame

local OverlayCorner = Instance.new("UICorner")
OverlayCorner.CornerRadius = UDim.new(0, 14)
OverlayCorner.Parent = DarkOverlay

-- ==========================================
-- 4. CABECERA (TÍTULO RAINBOW)
-- ==========================================
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

-- ==========================================
-- 5. PESTAÑAS Y CONTENEDORES
-- ==========================================
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
MainPage.CanvasSize = UDim2.new(0, 0, 0, 360) -- Ampliado para que quepan todos los botones
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

-- ==========================================
-- 6. CONTENIDO INFORMACIÓN
-- ==========================================
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
InfoText.Text = "Nombre del Creador: JoseAngel_Blox\n\n" ..
                "Fecha de lanzamiento: 02/08/2026\n\n" ..
                "Versión: 2.2\n\n" ..
                "UPDATE: Auto Collect Cash con ForcedTP + Auto Click x2 con getconnections integrados en un diseño Pro con fondo personalizado."
InfoText.Parent = InfoPage

-- ==========================================
-- 7. GENERADOR DE TOGGLES ANIMADOS (PRO)
-- ==========================================
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
-- 8. REGISTRO DE TOGGLES Y SELECTORES
-- ==========================================

-- 1) Auto Kick
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

-- 2) Auto Farm (Safe Zone)
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
                            else
                                local parte = safeZone:FindFirstChildWhichIsA("BasePart", true)
                                if parte then
                                    char.Humanoid:MoveTo(parte.Position)
                                end
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

-- 3) Multiplier x2
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

-- 4) Auto Click x2 (Bonuses)
createToggle("Auto Click x2 (Bonuses)", 132, function(state)
    getgenv().AutoClickX2 = state
    if state then
        startAutoClickX2()
    end
end)

-- 5) Auto Collect Cash (¡NUEVO!)
createToggle("Auto Collect Cash", 176, function(state)
    getgenv().AutoCollectCash = state
    if state then
        startAutoCollectCash()
    end
end)

-- 6) Selector de Velocidad para Auto Farm
local opcionesVelocidad = {
    {"Velocidad Farm: 200", 200},
    {"Velocidad Farm: 500", 500},
    {"Velocidad Farm: 1000", 1000},
    {"Velocidad Farm: 1500", 1500}
}
local indiceVel = 2

local SpeedSelectorBtn = Instance.new("TextButton")
SpeedSelectorBtn.Size = UDim2.new(1, 0, 0, 34)
SpeedSelectorBtn.Position = UDim2.new(0, 0, 0, 224)
SpeedSelectorBtn.BackgroundColor3 = Color3.fromRGB(75, 45, 85)
SpeedSelectorBtn.Text = "Auto Farm -> Velocidad: 500"
SpeedSelectorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedSelectorBtn.Font = Enum.Font.GothamBold
SpeedSelectorBtn.TextSize = 12
SpeedSelectorBtn.ZIndex = 4
SpeedSelectorBtn.Parent = MainPage
Instance.new("UICorner", SpeedSelectorBtn).CornerRadius = UDim.new(0, 8)

SpeedSelectorBtn.MouseButton1Click:Connect(function()
    indiceVel = indiceVel + 1
    if indiceVel > #opcionesVelocidad then
        indiceVel = 1
    end
    getgenv().VelocidadFarm = opcionesVelocidad[indiceVel][2]
    SpeedSelectorBtn.Text = "Auto Farm -> " .. opcionesVelocidad[indiceVel][1]
end)

-- 7) Selector de Frecuencia para Check X2
local opcionesTiempo = {
    {"0.1 segundo (Rápido)", 0.1},
    {"1 segundo", 1},
    {"5 segundos", 5},
    {"10 segundos", 10}
}
local indiceTiempo = 1

local TimeSelectorBtn = Instance.new("TextButton")
TimeSelectorBtn.Size = UDim2.new(1, 0, 0, 34)
TimeSel
