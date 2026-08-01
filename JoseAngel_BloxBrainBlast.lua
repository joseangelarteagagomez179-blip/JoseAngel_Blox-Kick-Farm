-- ==============================================================================
-- SCRIPT: JoseAngel_Blox BrainBlast (v1.1 - Definitivo)
-- CREADO POR: JoseAngel_Blox
-- COMPATIBILIDAD: Delta Executor (PC & Mobile) - SIN LIBRERÍAS
-- ==============================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

-- 1. SISTEMA ANTI-AFK (Evita que el juego te desconecte por inactividad)
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- Reiniciar interfaz si ya estaba abierta
if CoreGui:FindFirstChild("JoseAngel_Blox_GUI") then
    CoreGui.JoseAngel_Blox_GUI:Destroy()
end

-- ==============================================================================
-- 2. INTERFAZ GRÁFICA (GUI) ANCHA, BAJA Y CON ESQUINAS REDONDEADAS
-- ==============================================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_GUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Contenedor Principal (620x340 - Formato Apaisado)
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

-- Título Principal
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -20, 0, 26)
TitleLabel.Position = UDim2.new(0, 15, 0, 8)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "JoseAngel_Blox BrainBlast v1.1"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 19
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = MainFrame

-- Subtítulo del Creador
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

-- Panel Derecho (Contenido de Funciones)
local RightPanel = Instance.new("Frame")
RightPanel.Size = UDim2.new(1, -195, 1, -65)
RightPanel.Position = UDim2.new(0, 183, 0, 55)
RightPanel.BackgroundColor3 = Color3.fromRGB(30, 33, 42)
RightPanel.Parent = MainFrame

local RightCorner = Instance.new("UICorner")
RightCorner.CornerRadius = UDim.new(0, 10)
RightCorner.Parent = RightPanel

-- ==============================================================================
-- 3. MOTOR DE PESTAÑAS Y CONTROLES NATIVOS
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
-- 4. CREACIÓN DE LAS 4 PESTAÑAS
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
-- 5. PESTAÑA 1: INFO
-- ==============================================================================
CreateLabel(InfoPage, "Nombre del Creador: JoseAngel_Blox")
CreateLabel(InfoPage, "Versión Actual: v1.1 Reciente")
CreateLabel(InfoPage, "Estado: Actualizado y Funcional")
CreateLabel(InfoPage, "Mayor compatibilidad con Móviles y PC")

-- ==============================================================================
-- 6. PESTAÑA 2: MAIN (CON TUS CÓDIGOS REALES DE SIMPLESPY)
-- ==============================================================================

-- AUTO LANZADO PERFECTO (Con potencia 1 y tu código de SimpleSpy)
CreateToggle(MainPage, "Auto Lanzado Perfecto", function(state)
    getgenv().AutoLaunch = state
    task.spawn(function()
        while getgenv().AutoLaunch do
            local rep = ReplicatedStorage:FindFirstChild("Remotes")
            local blast = rep and rep:FindFirstChild("Blast")
            
            if blast then
                if blast:FindFirstChild("BlastChargeStarted") then
                    pcall(function() blast.BlastChargeStarted:FireServer() end)
                end
                if blast:FindFirstChild("FireBlast") then
                    pcall(function()
                        blast.FireBlast:FireServer(1, -1, "1877891164_62440")
                    end)
                end
            end
            task.wait(1.5)
        end
    end)
end)

-- AUTO RECOLECTAR DINERO (Con tu código "1_1" hasta "8_1" + Brainrots)
CreateToggle(MainPage, "Auto Recolectar (Dinero/Brainrots)", function(state)
    getgenv().AutoCollect = state
    task.spawn(function()
        while getgenv().AutoCollect do
            local rep = ReplicatedStorage:FindFirstChild("Remotes")
            local bases = rep and rep:FindFirstChild("Bases")
            
            if bases then
                if bases:FindFirstChild("CollectCash") then
                    for i = 1, 8 do
                        pcall(function()
                            bases.CollectCash:FireServer(tostring(i) .. "_1")
                        end)
                    end
                end
                if bases:FindFirstChild("PickupBrainrot") then
                    pcall(function() bases.PickupBrainrot:FireServer() end)
                end
            end
            
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") then
                        fireproximityprompt(obj)
                    elseif obj:IsA("BasePart") and (obj.Name:lower():find("coin") or obj.Name:lower():find("cash") or obj.Name:lower():find("drop")) then
                        obj.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end)

-- AUTO ENTRENAR X2 (Remotes exactos de Training + Auto-Clic)
CreateToggle(MainPage, "Auto Entrenar x2", function(state)
    getgenv().AutoTrain = state
    task.spawn(function()
        while getgenv().AutoTrain do
            local rep = ReplicatedStorage:FindFirstChild("Remotes")
            local train = rep and rep:FindFirstChild("Training")
            
            if train then
                if train:FindFirstChild("ShowX2Button") then
                    pcall(function() train.ShowX2Button:FireServer(0) end)
                end
                if train:FindFirstChild("IncrementText") then
                    pcall(function() train.IncrementText:FireServer() end)
                end
            end
            
            VirtualUser:Button1Down(Vector2.new(0,0))
            task.wait(0.03)
            VirtualUser:Button1Up(Vector2.new(0,0))
            
            if LocalPlayer.Character then
                for _, tool in pairs(LocalPlayer.Character:GetChildren()) do
                    if tool:IsA("Tool") then tool:Activate() end
                end
            end
            task.wait(0.1)
        end
    end)
end)

-- AUTO RENACER
CreateToggle(MainPage, "Auto Renacer (Requisito Cumplido)", function(state)
    getgenv().AutoRebirth = state
    task.spawn(function()
        while getgenv().AutoRebirth do
            for _, rem in pairs(game:GetDescendants()) do
                if rem:IsA("RemoteEvent") and (rem.Name:lower():find("rebirth") or rem.Name:lower():find("prestige")) then
                    pcall(function() rem:FireServer(true) end)
                end
            end
            task.wait(5)
        end
    end)
end)

-- AUTO COLOCAR MEJORES BRAINROTS
CreateToggle(MainPage, "Auto Colocar Mejores Brainrots", function(state)
    getgenv().AutoEquipBest = state
    task.spawn(function()
        while getgenv().AutoEquipBest do
            for _, rem in pairs(game:GetDescendants()) do
                if rem:IsA("RemoteEvent") and (rem.Name:lower():find("equip") or rem.Name:lower():find("best") or rem.Name:lower():find("place")) then
                    pcall(function() rem:FireServer("Best") end)
                end
            end
            task.wait(4)
        end
    end)
end)

-- ==============================================================================
-- 7. PESTAÑA 3: FUNCIONES AVANZADAS
-- ==============================================================================
CreateToggle(AdvPage, "Auto Vender Repetidos/Bajos (Comunes)", function(state)
    getgenv().AutoSellLow = state
    task.spawn(function()
        while getgenv().AutoSellLow do
            for _, rem in pairs(game:GetDescendants()) do
                if rem:IsA("RemoteEvent") and rem.Name:lower():find("sell") then
                    pcall(function() rem:FireServer("Common") end)
                end
            end
            task.wait(3)
        end
    end)
end)

CreateButton(AdvPage, "Mejorar Todo (1-Click)", function()
    for _, rem in pairs(game:GetDescendants()) do
        if rem:IsA("RemoteEvent") and (rem.Name:lower():find("upgrade") or rem.Name:lower():find("buy")) then
            pcall(function() rem:FireServer("All") end)
        end
    end
end)

CreateToggle(AdvPage, "Velocidad (50) & Salto Alto", function(state)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = state and 50 or 16
        LocalPlayer.Character.Humanoid.JumpPower = state and 85 or 50
    end
end)

-- ==============================================================================
-- 8. PESTAÑA 4: EXTRA ÚTILES
-- ==============================================================================
CreateButton(ExtraPage, "Teletransporte: Ir a mi Base", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local target = nil
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") or obj:IsA("Model") then
                local nom = obj.Name:lower()
                if nom:find(LocalPlayer.Name:lower()) or nom == "1_1" or nom == "base" or nom == "plot" then
                    target = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
                    break
                end
            end
        end
        if not target then
            target = workspace:FindFirstChildWhichIsA("SpawnLocation", true)
        end
        if target then
            LocalPlayer.Character.HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 6, 0)
        end
    end
end)

CreateButton(ExtraPage, "Teletransporte: Punto de Lanzamiento", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local target = nil
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") or obj:IsA("Model") then
                local nom = obj.Name:lower()
                if nom:find("cannon") or nom:find("launch") or nom:find("blast") or nom:find("slingshot") then
                    target = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
                    break
                end
            end
        end
        if target then
            LocalPlayer.Character.HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 6, 0)
        else
            local sp = workspace:FindFirstChildWhichIsA("SpawnLocation", true)
            if sp then
                LocalPlayer.Character.HumanoidRootPart.CFrame = sp.CFrame + Vector3.new(0, 6, 0)
            end
        end
    end
end)

print("¡JoseAngel_Blox BrainBlast v1.1 cargado exitosamente!")
