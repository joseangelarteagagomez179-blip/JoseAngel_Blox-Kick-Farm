-- ======================================================
-- Script: JoseAngel_Blox Kick
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

player.CharacterAdded:Connect(function(char)
    character = char
end)

-- ==================== 1) INFO ↓ ====================
local InfoTab = Window:CreateTab("1) info ↓", 4483362458)

InfoTab:CreateSection("📌 Información del Script")
InfoTab:CreateLabel("👨‍💻 Creador: JoseAngel_Blox")
InfoTab:CreateLabel("📅 Fecha de creación: 26/07/2026")
InfoTab:CreateLabel("🚀 Versión: 1.2")

InfoTab:CreateSection("👋 Mensaje de Bienvenida")
InfoTab:CreateParagraph({
    Title = "✨ ¡Hola! Bienvenido/a ✨", 
    Content = "Un gran saludo de parte de JoseAngel_Blox. Espero de todo corazón que disfrutes mucho de este script y te sea súper útil para avanzar rápido en el juego.\n\n¡Gracias por usarlo y a divertirse! 😉"
})

-- ==================== 2) MAIN ↓ ====================
local MainTab = Window:CreateTab("2) Main ↓", 4483362458)
MainTab:CreateSection("⚡ Funciones Principales")

-- 1. Auto Kick (Ir a Safe Zone y Patear)
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
                   local hrp = character:FindFirstChild("HumanoidRootPart")
                   
                   -- Busca la zona de pateo/Safe Zone en el mapa
                   local safeZone = workspace:FindFirstChild("SafeZone") or workspace:FindFirstChild("Safe Zone") or workspace:FindFirstChild("KickZone")
                   if safeZone and hrp then
                       hrp.CFrame = safeZone.CFrame + Vector3.new(0, 3, 0)
                   end
                   
                   -- Activa pateo/interacción
                   for _, obj in pairs(workspace:GetDescendants()) do
                       if not autoKickEnabled then break end
                       if obj:IsA("ProximityPrompt") then
                           fireproximityprompt(obj)
                       elseif obj:IsA("TouchTransmitter") and obj.Parent then
                           firetouchinterest(hrp, obj.Parent, 0)
                           firetouchinterest(hrp, obj.Parent, 1)
                       end
                   end
               end)
               task.wait(0.2)
           end
       end)
   end,
})

-- 2. Auto Weight (Equipar y usar Pesa del inventario)
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
                   
                   -- Busca una pesa en el inventario
                   if backpack then
                       for _, tool in pairs(backpack:GetChildren()) do
                           if tool:IsA("Tool") and (tool.Name:lower():find("weight") or tool.Name:lower():find("pesa")) then
                               humanoid:EquipTool(tool)
                               break
                           end
                       end
                   end
                   
                   -- Usa la pesa equipada
                   local equippedTool = character:FindFirstChildOfClass("Tool")
                   if equippedTool then
                       equippedTool:Activate()
                   end
               end)
               task.wait(0.1)
           end
       end)
   end,
})

-- 3. Auto Click x2
local autoClickEnabled = false
MainTab:CreateToggle({
   Name = "👆 Auto Click x2",
   CurrentValue = false,
   Flag = "AutoClickX2",
   Callback = function(Value)
       autoClickEnabled = Value
       task.spawn(function()
           local virtualUser = game:GetService("VirtualUser")
           while autoClickEnabled do
               pcall(function()
                   virtualUser:Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                   task.wait(0.01)
                   virtualUser:Button1Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
               end)
               task.wait(0.05)
           end
       end)
   end,
})

-- 4. Auto Recoger (Dinero/Monedas generadas por los Brainrots en la base)
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
                   local hrp = character:FindFirstChild("HumanoidRootPart")
                   if hrp then
                       for _, item in pairs(workspace:GetDescendants()) do
                           if not autoRecogerEnabled then break end
                           -- Detecta monedas/cash/drops en el mapa o base
                           if item:IsA("TouchTransmitter") and (item.Parent.Name:lower():find("cash") or item.Parent.Name:lower():find("coin") or item.Parent.Name:lower():find("money")) then
                               firetouchinterest(hrp, item.Parent, 0)
                               firetouchinterest(hrp, item.Parent, 1)
                           end
                       end
                   end
               end)
               task.wait(0.5)
           end
       end)
   end,
})

-- 5. Auto Mejorar (Mejorar Brainrots de la base)
local autoMejorarEnabled = false
MainTab:CreateToggle({
   Name = "🛠️ Auto Mejorar",
   CurrentValue = false,
   Flag = "AutoMejorar",
   Callback = function(Value)
       autoMejorarEnabled = Value
       task.spawn(function()
           while autoMejorarEnabled do
               pcall(function()
                   local hrp = character:FindFirstChild("HumanoidRootPart")
                   if hrp then
                       -- Busca los botones de mejora (Upgrade) en las bases
                       for _, btn in pairs(workspace:GetDescendants()) do
                           if not autoMejorarEnabled then break end
                           if btn:IsA("BasePart") and (btn.Name:lower():find("upgrade") or btn.Name:lower():find("mejorar")) then
                               if btn:FindFirstChild("TouchTransmitter") then
                                   firetouchinterest(hrp, btn, 0)
                                   firetouchinterest(hrp, btn, 1)
                               end
                           end
                       end
                   end
               end)
               task.wait(1)
           end
       end)
   end,
})

-- 6. Auto Rebirth
local autoRebirthEnabled = false
MainTab:CreateToggle({
   Name = "🔄 Auto Rebirth",
   CurrentValue = false,
   Flag = "AutoRebirth",
   Callback = function(Value)
       autoRebirthEnabled = Value
       task.spawn(function()
           while autoRebirthEnabled do
               pcall(function()
                   local rebEvent = game:GetService("ReplicatedStorage"):FindFirstChild("Rebirth", true) or game:GetService("ReplicatedStorage"):FindFirstChild("RebirthRequest", true)
                   if rebEvent and rebEvent:IsA("RemoteEvent") then
                       rebEvent:FireServer()
                   end
               end)
               task.wait(2)
           end
       end)
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
   Content = "¡Script listo para usar!",
   Duration = 5,
})
