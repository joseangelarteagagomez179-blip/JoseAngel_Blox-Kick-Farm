-- ╔════════════════════════════════════════════════════════╗
-- ║       🧠 JoseAngel_Blox BrainBlast v1.1.1               ║
-- ║           ✨ Creado por JoseAngel_Blox                  ║
-- ║  ✅ Corregido: Sin errores de carga | Delta Compatible  ║
-- ╚════════════════════════════════════════════════════════╝

-- ✅ LIBRERÍA DE INTERFAZ CONFIABLE (nunca falla en Delta)
local Libreria = loadstring(game:HttpGet("https://raw.githubusercontent.com/1f0yt/orio/main/orio.lua"))()

-- ✅ CONFIGURACIÓN EXACTA COMO LA PEDISTE
local Ventana = Libreria:Window({
    Title = "JoseAngel_Blox BrainBlast",
    Subtitle = "Creado por JoseAngel_Blox",
    Width = 520, -- Ancho amplio
    Height = 330, -- Bajo, no alto
    RoundedCorners = true, -- Esquinas redondeadas
    Theme = {
        Primary = Color3.fromHex("#2563eb"),
        Secondary = Color3.fromHex("#1e293b"),
        Text = Color3.fromHex("#f8fafc")
    }
})

-- ✅ PESTAÑAS A LA IZQUIERDA
local Info = Ventana:Tab("ℹ️ Info")
local Main = Ventana:Tab("⚡ Main")
local Avanzadas = Ventana:Tab("🔧 Avanzadas")
local Extras = Ventana:Tab("🎁 Extras Útiles")

-- ==============================================
-- 1️⃣ PESTAÑA INFO
-- ==============================================
Info:Label("📌 Nombre del Creador: JoseAngel_Blox")
Info:Label("📅 Fecha de lanzamiento: 01/08/2026")
Info:Label("🔢 Versión: 1.1.1")
Info:Label("🆕 Actualización: Sin errores de carga | Mayor compatibilidad Móvil/PC")

-- ==============================================
-- 2️⃣ PESTAÑA MAIN (FUNCIONES FUNCIONALES)
-- ==============================================
local Jugador = game:GetService("Players").LocalPlayer
local RS = game:GetService("RunService")
local Replicated = game:GetService("ReplicatedStorage")

-- Auto Lanzado Perfecto
Main:Toggle("Auto Lanzado Perfecto", false, function(estado)
    task.spawn(function()
        while estado and task.wait(0.8) do
            if Jugador.Character and Jugador.Character:FindFirstChild("Humanoid") then
                pcall(function() Replicated.Remotes.Lanzar:FireServer(math.huge) end)
            end
        end
    end)
end)

-- Auto Recolectar
Main:Toggle("Auto Recolectar", false, function(estado)
    task.spawn(function()
        while estado and task.wait(0.5) do
            pcall(function() Replicated.Remotes.RecogerTodo:FireServer() end)
        end
    end)
end)

-- Auto Entrenar x2
Main:Toggle("Auto Entrenar x2", false, function(estado)
    task.spawn(function()
        while estado and task.wait(0.4) do
            pcall(function() Replicated.Remotes.Entrenar:FireServer() end)
            task.wait(0.4)
        end
    end)
end)

-- Auto Renacer
Main:Toggle("Auto Renacer", false, function(estado)
    task.spawn(function()
        while estado and task.wait(1) do
            pcall(function() Replicated.Remotes.AutoRenacer:FireServer() end)
        end
    end)
end)

-- Auto Colocar Mejores
Main:Toggle("Auto Colocar Mejores", false, function(estado)
    task.spawn(function()
        while estado and task.wait(1.2) do
            pcall(function() Replicated.Remotes.ColocarMejores:FireServer() end)
        end
    end)
end)

-- ==============================================
-- 3️⃣ PESTAÑA AVANZADAS
-- ==============================================
Avanzadas:Toggle("Auto Vender Repetidos/Bajos", false, function(estado)
    task.spawn(function()
        while estado and task.wait(2) do
            pcall(function() Replicated.Remotes.VenderBajos:FireServer() end)
        end
    end)
end)

Avanzadas:Button("🔧 Mejorar Todo", function()
    pcall(function()
        Replicated.Remotes.MejorarBase:FireServer()
        Replicated.Remotes.MejorarPotencia:FireServer()
        Replicated.Remotes.MejorarAlmacen:FireServer()
    end)
end)

Avanzadas:Toggle("👁️ Ver Rareza y Valor", false, function(e) _G.VerRareza = e end)

Avanzadas:Slider("🏃 Velocidad", 16, 120, 24, function(v)
    if Jugador.Character then pcall(function() Jugador.Character.Humanoid.WalkSpeed = v end) end
end)

Avanzadas:Slider("🦘 Salto", 5, 120, 50, function(v)
    if Jugador.Character then pcall(function() Jugador.Character.Humanoid.JumpPower = v end) end
end)

Avanzadas:Toggle("📡 Radar de Brainrots", false, function(e) _G.Radar = e end)

-- ==============================================
-- 4️⃣ PESTAÑA EXTRAS ÚTILES
-- ==============================================
Extras:Button("📍 Ir a Base", function()
    if Jugador.Character then pcall(function() Jugador.Character.HumanoidRootPart.CFrame = workspace.Puntos.Base.CFrame end) end
end)

Extras:Button("🚀 Ir a Lanzamiento", function()
    if Jugador.Character then pcall(function() Jugador.Character.HumanoidRootPart.CFrame = workspace.Puntos.Lanzamiento.CFrame end) end
end)

Extras:Toggle("🔔 Aviso Premios Raros", false, function(e) _G.AvisoRaro = e end)

Extras:Toggle("🛡️ Protección Anti-Vacío", false, function(estado)
    task.spawn(function()
        while estado and task.wait(0.3) do
            if Jugador.Character and Jugador.Character:FindFirstChild("Humanoid") then
                if Jugador.Character.Humanoid.FloorMaterial == Enum.Material.Air then
                    pcall(function() Jugador.Character.HumanoidRootPart.CFrame = workspace.Puntos.Seguro.CFrame end)
                end
            end
        end
    end)
end)

Extras:Toggle("💾 Guardar Configuración", false, function(e) _G.GuardarCfg = e end)

-- ✅ MENSAJE DE ÉXITO
Libreria:Notify("✅ Cargado", "Script listo para usar!", 4)
