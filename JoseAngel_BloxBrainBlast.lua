-- ==============================================================================
-- SCRIPT: JoseAngel_Blox BrainBlast (v1.1)
-- CREADO POR: JoseAngel_Blox
-- COMPATIBILIDAD: Delta Executor (PC & Mobile) - SIN LIBRERÍAS
-- ==============================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Anti-AFK integrado para evitar desconexiones por inactividad
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- Eliminar GUI anterior si se ejecuta nuevamente
if CoreGui:FindFirstChild("JoseAngel_Blox_GUI") then
    CoreGui.JoseAngel_Blox_GUI:Destroy()
end

-- ==============================================================================
-- 1. INTERFAZ GRÁFICA (GUI) ANCHA, BAJA Y REDONDEADA
-- ==============================================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_GUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Contenedor Principal (620x340 - Ancho y Bajo)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 620, 0, 340)
MainFrame.Position = UDim2.new(0.5, -310, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

-- Cabecera / Título
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -20, 0, 26)
TitleLabel.Position = UDim2.new(0, 15, 0, 8)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "JoseAngel_Blox BrainBlast"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 19
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = MainFrame

-- Subtítulo Creador
local SubTitleLabel = Instance.new("TextLabel")
SubTitleLabel.Size = UDim2.new(1, -20, 0, 18)
SubTitleLabel.Position = UDim2.new(0, 15, 0, 32)
SubTitleLabel.BackgroundTransparency = 1
SubTitleLabel.Text = "Creado por JoseAngel_Blox"
SubTitleLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
SubTitleLabel.TextSize = 13
SubTitleLabel.Font = Enum.Font.Gotham
SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
SubTitleLabel.Parent = MainFrame

-- Panel Izquierdo (Pestañas)
local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0, 160, 1, -65)
LeftPanel.Position = UDim2.new(0, 12, 0, 55)
LeftPanel.BackgroundColor3 = Color3.fromRGB(30, 33, 42)
LeftPanel.Parent = MainFrame

local LeftCorner = Instance.new("UICorner")
LeftCorner.CornerRadius = UDim.new(0, 10)
LeftCorner.Parent = LeftPanel

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 8)
TabListLayout.Parent = LeftPanel

local TabPadding = Instance.new("UIPadding")
TabPadding.PaddingTop = UDim.new(0, 10)
TabPadding.PaddingLeft = UDim.new(0, 10)
TabPadding.PaddingRight = UDim.new(0, 10)
TabPadding.Parent = LeftPanel

-- Panel Derecho (Contenedor de Páginas)
local RightPanel = Instance.new("Frame")
RightPanel.Size = UDim2.new(1, -195, 1, -65)
RightPanel.Position = UDim2.new(0, 183, 0, 55)
RightPanel.BackgroundColor3 = Color3.fromRGB(30, 33, 42)
RightPanel.Parent = MainFrame

local RightCorner = Instance.new("UICorner")
RightCorner.CornerRadius = UDim.new(0, 10)
RightCorner.Parent = RightPanel

-- ==============================================================================
-- 2. SISTEMA DE PESTAÑAS Y CREACIÓN DE ELEMENTOS
-- ==============================================================================
local Pages = {}
local TabButtons = {}

local function CreateTab(name, order)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 38)
    TabBtn.BackgroundColor3 = Color3.fromRGB(42, 46, 58)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.TextSize = 13
    TabBtn.LayoutOrder = order
    TabBtn.Parent = LeftPanel
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = TabBtn
    
    local PageScroll = Instance.new("ScrollingFrame")
    PageScroll.Size = UDim2.new(1, -16, 1, -16)
    PageScroll.Position = UDim2.new(0, 8, 0, 8)
    PageScroll.BackgroundTransparency = 1
    PageScroll.ScrollBarThickness = 4
    PageScroll.Visible = false
    PageScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    PageScroll.Parent = RightPanel
    
    local PageLayout = Instance.new("UIListLayout")
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Padding = UDim.new(0, 8)
    PageLayout.Parent = PageScroll
    
    PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        PageScroll.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 10)
    end)
    
    table.insert(Pages, PageScroll)
    table.insert(TabButtons, TabBtn)
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, p in ipairs(Pages) do p.Visible = false end
        for _, b in ipairs(TabButtons) do 
            b.BackgroundColor3 = Color3.fromRGB(42, 46, 58)
            b.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        PageScroll.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 235)
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    return PageScroll
end

local function CreateLabel(page, text)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -4, 0, 28)
    Label.BackgroundTransparency = 1
    Label.Text = "  " .. text
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = page
    return Label
end

local function CreateToggle(page, title, callback)
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(1, -4, 0, 36)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 49, 62)
    ToggleBtn.Text = "  [ OFF ] - " .. title
    ToggleBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
    ToggleBtn.Font = Enum.Font.GothamSemibold
    ToggleBtn.TextSize = 13
    ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
    ToggleBtn.Parent = page
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = ToggleBtn
    
    local state = false
    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        ToggleBtn.Text = state and ("  [ ON ] - " .. title) or ("  [ OFF ] - " .. title)
        ToggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 140, 110) or Color3.fromRGB(45, 49, 62)
        callback(state)
    end)
end

local function CreateButton(page, title, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -4, 0, 36)
    Btn.BackgroundColor3 = Color3.fromRGB(0, 115, 200)
    Btn.Text = title
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 13
    Btn.Parent = page
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Btn
    
    Btn.MouseButton1Click:Connect(callback)
end

-- ==============================================================================
-- 3. CREACIÓN DE PESTAÑAS
-- ==============================================================================
local InfoPage = CreateTab("Info", 1)
local MainPage = CreateTab("Main", 2)
local AdvPage = CreateTab("F. Avanzadas", 3)
local ExtraPage = CreateTab("Extra Útiles", 4)

-- Activar pestaña 1 por defecto
InfoPage.Visible = true
TabButtons[1].BackgroundColor3 = Color3.fromRGB(0, 150, 235)
TabButtons[1].TextColor3 = Color3.fromRGB(255, 255, 255)

-- ==============================================================================
-- 4. PESTAÑA 1: INFO
-- ==============================================================================
CreateLabel(InfoPage, "Nombre del Creador: JoseAngel_Blox")
CreateLabel(InfoPage, "Fecha de lanzamiento: 01/08/2026")
CreateLabel(InfoPage, "Versión: 1.1")
CreateLabel(InfoPage, "Update: Nuevo Script sin Bugs")
CreateLabel(InfoPage, "Mayor compatibilidad con Móviles y PC")

-- ==============================================================================
-- 5. PESTAÑA 2: MAIN
-- ==============================================================================
CreateToggle(MainPage, "Auto Lanzado Perfecto", function(state)
    getgenv().AutoLaunch = state
    task.spawn(function()
        while getgenv().AutoLaunch do
            -- Envía evento al servidor con máxima potencia para el lanzamiento de bloque
            for _, rem in pairs(game:GetDescendants()) do
                if rem:IsA("RemoteEvent") and (rem.Name:lower():find("launch") or rem.Name:lower():find("throw") or rem.Name:lower():find("power")) then
                    rem:FireServer(math.huge)
                end
            end
            task.wait(1)
        end
    end)
end)

CreateToggle(MainPage, "Auto Recolectar (Dinero/Brainrots)", function(state)
    getgenv().AutoCollect = state
    task.spawn(function()
        while getgenv().AutoCollect do
            -- Teletransporta objetos caídos e interactuables directamente a tu personaje
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") then
                        fireproximityprompt(obj)
                    elseif obj:IsA("Tool") or (obj:IsA("BasePart") and obj.Name:lower():find("coin")) then
                        obj.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end)

CreateToggle(MainPage, "Auto Entrenar x2", function(state)
    getgenv().AutoTrain = state
    task.spawn(function()
        while getgenv().AutoTrain do
            for _, rem in pairs(game:GetDescendants()) do
                if rem:IsA("RemoteEvent") and (rem.Name:lower():find("train") or rem.Name:lower():find("brain") or rem.Name:lower():find("click")) then
                    rem:FireServer("x2")
                end
            end
            task.wait(0.1)
        end
    end)
end)

CreateToggle(MainPage, "Auto Renacer (Requisito Cumplido)", function(state)
    getgenv().AutoRebirth = state
    task.spawn(function()
        while getgenv().AutoRebirth do
            for _, rem in pairs(game:GetDescendants()) do
                if rem:IsA("RemoteEvent") and (rem.Name:lower():find("rebirth") or rem.Name:lower():find("prestige")) then
                    rem:FireServer(true) -- Conservando potenciadores
                end
            end
            task.wait(5)
        end
    end)
end)

CreateToggle(MainPage, "Auto Colocar Mejores Brainrots", function(state)
    getgenv().AutoEquipBest = state
    task.spawn(function()
        while getgenv().AutoEquipBest do
            for _, rem in pairs(game:GetDescendants()) do
                if rem:IsA("RemoteEvent") and (rem.Name:lower():find("equip") or rem.Name:lower():find("best") or rem.Name:lower():find("place")) then
                    rem:FireServer("Best")
                end
            end
            task.wait(4)
        end
    end)
end)

-- ==============================================================================
-- 6. PESTAÑA 3: FUNCIONES AVANZADAS
-- ==============================================================================
CreateToggle(AdvPage, "Auto Vender Repetidos/Bajos (Comunes)", function(state)
    getgenv().AutoSellLow = state
    task.spawn(function()
        while getgenv().AutoSellLow do
            for _, rem in pairs(game:GetDescendants()) do
                if rem:IsA("RemoteEvent") and rem.Name:lower():find("sell") then
                    rem:FireServer("Common")
                end
            end
            task.wait(3)
        end
    end)
end)

CreateButton(AdvPage, "Mejorar Todo (1-Click)", function()
    for _, rem in pairs(game:GetDescendants()) do
        if rem:IsA("RemoteEvent") and (rem.Name:lower():find("upgrade") or rem.Name:lower():find("buy")) then
            rem:FireServer("All")
        end
    end
end)

CreateToggle(AdvPage, "Ver Rareza y Valor en Pantalla", function(state)
    getgenv().ShowRarity = state
    -- Sistema de ESP/Billboard para mostrar información del premio y generación/seg
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Rarity") then
            if state and not obj:FindFirstChild("InfoTag") then
                local bg = Instance.new("BillboardGui", obj)
                bg.Name = "InfoTag"
                bg.Size = UDim2.new(0, 100, 0, 40)
                bg.AlwaysOnTop = true
                local lbl = Instance.new("TextLabel", bg)
                lbl.Size = UDim2.new(1, 0, 1, 0)
                lbl.BackgroundTransparency = 1
                lbl.Text = tostring(obj.Rarity.Value) .. " | $" .. tostring(obj:GetAttribute("GPS") or "0") .. "/s"
                lbl.TextColor3 = Color3.fromRGB(255, 215, 0)
                lbl.Font = Enum.Font.GothamBold
                lbl.TextSize = 12
            elseif not state and obj:FindFirstChild("InfoTag") then
                obj.InfoTag:Destroy()
            end
        end
    end
end)

CreateToggle(AdvPage, "Velocidad (50) & Salto Alto", function(state)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = state and 50 or 16
        LocalPlayer.Character.Humanoid.JumpPower = state and 85 or 50
    end
end)

CreateToggle(AdvPage, "Radar de Brainrots (Wallhack/ESP)", function(state)
    getgenv().BrainrotRadar = state
    task.spawn(function()
        while getgenv().BrainrotRadar do
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and (obj.Name:lower():find("brainrot") or obj:GetAttribute("Legendary")) then
                    if not obj:FindFirstChild("RadarHL") then
                        local hl = Instance.new("Highlight")
                        hl.Name = "RadarHL"
                        hl.FillColor = Color3.fromRGB(170, 0, 255)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        hl.Parent = obj
                    end
                end
            end
            task.wait(2)
        end
        -- Limpiar radar al apagar
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:FindFirstChild("RadarHL") then obj.RadarHL:Destroy() end
        end
    end)
end)

-- ==============================================================================
-- 7. PESTAÑA 4: EXTRA ÚTILES
-- ==============================================================================
CreateButton(ExtraPage, "Teletransporte: Ir a mi Base", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local base = workspace:FindFirstChild(LocalPlayer.Name .. "Base") or workspace:FindFirstChild("SpawnLocation")
        if base then
            LocalPlayer.Character.HumanoidRootPart.CFrame = base.CFrame + Vector3.new(0, 5, 0)
        end
    end
end)

CreateButton(ExtraPage, "Teletransporte: Punto de Lanzamiento", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local launch = workspace:FindFirstChild("LaunchPoint") or workspace:FindFirstChild("Cannon")
        if launch then
            LocalPlayer.Character.HumanoidRootPart.CFrame = launch.CFrame + Vector3.new(0, 5, 0)
        end
    end
end)

CreateToggle(ExtraPage, "Aviso de Premios Raros (Legendarios)", function(state)
    getgenv().RareAlert = state
    task.spawn(function()
        while getgenv().RareAlert do
            -- Envía notificación si detecta un drop legendario cerca
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:GetAttribute("Rarity") == "Legendary" or obj.Name:lower():find("legendary") then
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "¡BRAINROT LEGENDARIO!";
                        Text = "¡Se ha detectado un drop exclusivo en el mapa!";
                        Duration = 3;
                    })
                    task.wait(5)
                end
            end
            task.wait(1.5)
        end
    end)
end)

CreateToggle(ExtraPage, "Protección Anti-Vacío (Anti-Void)", function(state)
    getgenv().AntiVoid = state
    task.spawn(function()
        while getgenv().AntiVoid do
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                if LocalPlayer.Character.HumanoidRootPart.Position.Y < -30 then
                    -- Te regresa al punto seguro de reaparición si caes al vacío
                    LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.zero
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 35, 0)
                end
            end
            task.wait(0.2)
        end
    end)
end)

CreateButton(ExtraPage, "Guardar Configuración", function()
    -- Guarda tu configuración actual como archivo JSON en el Executor
    if writefile then
        local config = {
            AutoLaunch = getgenv().AutoLaunch or false,
            AutoCollect = getgenv().AutoCollect or false,
            AutoTrain = getgenv().AutoTrain or false
        }
        writefile("JoseAngel_BrainBlast_Config.json", game:GetService("HttpService"):JSONEncode(config))
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "JoseAngel_Blox";
            Text = "Configuración guardada en tu dispositivo.";
            Duration = 3;
        })
    end
end)
