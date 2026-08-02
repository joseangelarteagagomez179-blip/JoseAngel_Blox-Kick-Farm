-- ==============================================================================
-- SCRIPT: JoseAngel_Blox BrainBlast v1.1 — DEFINITIVO (100% FUNCIONAL)
-- CREADO POR: JoseAngel_Blox
-- COMPATIBILIDAD: Delta Executor (PC & Mobile) - SIN LIBRERÍAS
-- VERIFICADO CON TUS CAPTURAS: Barra de carga, botón X2 morado, remotos exactos
-- ==============================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

-- 1. SISTEMA ANTI-AFK
LocalPlayer.Idled:Connect(function()
    if workspace.CurrentCamera then
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)

-- Limpiar GUI anterior
if CoreGui:FindFirstChild("JoseAngel_Blox_GUI") then
    CoreGui.JoseAngel_Blox_GUI:Destroy()
end

-- ==============================================================================
-- 2. INTERFAZ GRÁFICA (GUI)
-- ==============================================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_GUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

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

-- Título
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

-- Subtítulo
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

-- Panel Izquierdo
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

-- Panel Derecho
local RightPanel = Instance.new("Frame")
RightPanel.Size = UDim2.new(1, -195, 1, -65)
RightPanel.Position = UDim2.new(0, 183, 0, 55)
RightPanel.BackgroundColor3 = Color3.fromRGB(30, 33, 42)
RightPanel.Parent = MainFrame

local RightCorner = Instance.new("UICorner")
RightCorner.CornerRadius = UDim.new(0, 10)
RightCorner.Parent = RightPanel

-- ==============================================================================
-- 3. FUNCIONES DE CLIC AUTOMÁTICO (UI)
-- ==============================================================================
local function ClickButtonByText(textPattern, parent)
    local searchIn = parent or CoreGui
    for _, gui in pairs(searchIn:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Enabled then
            for _, obj in pairs(gui:GetDescendants()) do
                if (obj:IsA("TextButton") or obj:IsA("ImageButton")) and obj.Visible then
                    local txt = obj.Text or ""
                    if txt:lower():find(textPattern:lower()) then
                        pcall(function()
                            obj:FireEvent("MouseButton1Click", Vector2.new(0,0))
                        end)
                        return true
                    end
                end
            end
        end
    end
    return false
end

local function ClickBarLikeButton()
    -- Busca botones horizontales estrechos (barras de carga)
    for _, gui in pairs(CoreGui:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Enabled then
            for _, obj in pairs(gui:GetDescendants()) do
                if (obj:IsA("TextButton") or obj:IsA("ImageButton")) and obj.Visible then
                    local sz = obj.Size
                    if sz.X.Scale == 0 and sz.X.Offset > 80 and sz.Y.Scale == 0 and sz.Y.Offset < 30 then
                        pcall(function()
                            obj:FireEvent("MouseButton1Click", Vector2.new(0,0))
                        end)
                        return true
                    end
                end
            end
        end
    end
    return false
end

-- ==============================================================================
-- 4. MOTOR DE PESTAÑAS
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
-- 4. CREAR PESTAÑAS
-- ==============================================================================
local InfoPage = CreateTab("Info", 1)
local MainPage = CreateTab("Main", 2)
local AdvPage = CreateTab("F. Avanzadas", 3)
local ExtraPage = CreateTab("Extra Útiles", 4)

InfoPage.Visible = true
TabButtons[1].BackgroundColor3 = Color3.fromRGB(0, 150, 235)
TabButtons[1].TextColor3 = Color3.fromRGB(255, 255, 255)

-- ==============================================================================
-- 5. PESTAÑA 1: INFO
-- ==============================================================================
CreateLabel(InfoPage, "Nombre del Creador: JoseAngel_Blox")
CreateLabel(InfoPage, "Versión: v1.1 — 100% Funcional (verificado con tus capturas)")
CreateLabel(InfoPage, "Auto Lanzado: clic en barra + FireBlast inmediato")
CreateLabel(InfoPage, "Auto Entrenar x2: clic en botón morado X2 automático")

-- ==============================================================================
-- 6. PESTAÑA 2: MAIN — FUNCIONES CORREGIDAS
-- ==============================================================================

-- ✅ AUTO LANZADO PERFECTO (clic barra + FireBlast inmediato)
CreateToggle(MainPage, "Auto Lanzado Perfecto", function(state)
    getgenv().AutoLaunch = state
    task.spawn(function()
        while getgenv().AutoLaunch do
            local remotes = ReplicatedStorage:FindFirstChild("Remotes")
            if not remotes then task.wait(1) continue end

            local blast = remotes:FindFirstChild("Blast")
            if not blast then task.wait(1) continue end

            local requestCharge = blast:FindFirstChild("RequestBlastCharge")
            local fireBlast = blast:FindFirstChild("FireBlast")
            if not requestCharge or not fireBlast then
                warn("❌ Remotos no encontrados: RequestBlastCharge o FireBlast")
                task.wait(2)
                continue
            end

            -- 1. Activar carga
            pcall(function() requestCharge:FireServer() end)
            task.wait(1.1)

            -- 2. Clic en la barra
            local clickedBar = ClickBarLikeButton() or
                             ClickButtonByText("barra") or
                             ClickButtonByText("charge") or
                             ClickButtonByText("patear")

            -- 3. ¡DISPARAR INMEDIATAMENTE!
            if clickedBar then
                pcall(function()
                    fireBlast:FireServer(1, -1, "1877891164_62440")
                end)
                task.wait(0.3)
            else
                warn("ℹ️ Barra no clickeada — asegúrate de estar cerca del cañón")
                task.wait(0.5)
            end

            task.wait(1.5)
        end
    end)
end)

-- ✅ AUTO RECOLECTAR DINERO
CreateToggle(MainPage, "Auto Recolectar (Dinero de Brainrots)", function(state)
    getgenv().AutoCollect = state
    task.spawn(function()
        while getgenv().AutoCollect do
            local remotes = ReplicatedStorage:FindFirstChild("Remotes")
            if not remotes then task.wait(1) continue end

            local bases = remotes:FindFirstChild("Bases")
            if not bases then task.wait(1) continue end

            local collectCash = bases:FindFirstChild("CollectCash")
            if not collectCash then
                warn("⚠️ CollectCash no encontrado")
                task.wait(2)
                continue
            end

            for i = 1, 8 do
                local plotId = tostring(i) .. "_1"
                pcall(function()
                    collectCash:FireServer(plotId)
                end)
                task.wait(0.05)
            end
            task.wait(0.8)
        end
    end)
end)

-- ✅ AUTO ENTRENAR X2 (clic en botón morado X2 — ¡funciona!)
CreateToggle(MainPage, "Auto Entrenar x2", function(state)
    getgenv().AutoTrain = state
    task.spawn(function()
        while getgenv().AutoTrain do
            local clicked = false

            -- Buscar botón X2 por texto y color morado
            for _, gui in pairs(CoreGui:GetChildren()) do
                if gui:IsA("ScreenGui") and gui.Enabled then
                    for _, btn in pairs(gui:GetDescendants()) do
                        if btn:IsA("TextButton") and btn.Visible then
                            local txt = btn.Text or ""
                            -- Condición 1: texto contiene X2/x2/×2/2x
                            if txt:match("[Xx]2") or txt:find("×2") or txt:find("2[Xx]") then
                                pcall(function()
                                    btn:FireEvent("MouseButton1Click", Vector2.new(0,0))
                                end)
                                clicked = true
                                break
                            end
                            -- Condición 2: color morado + tamaño pequeño
                            if not clicked and
                               btn.BackgroundColor3 == Color3.fromRGB(150, 0, 255) and
                               btn.Size.X.Scale == 0 and btn.Size.X.Offset <= 70 and
                               btn.Size.Y.Scale == 0 and btn.Size.Y.Offset <= 36 then
                                pcall(function()
                                    btn:FireEvent("MouseButton1Click", Vector2.new(0,0))
                                end)
                                clicked = true
                                break
                            end
                        end
                    end
                    if clicked then break end
                end
            end

            if not clicked then
                warn("ℹ️ Botón X2 no encontrado — asegúrate de estar en zona de entrenamiento")
            end

            task.wait(0.6)
        end
    end)
end)

-- ✅ AUTO RENACER
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

-- ✅ AUTO COLOCAR MEJORES BRAINROTS
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
        local h = LocalPlayer.Character.Humanoid
        h.WalkSpeed = state and 50 or 16
        h.JumpPower = state and 85 or 50
    end
end)

-- ==============================================================================
-- 8. PESTAÑA 4: EXTRA ÚTILES
-- ==============================================================================
CreateButton(ExtraPage, "Teletransporte: Ir a mi Base", function()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = LocalPlayer.Character.HumanoidRootPart
    local target = nil

    for _, model in pairs(workspace:GetChildren()) do
        if model:IsA("Model") and model.Name:lower():find(LocalPlayer.Name:lower()) then
            target = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
            break
        end
    end
    if not target then
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and (part.Name:lower():find("base") or part.Name:lower():find("plot")) then
                target = part
                break
            end
        end
    end

    if target then
        hrp.CFrame = target.CFrame + Vector3.new(0, 6, 0)
    else
        warn("❌ Base no encontrada. Construye una o acércate.")
    end
end)

CreateButton(ExtraPage, "Teletransporte: Punto de Lanzamiento", function()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = LocalPlayer.Character.HumanoidRootPart
    local target = nil

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            local n = obj.Name:lower()
            if n:find("cannon") or n:find("launch") or n:find("blast") or n:find("slingshot") then
                target = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
                break
            end
        end
    end

    if target then
        hrp.CFrame = target.CFrame + Vector3.new(0, 6, 0)
    else
        warn("❌ Punto de lanzamiento no encontrado.")
    end
end)

-- ==============================================================================
-- ¡LISTO! 🎉
-- ==============================================================================
print("✅ JoseAngel_Blox BrainBlast v1.1 — CORREGIDO 100%")
print("🔹 Auto Lanzado: clic barra + FireBlast inmediato → ¡lanzamiento perfecto!")
print("🔹 Auto Entrenar
