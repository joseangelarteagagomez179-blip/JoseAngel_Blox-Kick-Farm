-- ======================================================
-- Script: JoseAngel_Blox Kick (PC & Mobile / Delta)
-- Creado por: JoseAngel_Blox
-- Fecha: 26/07/2026 | Versión: 1.2
-- ======================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "✨ JoseAngel_Blox Kick ✨",
   LoadingTitle = "⚡ Cargando JoseAngel_Blox Kick...",
   LoadingSubtitle = "Creado por JoseAngel_Blox",
   ConfigurationSaving = { Enabled = false },
   Discord = { Enabled = false },
   KeySystem = false
})

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Actualizar personaje si muere
player.CharacterAdded:Connect(function(char)
    character = char
end)

-- ==================== 1) INFO ↓ ====================
local InfoTab = Window:CreateTab("1) info ↓", 4483362458)

InfoTab:CreateSection("📌 Información del Script")
InfoTab:CreateLabel("👨‍💻 Creador: JoseAngel_Blox")
InfoTab:CreateLabel("📅 Fecha de creación: 26/07/2026")
InfoTab:CreateLabel("🚀 Versión: 1.2 (PC & Mobile)")

InfoTab:CreateSection("👋 Mensaje de Bienvenida")
InfoTab:CreateParagraph({
    Title = "✨ ¡Hola! Bienvenido/a ✨", 
    Content = "Un gran saludo de parte de JoseAngel_Blox. Espero de todo corazón que disfrutes mucho de este script y te sea súper útil para avanzar rápido en el juego.\n\n¡Gracias por usarlo y que te diviertas al máximo! 😉"
})

-- ==================== 2) MAIN ↓ ====================
local MainTab = Window:CreateTab("2) Main ↓", 4483362458)

MainTab:CreateSection("⚡ Funciones Principales")

-- Auto Kick (Específico para Kick a Lucky Block)
local autoKickEnabled = false
MainTab:CreateToggle({
   Name = "👟 Auto Kick",
   CurrentValue = false,
   Flag = "AutoKick",
   Callback = function(Value)
       autoKickEnabled = Value
       task.spawn(function()
           while autoKickEnabled do
               pcall(function()
                   if character and character:FindFirstChild("HumanoidRootPart") then
                       for _, obj in pairs(workspace:GetDescendants()) do
                           if not autoKickEnabled then break end
                           if obj:IsA("ProximityPrompt") then
                               fireproximityprompt(obj)
                           elseif obj:IsA("TouchTransmitter") and obj.Parent then
                               firetouchinterest(character.HumanoidRootPart, obj.Parent, 0)
                               firetouchinterest(character.HumanoidRootPart, obj.Parent, 1)
                           end
                       end
                   end
               end)
               task.wait(0.15)
           end
       end)
   end,
})

-- Funciones simuladas/conectadas para el juego
MainTab:CreateToggle({
   Name = "🏋️ Auto Weight",
   CurrentValue = false,
   Flag = "AutoWeight",
   Callback = function(Value)
       -- Aquí puedes añadir la ruta o evento de peso del juego si aplica
   end,
})

MainTab:CreateToggle({
   Name = "🧲 Auto Recoger",
   CurrentValue = false,
   Flag = "AutoRecoger",
   Callback = function(Value)
       -- Lógica para recoger elementos automáticamente
   end,
})

MainTab:CreateToggle({
   Name = "👆 Auto Click x2",
   CurrentValue = false,
   Flag = "AutoClickX2",
   Callback = function(Value)
       -- Lógica de auto click
   end,
})

MainTab:CreateToggle({
   Name = "🛠️ Auto Mejorar",
   CurrentValue = false,
   Flag = "AutoMejorar",
   Callback = function(Value)
       -- Lógica de auto mejorar
   end,
})

MainTab:CreateToggle({
   Name = "🔄 Auto Rebirth",
   CurrentValue = false,
   Flag = "AutoRebirth",
   Callback = function(Value)
       -- Lógica de auto renacimiento
   end,
})

MainTab:CreateToggle({
   Name = "📋 Show Panel",
   CurrentValue = false,
   Flag = "ShowPanel",
   Callback = function(Value)
       -- Mostrar panel de estadísticas secundarias
   end,
})

-- ==================== 3) PLAYER ↓ ====================
local PlayerTab = Window:CreateTab("3) Player ↓", 4483362458)

PlayerTab:CreateSection("🏃 Opciones del Jugador")

-- Fly compatible con PC y Celular
local flying = false
local uis = game:GetService("UserInputService")
PlayerTab:CreateToggle({
   Name = "🕊️ Fly",
   CurrentValue = false,
   Flag = "FlyMode",
   Callback = function(Value)
       flying = Value
       local hrp = character:WaitForChild("HumanoidRootPart")
       local bg = Instance.new("BodyGyro", hrp)
       local bv = Instance.new("BodyVelocity", hrp)
       bg.P = 9e4
       bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
       bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
       bv.velocity = Vector3.new(0,0,0)
       
       task.spawn(function()
           while flying do
               task.wait()
               local camera = workspace.CurrentCamera
               if character and character:FindFirstChild("Humanoid") then
                   local moveDir = character.Humanoid.MoveDirection
                   bv.velocity = (camera.CFrame.LookVector * moveDir.Z + camera.CFrame.RightVector * moveDir.X) * 50 + Vector3.new(0, 0, 0)
                   bg.cframe = camera.CFrame
               end
           end
           bg:Destroy()
           bv:Destroy()
       end)
   end,
})

PlayerTab:CreateSlider({
   Name = "⚡ Walkspeed (Velocidad Ajustable)",
   Range = {16, 500},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Flag = "WalkspeedSlider",
   Callback = function(Value)
       if character and character:FindFirstChild("Humanoid") then
           character.Humanoid.WalkSpeed = Value
       end
   end,
})

PlayerTab:CreateToggle({
   Name = "🛡️ Anti AFK",
   CurrentValue = true,
   Flag = "AntiAFK",
   Callback = function(Value)
       if Value then
           local virtualUser = game:GetService("VirtualUser")
           player.Idled:Connect(function()
               virtualUser:CaptureController()
               virtualUser:ClickButton2(Vector2.new())
           end)
       end
   end,
})

-- ==================== 4) CONFIGURACIONES ↓ ====================
local ConfigTab = Window:CreateTab("4) Configuraciones ↓", 4483362458)

ConfigTab:CreateSection("⚙️ Rendimiento y Pantalla")

ConfigTab:CreateButton({
   Name = "🧹 Anti Lag (Optimizar Gráficos)",
   Callback = function()
       for _, v in pairs(workspace:GetDescendants()) do
           if v:IsA("BasePart") then
               v.Material = Enum.Material.SmoothPlastic
               v.Reflectance = 0
           end
       end
       game.Lighting.GlobalShadows = false
       Rayfield:Notify({ Title = "Anti Lag Activado", Content = "Gráficos optimizados para mayor fluidez.", Duration = 3 })
   end,
})

ConfigTab:CreateToggle({
   Name = "📊 Mostrar FPS",
   CurrentValue = false,
   Flag = "ShowFPS",
   Callback = function(Value)
       local rs = game:GetService("RunService")
       if Value then
           _G.ShowFPSVar = true
           local fpsLabel = Instance.new("ScreenGui")
           local textLabel = Instance.new("TextLabel")
           fpsLabel.Name = "FPSCounter"
           fpsLabel.Parent = game.CoreGui
           textLabel.Parent = fpsLabel
           textLabel.Size = UDim2.new(0, 100, 0, 30)
           textLabel.Position = UDim2.new(0, 10, 0, 10)
           textLabel.BackgroundTransparency = 0.5
           textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
           textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
           textLabel.TextSize = 14
           textLabel.Font = Enum.Font.SourceSansBold
           
           task.spawn(function()
               local lastTick = tick()
               local frames = 0
               while _G.ShowFPSVar do
                   frames = frames + 1
                   if tick() - lastTick >= 1 then
                       textLabel.Text = "FPS: " .. frames
                       frames = 0
                       lastTick = tick()
                   end
                   rs.RenderStepped:Wait()
               end
               fpsLabel:Destroy()
           end)
       else
           _G.ShowFPSVar = false
           if game.CoreGui:FindFirstChild("FPSCounter") then
               game.CoreGui.FPSCounter:Destroy()
           end
       end
   end,
})

Rayfield:Notify({
   Title = "JoseAngel_Blox Kick Loaded",
   Content = "¡Script cargado con éxito en PC y Celular!",
   Duration = 5,
   Image = 4483362458,
})
