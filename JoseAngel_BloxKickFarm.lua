-- ==========================================
-- SCRIPT NATIVO: JoseAngel_Blox Kick Farm V1.1 (DEFINITIVO)
-- Universal (PC & Móvil) para Delta Executor
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local guiName = "JoseAngel_Blox_KickFarm_V1.1"

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
ToggleGuiBtn.Position = UDim2.new(0, 15, 0.5, -22)
ToggleGuiBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleGuiBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleGuiBtn.Text = "JB\nMenu"
ToggleGuiBtn.Font = Enum.Font.GothamBold
ToggleGuiBtn.TextSize = 12
ToggleGuiBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleGuiBtn).CornerRadius = UDim.new(1, 0)

-- ==========================================
-- INTERFAZ PRINCIPAL
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 320)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Active = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

ToggleGuiBtn.Activated:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- ==========================================
-- SISTEMA DE ARRASTRE UNIVERSAL (PC & MÓVIL)
-- ==========================================
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
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
-- PANELES
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

-- Contenedores
local InfoContainer = Instance.new("ScrollingFrame") -- Cambiado a ScrollingFrame por seguridad si el texto es grande
InfoContainer.Size = UDim2.new(1, 0, 1, 0)
InfoContainer.BackgroundTransparency = 1
InfoContainer.Visible = true 
InfoContainer.CanvasSize = UDim2.new(0, 0, 0, 200)
InfoContainer.ScrollBarThickness = 4
InfoContainer.Parent = RightPanel

local MainContainer = Instance.new("Frame")
MainContainer.Size = UDim2.new(1, 0, 1, 0)
MainContainer.BackgroundTransparency = 1
MainContainer.Visible = false 
MainContainer.Parent = RightPanel

-- Layouts
local UIListLayoutMain = Instance.new("UIListLayout", MainContainer)
UIListLayoutMain.Padding = UDim.new(0, 15)
local UIPaddingMain = Instance.new("UIPadding", MainContainer)
UIPaddingMain.PaddingTop = UDim.new(0, 15)
UIPaddingMain.PaddingLeft = UDim.new(0, 15)
UIPaddingMain.PaddingRight = UDim.new(0, 15)

local UIListLayoutInfo = Instance.new("UIListLayout", InfoContainer)
UIListLayoutInfo.Padding = UDim.new(0, 10)
local UIPaddingInfo = Instance.new("UIPadding", InfoContainer)
UIPaddingInfo.PaddingTop = UDim.new(0, 15)
UIPaddingInfo.PaddingLeft = UDim.new(0, 15)
UIPaddingInfo.PaddingRight = UDim.new(0, 15)

-- ==========================================
-- CREACIÓN DE PESTAÑAS
-- ==========================================
local UIListLayoutLeft = Instance.new("UIListLayout", LeftPanel)
UIListLayoutLeft.Padding = UDim.new(0, 8)
UIListLayoutLeft.SortOrder = Enum.SortOrder.LayoutOrder
local UIPaddingLeft = Instance.new("UIPadding", LeftPanel)
UIPaddingLeft.PaddingTop = UDim.new(0, 10)
UIPaddingLeft.PaddingLeft = UDim.new(0, 10)
UIPaddingLeft.PaddingRight = UDim.new(0, 10)

local function CreateTab(text, container, isDefault, layoutOrder)
    local btn = Instance.new("TextButton")
    btn.LayoutOrder = layoutOrder
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = isDefault and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = LeftPanel
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    btn.Activated:Connect(function()
        InfoContainer.Visible = false
        MainContainer.Visible = false
        container.Visible = true
        
        for _, child in pairs(LeftPanel:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            end
        end
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)
    return btn
end

local TabInfo = CreateTab("1) info ↓", InfoContainer, true, 1)
local TabMain = CreateTab("2) Main ↓", MainContainer, false, 2)

-- ==========================================
-- CONTENIDO: PESTAÑA INFO (Ajustado Multilínea)
-- ==========================================
local function AddInfoText(text, height)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, height or 25)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextYAlignment = Enum.TextYAlignment.Top
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
    lbl.TextWrapped = true
    lbl.Parent = InfoContainer
end

AddInfoText("Nombre del creador: JoseAngel_Blox")
AddInfoText("Fecha de lanzamiento: 27/07/2026")
AddInfoText("Versión: 1.1")
AddInfoText("Update: Nuevo script 100% funcional sin lag mayor compatibilidad 0bugs disfruta del script atentamente JoseAngel_Blox", 55)

-- ==========================================
-- COMPONENTE DE SELECTOR (TOGGLE UNIVERSAL)
-- ==========================================
local function CreateVisualToggle(parent, text, text_below)
    local toggleRow = Instance.new("Frame")
    toggleRow.Size = UDim2.new(1, 0, 0, 50)
    toggleRow.BackgroundTransparency = 1
    toggleRow.Parent = parent
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(0.6, 0, 1, 0)
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

    local toggleSwitch = Instance.new("Frame")
    toggleSwitch.Size = UDim2.new(0, 50, 0, 26)
    toggleSwitch.Position = UDim2.new(1, -55, 0.5, -13)
    toggleSwitch.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    toggleSwitch.Parent = toggleRow
    Instance.new("UICorner", toggleSwitch).CornerRadius = UDim.new(1, 0)

    local toggleSlider = Instance.new("Frame")
    toggleSlider.Size = UDim2.new(0, 22, 0, 22)
    toggleSlider.Position = UDim2.new(0, 2, 0, 2)
    toggleSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleSlider.Parent = toggleSwitch
    Instance.new("UICorner", toggleSlider).CornerRadius = UDim.new(1, 0)

    local clickButton = Instance.new("TextButton")
    clickButton.Size = UDim2.new(1, 0, 1, 0)
    clickButton.BackgroundTransparency = 1
    clickButton.Text = ""
    clickButton.ZIndex = 10
    clickButton.Parent = toggleRow

    return toggleSwitch, toggleSlider, clickButton
end

-- ==========================================
-- CONTENIDO: PESTAÑA MAIN (Lógica y Funciones)
-- ==========================================
local colorOn = Color3.fromRGB(50, 200, 50)
local colorOff = Color3.fromRGB(220, 220, 220)

local pkSwitch, pkSlider, pkButton = CreateVisualToggle(MainContainer, "Perfect Kick")
local afSwitch, afSlider, afButton = CreateVisualToggle(MainContainer, "Auto farm", "Regresar a safe zone rápido")

local function HandleToggle(switch, slider, button, callback)
    local isOn = false
    button.Activated:Connect(function()
        isOn = not isOn
        
        local switchTween, sliderTween
        if isOn then
            switchTween = TweenService:Create(switch, TweenInfo.new(0.2), {BackgroundColor3 = colorOn})
            sliderTween = TweenService:Create(slider, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(1, -24, 0, 2)})
        else
            switchTween = TweenService:Create(switch, TweenInfo.new(0.2), {BackgroundColor3 = colorOff})
            sliderTween = TweenService:Create(slider, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0, 2, 0, 2)})
        end
        
        switchTween:Play()
        sliderTween:Play()
        
        callback(isOn)
    end)
end

-- 1) Perfect Kick (Pateo automático mediante rev_KickEvent)
local pkActivo = false
HandleToggle(pkSwitch, pkSlider, pkButton, function(isOn)
    pkActivo = isOn
    if pkActivo then
        task.spawn(function()
            while pkActivo do
                pcall(function()
                    local kickEvent = ReplicatedStorage:FindFirstChild("Shared") 
                        and ReplicatedStorage.Shared:FindFirstChild("Packages") 
                        and ReplicatedStorage.Shared.Packages:FindFirstChild("Network") 
                        and ReplicatedStorage.Shared.Packages.Network:FindFirstChild("rev_KickEvent")
                    
                    if kickEvent then
                        kickEvent:FireServer()
                    end
                end)
                task.wait(0.05)
            end
        end)
    end
end)

-- 2) Auto farm (Velocidad aumentada a 250 para volar directo a la Safe Zone)
local afActivo = false
HandleToggle(afSwitch, afSlider, afButton, function(isOn)
    afActivo = isOn
    if afActivo then
        task.spawn(function()
            while afActivo do
                local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                
                if humanoid and rootPart then
                    humanoid.WalkSpeed = 250 
                    
                    local safeZone = workspace:FindFirstChild("KickReady", true)
                    if safeZone then
                        local targetPos = nil
                        if safeZone:IsA("BasePart") then
                            targetPos = safeZone.Position
                        elseif safeZone:IsA("Model") and safeZone.PrimaryPart then
                            targetPos = safeZone.PrimaryPart.Position
                        else
                            local part = safeZone:FindFirstChildWhichIsA("BasePart", true)
                            if part then
                                targetPos = part.Position
                            end
                        end
                        
                        if targetPos then
                            humanoid:MoveTo(targetPos)
                        end
                    end
                end
                task.wait(0.3)
            end
        end)
    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16 
        end
    end
end)
