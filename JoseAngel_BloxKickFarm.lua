-- ==========================================
-- SCRIPT NATIVO: JoseAngel_Blox Kick Farm V2.0
-- (Con selectores visuales personalizados)
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local guiName = "JoseAngel_Blox_KickFarm_V2"

-- 1. Evitar ventanas duplicadas
if CoreGui:FindFirstChild(guiName) then
    CoreGui:FindFirstChild(guiName):Destroy()
end

-- 2. Crear ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = guiName
ScreenGui.Parent = CoreGui

-- ==========================================
-- BOTÓN PARA ACTIVAR / DESACTIVAR EL SCRIPT
-- ==========================================
local ToggleGuiBtn = Instance.new("TextButton")
ToggleGuiBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleGuiBtn.Position = UDim2.new(0, 15, 0.5, -22) -- A un lado de la pantalla
ToggleGuiBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleGuiBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleGuiBtn.Text = "JB\nMenu"
ToggleGuiBtn.Font = Enum.Font.GothamBold
ToggleGuiBtn.TextSize = 12
ToggleGuiBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleGuiBtn).CornerRadius = UDim.new(1, 0) -- Lo hace un círculo perfecto

-- ==========================================
-- INTERFAZ PRINCIPAL (Cuadrada con bordes redondeados)
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 320)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -160) -- Centrado
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Draggable = true -- Se puede deslizar por la pantalla
MainFrame.Active = true
MainFrame.Visible = true -- Visible por defecto para el primer arranque
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12) -- Esquinas redondeadas

-- Funcionalidad del botón de ocultar/mostrar
ToggleGuiBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- ==========================================
-- TEXTOS DE LA CABECERA
-- ==========================================
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox Kick Farm"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = MainFrame

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0, 28)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Creado por JoseAngel_Blox"
SubTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 13
SubTitle.Parent = MainFrame

-- ==========================================
-- PANELES (Izquierdo: Pestañas | Derecho: Funciones)
-- ==========================================
local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0, 140, 1, -65)
LeftPanel.Position = UDim2.new(0, 15, 0, 55)
LeftPanel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
LeftPanel.Parent = MainFrame
Instance.new("UICorner", LeftPanel).CornerRadius = UDim.new(0, 8)

local RightPanel = Instance.new("Frame")
RightPanel.Size = UDim2.new(1, -175, 1, -65)
RightPanel.Position = UDim2.new(0, 165, 0, 55)
RightPanel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
RightPanel.Parent = MainFrame
Instance.new("UICorner", RightPanel).CornerRadius = UDim.new(0, 8)

-- Contenedores de cada pestaña
local InfoContainer = Instance.new("Frame")
InfoContainer.Size = UDim2.new(1, 0, 1, 0)
InfoContainer.BackgroundTransparency = 1
InfoContainer.Visible = false -- Oculto al inicio
InfoContainer.Parent = RightPanel

local MainContainer = Instance.new("Frame")
MainContainer.Size = UDim2.new(1, 0, 1, 0)
MainContainer.BackgroundTransparency = 1
MainContainer.Visible = true -- Visible por defecto
MainContainer.Parent = RightPanel

-- Layouts
local UIListLayoutMain = Instance.new("UIListLayout", MainContainer)
UIListLayoutMain.Padding = UDim.new(0, 15)
local UIPaddingMain = Instance.new("UIPadding", MainContainer)
UIPaddingMain.PaddingTop = UDim.new(0, 15)
UIPaddingMain.PaddingLeft = UDim.new(0, 15)
UIPaddingMain.PaddingRight = UDim.new(0, 15)

local UIListLayoutInfo = Instance.new("UIListLayout", InfoContainer)
UIListLayoutInfo.Padding = UDim.new(0, 12)
local UIPaddingInfo = Instance.new("UIPadding", InfoContainer)
UIPaddingInfo.PaddingTop = UDim.new(0, 15)
UIPaddingInfo.PaddingLeft = UDim.new(0, 15)
UIPaddingInfo.PaddingRight = UDim.new(0, 15)

-- ==========================================
-- CREACIÓN DE PESTAÑAS (Lado Izquierdo)
-- ==========================================
local UIListLayoutLeft = Instance.new("UIListLayout", LeftPanel)
UIListLayoutLeft.Padding = UDim.new(0, 8)
local UIPaddingLeft = Instance.new("UIPadding", LeftPanel)
UIPaddingLeft.PaddingTop = UDim.new(0, 10)
UIPaddingLeft.PaddingLeft = UDim.new(0, 10)
UIPaddingLeft.PaddingRight = UDim.new(0, 10)

local function CreateTab(text, container, isMain)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = isMain and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = LeftPanel
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    btn.MouseButton1Click:Connect(function()
        InfoContainer.Visible = false
        MainContainer.Visible = false
        container.Visible = true
        
        -- Reiniciar colores
        for _, child in pairs(LeftPanel:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            end
        end
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60) -- Ilumina la seleccionada
    end)
    return btn
end

-- Crear pestañas, 'Main' es la primera
local TabMain = CreateTab("2) Main ↓", MainContainer, true)
local TabInfo = CreateTab("1) info ↓", InfoContainer, false)

-- ==========================================
-- CONTENIDO: PESTAÑA INFO
-- ==========================================
local function AddInfoText(text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 20)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
    lbl.TextWrapped = true
    lbl.Parent = InfoContainer
end

AddInfoText("Nombre del creador: JoseAngel_Blox")
AddInfoText("Fecha de lanzamiento: 27/07/2026")
AddInfoText("Versión: 1.2")
AddInfoText("Update: Añadidos selectores visuales nativos estilo iOS, optimización gráfica.")

-- ==========================================
-- COMPONENTE DE SELECTOR VISUAL (TOGGLE) NATIVO
-- (Sin librerías, estilo image_0.png)
-- ==========================================
local TweenService = game:GetService("TweenService")

local function CreateVisualToggle(parent, text, text_below)
    local toggleRow = Instance.new("Frame")
    toggleRow.Size = UDim2.new(1, 0, 0, 50)
    toggleRow.BackgroundTransparency = 1
    toggleRow.Parent = parent
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(0.6, 0, 1, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 16
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = toggleRow

    if text_below then
        local subTextLabel = Instance.new("TextLabel")
        subTextLabel.Size = UDim2.new(1, 0, 0, 16)
        subTextLabel.Position = UDim2.new(0, 0, 0.7, 0)
        subTextLabel.BackgroundTransparency = 1
        subTextLabel.Text = text_below
        subTextLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        subTextLabel.Font = Enum.Font.Gotham
        subTextLabel.TextSize = 12
        subTextLabel.TextXAlignment = Enum.TextXAlignment.Left
        subTextLabel.Parent = textLabel
    end

    -- El interruptor visual en sí
    local toggleSwitch = Instance.new("Frame")
    toggleSwitch.Size = UDim2.new(0, 50, 0, 26) -- Proporciones estilo image_0.png
    toggleSwitch.Position = UDim2.new(1, -55, 0.5, -13) -- A la derecha, centrado verticalmente
    toggleSwitch.BackgroundColor3 = Color3.fromRGB(220, 220, 220) -- Color OFF por defecto (gris claro)
    toggleSwitch.Active = true
    toggleSwitch.Parent = toggleRow
    local switchCorner = Instance.new("UICorner", toggleSwitch)
    switchCorner.CornerRadius = UDim.new(1, 0) -- Totalmente redondeado

    local toggleSlider = Instance.new("Frame")
    toggleSlider.Size = UDim2.new(0, 22, 0, 22) -- El círculo
    toggleSlider.Position = UDim2.new(0, 2, 0, 2) -- Posición OFF por defecto (izquierda)
    toggleSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleSlider.Parent = toggleSwitch
    local sliderCorner = Instance.new("UICorner", toggleSlider)
    sliderCorner.CornerRadius = UDim.new(1, 0) -- Totalmente redondeado

    return toggleSwitch, toggleSlider
end

-- ==========================================
-- CONTENIDO: PESTAÑA MAIN (Con selectores)
-- ==========================================

-- Servicios necesarios
local VirtualUser = game:GetService("VirtualUser")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Definir colores para ON y OFF
local colorOn = Color3.fromRGB(50, 200, 50) -- Verde image_0.png
local colorOff = Color3.fromRGB(220, 220, 220) -- Gris image_0.png

-- Crear Toggles
local pkSwitch, pkSlider = CreateVisualToggle(MainContainer, "Perfect Kick")
local afSwitch, afSlider = CreateVisualToggle(MainContainer, "Auto Farm", "Go to Safe Zone fast")

-- Lógica de animación y estado
local function HandleToggle(switch, slider, callback)
    local isOn = false
    
    switch.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isOn = not isOn
            
            local switchTween, sliderTween
            if isOn then
                -- Tween a ON
                switchTween = TweenService:Create(switch, TweenInfo.new(0.25), {BackgroundColor3 = colorOn})
                sliderTween = TweenService:Create(slider, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(1, -24, 0, 2)})
            else
                -- Tween a OFF
                switchTween = TweenService:Create(switch, TweenInfo.new(0.25), {BackgroundColor3 = colorOff})
                sliderTween = TweenService:Create(slider, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 2, 0, 2)})
            end
            
            switchTween:Play()
            sliderTween:Play()
            
            callback(isOn)
        end
    end)
end

-- ==========================================
-- LÓGICA DE LAS FUNCIONES MAIN
-- ==========================================

-- Perfect Kick
local pkActivo = false
HandleToggle(pkSwitch, pkSlider, function(isOn)
    pkActivo = isOn
    if pkActivo then
        task.spawn(function()
            while pkActivo do
                VirtualUser:ClickButton1(Vector2.new(0,0))
                task.wait(0.01) -- Velocidad ultra rápida optimizada
            end
        end)
    end
end)

-- Auto Farm (Safe zone + Velocidad)
local afActivo = false
HandleToggle(afSwitch, afSlider, function(isOn)
    afActivo = isOn
    if afActivo then
        -- Primero se asegura de teletransportar a la zona segura
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        
        if humanoid and rootPart then
            humanoid.WalkSpeed = 100 
            
            local safeZone = workspace:FindFirstChild("SpawnLocation", true)
            if safeZone and safeZone:IsA("SpawnLocation") then
                rootPart.CFrame = safeZone.CFrame + Vector3.new(0, 5, 0)
            end
        end
        
        -- Luego mantiene la velocidad mientras el toggle esté activo
        task.spawn(function()
            while afActivo do
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 100
                end
                task.wait(1) -- Verifica y aplica velocidad cada segundo
            end
        end)
    else
        -- Al apagar el toggle, restablece la velocidad
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16 -- Velocidad normal por defecto
        end
    end
end)
