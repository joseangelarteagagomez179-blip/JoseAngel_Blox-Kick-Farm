-- ======================================================
-- Script: JoseAngel_Blox Kick
-- Creado por: JoseAngel_Blox
-- Fecha: 26/07/2026 | Versión: 1.3 (Remotos Reales)
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

player.CharacterAdded:Connect(function(char)
    character = char
end)

-- Buscar un RemoteEvent en ReplicatedStorage por su nombre
local function getRemote(name)
    return game:GetService("ReplicatedStorage"):FindFirstChild(name, true)
end

-- ==================== 1) INFO ↓ ====================
local InfoTab = Window:CreateTab("1) info ↓", 4483362458)

InfoTab:CreateSection("📌 Información del Script")
InfoTab:CreateLabel("👨‍💻 Creador: JoseAngel_Blox")
InfoTab:CreateLabel("📅 Fecha de creación: 26/07/2026")
InfoTab:CreateLabel("🚀 Versión: 1.3")

InfoTab:CreateSection("👋 Mensaje de Bienvenida")
InfoTab:CreateParagraph({
    Title = "✨ ¡Hola! Bienvenido/a ✨", 
    Content = "Un gran saludo de parte de JoseAngel_Blox. Espero de todo corazón que disfrutes mucho de este script y te sea súper útil para avanzar rápido en el juego.\n\n¡Gracias por usarlo y a divertirse! 😉"
})

-- ==================== 2) MAIN ↓ ====================
local MainTab = Window:CreateTab("2) Main ↓", 4483362458)
MainTab:CreateSection("⚡ Funciones Principales")

-- 1. Auto Kick (Evento Real: rev_KickEvent)
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
                   local kickRemote = getRemote("rev_KickEvent")
                   if kickRemote then
                       kickRemote:FireServer()
                   end
               end)
               task.wait(0.05)
           end
       end)
   end,
})

-- 2. Auto Weight (Equipar y Usar Pesa)
local autoWeightEnabled = false
MainTab:CreateToggle({
   Name = "🏋️ Auto Weight",
   CurrentValue = false,
   Flag = "AutoWeight",
   Callback = function(Value)
       autoWeightEnabled = Value
       task.spawn(function()
           while autoWeightEnabled do
               pcall(function()
                   local backpack = player:FindFirstChild("Backpack")
                   local humanoid = character:FindFirstChildOfClass("Humanoid")
                   
                   if backpack then
                       for _, tool in pairs(backpack:GetChildren()) do
                           if tool:IsA("Tool") then
                               humanoid:EquipTool(tool)
                           end
                       end
                   end
                   
                   local tool = character:FindFirstChildOfClass("Tool")
                   if tool then
                       tool:Activate()
                   end
               end)
               task.wait(0.1)
           end
       end)
   end,
})

-- 3. Auto Click x2 (Evento Real: rev_TaviMishkal)
local autoClickEnabled = false
MainTab:CreateToggle({
   Name = "👆 Auto Click x2",
   CurrentValue = false,
   Flag = "AutoClickX2",
   Callback = function(Value)
       autoClickEnabled = Value
       task.spawn(function()
           while autoClickEnabled do
               pcall(function()
                   local clickRemote = getRemote("rev_TaviMishkal")
                   if clickRemote then
                       clickRemote:FireServer()
                   end
               end)
               task.wait(0.01)
           end
       end)
   end,
})

-- 4. Auto Recoger (Evento Real: rev_B_Collect)
local autoRecogerEnabled = false
MainTab:CreateToggle({
   Name = "🧲 Auto Recoger",
   CurrentValue = false,
   Flag = "AutoRecoger",
   Callback = function(Value)
       autoRecogerEnabled = Value
       task.spawn(function()
           while autoRecogerEnabled do
               pcall(function()
                   local collectRemote = getRemote("rev_B_Collect")
                   if collectRemote then
                       collectRemote:FireServer()
                   end
               end)
               task.wait(0.2)
           end
       end)
   end,
})

-- 5. Auto Mejorar (En espera del remoto exacto)
local autoMejorarEnabled = false
MainTab:CreateToggle({
   Name = "🛠️ Auto Mejorar",
   CurrentValue = false,
   Flag = "AutoMejorar",
   Callback = function(Value)
       autoMejorarEnabled = Value
   end,
})

-- 6. Auto Rebirth (En espera del remoto exacto)
local autoRebirthEnabled = false
MainTab:CreateToggle({
   Name = "🔄 Auto Rebirth",
   CurrentValue = false,
   Flag = "AutoRebirth",
   Callback = function(Value)
       autoRebirthEnabled = Value
   end,
})

-- 7. Show Panel
MainTab:CreateToggle({
   Name = "📋 Show Panel",
   CurrentValue = false,
   Flag = "ShowPanel",
   Callback = function(Value)
       local playerGui = player:FindFirstChild("PlayerGui")
       if playerGui then
           for _, gui in pairs(playerGui:GetChildren()) do
               if gui:IsA("ScreenGui") and gui.Name ~= "Rayfield" then
                   gui.Enabled = Value
               end
           end
       end
   end,
})

-- ==================== 3) PLAYER ↓ ====================
local PlayerTab = Window:CreateTab("3) Player ↓", 4483362458)
PlayerTab:CreateSection("🏃 Opciones del Jugador")

-- Fly
local flying = false
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
                   bv.velocity = (camera.CFrame.LookVector * moveDir.Z + camera.CFrame.RightVector * moveDir.X) * 50
                   bg.cframe = camera.CFrame
               end
           end
           bg:Destroy()
           bv:Destroy()
       end)
   end,
})

-- Walkspeed
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

-- Anti AFK
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
       Rayfield:Notify({ Title = "Anti Lag", Content = "Gráficos optimizados.", Duration = 3 })
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
   Content = "¡Remotos de Click x2 y Kick conectados!",
   Duration = 5,
})
