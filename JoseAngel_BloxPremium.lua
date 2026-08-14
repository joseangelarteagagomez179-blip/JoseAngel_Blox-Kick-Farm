-- ==========================================
-- JoseAngel_Blox Premium v1.1
-- Juego: Kick a Lucky Block
-- ==========================================

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

-- Evitar duplicados
if CoreGui:FindFirstChild("JoseAngelBloxUI") then
    CoreGui.JoseAngelBloxUI:Destroy()
end

-- ==========================================
-- 1. CREACIÓN DE LA INTERFAZ BASE
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngelBloxUI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true -- Permite mover la ventana

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15) -- Esquinas redondeadas
UICorner.Parent = MainFrame

-- Título (Rainbow Text)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "JoseAngel_Blox Premium v1.1"
Title.TextSize = 18
Title.Parent = MainFrame

-- Efecto Rainbow en movimiento
RunService.RenderStepped:Connect(function()
    Title.TextColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
end)

-- Subtítulo
local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, 0, 0, 20)
Subtitle.Position = UDim2.new(0, 0, 0, 25)
Subtitle.BackgroundTransparency = 1
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "Creado por JoseAngel_Blox"
Subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
Subtitle.TextSize = 12
Subtitle.Parent = MainFrame

-- Separador
local Line = Instance.new("Frame")
Line.Size = UDim2.new(1, -20, 0, 1)
Line.Position = UDim2.new(0, 10, 0, 50)
Line.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
Line.BorderSizePixel = 0
Line.Parent = MainFrame

-- Contenedor Izquierdo (Pestañas)
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 120, 1, -60)
TabContainer.Position = UDim2.new(0, 10, 0, 55)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 5)
TabListLayout.Parent = TabContainer

-- Contenedor Derecho (Funciones)
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -140, 1, -60)
ContentContainer.Position = UDim2.new(0, 130, 0, 55)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

-- ==========================================
-- SISTEMA DE PESTAÑAS (TABS)
-- ==========================================
local Tabs = {}
local function CreateTab(name)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 30)
    TabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabBtn.TextSize = 14
    TabBtn.Parent = TabContainer
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

    local TabPage = Instance.new("ScrollingFrame")
    TabPage.Size = UDim2.new(1, 0, 1, 0)
    TabPage.BackgroundTransparency = 1
    TabPage.Visible = false
    TabPage.ScrollBarThickness = 4
    TabPage.Parent = ContentContainer
    
    local PageLayout = Instance.new("UIListLayout")
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Padding = UDim.new(0, 8)
    PageLayout.Parent = TabPage

    TabBtn.MouseButton1Click:Connect(function()
        for _, page in pairs(Tabs) do page.Visible = false end
        TabPage.Visible = true
    end)

    table.insert(Tabs, TabPage)
    return TabPage
end

local InfoTab = CreateTab("1) Info")
local MainTab = CreateTab("2) Main")
local PlayerTab = CreateTab("3) Player & Opt")
Tabs[1].Visible = true -- Mostrar la primera pestaña por defecto

-- Función auxiliar para crear Botones de funciones
local function CreateButton(parent, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -10, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
    Btn.Font = Enum.Font.GothamBold
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 14
    Btn.Parent = parent
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

local function CreateToggle(parent, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -10, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(150, 50, 50) -- Rojo apagado (Off)
    Btn.Font = Enum.Font.GothamBold
    Btn.Text = text .. " [OFF]"
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 14
    Btn.Parent = parent
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    local state = false
    Btn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            Btn.BackgroundColor3 = Color3.fromRGB(50, 150, 50) -- Verde (On)
            Btn.Text = text .. " [ON]"
        else
            Btn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
            Btn.Text = text .. " [OFF]"
        end
        callback(state)
    end)
    return Btn
end

-- ==========================================
-- PESTAÑA 1: INFO
-- ==========================================
local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(1, -10, 0, 150)
InfoText.BackgroundTransparency = 1
InfoText.Font = Enum.Font.Gotham
InfoText.Text = "Nombre del Creador: JoseAngel_Blox\nFecha de lanzamiento: 13/08/2026\nVersión: 1.1\n\nUPDATE: Bienvenidos a todos a mi script premium este script te ayudará mucho a subir tu fuerza de patada y tiene otras funciones más espero y disfrutes del script atentamente JoseAngel_Blox."
InfoText.TextColor3 = Color3.fromRGB(220, 220, 220)
InfoText.TextSize = 13
InfoText.TextWrapped = true
InfoText.TextXAlignment = Enum.TextXAlignment.Left
InfoText.TextYAlignment = Enum.TextYAlignment.Top
InfoText.Parent = InfoTab

-- Sistema de Likes/Dislikes Visual
local LikeFrame = Instance.new("Frame")
LikeFrame.Size = UDim2.new(1, -10, 0, 40)
LikeFrame.BackgroundTransparency = 1
LikeFrame.Parent = InfoTab

local likes, dislikes = 0, 0

local LikeBtn = Instance.new("TextButton")
LikeBtn.Size = UDim2.new(0.45, 0, 1, 0)
LikeBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
LikeBtn.Font = Enum.Font.GothamBold
LikeBtn.Text = "👍 Like ("..likes..")"
LikeBtn.TextColor3 = Color3.new(1,1,1)
LikeBtn.Parent = LikeFrame
Instance.new("UICorner", LikeBtn).CornerRadius = UDim.new(0,6)

local DislikeBtn = Instance.new("TextButton")
DislikeBtn.Size = UDim2.new(0.45, 0, 1, 0)
DislikeBtn.Position = UDim2.new(0.55, 0, 0, 0)
DislikeBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
DislikeBtn.Font = Enum.Font.GothamBold
DislikeBtn.Text = "👎 Dislike ("..dislikes..")"
DislikeBtn.TextColor3 = Color3.new(1,1,1)
DislikeBtn.Parent = LikeFrame
Instance.new("UICorner", DislikeBtn).CornerRadius = UDim.new(0,6)

LikeBtn.MouseButton1Click:Connect(function()
    likes = likes + 1
    LikeBtn.Text = "👍 Like ("..likes..")"
end)

DislikeBtn.MouseButton1Click:Connect(function()
    dislikes = dislikes + 1
    DislikeBtn.Text = "👎 Dislike ("..dislikes..")"
end)

-- ==========================================
-- PESTAÑA 2: MAIN
-- ==========================================
local autoKickActivo = false
local autoFarmActivo = false
local autoCollectActivo = false
local multiX2Activo = false

-- Auto Kick
CreateToggle(MainTab, "Auto Kick", function(estado)
    autoKickActivo = estado
    task.spawn(function()
        while autoKickActivo do
            local args = { 1, 1, 1786668521.972088 }
            -- Usamos pcall para evitar que el script se rompa si el evento aún no carga
            pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network"):WaitForChild("ref_KickEvent"):InvokeServer(unpack(args))
            end)
            task.wait(0.1) -- Pequeño delay para no crashear
        end
    end)
end)

-- Auto Farm (Correr a la safe zone "KickReady")
CreateToggle(MainTab, "Auto Farm (Ir a KickReady)", function(estado)
    autoFarmActivo = estado
    task.spawn(function()
        while autoFarmActivo do
            local zonaSegura = Workspace:FindFirstChild("KickReady", true)
            local character = LocalPlayer.Character
            if zonaSegura and character and character:FindFirstChild("Humanoid") then
                -- Hace que el personaje corra hacia la posición de la zona
                character.Humanoid:MoveTo(zonaSegura.Position)
            end
            task.wait(1)
        end
    end)
end)

-- Auto Collect Cash (Bucle genérico para recoger drops)
CreateToggle(MainTab, "Auto Collect Cash", function(estado)
    autoCollectActivo = estado
    task.spawn(function()
        while autoCollectActivo do
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                -- Busca piezas de dinero en el workspace (ajustar si están en una carpeta específica)
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("Part") and (obj.Name:lower():match("cash") or obj.Name:lower():match("coin") or obj.Name:lower():match("drop")) then
                        obj.CFrame = character.HumanoidRootPart.CFrame
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end)

-- Multiplicador x2
CreateToggle(MainTab, "Multiplicador x2", function(estado)
    multiX2Activo = estado
    -- Nota: Los multiplicadores reales suelen requerir un gamepass, esto intenta forzar un evento de boost si existe
    task.spawn(function()
        while multiX2Activo do
            pcall(function()
                -- Placeholders por si el juego tiene eventos de multiplicador
                local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                if remotes and remotes:FindFirstChild("ActivateBoost") then
                    remotes.ActivateBoost:FireServer("2x")
                end
            end)
            task.wait(5)
        end
    end)
end)

-- ==========================================
-- PESTAÑA 3: PLAYER & OPTIMIZACIÓN
-- ==========================================

-- Anti Lag (Gráficos al mínimo)
CreateButton(PlayerTab, "Activar Anti Lag", function()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end
    end
    game:GetService("Lighting").GlobalShadows = false
    game:GetService("Lighting").FogEnd = 9e9
end)

-- Mostrar Fps
local FpsLabel = Instance.new("TextLabel")
FpsLabel.Size = UDim2.new(1, -10, 0, 30)
FpsLabel.BackgroundTransparency = 1
FpsLabel.Font = Enum.Font.GothamBold
FpsLabel.Text = "FPS: Calculando..."
FpsLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
FpsLabel.TextSize = 14
FpsLabel.Parent = PlayerTab

RunService.RenderStepped:Connect(function(deltaTime)
    local fps = math.floor(1 / deltaTime)
    FpsLabel.Text = "FPS: " .. fps
end)

-- Infinite Jump
local infiniteJumpActivo = false
CreateToggle(PlayerTab, "Infinite Jump", function(estado)
    infiniteJumpActivo = estado
end)

UserInputService.JumpRequest:Connect(function()
    if infiniteJumpActivo then
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Reset Player
CreateButton(PlayerTab, "Reset Player", function()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.Health = 0
        -- Alternativa segura: character:BreakJoints()
    end
end)
