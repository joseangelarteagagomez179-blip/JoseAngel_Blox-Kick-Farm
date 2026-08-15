-- ==========================================================
-- Interfaz y Script de Meteor Shower para Kick a Lucky Block
-- Creado por JoseAngel_Blox
-- ==========================================================

local player = game.Players.LocalPlayer
local coreGui = game:GetService("CoreGui") or player:WaitForChild("PlayerGui")

-- 1. CREACIÓN DE LA INTERFAZ (GUI)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JoseAngel_MeteorUI"
screenGui.Parent = coreGui

-- Ventana principal (Cuadrada y pequeña)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 250) 
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
mainFrame.Active = true
mainFrame.Draggable = true -- Para que la puedas mover por la pantalla
mainFrame.Parent = screenGui

-- Esquinas redondeadas
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 15) 
uiCorner.Parent = mainFrame

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 25)
title.Position = UDim2.new(0, 0, 0, 15)
title.BackgroundTransparency = 1
title.Text = "JoseAngel_Blox Meteor Shower"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Subtítulo
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 15)
subtitle.Position = UDim2.new(0, 0, 0, 45)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Creado por JoseAngel_Blox"
subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
subtitle.TextScaled = true
subtitle.Font = Enum.Font.Gotham
subtitle.Parent = mainFrame

-- Botón: Auto Recolectar
local btnMeteor = Instance.new("TextButton")
btnMeteor.Size = UDim2.new(0.8, 0, 0, 40)
btnMeteor.Position = UDim2.new(0.1, 0, 0, 90)
btnMeteor.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
btnMeteor.Text = "Auto Recolectar: OFF"
btnMeteor.TextColor3 = Color3.fromRGB(255, 80, 80)
btnMeteor.Font = Enum.Font.GothamBold
btnMeteor.TextSize = 14
btnMeteor.Parent = mainFrame
Instance.new("UICorner", btnMeteor).CornerRadius = UDim.new(0, 8)

-- Botón: Auto Farm (Correr a Safe Zone)
local btnFarm = Instance.new("TextButton")
btnFarm.Size = UDim2.new(0.8, 0, 0, 40)
btnFarm.Position = UDim2.new(0.1, 0, 0, 145)
btnFarm.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
btnFarm.Text = "Auto Farm: OFF"
btnFarm.TextColor3 = Color3.fromRGB(255, 80, 80)
btnFarm.Font = Enum.Font.GothamBold
btnFarm.TextSize = 14
btnFarm.Parent = mainFrame
Instance.new("UICorner", btnFarm).CornerRadius = UDim.new(0, 8)

-- 2. LÓGICA Y FUNCIONES
local autoMeteor = false
local autoFarm = false

-- Función de clic para Auto Recolectar
btnMeteor.MouseButton1Click:Connect(function()
    autoMeteor = not autoMeteor
    if autoMeteor then
        btnMeteor.Text = "Auto Recolectar: ON"
        btnMeteor.TextColor3 = Color3.fromRGB(80, 255, 80)
    else
        btnMeteor.Text = "Auto Recolectar: OFF"
        btnMeteor.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end)

-- Función de clic para Auto Farm
btnFarm.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    if autoFarm then
        btnFarm.Text = "Auto Farm: ON"
        btnFarm.TextColor3 = Color3.fromRGB(80, 255, 80)
    else
        btnFarm.Text = "Auto Farm: OFF"
        btnFarm.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end)

-- Loop para Auto Recolectar Meteoritos
task.spawn(function()
    while task.wait(0.5) do
        if autoMeteor then
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                -- Busca piezas en el mapa que correspondan a los meteoritos del evento
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") and (string.match(v.Name, "Meteor") or string.match(v.Name, "Drop")) then
                        char.HumanoidRootPart.CFrame = v.CFrame
                        task.wait(0.3) -- Pausa breve para recolectar correctamente
                    end
                end
            end
        end
    end
end)

-- Loop para Auto Farm (Correr a KickReady)
task.spawn(function()
    while task.wait(0.2) do
        if autoFarm then
            local char = player.Character
            -- Busca la Safe Zone llamada "KickReady"
            local safeZone = workspace:FindFirstChild("KickReady", true) 
            
            if char and char:FindFirstChild("Humanoid") and safeZone then
                -- Obliga al personaje a correr automáticamente hacia la zona segura
                char.Humanoid:MoveTo(safeZone.Position)
            end
        end
    end
end)
