-- ==========================================================
-- SCRIPT: JoseAngel_Blox Kick
-- CREADOR: JoseAngel_Blox
-- FECHA: 27/07/2026
-- ==========================================================

-- Cargar la librería Rayfield (Interfaz profesional con pestañas a la izquierda)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "JoseAngel_Blox Kick",
   LoadingTitle = "Cargando JoseAngel_Blox Kick...",
   LoadingSubtitle = "por JoseAngel_Blox",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "JoseAngel_BloxFolder",
      FileName = "KickLuckyBlockHub"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = true
   },
   KeySystem = false
})

-- ==========================================
-- 1. CREACIÓN DE PESTAÑAS (LADO IZQUIERDO)
-- ==========================================
local InfoTab = Window:CreateTab("Info", 4483362458)
local MainTab = Window:CreateTab("Main", 4483345998)
local PlayerTab = Window:CreateTab("Player", 4483345998)
local ConfigTab = Window:CreateTab("Configuración", 4483345998)

-- ==========================================
-- 2. PESTAÑA: INFO
-- ==========================================
InfoTab:CreateLabel("👤 Nombre del Creador: JoseAngel_Blox")
InfoTab:CreateLabel("📅 Fecha de creación: 27/07/2026")
InfoTab:CreateLabel("⚙️ Versión: 1.1")

-- ==========================================
-- 3. PESTAÑA: MAIN (FARM Y PODER)
-- ==========================================
MainTab:CreateToggle({
   Name = "Auto Perfect Kick",
   CurrentValue = false,
   Flag = "AutoPerfect",
   Callback = function(Value)
      getgenv().AutoPerfect = Value
      task.spawn(function()
          while getgenv().AutoPerfect do
              task.wait(0.1)
              -- Lógica para forzar el Perfect en la interfaz del jugador
              for i,v in pairs(game.Players.LocalPlayer.PlayerGui:GetDescendants()) do
                  if v:IsA("TextButton") and (v.Text == "Kick" or v.Name == "KickButton") then
                      -- Simula disparar la patada cuando el medidor está al máximo
                      firesignal(v.MouseButton1Click)
                  end
              end
          end
      end)
   end
})

MainTab:CreateToggle({
   Name = "Auto Train (Levantar pesas)",
   CurrentValue = false,
   Flag = "AutoTrain",
   Callback = function(Value)
      getgenv().AutoTrain = Value
      task.spawn(function()
          while getgenv().AutoTrain do
              task.wait(0.05) -- Máxima velocidad
              game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
          end
      end)
   end
})

MainTab:CreateToggle({
   Name = "Auto Buy Weights",
   CurrentValue = false,
   Flag = "AutoBuy",
   Callback = function(Value)
      getgenv().AutoBuy = Value
      task.spawn(function()
          while getgenv().AutoBuy do
              task.wait(2)
              -- Fuego a todos los botones de compra que digan "Buy" o "Equip" en la tienda
              for i,v in pairs(game.Players.LocalPlayer.PlayerGui:GetDescendants()) do
                  if v:IsA("TextButton") and (v.Text == "Buy" or v.Name == "BuyButton") then
                      firesignal(v.MouseButton1Click)
                  end
              end
          end
      end)
   end
})

MainTab:CreateToggle({
   Name = "Auto Collect Multipliers",
   CurrentValue = false,
   Flag = "AutoMult",
   Callback = function(Value)
      getgenv().AutoMult = Value
      task.spawn(function()
          while getgenv().AutoMult do
              task.wait(0.5)
              for i,v in pairs(game.Players.LocalPlayer.PlayerGui:GetDescendants()) do
                  if v:IsA("TextButton") and v.Text:match("x2") and v.Visible then
                      firesignal(v.MouseButton1Click)
                  end
              end
          end
      end)
   end
})

MainTab:CreateToggle({
   Name = "Auto Collect Cash",
   CurrentValue = false,
   Flag = "AutoCash",
   Callback = function(Value)
      getgenv().AutoCash = Value
      task.spawn(function()
          while getgenv().AutoCash do
              task.wait(0.5)
              -- Teletransporta billetes/monedas del suelo al jugador
              local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
              if hrp then
                  for i,v in pairs(workspace:GetDescendants()) do
                      if v:IsA("Part") and (v.Name == "Cash" or v.Name == "Coin" or v.Name == "Money") then
                          v.CFrame = hrp.CFrame
                      end
                  end
              end
          end
      end)
   end
})

MainTab:CreateToggle({
   Name = "Auto Place Memes",
   CurrentValue = false,
   Flag = "AutoPlace",
   Callback = function(Value)
      getgenv().AutoPlace = Value
      task.spawn(function()
          while getgenv().AutoPlace do
              task.wait(1)
              -- Busca interacciones de colocación en la base y las activa
              for i,v in pairs(workspace:GetDescendants()) do
                  if v:IsA("ProximityPrompt") and v.ActionText:match("Place") then
                      fireproximityprompt(v)
                  end
              end
          end
      end)
   end
})

MainTab:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Flag = "AutoRebirth",
   Callback = function(Value)
      getgenv().AutoRebirth = Value
      task.spawn(function()
          while getgenv().AutoRebirth do
              task.wait(5)
              for i,v in pairs(game.Players.LocalPlayer.PlayerGui:GetDescendants()) do
                  if v:IsA("TextButton") and (v.Text == "Rebirth" or v.Name == "RebirthButton") then
                      firesignal(v.MouseButton1Click)
                  end
              end
          end
      end)
   end
})

MainTab:CreateButton({
   Name = "Anti-Tsunami (Remove Water)",
   Callback = function()
      local borrados = 0
      for i,v in pairs(workspace:GetDescendants()) do
          if v.Name == "Tsunami" or v.Name == "Water" then
              v:Destroy()
              borrados = borrados + 1
          end
      end
      Rayfield:Notify({Title = "Éxito", Content = "Tsunami eliminado. ("..borrados.." partes borradas)", Duration = 3})
   end
})

MainTab:CreateToggle({
   Name = "Auto Safe Zone",
   CurrentValue = false,
   Flag = "SafeZone",
   Callback = function(Value)
      local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
      if Value then
          -- Crea una plataforma en el cielo y te lleva ahí
          local plataforma = Instance.new("Part")
          plataforma.Name = "PlataformaSegura"
          plataforma.Size = Vector3.new(50, 2, 50)
          plataforma.Position = Vector3.new(0, 5000, 0)
          plataforma.Anchored = true
          plataforma.Parent = workspace
          hrp.CFrame = CFrame.new(0, 5005, 0)
          Rayfield:Notify({Title = "A salvo", Content = "Teletransportado a la Zona Segura.", Duration = 3})
      else
          -- Te devuelve al mapa normal (spawn) y borra la plataforma
          if workspace:FindFirstChild("PlataformaSegura") then
              workspace.PlataformaSegura:Destroy()
          end
          -- Suicidio suave para reaparecer en el spawn normal
          game.Players.LocalPlayer.Character.Humanoid.Health = 0
      end
   end
})

-- ==========================================
-- 4. PESTAÑA: PLAYER (MOVIMIENTO)
-- ==========================================
PlayerTab:CreateToggle({
   Name = "Fly (Vuelo)",
   CurrentValue = false,
   Flag = "Fly",
   Callback = function(Value)
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local hrp = char:WaitForChild("HumanoidRootPart")
      
      if Value then
          getgenv().Flying = true
          local bodyVel = Instance.new("BodyVelocity")
          bodyVel.Name = "VueloViral"
          bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
          bodyVel.Velocity = Vector3.new(0, 0, 0)
          bodyVel.Parent = hrp
          
          game:GetService("RunService").RenderStepped:Connect(function()
              if getgenv().Flying and char:FindFirstChild("Humanoid") then
                  local moveDir = char.Humanoid.MoveDirection
                  bodyVel.Velocity = (moveDir * 50) -- Velocidad del vuelo
              end
          end)
      else
          getgenv().Flying = false
          if hrp:FindFirstChild("VueloViral") then
              hrp.VueloViral:Destroy()
          end
      end
   end
})

PlayerTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 300},
   Increment = 1,
   CurrentValue = 16,
   Flag = "WalkSpeedSlider",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end
})

PlayerTab:CreateSlider({
   Name = "JumpPower",
   Range = {50, 300},
   Increment = 1,
   CurrentValue = 50,
   Flag = "JumpPowerSlider",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end
})

PlayerTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfJump",
   Callback = function(Value)
      getgenv().InfJump = Value
      game:GetService("UserInputService").JumpRequest:Connect(function()
          if getgenv().InfJump then
              game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
          end
      end)
   end
})

-- ==========================================
-- 5. PESTAÑA: CONFIGURACIÓN
-- ==========================================
ConfigTab:CreateToggle({
   Name = "Mostrar FPS",
   CurrentValue = false,
   Flag = "ShowFPS",
   Callback = function(Value)
      if Value then
          local Gui = Instance.new("ScreenGui")
          Gui.Name = "FPSGui"
          Gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
          local Text = Instance.new("TextLabel")
          Text.Parent = Gui
          Text.Size = UDim2.new(0, 100, 0, 30)
          Text.Position = UDim2.new(1, -110, 0, 10)
          Text.BackgroundTransparency = 0.5
          Text.BackgroundColor3 = Color3.new(0,0,0)
          Text.TextColor3 = Color3.new(1,1,1)
          Text.TextScaled = true
          Text.Font = Enum.Font.SourceSansBold
          
          getgenv().ShowFPS = true
          task.spawn(function()
              local RunService = game:GetService("RunService")
              while getgenv().ShowFPS do
                  local fps = math.floor(1 / RunService.RenderStepped:Wait())
                  Text.Text = "FPS: " .. fps
              end
          end)
      else
          getgenv().ShowFPS = false
          if game.Players.LocalPlayer.PlayerGui:FindFirstChild("FPSGui") then
              game.Players.LocalPlayer.PlayerGui.FPSGui:Destroy()
          end
      end
   end
})

ConfigTab:CreateButton({
   Name = "Anti Lag (Boost de FPS)",
   Callback = function()
      -- Borra texturas, materiales y sombras para que el juego vuele
      workspace.Terrain.WaterWaveSize = 0
      workspace.Terrain.WaterWaveSpeed = 0
      workspace.Terrain.WaterReflectance = 0
      workspace.Terrain.WaterTransparency = 0
      game.Lighting.GlobalShadows = false
      game.Lighting.FogEnd = 9e9
      for i,v in pairs(workspace:GetDescendants()) do
          if v:IsA("BasePart") then
              v.Material = Enum.Material.SmoothPlastic
          elseif v:IsA("Decal") or v:IsA("Texture") then
              v:Destroy()
          end
      end
      Rayfield:Notify({Title = "Anti Lag", Content = "Gráficos reducidos al mínimo. FPS Boost activado.", Duration = 3})
   end
})

-- Inicializar Rayfield
Rayfield:LoadConfiguration()
