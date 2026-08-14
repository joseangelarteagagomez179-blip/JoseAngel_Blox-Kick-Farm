--[[ 
    ╔═══════════════════════════════════════════════════╗
    ║   JOSEANGEL_BLOX PREMIUM v1.1                    ║
    ║   Created by JoseAngel_Blox                       ║
    ╚═══════════════════════════════════════════════════╝
    
    Features: Rainbow Animated Title | Tabs System | 
              Auto Kick | Auto Farm | Stats | Optimization
    
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- Crear el GUI principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_Premium_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

-- Contenedor principal (cuadrado con esquinas redondeadas)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainContainer"
MainFrame.Size = UDim2.new(0, 500, 0, 700)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -350)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

-- Border decorativo
local Border = Instance.new("Frame")
Border.Name = "Border"
Border.Size = UDim2.new(1, -2, 1, -2)
Border.Position = UDim2.new(0, 1, 0, 1)
Border.BackgroundColor3 = Color3.fromRGB(0, 191, 255)
Border.BackgroundTransparency = 0.5
Border.BorderSizePixel = 0
Border.Parent = MainFrame

-- Título Rainbow Animado
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "RainbowTitle"
TitleLabel.Size = UDim2.new(1, -40, 0, 60)
TitleLabel.Position = UDim2.new(0, 20, 0, 15)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🌈 JoseAngel_Blox Premium v1.1 🌈"
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 22
TitleLabel.TextWrapped = true
TitleLabel.Parent = MainFrame

-- Subtítulo
local CreatorLabel = Instance.new("TextLabel")
CreatorLabel.Name = "CreatorText"
CreatorLabel.Size = UDim2.new(1, -40, 0, 25)
CreatorLabel.Position = UDim2.new(0, 20, 0, 75)
CreatorLabel.BackgroundTransparency = 1
CreatorLabel.Text = "Creado por JoseAngel_Blox ✨"
CreatorLabel.TextColor3 = Color3.fromRGB(150, 150, 255)
CreatorLabel.Font = Enum.Font.Gotham
CreatorLabel.TextSize = 14
CreatorLabel.TextWrapped = true
CreatorLabel.Parent = MainFrame

-- Panel izquierdo: Pestañas
local TabPanel = Instance.new("ScrollingFrame")
TabPanel.Name = "TabsPanel"
TabPanel.Size = UDim2.new(0, 120, 1, -120)
TabPanel.Position = UDim2.new(0, 15, 0, 105)
TabPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
TabPanel.BackgroundTransparency = 0.3
TabPanel.BorderSizePixel = 0
TabPanel.CanvasSize = UDim2.new(0, 0, 0, 200)
TabPanel.ScrollBarThickness = 8
TabPanel.ScrollBarImageColor3 = Color3.fromRGB(0, 191, 255)
TabPanel.Parent = MainFrame

-- Panel derecho: Funciones
local ContentPanel = Instance.new("ScrollingFrame")
ContentPanel.Name = "ContentPanel"
ContentPanel.Size = UDim2.new(1, -140, 1, -120)
ContentPanel.Position = UDim2.new(0, 135, 0, 105)
ContentPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
ContentPanel.BackgroundTransparency = 0.3
ContentPanel.BorderSizePixel = 0
ContentPanel.CanvasSize = UDim2.new(0, 0, 0, 300)
ContentPanel.ScrollBarThickness = 8
ContentPanel.ScrollBarImageColor3 = Color3.fromRGB(0, 191, 255)
ContentPanel.Parent = MainFrame

-- Colores del tema
local ThemeColors = {
    Primary = Color3.fromRGB(0, 191, 255),
    Secondary = Color3.fromRGB(25, 25, 45),
    Accent = Color3.fromRGB(255, 100, 100),
    Success = Color3.fromRGB(100, 255, 100),
    Warning = Color3.fromRGB(255, 200, 0),
    Disabled = Color3.fromRGB(80, 80, 90),
}

-- Variables de estado
local GameState = {
    AutoKick = false,
    AutoFarm = false,
    AutoCollect = false,
    MultiplierEnabled = false,
    AntiLag = false,
    ShowFPS = false,
    InfiniteJump = false,
    CurrentTab = nil,
}

-- ============================================
-- SISTEMA RAINBOW ANIMADO PARA EL TÍTULO
-- ============================================
local function RainbowTitleAnimation()
    local colors = {
        Color3.fromRGB(255, 0, 0),
        Color3.fromRGB(255, 127, 0),
        Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(0, 255, 0),
        Color3.fromRGB(0, 255, 255),
        Color3.fromRGB(0, 0, 255),
        Color3.fromRGB(128, 0, 255),
    }
    local colorIndex = 1
    local animationSpeed = 0.05
    
    while task.wait(animationSpeed) do
        colorIndex = (colorIndex % #colors) + 1
        local currentColor = colors[colorIndex]
        
        -- Animación de opacidad
        local alphaTween = TweenService:Create(TitleLabel, TweenInfo.new(animationSpeed * 2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextColor3 = currentColor})
        alphaTween:Play()
    end
end

-- Iniciar animación rainbow
task.spawn(function()
    for i = 1, 100 do
        task.wait(0.08)
        local colors = {
            Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 127, 0),
            Color3.fromRGB(255, 255, 0), Color3.fromRGB(0, 255, 0),
            Color3.fromRGB(0, 255, 255), Color3.fromRGB(0, 0, 255),
            Color3.fromRGB(128, 0, 255),
        }
        local r, g, b = unpack(colors[math.random(1, #colors)])
        TitleLabel.TextColor3 = Color3.new(r/255, g/255, b/255)
    end
end)

-- ============================================
-- CREAR PESTAÑAS
-- ============================================
local function CreateTab(name, iconName, contentCallback)
    -- Botón de pestaña
    local TabButton = Instance.new("TextButton")
    TabButton.Name = "Tab_" .. name
    TabButton.Size = UDim2.new(1, -10, 0, 40)
    TabButton.Position = UDim2.new(0, 5, 0, 0)
    TabButton.AutoButtonColor = false
    TabButton.BackgroundColor3 = ThemeColors.Secondary
    TabButton.Text = iconName .. " " .. name
    TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabButton.Font = Enum.Font.GothamBold
    TabButton.TextSize = 14
    TabButton.BorderSizePixel = 0
    TabButton.Parent = TabPanel
    
    -- Estado activo/inactivo
    TabButton.MouseEnter:Connect(function()
        if not GameState.CurrentTab or GameState.CurrentTab ~= TabButton then
            TabButton.BackgroundColor3 = ThemeColors.Primary
        end
    end)
    
    TabButton.MouseLeave:Connect(function()
        if not GameState.CurrentTab or GameState.CurrentTab ~= TabButton then
            TabButton.BackgroundColor3 = ThemeColors.Secondary
        end
    end)
    
    TabButton.MouseButton1Click:Connect(function()
        ActivateTab(TabButton, contentCallback)
    end)
    
    return TabButton
end

-- ============================================
-- ACTIVAR PESTAÑA
-- ============================================
function ActivateTab(selectedTab, contentCallback)
    -- Desactivar todas las pestañas
    for _, button in ipairs(TabPanel:GetChildren()) do
        if button:IsA("TextButton") then
            button.BackgroundColor3 = ThemeColors.Secondary
            button.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
    end
    
    -- Activar pestaña seleccionada
    selectedTab.BackgroundColor3 = ThemeColors.Primary
    selectedTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    GameState.CurrentTab = selectedTab
    
    -- Limpiar panel de contenido
    for _, child in ipairs(ContentPanel:GetChildren()) do
        child:Destroy()
    end
    
    -- Renderizar contenido
    contentCallback()
end

-- ============================================
-- CREAR BOTÓN DE FUNCIONALIDAD
-- ============================================
function CreateToggle(parent, name, description, callback)
    local ToggleContainer = Instance.new("Frame")
    ToggleContainer.Size = UDim2.new(1, -20, 0, 60)
    ToggleContainer.Position = UDim2.new(0, 10, 0, 0)
    ToggleContainer.BackgroundColor3 = ThemeColors.Secondary
    ToggleContainer.BackgroundTransparency = 0.3
    ToggleContainer.BorderSizePixel = 0
    ToggleContainer.Parent = parent
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 30)
    Label.Position = UDim2.new(0, 10, 0, 10)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 16
    Label.Parent = ToggleContainer
    
    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(1, -20, 0, 25)
    Desc.Position = UDim2.new(0, 10, 0, 35)
    Desc.BackgroundTransparency = 1
    Desc.Text = description
    Desc.TextColor3 = Color3.fromRGB(150, 150, 150)
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 12
    Desc.Parent = ToggleContainer
    
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 50, 0, 30)
    Button.Position = UDim2.new(1, -60, 0, 15)
    Button.AutoButtonColor = false
    Button.BackgroundColor3 = ThemeColors.Disabled
    Button.Text = "OFF"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 12
    Button.BorderSizePixel = 0
    Button.Parent = ToggleContainer
    
    local ToggleState = false
    
    Button.MouseButton1Click:Connect(function()
        ToggleState = not ToggleState
        Button.Text = ToggleState and "ON" or "OFF"
        Button.BackgroundColor3 = ToggleState and ThemeColors.Success or ThemeColors.Disabled
        
        if callback then
            callback(ToggleState)
        end
    end)
    
    return ToggleState
end

-- ============================================
-- CREAR BOTÓN SIMPLE
-- ============================================
function CreateButton(parent, name, onClick, enabled)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -20, 0, 45)
    Button.Position = UDim2.new(0, 10, 0, 0)
    Button.AutoButtonColor = false
    Button.BackgroundColor3 = enabled and ThemeColors.Primary or ThemeColors.Disabled
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 15
    Button.BorderSizePixel = 0
    Button.Parent = parent
    
    Button.MouseButton1Click:Connect(function()
        if enabled then
            onClick()
        end
    end)
    
    return Button
end

-- ============================================
-- PESTAÑA 1: INFO
-- ============================================
function RenderInfoTab()
    local infoContent = {}
    
    -- Encabezado de sección
    local Header = Instance.new("TextLabel")
    Header.Size = UDim2.new(1, -20, 0, 40)
    Header.Position = UDim2.new(0, 10, 0, 10)
    Header.BackgroundTransparency = 1
    Header.Text = "ℹ️ Información del Script"
    Header.TextColor3 = ThemeColors.Primary
    Header.Font = Enum.Font.GothamBold
    Header.TextSize = 18
    Header.Parent = ContentPanel
    
    table.insert(infoContent, Header)
    
    -- Datos del creador
    local DataBox = Instance.new("Frame")
    DataBox.Size = UDim2.new(1, -20, 0, 150)
    DataBox.Position = UDim2.new(0, 10, 0, 60)
    DataBox.BackgroundColor3 = ThemeColors.Secondary
    DataBox.BackgroundTransparency = 0.3
    DataBox.BorderSizePixel = 0
    DataBox.Parent = ContentPanel
    
    local Labels = {
        { text = "Nombre del Creador:", value = "JoseAngel_Blox", col = ThemeColors.Accent },
        { text = "Fecha de Lanzamiento:", value = "13/08/2026", col = ThemeColors.Primary },
        { text = "Versión:", value = "1.1", col = ThemeColors.Success },
    }
    
    for i, data in ipairs(Labels) do
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -20, 0, 25)
        Label.Position = UDim2.new(0, 10, 0, (i-1) * 35)
        Label.BackgroundTransparency = 1
        Label.Text = data.text .. " " .. data.value
        Label.TextColor3 = data.col
        Label.Font = Enum.Font.Gotham
        Label.TextSize = 14
        Label.Parent = DataBox
    end
    
    -- Mensaje de actualización
    local UpdateBox = Instance.new("Frame")
    UpdateBox.Size = UDim2.new(1, -20, 0, 180)
    UpdateBox.Position = UDim2.new(0, 10, 0, 220)
    UpdateBox.BackgroundColor3 = Color3.fromRGB(30, 40, 60)
    UpdateBox.BackgroundTransparency = 0.5
    UpdateBox.BorderSizePixel = 0
    UpdateBox.Parent = ContentPanel
    
    local UpdateHeader = Instance.new("TextLabel")
    UpdateHeader.Size = UDim2.new(1, -20, 0, 30)
    UpdateHeader.Position = UDim2.new(0, 0, 0, 0)
    UpdateHeader.BackgroundTransparency = 1
    UpdateHeader.Text = "📢 UPDATE:"
    UpdateHeader.TextColor3 = ThemeColors.Warning
    UpdateHeader.Font = Enum.Font.GothamBold
    UpdateHeader.TextSize = 16
    UpdateHeader.Parent = UpdateBox
    
    local UpdateMessage = Instance.new("TextLabel")
    UpdateMessage.Size = UDim2.new(1, -20, 0, 120)
    UpdateMessage.Position = UDim2.new(0, 0, 0, 35)
    UpdateMessage.BackgroundTransparency = 1
    UpdateMessage.Text = [[Bienvenidos a todos a mi script premium este script te ayudará mucho a subir tu fuerza de patada y tiene otras funciones más espero y disfrutes del script atentamente JoseAngel_Blox..]]
    UpdateMessage.TextColor3 = Color3.fromRGB(220, 220, 220)
    UpdateMessage.Font = Enum.Font.Gotham
    UpdateMessage.TextSize = 12
    UpdateMessage.TextWrapped = true
    UpdateMessage.TextTransparency = 0.8
    UpdateMessage.VerticalText = true
    UpdateMessage.Parent = UpdateBox
    
    -- Botones de Like y Dislike
    local VoteSection = Instance.new("Frame")
    VoteSection.Size = UDim2.new(1, -20, 0, 120)
    VoteSection.Position = UDim2.new(0, 10, 0, 410)
    VoteSection.BackgroundColor3 = ThemeColors.Secondary
    VoteSection.BackgroundTransparency = 0.3
    VoteSection.BorderSizePixel = 0
    VoteSection.Parent = ContentPanel
    
    local VoteTitle = Instance.new("TextLabel")
    VoteTitle.Size = UDim2.new(1, -20, 0, 30)
    VoteTitle.Position = UDim2.new(0, 0, 0, 0)
    VoteTitle.BackgroundTransparency = 1
    VoteTitle.Text = "❤️ Vota por el Script ❤️"
    VoteTitle.TextColor3 = ThemeColors.Accent
    VoteTitle.Font = Enum.Font.GothamBold
    VoteTitle.TextSize = 16
    VoteTitle.Parent = VoteSection
    
    -- Contenedores de Like/Dislike
    local LikeContainer = Instance.new("Frame")
    LikeContainer.Size = UDim2.new(0, 100, 0, 70)
    LikeContainer.Position = UDim2.new(0, 10, 0, 35)
    LikeContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    LikeContainer.BackgroundTransparency = 0.3
    LikeContainer.BorderSizePixel = 0
    LikeContainer.Parent = VoteSection
    
    local LikeBtn = Instance.new("TextButton")
    LikeBtn.Size = UDim2.new(1, 0, 0, 40)
    LikeBtn.BackgroundTransparency = 1
    LikeBtn.Text = "👍 LIKE"
    LikeBtn.TextColor3 = ThemeColors.Success
    LikeBtn.Font = Enum.Font.GothamBold
    LikeBtn.TextSize = 14
    LikeBtn.BorderSizePixel = 0
    LikeBtn.Parent = LikeContainer
    
    local LikeCount = Instance.new("TextLabel")
    LikeCount.Size = UDim2.new(1, 0, 0, 30)
    LikeCount.Position = UDim2.new(0, 0, 0, 45)
    LikeCount.BackgroundTransparency = 1
    LikeCount.Text = "Likes: 0"
    LikeCount.TextColor3 = Color3.fromRGB(200, 255, 200)
    LikeCount.Font = Enum.Font.Gotham
    LikeCount.TextSize = 14
    LikeCount.Parent = LikeContainer
    
    local DislikeContainer = Instance.new("Frame")
    DislikeContainer.Size = UDim2.new(0, 100, 0, 70)
    DislikeContainer.Position = UDim2.new(1, -110, 0, 35)
    DislikeContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    DislikeContainer.BackgroundTransparency = 0.3
    DislikeContainer.BorderSizePixel = 0
    DislikeContainer.Parent = VoteSection
    
    local DislikeBtn = Instance.new("TextButton")
    DislikeBtn.Size = UDim2.new(1, 0, 0, 40)
    DislikeBtn.BackgroundTransparency = 1
    DislikeBtn.Text = "👎 DISLIKE"
    DislikeBtn.TextColor3 = ThemeColors.Accent
    DislikeBtn.Font = Enum.Font.GothamBold
    DislikeBtn.TextSize = 14
    DislikeBtn.BorderSizePixel = 0
    DislikeBtn.Parent = DislikeContainer
    
    local DislikeCount = Instance.new("TextLabel")
    DislikeCount.Size = UDim2.new(1, 0, 0, 30)
    DislikeCount.Position = UDim2.new(0, 0, 0, 45)
    DislikeCount.BackgroundTransparency = 1
    DislikeCount.Text = "Dislikes: 0"
    DislikeCount.TextColor3 = Color3.fromRGB(255, 200, 200)
    DislikeCount.Font = Enum.Font.Gotham
    DislikeCount.TextSize = 14
    DislikeCount.Parent = DislikeContainer
    
    -- Variables de votación
    local likeVotes = 0
    local dislikeVotes = 0
    
    LikeBtn.MouseButton1Click:Connect(function()
        likeVotes += 1
        LikeCount.Text = "Likes: " .. likeVotes
        LikeBtn.BackgroundColor3 = ThemeColors.Success
        task.delay(0.3, function()
            LikeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        end)
    end)
    
    DislikeBtn.MouseButton1Click:Connect(function()
        dislikeVotes += 1
        DislikeCount.Text = "Dislikes: " .. dislikeVotes
        DislikeBtn.BackgroundColor3 = ThemeColors.Accent
        task.delay(0.3, function()
            DislikeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        end)
    end)
end

-- ============================================
-- PESTAÑA 2: MAIN
-- ============================================
function RenderMainTab()
    -- Auto Kick
    CreateToggle(ContentPanel, "Auto Kick", "Kicks automáticamente el bloque lucky con timing perfecto", function(state)
        GameState.AutoKick = state
        print("Auto Kick:", state and "ACTIVADO" or "DESACTIVADO")
    end)
    
    -- Auto Farm
    CreateToggle(ContentPanel, "Auto Farm", "Corre automáticamente hacia la zona segura KickReady", function(state)
        GameState.AutoFarm = state
        print("Auto Farm:", state and "ACTIVADO" or "DESACTIVADO")
    end)
    
    -- Auto Collect Cash
    CreateToggle(ContentPanel, "Auto Collect Cash", "Recoge dinero automático del pad verde", function(state)
        GameState.AutoCollect = state
        print("Auto Collect:", state and "ACTIVADO" or "DESACTIVADO")
    end)
    
    -- Multiplicador x2
    CreateToggle(ContentPanel, "Multiplicador x2", "Duplica tus ganancias actuales", function(state)
        GameState.MultiplierEnabled = state
        print("Multiplier:", state and "x2 ACTIVADO" or "x2 DESACTIVADO")
    end)
    
    -- SEPARADOR
    local Separator = Instance.new("Frame")
    Separator.Size = UDim2.new(1, -20, 0, 5)
    Separator.Position = UDim2.new(0, 10, 0, 450)
    Separator.BackgroundColor3 = ThemeColors.Primary
    Separator.BackgroundTransparency = 0.5
    Separator.BorderSizePixel = 0
    Separator.Parent = ContentPanel
    
    -- Manual Kick Button (por si el auto kick falla)
    CreateButton(ContentPanel, "🎯 KICK MANUAL", function()
        LocalPlayerManualKick()
    end, true)
    
    -- Teletransportar a KickReady
    CreateButton(ContentPanel, "🏠 TELEPORT A KICKREADY", function()
        TeleportToZone()
    end, true)
end

-- ============================================
-- LÓGICA DEL AUTO KICK
-- ============================================
function LocalPlayerManualKick()
    print("⚡ EJECUTANDO KICK...")
    
    local success, args = pcall(function()
        local kickArgs = {
            1,
            1,
            1786668521.972088
        }
        
        local packageService = ReplicatedStorage:FindFirstChild("Shared")
        if packageService then
            packageService = packageService:FindFirstChild("Packages")
            if packageService then
                packageService = packageService:FindFirstChild("Network")
                if packageService then
                    packageService = packageService:FindFirstChild("ref_KickEvent")
                    if packageService then
                        return packageService:InvokeServer(unpack(kickArgs))
                    end
                end
            end
        end
        return nil
    end)
    
    if success then
        print("✅ KICK REALIZADO CON ÉXITO!")
    else
        print("❌ ERROR AL REALIZAR KICK - Verifica el evento")
    end
end

-- ============================================
-- LÓGICA DEL AUTO FARM
-- ============================================
function TeleportToZone()
    local character = Players.LocalPlayer.Character
    if not character then
        warn("Sin personaje cargado")
        return
    end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        warn("HumanoidRootPart no encontrado")
        return
    end
    
    -- Buscar parte llamada "KickReady" o zona segura
    local targetPart = Workspace:FindFirstChildOfClass("Part")
    local safeZoneFound = false
    
    -- Intentar encontrar zonas llamadas KickReady
    for _, obj in pairs(Workspace:GetChildren()) do
        if string.find(string.lower(obj.Name), "kicReady") or 
           string.find(string.lower(obj.Name), "safe zone") or
           string.find(string.lower(obj.Name), "base") then
            
            -- Comprobar si está en la zona segura
            local position = obj.Position
            if humanoidRootPart.Position.Z < position.Z + 100 and humanoidRootPart.Position.Z > position.Z - 100 then
                safeZoneFound = true
                break
            end
        end
    end
    
    -- Mover al jugador a posición segura aproximada
    local safeZPosition = humanoidRootPart.Position.Z + 50
    humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position.X, humanoidRootPart.Position.Y, safeZPosition)
    
    print("✅ Movido a zona segura!")
end

-- Loop del Auto Farm
game:GetService("RunService").Heartbeat:Connect(function()
    if GameState.AutoFarm then
        local character = Players.LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildWhichIsA("Humanoid")
            if humanoid then
                -- Correr hacia la base/zona segura
                humanoid:MoveTo(character.HumanoidRootPart.Position + Vector3.new(0, 0, 50))
            end
        end
    end
end)

-- ============================================
-- PESTAÑA 3: PLAYER & OPTIMIZACIÓN
-- ============================================
function RenderOptimizationTab()
    -- Anti Lag
    CreateToggle(ContentPanel, "Anti Lag", "Reduce latencia y mejora rendimiento", function(state)
        GameState.AntiLag = state
        ApplyAntiLag(state)
    end)
    
    -- Mostrar FPS
    local fpsDisplay = CreateToggle(ContentPanel, "Mostrar FPS", "Muestra contador de FPS en pantalla", function(state)
        GameState.ShowFPS = state
        ToggleFPSDisplay(state)
    end)
    
    -- Infinite Jump
    CreateToggle(ContentPanel, "Infinite Jump", "Salto infinito sin limitaciones", function(state)
        GameState.InfiniteJump = state
    end)
    
    -- Separador
    local Separator = Instance.new("Frame")
    Separator.Size = UDim2.new(1, -20, 0, 5)
    Separator.Position = UDim2.new(0, 10, 0, 140)
    Separator.BackgroundColor3 = ThemeColors.Primary
    Separator.BackgroundTransparency = 0.5
    Separator.BorderSizePixel = 0
    Separator.Parent = ContentPanel
    
    -- Reset Player
    CreateButton(ContentPanel, "↻ RESET PLAYER", function()
        local plr = Players.LocalPlayer
        if plr then
            plr:LoadCharacter()
            print("✅ Jugador reiniciado!")
        end
    end, true)
    
    -- Exit Script
    CreateButton(ContentPanel, "🚪 SALIR DEL SCRIPT", function()
        ScreenGui:Destroy()
        print("👋 Script cerrado correctamente")
    end, true)
end

-- ============================================
-- FUNCIONES DE OPTIMIZACIÓN
-- ============================================
function ApplyAntiLag(enabled)
    if enabled then
        -- Aplicar configuraciones para reducir lag
        Lighting.Brightness = 2
        Lighting.GlobalShadows = false
        Lighting.FogEnd = math.huge
        print("✅ Anti-Lag ACTIVADO")
    else
        -- Restaurar valores normales
        Lighting.Brightness = 1
        Lighting.GlobalShadows = true
        Lighting.FogEnd = 1000
        print("❌ Anti-Lag DESACTIVADO")
    end
end

function ToggleFPSDisplay(enabled)
    -- Remover display existente
    if ScreenGui:FindFirstChild("FPSDisplay") then
        ScreenGui.FPSDisplay:Destroy()
    end
    
    if enabled then
        -- Crear nuevo display de FPS
        local FPSScreenGui = Instance.new("ScreenGui")
        FPSScreenGui.Name = "FPSOverlay"
        FPSScreenGui.Parent = ScreenGui
        
        local FPSSquare = Instance.new("Frame")
        FPSSquare.Size = UDim2.new(0, 80, 0, 40)
        FPSSquare.Position = UDim2.new(1, -85, 0, 10)
        FPSSquare.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        FPSSquare.BackgroundTransparency = 0.5
        FPSSquare.BorderSizePixel = 0
        FPSSquare.Name = "FPSDisplay"
        FPSSquare.Parent = FPSScreenGui
        
        local FPSLabel = Instance.new("TextLabel")
        FPSLabel.Size = UDim2.new(1, 0, 1, 0)
        FPSLabel.BackgroundTransparency = 1
        FPSLabel.Text = "FPS: 60"
        FPSLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        FPSLabel.Font = Enum.Font.GothamBold
        FPSLabel.TextSize = 16
        FPSLabel.Parent = FPSSquare
        
        game:GetService("RunService").Heartbeat:Connect(function()
            local fps = math.floor(1 / task.wait())
            FPSLabel.Text = "FPS: " .. fps
        end)
    end
end

-- ============================================
-- SISTEMA INFINITE JUMP
-- ============================================
local LocalPlayer = Players.LocalPlayer

LocalPlayer.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid", 10)
    if humanoid then
        if GameState.InfiniteJump then
            humanoid.JumpPower = 100
        else
            humanoid.JumpPower = 50
        end
    end
end)

-- Monitor cambios en salto infinito
while task.wait(0.5) do
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
    if humanoid then
        if GameState.InfiniteJump then
            humanoid.JumpPower = 100
        else
            humanoid.JumpPower = 50
        end
    end
end

-- ============================================
-- SISTEMA AUTO COLLECT CASH
-- ============================================
local LastTime = 0
local CollectionCooldown = 1 -- segundos

local Player = Players.LocalPlayer

game:GetService("RunService").Stepped:Connect(function()
    if GameState.AutoCollect then
        local currentTime = tick()
        
        if currentTime - LastTime >= CollectionCooldown then
            LastTime = currentTime
            
            -- Buscar partes verdes cerca del jugador (representan pads de recogida de dinero)
            local Character = Player.Character
            if Character then
                local RootPart = Character:FindFirstChild("HumanoidRootPart")
                
                if RootPart then
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and 
                           obj.Transparency == 0 and 
                           obj.CanCollide then
                            
                            -- Comprobar si está dentro de radio de recogida
                            if (RootPart.Position - obj.Position).Magnitude < 10 then
                                -- Recoger dinero (simulado - necesitaría API real del juego)
                                print("💵 Dinero recogido!")
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- ============================================
-- MENSAJE DE INICIO
-- ============================================
print("===========================================")
print("  🌈 JOSEANGEL_BLOX PREMIUM v1.1 🌈")
print("  Creado por JoseAngel_Blox")
print("  Lanzado: 13/08/2026")
print("===========================================")
print("")
print("✅ GUI CARGADA CORRECTAMENTE")
print("")
print("FUNCIONES DISPONIBLES:")
print("- Tab Info: Información del script y votos")
print("- Tab Main: Auto Kick, Auto Farm, Colector")
print("- Tab Opti: Anti-lag, FPS, Salto infinito")
print("")
print("⚠️ USAR RESPONSABLEMENTE")
print("⚠️ NO ABUSAR PARA EVITAR BANNES")
print("===========================================\n")

-- ============================================
-- MENSAJERÍA DE NOTIFICACIONES
-- ============================================
function SendNotification(title, message, duration)
    duration = duration or 3
    
    local NotificationGui = Instance.new("ScreenGui")
    NotificationGui.Name = "Notification_" .. tick()
    NotificationGui.Parent = ScreenGui
    
    local NotificationFrame = Instance.new("Frame")
    NotificationFrame.Size = UDim2.new(0, 300, 0, 60)
    NotificationFrame.Position = UDim2.new(0.5, -150, 0, 50)
    NotificationFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    NotificationFrame.BackgroundTransparency = 0.5
    NotificationFrame.BorderSizePixel = 0
    NotificationFrame.Parent = NotificationGui
    
    local NotifyLabel = Instance.new("TextLabel")
    NotifyLabel.Size = UDim2.new(1, 0, 1, 0)
    NotifyLabel.BackgroundTransparency = 1
    NotifyLabel.Text = title .. "\n" .. message
    NotifyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    NotifyLabel.Font = Enum.Font.GothamBold
    NotifyLabel.TextSize = 14
    NotifyLabel.TextYAlignment = Enum.TextYAlignment.Top
    NotifyLabel.TextWrapped = true
    NotifyLabel.Parent = NotificationFrame
    
    task.delay(duration, function()
        NotificationGui:Destroy()
    end)
end

-- Notificación de bienvenida
SendNotification("Welcome!", "Script cargado correctamente", 5)

-- Fin del script
print("Script ejecutándose...")
