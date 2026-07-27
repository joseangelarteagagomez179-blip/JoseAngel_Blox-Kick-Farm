-- ⚡ JoseAngel_Blox Kick | Versión 1.1
-- 🎮 Juego: Kick-a-Lucky Block
-- ✅ Compatible: Móvil / PC / Delta Executor

-- Servicios
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local Character, Humanoid, RootPart

-- Crear Interfaz
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SubTitle = Instance.new("TextLabel")
local TabContainer = Instance.new("Frame")
local InfoTab = Instance.new("TextButton")
local MainTab = Instance.new("TextButton")
local PlayerTab = Instance.new("TextButton")
local ConfigTab = Instance.new("TextButton")
local ContentFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local UICorner = Instance.new("UICorner")

-- Configuración General
ScreenGui.Name = "JoseAngel_BloxKick"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
if gethui then ScreenGui.Parent = gethui() end -- Ocultar de desarrolladores

-- Marco Principal (Ancho y cuadrado con esquinas redondeadas)
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
MainFrame.BorderRadius = UDim.new(0, 16)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -220)
MainFrame.Size = UDim2.new(0, 400, 0, 440)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)

-- Título
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 15)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Font = Enum.Font.GothamBold
Title.Text = "JoseAngel_Blox Kick"
Title.TextColor3 = Color3.fromRGB(255, 210, 60)
Title.TextScaled = true

-- Subtítulo
SubTitle.Parent = MainFrame
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0, 0, 0, 48)
SubTitle.Size = UDim2.new(1, 0, 0, 22)
SubTitle.Font = Enum.Font.Gotham
SubTitle.Text = "Creado por JoseAngel_Blox"
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 200)
SubTitle.TextScaled = true

-- Pestañas
TabContainer.Parent = MainFrame
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 15, 0, 80)
TabContainer.Size = UDim2.new(1, -30, 0, 32)

local function CrearPestaña(nombre, pos)
    local btn = Instance.new("TextButton")
    btn.Parent = TabContainer
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
    btn.Position = UDim2.new(pos, 0, 0, 0)
    btn.Size = UDim2.new(0.23, 0, 1, 0)
    btn.Font = Enum.Font.GothamBold
    btn.Text = nombre
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.TextScaled = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end

InfoTab = CrearPestaña("Info", 0)
MainTab = CrearPestaña("Main", 0.26)
PlayerTab = CrearPestaña("Player", 0.52)
ConfigTab = CrearPestaña("Configuración", 0.78)

-- Área de Contenido
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
ContentFrame.Position = UDim2.new(0, 15, 0, 122)
ContentFrame.Size = UDim2.new(1, -30, 1, -137)
ContentFrame.ScrollBarThickness = 4
Instance.new("UICorner", ContentFrame).CornerRadius = UDim.new(0, 10)

UIListLayout.Parent = ContentFrame
UIListLayout.Padding = UDim.new(0, 12)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Variables de Control
local Funciones = {
    PerfectKick = false, AutoFarm = false, AutoWeight = false,
    AutoClick = false, AutoMoney = false, Fly = false,
    WalkSpeed = 16, InfiniteJump = false, ShowFPS = false, AntiLag = false
}
local FPSLabel, ConexionVuelo, ConexionSalto, ConexionAutoClick, ConexionAutoFarm, ConexionDinero

-- Función para crear botones
local function CrearBoton(texto, variable)
    local btn = Instance.new("TextButton")
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 65)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Font = Enum.Font.Gotham
    btn.Text = texto.." ❌"
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.TextScaled = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    btn.MouseButton1Click:Connect(function()
        Funciones[variable] = not Funciones[variable]
        btn.Text = texto.." "..(Funciones[variable] and "✅" or "❌")
        btn.BackgroundColor3 = Funciones[variable] and Color3.fromRGB(30, 120, 70) or Color3.fromRGB(40, 40, 65)
    end)
    return btn
end

-- Barra de velocidad
local function CrearBarra()
    local contenedor = Instance.new("Frame")
    contenedor.BackgroundTransparency = 1
    contenedor.Size = UDim2.new(0.9, 0, 0, 55)

    local etiqueta = Instance.new("TextLabel")
    etiqueta.Parent = contenedor
    etiqueta.BackgroundTransparency = 1
    etiqueta.Size = UDim2.new(1, 0, 0, 20)
    etiqueta.Font = Enum.Font.Gotham
    etiqueta.Text = "Velocidad: "..Funciones.WalkSpeed
    etiqueta.TextColor3 = Color3.fromRGB(220, 220, 220)
    etiqueta.TextScaled = true

    local barra = Instance.new("TextBox")
    barra.Parent = contenedor
    barra.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    barra.Position = UDim2.new(0, 0, 0, 25)
    barra.Size = UDim2.new(1, 0, 0, 25)
    barra.Font = Enum.Font.Gotham
    barra.PlaceholderText = "Escribe velocidad ej: 50"
    barra.TextColor3 = Color3.fromRGB(255, 255, 255)
    barra.TextScaled = true
    Instance.new("UICorner", barra).CornerRadius = UDim.new(0, 6)

    barra.FocusLost:Connect(function()
        local valor = tonumber(barra.Text)
        if valor and valor > 0 then
            Funciones.WalkSpeed = valor
            etiqueta.Text = "Velocidad: "..Funciones.WalkSpeed
            if Humanoid then Humanoid.WalkSpeed = Funciones.WalkSpeed end
        end
        barra.Text = ""
    end)
    return contenedor
end

-- Cargar Pestañas
local function CargarInfo()
    ContentFrame:ClearAllChildren()
    local datos = {
        "📋 Información del Script",
        "Nombre del creador: JoseAngel_Blox",
        "Fecha de lanzamiento: 27/07/2026",
        "Versión: 1.1"
    }
    for _, texto in pairs(datos) do
        local lbl = Instance.new("TextLabel")
        lbl.BackgroundTransparency = 1
        lbl.Size = UDim2.new(0.9, 0, 0, 30)
        lbl.Font = Enum.Font.Gotham
        lbl.Text = texto
        lbl.TextColor3 = Color3.fromRGB(200, 200, 220)
        lbl.TextScaled = true
        lbl.Parent = ContentFrame
    end
end

local function CargarMain()
    ContentFrame:ClearAllChildren()
    CrearBoton("⚡ Perfect Kick", "PerfectKick").Parent = ContentFrame
    CrearBoton("🤖 Auto Farm", "AutoFarm").Parent = ContentFrame
    CrearBoton("🏋️ Auto Weight", "AutoWeight").Parent = ContentFrame
    CrearBoton("🖱️ Auto Click x2", "AutoClick").Parent = ContentFrame
    CrearBoton("💰 Auto Recoger Dinero", "AutoMoney").Parent = ContentFrame
end

local function CargarPlayer()
    ContentFrame:ClearAllChildren()
    CrearBoton("🕊️ Fly", "Fly").Parent = ContentFrame
    CrearBarra().Parent = ContentFrame
    CrearBoton("🦘 Saltos Infinitos", "InfiniteJump").Parent = ContentFrame
end

local function CargarConfig()
    ContentFrame:ClearAllChildren()
    CrearBoton("📊 Mostrar FPS", "ShowFPS").Parent = ContentFrame
    CrearBoton("🚀 Anti Lag", "AntiLag").Parent = ContentFrame
end

-- Eventos de pestañas
InfoTab.MouseButton1Click:Connect(CargarInfo)
MainTab.MouseButton1Click:Connect(CargarMain)
PlayerTab.MouseButton1Click:Connect(CargarPlayer)
ConfigTab.MouseButton1Click:Connect(CargarConfig)

-- Cargar pestaña inicial
CargarInfo()

-- Funciones del script
Player.CharacterAdded:Connect(function(pj)
    Character = pj
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
    Humanoid.WalkSpeed = Funciones.WalkSpeed
end)

-- Saltos infinitos
UIS.JumpRequest:Connect(function()
    if Funciones.InfiniteJump and Humanoid and Humanoid.Health > 0 then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Bucle principal
RunService.Heartbeat:Connect(function()
    if not Humanoid or Humanoid.Health <= 0 then return end

    -- Velocidad
    Humanoid.WalkSpeed = Funciones.WalkSpeed

    -- Auto Click
    if Funciones.AutoClick then task.wait(0.5) and UIS:SendKeyEvent(true, Enum.KeyCode.MouseButton1, false, game) end

    -- Auto Farm Brainrot
    if Funciones.AutoFarm and RootPart then
        local zona = workspace:FindFirstChild("SafeZone")
        if zona then Humanoid:MoveTo(zona.Position) end
    end

    -- Auto Weight
    if Funciones.AutoWeight then
        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("Tool") and v.Name:lower():find("weight") and not Player.Backpack:FindFirstChild(v.Name) then
                Player.Character.HumanoidRootPart.CFrame = v.CFrame
                task.wait(0.1)
            end
        end
    end

    -- Mostrar FPS
    if Funciones.ShowFPS then
        local fps = math.floor(1/RunService.RenderStepped:Wait())
        if not FPSLabel then
            FPSLabel = Instance.new("TextLabel", ScreenGui)
            FPSLabel.Position = UDim2.new(0.02,0,0.02,0)
            FPSLabel.Size = UDim2.new(0,120,0,25)
            FPSLabel.BackgroundTransparency = 0.3
            FPSLabel.BackgroundColor3 = Color3.new(0,0,0)
            FPSLabel.Font = Enum.Font.GothamBold
            FPSLabel.TextColor3 = Color3.new(1,1,1)
            FPSLabel.TextScaled = true
            Instance.new("UICorner", FPSLabel).CornerRadius = UDim.new(0,6)
        end
        FPSLabel.Text = "📊 FPS: "..fps
    elseif FPSLabel then FPSLabel:Destroy() FPSLabel = nil end

    -- Anti Lag
    if Funciones.AntiLag then
        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("ParticleEmitter") then v.Enabled = false end
            if v:IsA("Decal") and v.Transparency < 0.5 then v.Transparency = 0.5 end
        end
    end

    -- Vuelo
    if Funciones.Fly then
        Humanoid.PlatformStand = true
        local cam = workspace.CurrentCamera
        RootPart.Velocity = cam.CFrame.LookVector * 50 + cam.CFrame.UpVector * (UIS:IsKeyDown(Enum.KeyCode.Space) and 35 or 0) + cam.CFrame.UpVector * (UIS:IsKeyDown(Enum.KeyCode.LeftControl) and -35 or 0)
    else Humanoid.PlatformStand = false end
end)

-- Auto Recoger Dinero
task.spawn(function()
    while true do
        if Funciones.AutoMoney and Character then
            for _, v in pairs(workspace:GetChildren()) do
                if v.Name == "Coin" or v.Name == "Money" then
                    RootPart.CFrame = v.CFrame
                end
            end
        end
        task.wait(0.3)
    end
end)
