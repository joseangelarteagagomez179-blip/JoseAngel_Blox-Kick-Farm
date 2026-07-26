-- ======================================================
-- Script: ✨ JoseAngel_Blox Kick ✨
-- Creado por: JoseAngel_Blox
-- Fecha: 26/07/2026 | Versión: 1.9 (Remotos Oficiales)
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
local character, humanoid, hrp

local function actualizarChar()
    character = player.Character or player.CharacterAdded:Wait()
    humanoid = character:WaitForChild("Humanoid")
    hrp = character:WaitForChild("HumanoidRootPart")
end
actualizarChar()
player.CharacterAdded:Connect(actualizarChar)

local function getRemote(nombre)
    return game:GetService("ReplicatedStorage"):FindFirstChild(nombre, true)
end

-- ==================== 1) INFO ↓ ====================
local InfoTab = Window:CreateTab("1) info ↓", 4483362458)
InfoTab:CreateSection("📌 Información del Script")
InfoTab:CreateLabel("👨‍💻 Creador: JoseAngel_Blox")
InfoTab:CreateLabel("📅 Fecha: 26/07/2026")
InfoTab:CreateLabel("🚀 Versión: 1.9")
InfoTab:CreateSection("👋 Mensaje")
InfoTab:CreateParagraph({Title = "✨ ¡Remotos Oficiales! ✨", Content = "Todos sacados directamente de Dex Explorer 😉"})

-- ==================== 2) MAIN ↓ ====================
local MainTab = Window:CreateTab("2) Main ↓", 4483362458)
MainTab:CreateSection("⚡ Funciones Principales")

-- 👟 Auto Kick
local autoKick = false
MainTab:CreateToggle({Name = "👟 Auto Kick", CurrentValue = false, Flag = "AutoKick", Callback = function(v)
    autoKick = v
    task.spawn(function() while autoKick do pcall(function() local r = getRemote("rev_KickEvent") if r then r:FireServer() end end) task.wait(0.05) end end)
end})

-- 🏋️ Auto Weight ✅ REMOTOS EXACTOS rev_WeightEquip + rev_Weight_Multi
local autoWeight = false
MainTab:CreateToggle({Name = "🏋️ Auto Weight", CurrentValue = false, Flag = "AutoWeight", Callback = function(v)
    autoWeight = v
    task.spawn(function()
        while autoWeight do
            pcall(function()
                if not humanoid then return end
                local backpack = player:FindFirstChild("Backpack")
                if not backpack then return end

                local pesa = backpack:FindFirstChild("Weight")
                if pesa and pesa:IsA("Tool") then
                    if pesa.Parent ~= character then humanoid:EquipTool(pesa) end
                    -- Remotos oficiales para activar el entrenamiento
                    local equip = getRemote("rev_WeightEquip")
                    local multi = getRemote("rev_Weight_Multi")
                    local update = getRemote("rev_Weight_Update")
                    if equip then equip:FireServer() end
                    if multi then multi:FireServer() end
                    if update then update:FireServer() end
                end
            end)
            task.wait(0.08)
        end
    end)
end})

-- 👆 Auto Click x2 ✅ rev_TaviMishkal(2)
local autoClick = false
MainTab:CreateToggle({Name = "👆 Auto Click x2", CurrentValue = false, Flag = "AutoClickX2", Callback = function(v)
    autoClick = v
    task.spawn(function() while autoClick do pcall(function() local r = getRemote("rev_TaviMishkal") if r then r:FireServer(2) end end) task.wait(0.015) end end)
end})

-- 🧲 Auto Recoger Dinero ✅ REMOTO EXACTO rev_Collected
local autoRecoger = false
MainTab:CreateToggle({Name = "🧲 Auto Recoger Dinero", CurrentValue = false, Flag = "AutoRecoger", Callback = function(v)
    autoRecoger = v
    task.spawn(function()
        while autoRecoger do
            pcall(function()
                local r = getRemote("rev_Collected")
                if r then
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj.Name == "Coin" and obj:IsA("BasePart") and obj.Visible then
                            r:FireServer(obj)
                        end
                    end
                end
            end)
            task.wait(0.12)
        end
    end)
end})

-- 🔄 Auto Rebirth ✅ REMOTO rev_RebirthRequest
local autoRebirth = false
MainTab:CreateToggle({Name = "🔄 Auto Rebirth", CurrentValue = false, Flag = "AutoRebirth", Callback = function(v)
    autoRebirth = v
    task.spawn(function() while autoRebirth do pcall(function() local r = getRemote("rev_RebirthRequest") if r then r:FireServer() end end) task.wait(1) end end)
end})

-- 📋 Mostrar Panel de Patada ✅ KickResultGui
MainTab:CreateToggle({Name = "📋 Mostrar Panel de Patada", CurrentValue = true, Flag = "ShowPanel", Callback = function(v)
    local pg = player:FindFirstChild("PlayerGui")
    if pg and pg:FindFirstChild("KickResultGui") then
        pg.KickResultGui.Enabled = v
    end
end})

-- ==================== 3) PLAYER ↓ ====================
local PlayerTab = Window:CreateTab("3) Player ↓", 4483362458)
PlayerTab:CreateSection("🏃 Opciones del Jugador")

-- 🕊️ Fly Estable
local flying = false
PlayerTab:CreateToggle({Name = "🕊️ Fly", CurrentValue = false, Flag = "FlyMode", Callback = function(v)
    flying = v
    task.spawn(function()
        local bg, bv
        while flying and hrp and humanoid and humanoid.Health > 0 do
            bg = bg or Instance.new("BodyGyro", hrp)
            bv = bv or Instance.new("BodyVelocity", hrp)
            bg.P = 1000
            bg.maxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bv.maxForce = Vector3.new(math.huge, math.huge, math.huge)
            local cam = workspace.CurrentCamera
            local dir = humanoid.MoveDirection
            bv.Velocity = (cam.CFrame.LookVector * dir.Z + cam.CFrame.RightVector * dir.X) * 55
            bg.CFrame = cam.CFrame
            task.wait()
        end
        if bg then bg:Destroy() end
        if bv then bv:Destroy() end
    end)
end})

PlayerTab:CreateSlider({Name = "⚡ Walkspeed", Range = {16, 500}, Increment = 1, Suffix = " Speed", CurrentValue = 16, Flag = "WalkspeedSlider", Callback = function(v) if humanoid then humanoid.WalkSpeed = v end end})

PlayerTab:CreateToggle({Name = "🛡️ Anti AFK", CurrentValue = true, Flag = "AntiAFK", Callback = function(v) if v then local vu = game:GetService("VirtualUser") player.Idled:Connect(function() vu:CaptureController() vu:ClickButton2(Vector2.new()) end) end end})

-- ==================== 4) CONFIGURACIONES ↓ ====================
local ConfigTab = Window:CreateTab("4) Configuraciones ↓", 4483362458)
ConfigTab:CreateSection("⚙️ Rendimiento")

ConfigTab:CreateButton({Name = "🧹 Anti Lag", Callback = function() for _, d in pairs(workspace:GetDescendants()) do if d:IsA("BasePart") then d.Material = Enum.Material.SmoothPlastic d.Reflectance = 0 end end game.Lighting.GlobalShadows = false Rayfield:Notify({Title = "✅ Listo", Content = "Gráficos optimizados", Duration = 3}) end})

ConfigTab:CreateToggle({Name = "📊 Mostrar FPS", CurrentValue = false, Flag = "ShowFPS", Callback = function(v)
    local rs = game:GetService("RunService")
    if v then _G.ShowFPS = true local sg = Instance.new("ScreenGui") local tl = Instance.new("TextLabel") sg.Name = "FPSCounter" sg.Parent = game.CoreGui tl.Parent = sg tl.Size = UDim2.new(0,100,0,30) tl.Position = UDim2.new(0,10,0,10) tl.BackgroundTransparency = 0.5 tl.BackgroundColor3 = Color3.new(0,0,0) tl.TextColor3 = Color3.new(0,1,0) tl.TextSize = 14 tl.Font = Enum.Font.SourceSansBold
    task.spawn(function() local t=0 local f=0 while _G.ShowFPS do f=f+1 if tick()-t>=1 then tl.Text="FPS: "..f f=0 t=tick() end rs.RenderStepped:Wait() end sg:Destroy() end)
    else _G.ShowFPS=false if game.CoreGui:FindFirstChild("FPSCounter") then game.CoreGui.FPSCounter:Destroy() end end
end})

Rayfield:Notify({Title = "✅ JoseAngel_Blox Kick v1.9", Content = "¡Todos los remotos oficiales cargados!", Duration = 5})
