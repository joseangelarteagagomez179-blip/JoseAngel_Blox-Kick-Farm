-- Cargar la librería gráfica (Rayfield)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Crear la Ventana Principal
local Window = Rayfield:CreateWindow({
   Name = "JoseAngel_Blox Kick Farm | v1.1",
   LoadingTitle = "Cargando Script...",
   LoadingSubtitle = "Creado por JoseAngel_Blox",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "JoseAngelConfig",
      FileName = "KickFarmHub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false,
})

-- ==========================================
-- PESTAÑA 1: INFO
-- ==========================================
local InfoTab = Window:CreateTab("Info", 4483345998) -- El número es el ID del icono

InfoTab:CreateLabel("Nombre del creador: JoseAngel_Blox")
InfoTab:CreateLabel("Fecha de lanzamiento: 27/07/2026")
InfoTab:CreateLabel("Versión: 1.1")
InfoTab:CreateParagraph({
    Title = "Actualización 1.1", 
    Content = "Versión nueva optimizada sin lag, mayor rendimiento."
})

-- ==========================================
-- PESTAÑA 2: MAIN
-- ==========================================
local MainTab = Window:CreateTab("Main", 4483345998)

-- Variables globales
getgenv().AutoKick = false
getgenv().AutoFarm = false

-- Toggle: Auto-Kick
MainTab:CreateToggle({
   Name = "Auto-Kick",
   CurrentValue = false,
   Flag = "AutoKickToggle",
   Callback = function(Value)
      getgenv().AutoKick = Value
      while getgenv().AutoKick do
          task.wait(0.1)
          -- [!] Aquí irá la lógica para patear
      end
   end,
})

-- Toggle: Auto Farm
MainTab:CreateToggle({
   Name = "Auto Farm",
   CurrentValue = false,
   Flag = "AutoFarmToggle",
   Callback = function(Value)
      getgenv().AutoFarm = Value
      while getgenv().AutoFarm do
          task.wait(0.5)
          -- [!] Aquí irá la lógica de teletransporte
      end
   end,
})

-- Slider: Ajustador de Velocidad
MainTab:CreateSlider({
   Name = "Velocidad de carrera",
   Range = {16, 200},
   Increment = 1,
   Suffix = "WalkSpeed",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      local player = game.Players.LocalPlayer
      if player.Character and player.Character:FindFirstChild("Humanoid") then
          player.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

-- ==========================================
-- PESTAÑA 3: OPTIMIZACIÓN
-- ==========================================
local OptTab = Window:CreateTab("Optimización", 4483345998)

-- Botón: Anti Lag
OptTab:CreateButton({
   Name = "Activar Anti Lag",
   Callback = function()
      game.Lighting.GlobalShadows = false
      game.Lighting.FogEnd = 9e9
      for _, v in pairs(workspace:GetDescendants()) do
          if v:IsA("BasePart") and not v:IsA("MeshPart") then
              v.Material = Enum.Material.SmoothPlastic
          elseif v:IsA("Decal") or v:IsA("Texture") then
              v:Destroy()
          end
      end
      Rayfield:Notify({
         Title = "Anti Lag Activado",
         Content = "Gráficos reducidos al mínimo para mayor rendimiento.",
         Duration = 3,
         Image = 4483345998,
      })
   end,
})

-- Toggle: Mostrar FPS
local RunService = game:GetService("RunService")
local FpsLabel = OptTab:CreateLabel("FPS: Esperando...")
local FpsConnection

OptTab:CreateToggle({
   Name = "Mostrar FPS",
   CurrentValue = false,
   Flag = "FpsToggle",
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
   end,
})
