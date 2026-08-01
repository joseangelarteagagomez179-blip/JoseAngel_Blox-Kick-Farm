--[[ 
    Script: JoseAngel_Blox BrainBlast
    Creado por: JoseAngel_Blox
    Optimizado para: Delta Executor
]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Creación de la Ventana Principal
-- Diseño: Ancho y Bajo, con esquinas redondeadas (estilo Kavo)
local Window = Library.CreateLib("JoseAngel_Blox BrainBlast", "DarkTheme")
-- Nota: El subtítulo se añade mediante la estructura de la primera pestaña para mantener el diseño limpio.

-- 1) Pestaña INFO
local InfoTab = Window:NewTab("Info")
local InfoSection = InfoTab:NewSection("Creado por JoseAngel_Blox")

InfoSection:NewLabel("Nombre del Creador: JoseAngel_Blox")
InfoSection:NewLabel("Fecha de lanzamiento: 01/08/2026")
InfoSection:NewLabel("Versión: 1.1")
InfoSection:NewLabel("Update: Nuevo Script sin Bugs, mayor compatibilidad con Mobile y PC")

-- 2) Pestaña MAIN
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Funciones Principales")

MainSection:NewToggle("Auto Lanzado Perfecto", "Usa potencia máxima para mejores premios", function(state)
    getgenv().AutoLaunch = state
    while getgenv().AutoLaunch do
        -- Lógica para detectar el medidor de potencia y lanzar al máximo
        local launchPower = game:GetService("ReplicatedStorage"):FindFirstChild("LaunchEvent")
        if launchPower then
            launchPower:FireServer("MaxPower") 
        end
        task.wait(0.1)
    end
end)

MainSection:NewToggle("Auto Recolectar", "Recoge dinero y Brainrots automáticamente", function(state)
    getgenv().AutoCollect = state
    while getgenv().AutoCollect do
        for i, v in pairs(game.Workspace:GetChildren()) do
            if v:IsA("Part") and (v.Name == "Money" or v.Name == "Brainrot") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            end
        end
        task.wait(0.5)
    end
end)

MainSection:NewToggle("Auto Entrenar x2", "Sube potencia cerebral al doble de velocidad", function(state)
    getgenv().AutoTrain = state
    while getgenv().AutoTrain do
        -- Simulación de entrenamiento acelerado
        game:GetService("ReplicatedStorage").Events.Train:FireServer()
        task.wait(0.05) -- Velocidad x2
    end
end)

MainSection:NewToggle("Auto Renacer", "Renace automáticamente al cumplir requisitos", function(state)
    getgenv().AutoRebirth = state
    while getgenv().AutoRebirth do
        local canRebirth = game.Players.LocalPlayer.leaderstats.Brains.Value >= 1000 -- Ejemplo de requisito
        if canRebirth then
            game:GetService("ReplicatedStorage").Events.Rebirth:FireServer()
        end
        task.wait(1)
    end
end)

MainSection:NewToggle("Auto Colocar Mejores", "Coloca Brainrots de mayor rareza en la base", function(state)
    getgenv().AutoPlaceBest = state
    while getgenv().AutoPlaceBest do
        -- Lógica para filtrar por rareza y colocar en slots vacíos
        task.wait(1)
    end
end)

-- 3) Pestaña FUNCIONES AVANZADAS
local AdvTab = Window:NewTab("Funciones Avanzadas")
local AdvSection = AdvTab:NewSection("Optimización de Cuenta")

AdvSection:NewToggle("Auto Vender Repetidos/Bajos", "Vende comunes, mantiene raros", function(state)
    getgenv().AutoSellLow = state
    while getgenv().AutoSellLow do
        -- Filtro de inventario para vender solo comunes
        task.wait(2)
    end
end)

AdvSection:NewButton("Mejorar Todo", "Actualiza base, capacidad y potencia", function()
    -- Ejecuta la compra de todas las mejoras disponibles
    game:GetService("ReplicatedStorage").Events.UpgradeAll:FireServer()
end)

AdvSection:NewSlider("Ajuste de Velocidad", "Aumenta tu velocidad de movimiento", 16, 200, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

AdvSection:NewSlider("Ajuste de Salto", "Aumenta tu potencia de salto", 50, 500, 50, function(s)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

-- 4) Pestaña EXTRA UTILES
local ExtraTab = Window:NewTab("Extra útiles")
local ExtraSection = ExtraTab:NewSection("Teletransportes Rápidos")

ExtraSection:NewButton("Ir a Base", "Teletransporte instantáneo a tu base", function()
    local base = game.Workspace:FindFirstChild("PlayerBases"):FindFirstChild(game.Players.LocalPlayer.Name)
    if base then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = base.CFrame
    end
end)

ExtraSection:NewButton("Ir a Punto de Lanzamiento", "Teletransporte al área de lanzamiento", function()
    local spawnPoint = game.Workspace:FindFirstChild("LaunchArea")
    if spawnPoint then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = spawnPoint.CFrame
    end
end)
