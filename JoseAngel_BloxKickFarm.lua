-- Cargar la librería gráfica (Orion Library)
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Crear la Ventana Principal
local Window = OrionLib:MakeWindow({
    Name = "JoseAngel_Blox Kick Farm | Creado por JoseAngel_Blox",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "JoseAngelConfig",
    IntroText = "Cargando JoseAngel_Blox Farm..."
})

-- ==========================================
-- PESTAÑA 1: INFO
-- ==========================================
local InfoTab = Window:MakeTab({
    Name = "Info",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

InfoTab:AddLabel("Nombre del creador: JoseAngel_Blox")
InfoTab:AddLabel("Fecha de lanzamiento: 27/07/2026")
InfoTab:AddLabel("Versión: 1.1")
InfoTab:AddParagraph("Actualización 1.1", "Versión nueva optimizada sin lag, mayor rendimiento.")

-- ==========================================
-- PESTAÑA 2: MAIN
-- ==========================================
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Variable global para controlar los bucles
getgenv().AutoKick = false
getgenv().AutoFarm = false

-- Toggle: Auto-Kick
MainTab:AddToggle({
    Name = "Auto-Kick",
    Default = false,
    Callback = function(Value)
        getgenv().AutoKick = Value
        while getgenv().AutoKick do
            task.wait(0.1)
            -- [!] Aquí irá la lógica para patear. 
            -- (Dependerá de si el juego usa ProximityPrompts o ClickDetectors)
        end
    end
})

-- Toggle: Auto Farm
MainTab:AddToggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(Value)
        getgenv().AutoFarm = Value
        while getgenv().AutoFarm do
            task.wait(0.5)
            -- [!] Aquí irá la lógica para teletransportarse al bloque y patearlo
        end
    end
})

-- Ajustador de Velocidad (Slider funciona mejor que botones + y - en interfaces modernas)
MainTab:AddSlider({
    Name = "Velocidad de carrera",
    Min = 16,
    Max = 200,
    Default = 16,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "Velocidad",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = Value
        end
    end
})

-- ==========================================
-- PESTAÑA 3: OPTIMIZACIÓN
-- ==========================================
local OptTab = Window:MakeTab({
    Name = "Optimización",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Botón: Anti Lag
OptTab:AddButton({
    Name = "Activar Anti Lag",
    Callback = function()
        -- Borra texturas y apaga sombras para subir FPS
        game.Lighting.GlobalShadows = false
        game.Lighting.FogEnd = 9e9
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsA("MeshPart") then
                v.Material = Enum.Material.SmoothPlastic
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v:Destroy()
            end
        end
        OrionLib:MakeNotification({
            Name = "Anti Lag",
            Content = "Gráficos reducidos al mínimo para mayor rendimiento.",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end
})

-- Toggle: Mostrar FPS
local RunService = game:GetService("RunService")
local FpsLabel = OptTab:AddLabel("FPS: Esperando...")
local FpsConnection

OptTab:AddToggle({
    Name = "Mostrar FPS",
    Default = false,
    Callback = function(Value)
        if Value then
            FpsConnection = RunService.RenderStepped:Connect(function(deltaTime)
                local fps = math.floor(1 / deltaTime)
                FpsLabel:Set("FPS: " .. tostring(fps))
            end)
        else
            if FpsConnection then
                FpsConnection:Disconnect()
            end
            FpsLabel:Set("FPS: Oculto")
        end
    end
})

-- ==========================================
-- BOTÓN FLOTANTE PARA ABRIR/CERRAR EL SCRIPT
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
local ToggleBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Name = "JoseAngelToggle"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleBtn.Position = UDim2.new(0, 20, 0, 20) -- Arriba a la izquierda
ToggleBtn.Size = UDim2.new(0, 100, 0, 40)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "Mostrar/Ocultar"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 12
ToggleBtn.Draggable = true -- Permite mover el botón por la pantalla
ToggleBtn.Active = true

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = ToggleBtn

-- Simula presionar la tecla RightControl (tecla por defecto de Orion para ocultar)
ToggleBtn.MouseButton1Click:Connect(function()
    local vim = game:GetService("VirtualInputManager")
    vim:SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
end)

-- Iniciar interfaz
OrionLib:Init()
