-- ======================================================
-- Script: ✨ JoseAngel_Blox Kick ✨
-- Creado por: JoseAngel_Blox
-- Fecha: 26/07/2026 | Versión: 1.1 (Remotos Corregidos)
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

local function getRemote(name)
    return game:GetService("ReplicatedStorage"):FindFirstChild(name, true)
end

-- ==================== 1) INFO ↓ ====================
local InfoTab = Window:CreateTab("1) info ↓", 4483362458)
InfoTab:CreateSection("📌 Información del Script")
InfoTab:CreateLabel("👨‍💻 Creador: JoseAngel_Blox")
InfoTab:CreateLabel("📅 Fecha de creación: 26/07/2026")
InfoTab:CreateLabel("🚀 Versión: 1.1")
InfoTab:CreateSection("👋 Mensaje de Bienvenida")
InfoTab:CreateParagraph({Title = "✨ ¡Hola! Bienvenido/a ✨", Content = "Un gran saludo de parte de JoseAngel_Blox. Espero de todo corazón que disfrutes mucho de este script y te sea súper útil para avanzar rápido en el juego.\n\n¡Gracias por usarlo y a divertirse! 😉"})

-- ==================== 2) MAIN ↓ ====================
local MainTab = Window:CreateTab("2) Main ↓", 4483362458)
MainTab:CreateSection("⚡ Funciones Principales")

local autoKickEnabled = false
MainTab:CreateToggle({Name = "👟 Auto Kick", CurrentValue = false, Flag = "AutoKick", Callback = function(Value)
    autoKickEnabled = Value
    task.spawn(function() while autoKickEnabled do pcall(function() local r = getRemote("rev_KickEvent") if r then r:FireServer() end end) task.wait(0.05) end end)
end})

local autoWeightEnabled = false
MainTab:CreateToggle({Name = "🏋️ Auto Weight", CurrentValue = false, Flag = "AutoWeight", Callback = function(Value)
    autoWeightEnabled = Value
    task.spawn(function() while autoWeightEnabled do pcall(function() local r = getRemote("rev_KickData") if r then r:FireServer(2) end end) task.wait(0.1) end end)
end})

local autoClickEnabled = false
MainTab:CreateToggle({Name = "👆 Auto Click x2", CurrentValue = false, Flag = "AutoClickX2", Callback = function(Value)
    autoClickEnabled = Value
    task.spawn(function() while autoClickEnabled do pcall(function() local r = getRemote("rev_TaviMishkal") if r then r:FireServer(2) end end) task.wait(0.01) end end)
end})

local autoRecogerEnabled = false
MainTab:CreateToggle({Name = "🧲 Auto Recoger", CurrentValue = false, Flag = "AutoRecoger", Callback = function(Value)
    autoRecogerEnabled = Value
    task.spawn(function() while autoRecogerEnabled do pcall(function() local r = getRemote("rev_B_Collect") if r then for _, o in pairs(workspace:GetDescendants()) do if o:IsA("BasePart") and (o.Name:find("Coin") or o.Name:find("Money") or o.Name:find("Collect") or o:GetAttribute("Collectable")) then r:FireServer(o) end end end end) task.wait(0.15) end end)
end})

local autoMejorarEnabled = false
MainTab:CreateToggle({Name = "🛠️ Auto Mejorar", CurrentValue = false, Flag = "AutoMejorar", Callback = function(Value) autoMejorarEnabled = Value end})
local autoRebirthEnabled = false
MainTab:CreateToggle({Name = "🔄 Auto Rebirth", CurrentValue = false, Flag = "AutoRebirth", Callback = function(Value) autoRebirthEnabled = Value end})

MainTab:CreateToggle({Name = "📋 Show Panel", CurrentValue = false, Flag = "ShowPanel", Callback = function(Value)
    local pg = player:FindFirstChild("PlayerGui") if pg then for _, g in pairs(pg:GetChildren()) do if g:IsA("ScreenGui") and g.Name ~= "Rayfield" then g.Enabled = Value end end end
end})

-- ==================== 3) PLAYER ↓ ====================
local PlayerTab = Window:CreateTab("3) Player ↓", 4483362458)
PlayerTab:CreateSection("🏃 Opciones del Jugador")

local flying = false
PlayerTab:CreateToggle({Name = "🕊️ Fly", CurrentValue = false, Flag = "FlyMode", Callback = function(Value)
    flying = Value local hrp = character:WaitForChild("HumanoidRootPart") local bg = Instance.new("BodyGyro",hrp) local bv = Instance.new("BodyVelocity",hrp) bg.P=9e4 bg.maxTorque=Vector3.new(9e9,9e9,9e9) bv.maxForce=Vector3.new(9e9,9e9,9e9)
    task.spawn(function() while flying do task.wait() local cam = workspace.CurrentCamera if character and character:FindFirstChild("Humanoid") then local md = character.Humanoid.MoveDirection bv.velocity = (cam.CFrame.LookVector*md.Z + cam.CFrame.RightVector*md.X)*50 bg.cframe = cam.CFrame end end bg:Destroy() bv:Destroy() end)
end})

PlayerTab:CreateSlider({Name = "⚡ Walkspeed (Velocidad Ajustable)", Range = {16,500}, Increment = 1, Suffix = " Speed", CurrentValue = 16, Flag = "WalkspeedSlider", Callback = function(Value) if character and character:FindFirstChild("Humanoid") then character.Humanoid.WalkSpeed = Value end end})

PlayerTab:CreateToggle({Name = "🛡️ Anti AFK", CurrentValue = true, Flag = "AntiAFK", Callback = function(Value) if Value then local v = game:GetService("VirtualUser") player.Idled:Connect(function() v:CaptureController() v:ClickButton2(Vector2.new()) end) end end})

-- ==================== 4) CONFIGURACIONES ↓ ====================
local ConfigTab = Window:CreateTab("4) Configuraciones ↓", 4483362458)
ConfigTab:CreateSection("⚙️ Rendimiento y Pantalla")

ConfigTab:CreateButton({Name = "🧹 Anti Lag (Optimizar Gráficos)", Callback = function() for _, v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic v.Reflectance = 0 end end game.Lighting.GlobalShadows = false Rayfield:Notify({Title = "Anti Lag", Content = "Gráficos optimizados.", Duration = 3}) end})

ConfigTab:CreateToggle({Name = "📊 Mostrar FPS", CurrentValue = false, Flag = "ShowFPS", Callback = function(Value)
    local rs = game:GetService("RunService") if Value then _G.ShowFPSVar = true local sg = Instance.new("ScreenGui") local tl = Instance.new("TextLabel") sg.Name = "FPSCounter" sg.Parent = game.CoreGui tl.Parent = sg tl.Size = UDim2.new(0,100,0,30) tl.Position = UDim2.new(0,10,0,10) tl.BackgroundTransparency = 0.5 tl.BackgroundColor3 = Color3.new(0,0,0) tl.TextColor3 = Color3.new(0,1,0) tl.TextSize = 14 tl.Font = Enum.Font.SourceSansBold
    task.spawn(function() local lt = tick() local f=0 while _G.ShowFPSVar do f=f+1 if tick()-lt>=1 then tl.Text="FPS: "..f f=0 lt=tick() end rs.RenderStepped:Wait() end sg:Destroy() end) else _G.ShowFPSVar=false if game.CoreGui:FindFirstChild("FPSCounter") then game.CoreGui.FPSCounter:Destroy() end end
end})

Rayfield:Notify({Title = "✅ JoseAngel_Blox Kick v1.1 Cargado", Content = "Auto Weight, Auto Click y Auto Recoger corregidos!", Duration = 5})
