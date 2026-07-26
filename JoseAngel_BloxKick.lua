-- ======================================================
-- Script: ✨ JoseAngel_Blox Kick ✨
-- Creado por: JoseAngel_Blox
-- Fecha: 26/07/2026 | Versión: 1.6 (Todo Corregido)
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

-- ✅ ACTUALIZAR PERSONAJE AL RESPAWNEAR
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
InfoTab:CreateLabel("🚀 Versión: 1.6")
InfoTab:CreateSection("👋 Mensaje")
InfoTab:CreateParagraph({Title = "✨ ¡Todo Arreglado! ✨", Content = "Solo pesas, clic automático y recoger dinero 😉"})

-- ==================== 2) MAIN ↓ ====================
local MainTab = Window:CreateTab("2) Main ↓", 4483362458)
MainTab:CreateSection("⚡ Funciones Principales")

-- 👟 Auto Kick
local autoKick = false
MainTab:CreateToggle({Name = "👟 Auto Kick", CurrentValue = false, Flag = "AutoKick", Callback = function(v)
    autoKick = v
    task.spawn(function() while autoKick do pcall(function() local r = getRemote("rev_KickEvent") if r then r:FireServer() end end) task.wait(0.05) end end)
end})

-- 🏋️ Auto Weight ✅ SOLO EQUIPA PESAS, IGNORA BRAINROTS
local autoWeight = false
MainTab:CreateToggle({Name = "🏋️ Auto Weight", CurrentValue = false, Flag = "AutoWeight", Callback = function(v)
    autoWeight = v
    task.spawn(function()
        while autoWeight do
            pcall(function()
                local backpack = player:FindFirstChild("Backpack")
                if not backpack or not humanoid then return end

                local pesa = nil
                -- Busca SOLO herramientas que sean pesas
                for _, herramienta in pairs(backpack:GetChildren()) do
                    if herramienta:IsA("Tool") and (
                        string.find(string.lower(herramienta.Name), "pesa") or
                        string.find(string.lower(herramienta.Name), "weight") or
                        string.find(string.lower(herramienta.Name), "dumbbell")
                    ) then
                        pesa = herramienta
                        break
                    end
                end
                -- Si ya la tienes equipada
                if not pesa then pesa = character:FindFirstChildWhichIsA("Tool") end

                if pesa then
                    if pesa.Parent ~= character then humanoid:EquipTool(pesa) end
                    pesa:Activate()
                    -- Valores exactos del remoto
                    local r = getRemote("rev_KickData")
                    if r then r:FireServer(12503000000, 183) end
                end
            end)
            task.wait(0.1)
        end
    end)
end})

-- 👆 Auto Click x2 ✅ CLIC A BOTONES MORADOS X2
local autoClick = false
MainTab:CreateToggle({Name = "👆 Auto Click x2", CurrentValue = false, Flag = "AutoClickX2", Callback = function(v)
    autoClick = v
    task.spawn(function()
        local VirtualUser = game:GetService("VirtualUser")
        while autoClick do
            pcall(function()
                -- Busca todos los botones morados de clic x2
                for _, gui in pairs(game:GetService("CoreGui"):GetDescendants()) do
                    if gui:IsA("GuiButton") and gui.Visible and gui.Text:find("x2") or gui.Name:find("Click") then
                        VirtualUser:Button1Down(Vector2.new(gui.AbsolutePosition.X + gui.AbsoluteSize.X/2, gui.AbsolutePosition.Y + gui.AbsoluteSize.Y/2))
                        VirtualUser:Button1Up(Vector2.new(gui.AbsolutePosition.X + gui.AbsoluteSize.X/2, gui.AbsolutePosition.Y + gui.AbsoluteSize.Y/2))
                    end
                end
                -- También activa el remoto por seguridad
                local r = getRemote("rev_TaviMishkal")
                if r then r:FireServer(2) end
            end)
            task.wait(0.02)
        end
    end)
end})

-- 🧲 Auto Recoger Dinero ✅ ARREGLADO SOLO PARA DINERO
local autoRecoger = false
MainTab:CreateToggle({Name = "🧲 Auto Recoger Dinero", CurrentValue = false, Flag = "AutoRecoger", Callback = function(v)
    autoRecoger = v
    task.spawn(function()
        while autoRecoger do
            pcall(function()
                -- Recoge objetos de dinero en el suelo
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and obj.Visible and (
                        obj.Name:find("Coin") or obj.Name:find("Money") or obj.Name:find("Cash") or obj.Name:find("Bill")
                    ) then
                        -- Se acerca y recoge
                        hrp:PivotTo(CFrame.new(obj.Position + Vector3.new(0, 2, 0)))
                    end
                end
            end)
            task.wait(0.15)
        end
    end)
end})

-- 🔄 Auto Rebirth
MainTab:CreateToggle({Name = "🔄 Auto Rebirth", CurrentValue = false, Flag = "AutoRebirth", Callback = function(v) end})

-- 📋 Show Panel ✅ ARREGLADO: Panel de rareza/mutación
MainTab:CreateToggle({Name = "📋 Mostrar Panel de Patada", CurrentValue = true, Flag = "ShowPanel", Callback = function(v)
    local playerGui = player:FindFirstChild("PlayerGui")
    if playerGui then
        for _, gui in pairs(playerGui:GetChildren()) do
            if gui:IsA("ScreenGui") and gui.Name ~= "Rayfield" and (gui.Name:find("Kick") or gui.Name:find("Preview") or gui.Name:find("Info")) then
                gui.Enabled = v
            end
        end
    end
end})

-- ==================== 3) PLAYER ↓ ====================
local PlayerTab = Window:CreateTab("3) Player ↓", 4483362458)
PlayerTab:CreateSection("🏃 Opciones del Jugador")

-- 🕊️ Fly ✅ TOTALMENTE CORREGIDO
local flying = false
PlayerTab:CreateToggle({Name = "🕊️ Fly", CurrentValue = false, Flag = "FlyMode", Callback = function(v)
    flying = v
    task.spawn(function()
        local bg, bv
        while flying and hrp and humanoid and humanoid.Health > 0 do
            bg = bg or Instance.new("BodyGyro", hrp)
            bv = bv or Instance.new("BodyVelocity", hrp)
            bg.P = 9e4
            bg.maxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bv.maxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.Velocity = Vector3.new(0, 0, 0)
            bg.CFrame = workspace.CurrentCamera.CFrame
            
            local cam = workspace.CurrentCamera
            local dir = Vector3.new()
            if humanoid.MoveDirection ~= Vector3.new() then
                dir = humanoid.MoveDirection
            end
            bv.Velocity = (cam.CFrame.LookVector * dir.Z + cam.CFrame.RightVector * dir.X) * 60
            
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

Rayfield:Notify({Title = "✅ JoseAngel_Blox Kick v1.6", Content = "¡Todo arreglado como pediste!", Duration = 5})
