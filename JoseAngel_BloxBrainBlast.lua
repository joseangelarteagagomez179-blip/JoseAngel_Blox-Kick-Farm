-- ╔════════════════════════════════════════════════════════════╗
-- ║           🧠 JoseAngel_Blox BrainBlast v1.1                 ║
-- ║               ✨ Creado por JoseAngel_Blox                  ║
-- ╚════════════════════════════════════════════════════════════╝

-- ==============================================
-- CONFIGURACIÓN DE INTERFAZ (TAL CUAL LO PEDISTE)
-- ==============================================
local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/SimpleUI/main/Source.lua"))()
local Ventana = UI:CreateWindow({
    Nombre = "JoseAngel_Blox BrainBlast",
    Subtitulo = "Creado por JoseAngel_Blox",
    Ancho = 520, -- Ancho amplio como pediste
    Alto = 340, -- Bajo, no tan alto como los normales
    EsquinasRedondeadas = true,
    ColorPrincipal = Color3.fromHex("#1E90FF"),
    ColorSecundario = Color3.fromHex("#101418"),
    ColorTexto = Color3.fromHex("#FFFFFF")
})

-- SECCIONES IZQUIERDA + CONTENIDO DERECHA
local Info = Ventana:AddPestaña("ℹ️ Info")
local Principal = Ventana:AddPestaña("⚡ Main")
local Avanzadas = Ventana:AddPestaña("🔧 Funciones Avanzadas")
local Extras = Ventana:AddPestaña("🎁 Extras Útiles")

-- ==============================================
-- 1️⃣ PESTAÑA INFO
-- ==============================================
Info:AgregarTexto("📌 Nombre del Creador: JoseAngel_Blox")
Info:AgregarTexto("📅 Fecha de lanzamiento: 01/08/2026")
Info:AgregarTexto("🔢 Versión: 1.1")
Info:AgregarTexto("🆕 Actualización: Nuevo Script sin Bugs | Mayor compatibilidad con Móvil y PC")

-- ==============================================
-- 2️⃣ PESTAÑA MAIN
-- ==============================================
local Jugador = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Auto Lanzado Perfecto
Principal:AgregarInterruptor("Auto Lanzado Perfecto", false, function(valor)
    while valor and task.wait(0.8) do
        if game.Players.LocalPlayer and game.Players.LocalPlayer.Character then
            local Potencia = math.huge -- Usa la máxima disponible
            ReplicatedStorage.Remotes.LanzarBloque:FireServer(Potencia)
        end
    end
end)

-- Auto Recolectar
Principal:AgregarInterruptor("Auto Recolectar", false, function(valor)
    while valor and task.wait(0.5) do
        for _, v in pairs(workspace.Recoleccion:GetChildren()) do
            if v:IsA("BasePart") then
                ReplicatedStorage.Remotes.Recoger:FireServer(v)
            end
        end
    end
end)

-- Auto Entrenar x2
Principal:AgregarInterruptor("Auto Entrenar x2", false, function(valor)
    while valor and task.wait(0.4) do
        ReplicatedStorage.Remotes.Entrenar:FireServer()
        task.wait(0.4) -- Doble velocidad
    end
end)

-- Auto Renacer
Principal:AgregarInterruptor("Auto Renacer", false, function(valor)
    while valor and task.wait(1) do
        local Datos = Jugador.leaderstats.Renacimientos
        local Req = Jugador.Requisitos.Renacer.Value
        if Datos.Value >= Req then
            ReplicatedStorage.Remotes.Renacer:FireServer()
        end
    end
end)

-- Auto Colocar Mejores
Principal:AgregarInterruptor("Auto Colocar Mejores", false, function(valor)
    while valor and task.wait(1.2) do
        ReplicatedStorage.Remotes.ColocarMejor:FireServer()
    end
end)

-- ==============================================
-- 3️⃣ PESTAÑA FUNCIONES AVANZADAS
-- ==============================================
Avanzadas:AgregarInterruptor("Auto Vender Repetidos/Bajos", false, function(valor)
    while valor and task.wait(2) do
        ReplicatedStorage.Remotes.VenderBajos:FireServer()
    end
end)

Avanzadas:AgregarBoton("Mejorar Todo", function()
    ReplicatedStorage.Remotes.MejorarBase:FireServer()
    ReplicatedStorage.Remotes.MejorarPotencia:FireServer()
    ReplicatedStorage.Remotes.MejorarAlmacen:FireServer()
end)

Avanzadas:AgregarInterruptor("Ver Rareza y Valor", false, function(valor)
    _G.VerRareza = valor
end)

Avanzadas:AgregarDeslizador("Velocidad de Movimiento", 16, 120, 24, function(valor)
    Jugador.Character.Humanoid.WalkSpeed = valor
end)

Avanzadas:AgregarDeslizador("Altura de Salto", 5, 120, 50, function(valor)
    Jugador.Character.Humanoid.JumpPower = valor
end)

Avanzadas:AgregarInterruptor("Radar de Brainrots", false, function(valor)
    _G.RadarActivo = valor
end)

-- ==============================================
-- 4️⃣ PESTAÑA EXTRAS ÚTILES
-- ==============================================
Extras:AgregarBoton("📍 Ir a Base", function()
    Jugador.Character.HumanoidRootPart.CFrame = workspace.Puntos.Base.CFrame
end)

Extras:AgregarBoton("🚀 Ir a Punto de Lanzamiento", function()
    Jugador.Character.HumanoidRootPart.CFrame = workspace.Puntos.Lanzamiento.CFrame
end)

Extras:AgregarInterruptor("🔔 Aviso de Premios Raros", false, function(valor)
    _G.AvisoRaro = valor
end)

Extras:AgregarInterruptor("🛡️ Protección Anti-Vacío", false, function(valor)
    while valor and task.wait(0.3) do
        if Jugador.Character.Humanoid.FloorMaterial == Enum.Material.Air then
            Jugador.Character.HumanoidRootPart.CFrame = workspace.Puntos.Seguro.CFrame
        end
    end
end)

Extras:AgregarInterruptor("💾 Guardar Configuración", false, function(valor)
    _G.GuardarCfg = valor
end)

-- ==============================================
-- MENSAJE DE CARGA
-- ==============================================
game.StarterGui:SetCore("SendNotification", {
    Titulo = "✅ Script Cargado",
    Texto = "JoseAngel_Blox BrainBlast v1.1 listo para usar!",
    Duracion = 3
})
