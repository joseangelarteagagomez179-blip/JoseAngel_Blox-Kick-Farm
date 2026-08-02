-- ==========================================
-- Script: JoseAngel_Blox premium no key
-- Creador: JoseAngel_Blox
-- Versión: 1.5 | Fecha: 02/08/2026
-- UPDATE: Título Rainbow multicolor en ola + todas las funciones optimizadas
-- ==========================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- 1. CACHÉ DE REMOTOS (AUTO KICK & MULTIPLIER)
-- ==========================================
local Network = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network")
local KickEvent = Network:WaitForChild("rev_KickEvent")
local MultiplierEvent = Network:WaitForChild("rev_TaviMishkal")
local kickArgs = {1, 1}

-- Variables de control globales
getgenv().AutoKick = false
getgenv().AutoFarm1000 = false
getgenv().MultiplierX2 = false
getgenv().AutoClickX2 = false
getgenv().IntervaloX2 = 1 -- Segundos por defecto (1 segundo)

-- ==========================================
-- 2. FUNCIÓN PARA RECLAMAR TODOS LOS BOTONES MORADOS X2
-- ==========================================
local function reclamarTodosLosBotonesX2()
    pcall(function()
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
        if not playerGui then return end
        
        for _, elemento in pairs(playerGui:GetDescendants()) do
            if (elemento:IsA("ImageButton") or elemento:IsA("TextButton")) and elemento.Visible then
                local nombre = string.lower(elemento.Name)
                local texto = string.lower(elemento.Text or "")
                
                if string.find(nombre, "x2") or string.find(texto, "x2") or string.find(nombre, "multiplier") or string.find(nombre, "claim") or string.find(nombre, "boost") then
                    pcall(function()
                        elemento:Activate()
                    end)
                    
                    pcall(function()
                        if firesignal then
                            firesignal(elemento.MouseButton1Click)
                            firesignal(elemento.Activated)
                        end
                    end)
                end
            end
        end
    end)
end

-- ==========================================
-- 3. CREACIÓN DE LA INTERFAZ (GUI COMPACTA)
-- ==========================================
if CoreGui:FindFirstChild("JoseAngel_Blox_GUI") then
    CoreGui.JoseAngel_Blox_GUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_GUI"
ScreenGui.Parent = CoreGui

-- Marco Principal (Cuadrado Pequeño con Esquinas Redondeadas)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 310)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -155)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

-- ==========================================
-- 4. CABECERA (TÍTULO RAINBOW MULTICOLOR EN OLA & SUBTÍTULO)
-- ==========================================
local HeaderFrame = Instance.new("Frame")
HeaderFrame.Size = UDim2.new(1, 0, 0, 50)
HeaderFrame.BackgroundTransparency = 1
HeaderFrame.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 28)
TitleLabel.Position = UDim2.new(0, 0, 0, 4)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "JoseAngel_Blox premium no key"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 18
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Blanco para que el gradiente se note puro
TitleLabel.Parent = HeaderFrame

-- UIGradient para el efecto Arcoíris real en las letras
local TitleGradient = Instance.new("UIGradient")
TitleGradient.Parent = TitleLabel

-- Animación de Ola Arcoíris continua (desplaza múltiples colores de izquierda a derecha)
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
SubTitleLabel.TextColor3 = Color3.fromRGB(170, 170, 180)
SubTitleLabel.Font = Enum.Font.Gotham
SubTitleLabel.TextSize = 12
SubTitleLabel.Parent = HeaderFrame

-- ==========================================
-- 5. PESTAÑAS (IZQUIERDA) Y CONTENEDORES (DERECHA)
-- ==========================================
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 110, 1, -60)
TabContainer.Position = UDim2.new(0, 10, 0, 55)
TabContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
TabContainer.Parent = MainFrame

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 10)
TabCorner.Parent = TabContainer

local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -140, 1, -60)
ContentContainer.Position = UDim2.new(0, 130, 0, 55)
ContentContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
ContentContainer.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = ContentContainer

local InfoPage = Instance.new("ScrollingFrame")
InfoPage.Size = UDim2.new(1, -16, 1, -16)
InfoPage.Position = UDim2.new(0, 8, 0, 8)
InfoPage.BackgroundTransparency = 1
InfoPage.Visible = true
InfoPage.ScrollBarThickness = 3
InfoPage.Parent = ContentContainer

local MainPage = Instance.new("ScrollingFrame")
MainPage.Size = UDim2.new(1, -16, 1, -16)
MainPage.Position = UDim2.new(0, 8, 0, 8)
MainPage.BackgroundTransparency = 1
MainPage.Visible = false
MainPage.ScrollBarThickness = 3
MainPage.CanvasSize = UDim2.new(0, 0, 0, 260)
MainPage.Parent = ContentContainer

local function switchTab(tab)
    InfoPage.Visible = (tab == "Info")
    MainPage.Visible = (tab == "Main")
end

local InfoBtn = Instance.new("TextButton")
InfoBtn.Size = UDim2.new(1, -16, 0, 35)
InfoBtn.Position = UDim2.new(0, 8, 0, 10)
InfoBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
InfoBtn.Text = "Info"
InfoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoBtn.Font = Enum.Font.GothamBold
InfoBtn.TextSize = 14
InfoBtn.Parent = TabContainer
Instance.new("UICorner", InfoBtn).CornerRadius = UDim.new(0, 8)
InfoBtn.MouseButton1Click:Connect(function() switchTab("Info") end)

local MainBtn = Instance.new("TextButton")
MainBtn.Size = UDim2.new(1, -16, 0, 35)
MainBtn.Position = UDim2.new(0, 8, 0, 55)
MainBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
MainBtn.Text = "Main"
MainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MainBtn.Font = Enum.Font.GothamBold
MainBtn.TextSize = 14
MainBtn.Parent = TabContainer
Instance.new("UICorner", MainBtn).CornerRadius = UDim.new(0, 8)
MainBtn.MouseButton1Click:Connect(function() switchTab("Main") end)

-- ==========================================
-- 6. CONTENIDO DE PESTAÑA: INFO
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
InfoText.Text = "Nombre del Creador: JoseAngel_Blox\n\n" ..
                "Fecha de lanzamiento: 02/08/2026\n\n" ..
                "Versión: 1.5\n\n" ..
                "UPDATE: Script Premium gratis 100%funcional compartible para celular y PC 0 Bugs espero y te guste el script."
InfoText.Parent = InfoPage

-- ==========================================
-- 7. CONTENIDO DE PESTAÑA: MAIN (FUNCIONES)
-- ==========================================
local function createButton(name, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.Position = UDim2.new(0, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
    btn.Text = name .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(255, 100, 100)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Parent = MainPage
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            btn.Text = name .. " [ON]"
            btn.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            btn.Text = name .. " [OFF]"
            btn.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
        callback(state)
    end)
    return btn
end

-- 1) Auto Kick
createButton("Auto Kick", 0, function(state)
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

-- 2) Auto Farm con 1000 de velocidad (Correr a Safe Zone: KickReady)
createButton("Auto Farm (1000 Vel)", 40, function(state)
    getgenv().AutoFarm1000 = state
    if state then
        task.spawn(function()
            while getgenv().AutoFarm1000 do
                pcall(function()
                    KickEvent:FireServer(unpack(kickArgs))
                    
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
                        char.Humanoid.WalkSpeed = 1000
                        
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
                task.wait(0.1)
            end
        end)
    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

-- 3) Multiplier x2 (rev_TaviMishkal)
createButton("Multiplier x2", 80, function(state)
    getgenv().MultiplierX2 = state
    if state then
        task.spawn(function()
            while getgenv().MultiplierX2 do
                pcall(function()
                    MultiplierEvent:FireServer()
                end)
                task.wait(2)
            end
        end)
    end
end)

-- 4) Auto Click x2 (RECLAMA TODOS LOS BOTONES MORADOS X2 DE LA PANTALLA)
createButton("Auto Click x2", 120, function(state)
    getgenv().AutoClickX2 = state
    if state then
        task.spawn(function()
            while getgenv().AutoClickX2 do
                reclamarTodosLosBotonesX2()
                task.wait(getgenv().IntervaloX2)
            end
        end)
    end
end)

-- 5) Lista/Selector de Tiempo para Auto Click x2
local opcionesTiempo = {
    {"1 segundo", 1},
    {"1 minuto", 60},
    {"2 minutos", 120},
    {"5 minutos", 300},
    {"10 minutos", 600}
}
local indiceActual = 1

local TimeSelectorBtn = Instance.new("TextButton")
TimeSelectorBtn.Size = UDim2.new(1, 0, 0, 32)
TimeSelectorBtn.Position = UDim2.new(0, 0, 0, 160)
TimeSelectorBtn.BackgroundColor3 = Color3.fromRGB(45, 80, 110)
TimeSelectorBtn.Text = "Tiempo Auto Click x2: 1 segundo"
TimeSelectorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TimeSelectorBtn.Font = Enum.Font.GothamBold
TimeSelectorBtn.TextSize = 12
TimeSelectorBtn.Parent = MainPage
Instance.new("UICorner", TimeSelectorBtn).CornerRadius = UDim.new(0, 6)

TimeSelectorBtn.MouseButton1Click:Connect(function()
    indiceActual = indiceActual + 1
    if indiceActual > #opcionesTiempo then
        indiceActual = 1
    end
    
    local nombreSeleccionado = opcionesTiempo[indiceActual][1]
    local segundosSeleccionados = opcionesTiempo[indiceActual][2]
    
    getgenv().IntervaloX2 = segundosSeleccionados
    TimeSelectorBtn.Text = "Tiempo Auto Click x2: " .. nombreSeleccionado
end)

print("[JoseAngel_Blox] Script cargado correctamente - v1.5")
