--[[
╔══════════════════════════════════════════════════════════════╗
║                 JoseAngel_Blox Kick v1.2                     ║
║             Creado por: JoseAngel_Blox                       ║
║             Fecha: 26/07/2026                                ║
║             Para: Kick a Lucky Block                         ║
║             Ejecutor: Delta Android                          ║
╚══════════════════════════════════════════════════════════════╝
--]]

-- ==================== SERVICIOS ====================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LP = Players.LocalPlayer

-- ==================== CONFIG ====================
local Config = {
    AutoKick = false,
    AutoWeight = false,
    AutoRecoger = false,
    AutoClickX2 = false,
    AutoMejorar = false,
    AutoRebirth = false,
    ShowPanel = false,
    Fly = false,
    WalkSpeed = 50,
    SpeedHack = false,
    AntiAfk = false,
    AntiLag = false,
    ShowFps = false,
}

-- ==================== VARIABLES ====================
local flyConnection = nil
local noclipConnection = nil
local flyBodyVel = nil
local fpsLabel = nil
local coros = {}

-- ==================== PARENT ====================
local parentObj = (function()
    local s, g = pcall(gethui)
    if s and g then return g end
    return game:GetService("CoreGui")
end)()

-- Limpiar GUI anterior
local old = parentObj:FindFirstChild("JoseAngelBloxKick")
if old then old:Destroy() end

-- ==================== COLORES ====================
local COLORS = {
    bg = Color3.fromRGB(12, 12, 28),
    bg2 = Color3.fromRGB(18, 18, 38),
    accent = Color3.fromRGB(255, 170, 0),
    accent2 = Color3.fromRGB(255, 200, 60),
    text = Color3.fromRGB(230, 230, 240),
    text2 = Color3.fromRGB(160, 160, 180),
    toggleOff = Color3.fromRGB(50, 50, 65),
    toggleOn = Color3.fromRGB(255, 170, 0),
    danger = Color3.fromRGB(255, 60, 60),
    success = Color3.fromRGB(60, 255, 120),
    info = Color3.fromRGB(60, 180, 255),
    card = Color3.fromRGB(18, 18, 40),
}

-- ==================== SCREEN GUI ====================
local gui = Instance.new("ScreenGui")
gui.Name = "JoseAngelBloxKick"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = parentObj

-- ==================== MAIN FRAME ====================
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 380, 0, 500)
main.Position = UDim2.new(0.5, -190, 0.5, -250)
main.BackgroundColor3 = COLORS.bg
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = main

-- Sombra exterior
local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://6014261993"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.6
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Parent = main

-- Borde brillante
local stroke = Instance.new("UIStroke")
stroke.Color = COLORS.accent
stroke.Thickness = 2
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Transparency = 0.3
stroke.Parent = main

-- ==================== TOP BAR ====================
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 55)
topBar.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
topBar.BackgroundTransparency = 0.1
topBar.BorderSizePixel = 0
topBar.Parent = main

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 16)
topBarCorner.Parent = topBar

-- Esquina inferior derecha del topbar
local topBarFill = Instance.new("Frame")
topBarFill.Size = UDim2.new(1, 0, 0, 20)
topBarFill.Position = UDim2.new(0, 0, 1, -20)
topBarFill.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
topBarFill.BackgroundTransparency = 0.1
topBarFill.BorderSizePixel = 0
topBarFill.Parent = topBar

-- Efecto de brillo en top bar
local glow = Instance.new("ImageLabel")
glow.Size = UDim2.new(1, 0, 0, 30)
glow.Position = UDim2.new(0, 0, 1, -15)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://5028857640"
glow.ImageColor3 = COLORS.accent
glow.ImageTransparency = 0.5
glow.ScaleType = Enum.ScaleType.Slice
glow.SliceCenter = Rect.new(20, 20, 280, 280)
glow.Parent = topBar

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 28)
title.Position = UDim2.new(0, 14, 0, 5)
title.BackgroundTransparency = 1
title.Text = "⚡ JoseAngel_Blox Kick"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

-- Subtítulo
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -50, 0, 18)
subtitle.Position = UDim2.new(0, 14, 0, 32)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Creado por JoseAngel_Blox"
subtitle.TextColor3 = Color3.fromRGB(255, 240, 200)
subtitle.TextSize = 12
subtitle.Font = Enum.Font.Gotham
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.TextTransparency = 0.15
subtitle.Parent = topBar

-- Botón cerrar
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -36, 0, 13)
closeBtn.BackgroundColor3 = COLORS.danger
closeBtn.BackgroundTransparency = 0.2
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Efecto hover cerrar
closeBtn.MouseEnter:Connect(function()
    closeBtn.BackgroundTransparency = 0
end)
closeBtn.MouseLeave:Connect(function()
    closeBtn.BackgroundTransparency = 0.2
end)

-- ==================== CONTENEDOR ====================
local container = Instance.new("Frame")
container.Size = UDim2.new(1, -16, 1, -65)
container.Position = UDim2.new(0, 8, 0, 60)
container.BackgroundTransparency = 1
container.BorderSizePixel = 0
container.ClipsDescendants = true
container.Parent = main

-- ==================== FUNCIÓN: CREAR BOTÓN DE SECCIÓN ====================
local function crearSeccion(titulo, icono)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 44)
    frame.BackgroundColor3 = COLORS.card
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.Parent = container

    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 10)
    fCorner.Parent = frame

    local fStroke = Instance.new("UIStroke")
    fStroke.Color = COLORS.accent
    fStroke.Thickness = 1
    fStroke.Transparency = 0.7
    fStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    fStroke.Parent = frame

    -- Botón header
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 44)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = frame

    -- Icono
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 30, 1, 0)
    iconLabel.Position = UDim2.new(0, 10, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icono
    iconLabel.TextColor3 = COLORS.accent
    iconLabel.TextSize = 18
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.Parent = btn

    -- Título
    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -80, 1, 0)
    titleLbl.Position = UDim2.new(0, 44, 0, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = titulo
    titleLbl.TextColor3 = COLORS.text
    titleLbl.TextSize = 15
    titleLbl.Font = Enum.Font.GothamSemibold
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = btn

    -- Flecha
    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 30, 1, 0)
    arrow.Position = UDim2.new(1, -34, 0, 0)
    arrow.BackgroundTransparency = 1
    arrow.Text = "↓"
    arrow.TextColor3 = COLORS.accent2
    arrow.TextSize = 18
    arrow.Font = Enum.Font.GothamBold
    arrow.Parent = btn

    -- Contenido (oculto inicialmente)
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, 0, 0, 0)
    content.Position = UDim2.new(0, 0, 0, 44)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ClipsDescendants = true
    content.Parent = frame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent = content

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 4)
    padding.PaddingBottom = UDim.new(0, 6)
    padding.PaddingLeft = UDim.new(0, 6)
    padding.PaddingRight = UDim.new(0, 6)
    padding.Parent = content

    local expanded = false

    local function updateSize()
        if expanded then
            local h = 44 + content.AbsoluteSize.Y
            frame.Size = UDim2.new(1, 0, 0, h)
        else
            frame.Size = UDim2.new(1, 0, 0, 44)
        end
    end

    content:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateSize)

    btn.MouseButton1Click:Connect(function()
        expanded = not expanded
        content.Visible = expanded
        arrow.Text = expanded and "↑" or "↓"
        arrow.TextColor3 = expanded and COLORS.accent or COLORS.accent2

        if expanded then
            frame.Size = UDim2.new(1, 0, 0, 44 + content.AbsoluteSize.Y)
            frame.BackgroundTransparency = 0.1
            fStroke.Transparency = 0.4
        else
            frame.Size = UDim2.new(1, 0, 0, 44)
            frame.BackgroundTransparency = 0.2
            fStroke.Transparency = 0.7
        end
    end)

    return content, layout
end

-- ==================== FUNCIÓN: TOGGLE BONITO ====================
local function crearToggle(padre, nombre, color, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(14, 14, 32)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = padre

    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 8)
    fCorner.Parent = frame

    local fStroke = Instance.new("UIStroke")
    fStroke.Color = Color3.fromRGB(255, 255, 255)
    fStroke.Thickness = 0.5
    fStroke.Transparency = 0.92
    fStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    fStroke.Parent = frame

    -- Label
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -65, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = nombre
    lbl.TextColor3 = COLORS.text
    lbl.TextSize = 14
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    -- Toggle switch
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 46, 0, 24)
    toggle.Position = UDim2.new(1, -56, 0.5, -12)
    toggle.BackgroundColor3 = COLORS.toggleOff
    toggle.Text = ""
    toggle.Parent = frame

    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(1, 0)
    tCorner.Parent = toggle

    -- Círculo del toggle
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 18, 0, 18)
    dot.Position = UDim2.new(0, 3, 0, 3)
    dot.BackgroundColor3 = Color3.fromRGB(160, 160, 170)
    dot.Parent = toggle

    local dCorner = Instance.new("UICorner")
    dCorner.CornerRadius = UDim.new(1, 0)
    dCorner.Parent = dot

    -- Brillo del toggle
    local dotGlow = Instance.new("ImageLabel")
    dotGlow.Size = UDim2.new(1, 4, 1, 4)
    dotGlow.Position = UDim2.new(0, -2, 0, -2)
    dotGlow.BackgroundTransparency = 1
    dotGlow.Image = "rbxassetid://5028857640"
    dotGlow.ImageColor3 = COLORS.accent
    dotGlow.ImageTransparency = 1
    dotGlow.ScaleType = Enum.ScaleType.Slice
    dotGlow.SliceCenter = Rect.new(20, 20, 280, 280)
    dotGlow.Parent = dot

    local active = false
    local c = color or COLORS.accent

    toggle.MouseButton1Click:Connect(function()
        active = not active
        callback(active)

        local targetColor = active and c or COLORS.toggleOff
        local targetPos = active and UDim2.new(0, 25, 0, 3) or UDim2.new(0, 3, 0, 3)
        local dotColor = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 170)

        TweenService:Create(toggle, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = targetColor
        }):Play()

        TweenService:Create(dot, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = targetPos,
            BackgroundColor3 = dotColor
        }):Play()

        if active then
            TweenService:Create(dotGlow, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageTransparency = 0.3
            }):Play()
        else
            TweenService:Create(dotGlow, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageTransparency = 1
            }):Play()
        end

        if active then
            TweenService:Create(frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 0.15
            }):Play()
        else
            TweenService:Create(frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 0.3
            }):Play()
        end
    end)

    toggle.MouseEnter:Connect(function()
        TweenService:Create(toggle, TweenInfo.new(0.15), {
            BackgroundTransparency = active and 0.05 or 0.1
        }):Play()
    end)
    toggle.MouseLeave:Connect(function()
        TweenService:Create(toggle, TweenInfo.new(0.15), {
            BackgroundTransparency = 0
        }):Play()
    end)
end

-- ==================== FUNCIÓN: LABEL ====================
local function crearLabel(padre, texto, color, tamano)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, tamano or 20)
    lbl.BackgroundTransparency = 1
    lbl.Text = texto
    lbl.TextColor3 = color or COLORS.text2
    lbl.TextSize = 13
    lbl.Font = Enum.Font.Gotham
    lbl.RichText = true
    lbl.TextWrapped = true
    lbl.Parent = padre
    return lbl
end

-- ==================== FUNCIÓN: BOTÓN ====================
local function crearBoton(padre, texto, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.BackgroundColor3 = color or COLORS.accent
    btn.BackgroundTransparency = 0.15
    btn.Text = texto
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamSemibold
    btn.BorderSizePixel = 0
    btn.Parent = padre

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.fromRGB(255, 255, 255)
    btnStroke.Thickness = 0.5
    btnStroke.Transparency = 0.9
    btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    btnStroke.Parent = btn

    btn.MouseButton1Click:Connect(callback)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundTransparency = 0.05,
            Size = UDim2.new(1, -4, 0, 38)
        }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundTransparency = 0.15,
            Size = UDim2.new(1, 0, 0, 38)
        }):Play()
    end)

    btn.MouseButton1Down:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.08), {
            Size = UDim2.new(1, -8, 0, 36)
        }):Play()
    end)
    btn.MouseButton1Up:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.08), {
            Size = UDim2.new(1, 0, 0, 38)
        }):Play()
    end)
end

-- ==================== CREAR SECCIONES ====================
local infoCont = crearSeccion("Info", "📋")
local mainCont = crearSeccion("Main", "⚙️")
local playerCont = crearSeccion("Player", "👤")
local configCont = crearSeccion("Config", "🔧")

-- ==================== 🎯 SECCIÓN INFO ====================
crearLabel(infoCont, '<font color="rgb(255,200,100)">━━━ 📋 INFORMACIÓN ━━━</font>', Color3.fromRGB(255,255,255), 24)

local infoItems = {
    "👤 <b>Creador:</b> JoseAngel_Blox",
    "📅 <b>Fecha:</b> 26/07/2026",
    "🔖 <b>Versión:</b> 1.2",
    "🎮 <b>Juego:</b> Kick a Lucky Block",
    "📱 <b>Ejecutor:</b> Delta Android",
}
for _, item in ipairs(infoItems) do
    crearLabel(infoCont, item, COLORS.text, 20)
end

crearLabel(infoCont, "", Color3.fromRGB(255,255,255), 4)

-- Mensaje de bienvenida
local welcomeFrame = Instance.new("Frame")
welcomeFrame.Size = UDim2.new(1, 0, 0, 0)
welcomeFrame.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
welcomeFrame.BackgroundTransparency = 0.85
welcomeFrame.BorderSizePixel = 0
welcomeFrame.AutomaticSize = Enum.AutomaticSize.Y
welcomeFrame.Parent = infoCont

local wCorner = Instance.new("UICorner")
wCorner.CornerRadius = UDim.new(0, 8)
wCorner.Parent = welcomeFrame

local wPadding = Instance.new("UIPadding")
wPadding.PaddingTop = UDim.new(0, 10)
wPadding.PaddingBottom = UDim.new(0, 10)
wPadding.PaddingLeft = UDim.new(0, 10)
wPadding.PaddingRight = UDim.new(0, 10)
wPadding.Parent = welcomeFrame

local wLayout = Instance.new("UIListLayout")
wLayout.Padding = UDim.new(0, 4)
wLayout.Parent = welcomeFrame

crearLabel(welcomeFrame, '🌟 <b>¡Bienvenido a JoseAngel_Blox Kick!</b> 🌟', Color3.fromRGB(255, 220, 100), 22)
crearLabel(welcomeFrame, "¡Hola! Soy JoseAngel_Blox y espero que disfrutes este script tanto como yo disfruté crearlo para ti. 💪", Color3.fromRGB(210, 210, 220), 32)
crearLabel(welcomeFrame, "Este script está diseñado para ayudarte a dominar Kick a Lucky Block con funciones automáticas y una interfaz moderna.", Color3.fromRGB(190, 190, 210), 28)
crearLabel(welcomeFrame, "¡Que te diviertas y a patear bloques! 🦶✨", Color3.fromRGB(255, 200, 80), 22)

-- Despedida
crearLabel(infoCont, "", Color3.fromRGB(255,255,255), 4)
crearLabel(infoCont, '<font color="rgb(255,150,150)">━━━ 💫 DESPEDIDA ━━━</font>', Color3.fromRGB(255,255,255), 24)
crearLabel(infoCont, "Gracias por usar este script. Si te gusta, compártelo con tus amigos. ¡Nos vemos en la próxima! 🚀", Color3.fromRGB(200, 200, 220), 28)
crearLabel(infoCont, "— JoseAngel_Blox ❤️", Color3.fromRGB(255, 200, 100), 20)

-- ==================== ⚙️ SECCIÓN MAIN ====================
crearLabel(mainCont, '<font color="rgb(255,200,100)">━━━ ⚙️ FUNCIONES PRINCIPALES ━━━</font>', Color3.fromRGB(255,255,255), 24)

crearToggle(mainCont, "🦶 Auto Kick", COLORS.accent, function(estado)
    Config.AutoKick = estado
    if estado then
        coros.AutoKick = task.spawn(function()
            while Config.AutoKick do
                task.wait(0.8)
                pcall(function()
                    local char = LP.Character
                    if not char then return end
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if not hrp then return end

                    local block = nil
                    local minDist = 30
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and obj.Name:lower():find("lucky") then
                            local d = (obj.Position - hrp.Position).Magnitude
                            if d < minDist then
                                block = obj
                                minDist = d
                            end
                        end
                    end

                    if block then
                        hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(block.Position.X, hrp.Position.Y, block.Position.Z))
                        task.wait(0.1)
                        local remote = ReplicatedStorage:FindFirstChild("KickBlock")
                            or ReplicatedStorage:FindFirstChild("Kick")
                            or (ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("Kick"))
                        if remote then
                            if remote:IsA("RemoteEvent") then remote:FireServer(block)
                            elseif remote:IsA("RemoteFunction") then remote:InvokeServer(block) end
                        else
                            local cd = block:FindFirstChildOfClass("ClickDetector")
                            if cd then fireclickdetector(cd) end
                        end
                    end
                end)
            end
        end)
    end
end)

crearToggle(mainCont, "🏋️ Auto Weight", COLORS.success, function(estado)
    Config.AutoWeight = estado
    if estado then
        coros.AutoWeight = task.spawn(function()
            while Config.AutoWeight do
                task.wait(0.3)
                pcall(function()
                    local char = LP.Character
                    if not char then return end
                    local weight = LP.Backpack:FindFirstChild("Weight")
                        or LP.Backpack:FindFirstChild("Barbell")
                        or char:FindFirstChild("Weight")
                        or char:FindFirstChild("Barbell")
                    if weight then
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if hum then hum:EquipTool(weight) end
                        task.wait(0.1)
                        weight:Activate()
                    end
                end)
            end
        end)
    end
end)

crearToggle(mainCont, "💰 Auto Recoger", COLORS.info, function(estado)
    Config.AutoRecoger = estado
    if estado then
        coros.AutoRecoger = task.spawn(function()
            while Config.AutoRecoger do
                task.wait(0.3)
                pcall(function()
                    local char = LP.Character
                    if not char then return end
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if not hrp then return end
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and (
                            obj.Name:lower():find("brainrot") or
                            obj.Name:lower():find("drop") or
                            obj.Name:lower():find("coin") or
                            obj.Name:lower():find("money")
                        ) then
                            local d = (obj.Position - hrp.Position).Magnitude
                            if d < 40 then
                                hrp.CFrame = CFrame.new(obj.Position)
                                task.wait(0.05)
                                firetouchinterest(hrp, obj, 0)
                                task.wait(0.05)
                                firetouchinterest(hrp, obj, 1)
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

crearToggle(mainCont, "🖱️ Auto Click x2", Color3.fromRGB(200, 100, 255), function(estado)
    Config.AutoClickX2 = estado
    if estado then
        coros.AutoClickX2 = task.spawn(function()
            while Config.AutoClickX2 do
                task.wait(0.1)
                pcall(function()
                    local vim = game:GetService("VirtualInputManager")
                    vim:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                    task.wait(0.05)
                    vim:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                    task.wait(0.05)
                    vim:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                    task.wait(0.05)
                    vim:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                end)
            end
        end)
    end
end)

crearToggle(mainCont, "⬆️ Auto Mejorar", Color3.fromRGB(255, 150, 50), function(estado)
    Config.AutoMejorar = estado
    if estado then
        coros.AutoMejorar = task.spawn(function()
            while Config.AutoMejorar do
                task.wait(3)
                pcall(function()
                    local remote = ReplicatedStorage:FindFirstChild("Upgrade")
                        or ReplicatedStorage:FindFirstChild("Mejorar")
                        or ReplicatedStorage:FindFirstChild("Buy")
                    if remote and remote:IsA("RemoteEvent") then
                        remote:FireServer()
                    end
                end)
            end
        end)
    end
end)

crearToggle(mainCont, "🔄 Auto Rebirth", Color3.fromRGB(255, 50, 100), function(estado)
    Config.AutoRebirth = estado
    if estado then
        coros.AutoRebirth = task.spawn(function()
            while Config.AutoRebirth do
                task.wait(5)
                pcall(function()
                    local remote = ReplicatedStorage:FindFirstChild("Rebirth")
                        or ReplicatedStorage:FindFirstChild("Prestige")
                        or ReplicatedStorage:FindFirstChild("Reset")
                    if remote and remote:IsA("RemoteEvent") then
                        remote:FireServer()
                    end
                end)
            end
        end)
    end
end)

crearToggle(mainCont, "📊 Show Panel", COLORS.accent2, function(estado)
    Config.ShowPanel = estado
end)

-- ==================== 👤 SECCIÓN PLAYER ====================
crearLabel(playerCont, '<font color="rgb(100,200,255)">━━━ 👤 MOVIMIENTO ━━━</font>', Color3.fromRGB(255,255,255), 24)

-- FLY
crearToggle(playerCont, "✈️ Fly", Color3.fromRGB(100, 180, 255), function(estado)
    Config.Fly = estado
    pcall(function()
        local char = LP.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        if estado then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1, 1, 1) * 100000
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.P = 10000
            bv.Parent = hrp
            flyBodyVel = bv

            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.PlatformStand = true end

            noclipConnection = RunService.Stepped:Connect(function()
                local c = LP.Character
                if not c then return end
                for _, p in ipairs(c:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end)

            flyConnection = RunService.RenderStepped:Connect(function()
                if not Config.Fly or not flyBodyVel or not flyBodyVel.Parent then return end
                local c = LP.Character
                if not c then return end
                local r = c:FindFirstChild("HumanoidRootPart")
                if not r then return end

                local speed = 50
                local move = Vector3.new(0, 0, 0)

                if UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.Up) then
                    move = move + (workspace.CurrentCamera.CFrame.LookVector * speed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.Down) then
                    move = move - (workspace.CurrentCamera.CFrame.LookVector * speed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.Left) then
                    move = move - (workspace.CurrentCamera.CFrame.RightVector * speed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) or UserInputService:IsKeyDown(Enum.KeyCode.Right) then
                    move = move + (workspace.CurrentCamera.CFrame.RightVector * speed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    move = move + Vector3.new(0, speed, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
                    move = move - Vector3.new(0, speed, 0)
                end

                flyBodyVel.Velocity = move
            end)
        else
            if flyBodyVel then flyBodyVel:Destroy() flyBodyVel = nil end
            if flyConnection then flyConnection:Disconnect() flyConnection = nil end
            if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
            local c = LP.Character
            if c then
                local hum = c:FindFirstChildOfClass("Humanoid")
                if hum then hum.PlatformStand = false end
            end
        end
    end)
end)

-- WALKSPEED
local wsFrame = Instance.new("Frame")
wsFrame.Size = UDim2.new(1, 0, 0, 68)
wsFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 32)
wsFrame.BackgroundTransparency = 0.3
wsFrame.BorderSizePixel = 0
wsFrame.Parent = playerCont

local wsCorner = Instance.new("UICorner")
wsCorner.CornerRadius = UDim.new(0, 8)
wsCorner.Parent = wsFrame

local wsStroke = Instance.new("UIStroke")
wsStroke.Color = Color3.fromRGB(255, 255, 255)
wsStroke.Thickness = 0.5
wsStroke.Transparency = 0.92
wsStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
wsStroke.Parent = wsFrame

local wsLabel = Instance.new("TextLabel")
wsLabel.Size = UDim2.new(1, -20, 0, 22)
wsLabel.Position = UDim2.new(0, 10, 0, 4)
wsLabel.BackgroundTransparency = 1
wsLabel.Text = "⚡ Walkspeed: " .. Config.WalkSpeed
wsLabel.TextColor3 = COLORS.text
wsLabel.TextSize = 14
wsLabel.Font = Enum.Font.GothamSemibold
wsLabel.TextXAlignment = Enum.TextXAlignment.Left
wsLabel.Parent = wsFrame

local wsSub = Instance.new("TextLabel")
wsSub.Size = UDim2.new(1, -20, 0, 16)
wsSub.Position = UDim2.new(0, 10, 0, 26)
wsSub.BackgroundTransparency = 1
wsSub.Text = "Velocidad infinita ajustable"
wsSub.TextColor3 = COLORS.text2
wsSub.TextSize = 11
wsSub.Font = Enum.Font.Gotham
wsSub.TextXAlignment = Enum.TextXAlignment.Left
wsSub.Parent = wsFrame

local wsMinus = Instance.new("TextButton")
wsMinus.Size = UDim2.new(0, 34, 0, 28)
wsMinus.Position = UDim2.new(0.5, -72, 0, 36)
wsMinus.BackgroundColor3 = COLORS.toggleOff
wsMinus.Text = "−"
wsMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
wsMinus.TextSize = 20
wsMinus.Font = Enum.Font.GothamBold
wsMinus.BorderSizePixel = 0
wsMinus.Parent = wsFrame

local wsMinusCorner = Instance.new("UICorner")
wsMinusCorner.CornerRadius = UDim.new(0, 6)
wsMinusCorner.Parent = wsMinus

local wsVal = Instance.new("TextLabel")
wsVal.Size = UDim2.new(0, 60, 0, 28)
wsVal.Position = UDim2.new(0.5, -30, 0, 36)
wsVal.BackgroundTransparency = 1
wsVal.Text = tostring(Config.WalkSpeed)
wsVal.TextColor3 = COLORS.accent2
wsVal.TextSize = 18
wsVal.Font = Enum.Font.GothamBold
wsVal.Parent = wsFrame

local wsPlus = Instance.new("TextButton")
wsPlus.Size = UDim2.new(0, 34, 0, 28)
wsPlus.Position = UDim2.new(0.5, 38, 0, 36)
wsPlus.BackgroundColor3 = COLORS.toggleOff
wsPlus.Text = "+"
wsPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
wsPlus.TextSize = 20
wsPlus.Font = Enum.Font.GothamBold
wsPlus.BorderSizePixel = 0
wsPlus.Parent = wsFrame

local wsPlusCorner = Instance.new("UICorner")
wsPlusCorner.CornerRadius = UDim.new(0, 6)
wsPlusCorner.Parent = wsPlus

wsMinus.MouseButton1Click:Connect(function()
    Config.WalkSpeed = math.max(16, Config.WalkSpeed - 5)
    wsVal.Text = tostring(Config.WalkSpeed)
    wsLabel.Text = "⚡ Walkspeed: " .. Config.WalkSpeed
end)

wsPlus.MouseButton1Click:Connect(function()
    Config.WalkSpeed = math.min(250, Config.WalkSpeed + 5)
    wsVal.Text = tostring(Config.WalkSpeed)
    wsLabel.Text = "⚡ Walkspeed: " .. Config.WalkSpeed
end)

wsMinus.MouseEnter:Connect(function()
    TweenService:Create(wsMinus, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(70, 70, 85)}):Play()
end)
wsMinus.MouseLeave:Connect(function()
    TweenService:Create(wsMinus, TweenInfo.new(0.15), {BackgroundColor3 = COLORS.toggleOff}):Play()
end)
wsPlus.MouseEnter:Connect(function()
    TweenService:Create(wsPlus, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(70, 70, 85)}):Play()
end)
wsPlus.MouseLeave:Connect(function()
    TweenService:Create(wsPlus, TweenInfo.new(0.15), {BackgroundColor3 = COLORS.toggleOff}):Play()
end)

RunService.Heartbeat:Connect(function()
    local char = LP.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = Config.WalkSpeed end
    end
end)

-- ANTI AFK
crearToggle(playerCont, "💤 Anti AFK", Color3.fromRGB(180, 180, 200), function(estado)
    Config.AntiAfk = estado
    if estado then
        LP.Idled:Connect(function()
            if Config.AntiAfk then
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new(0, 0))
            end
        end)
    end
end)

-- ==================== 🔧 SECCIÓN CONFIG ====================
crearLabel(configCont, '<font color="rgb(200,180,100)">━━━ 🔧 CONFIGURACIONES ━━━</font>', Color3.fromRGB(255,255,255), 24)

crearToggle(configCont, "🎮 Anti Lag", Color3.fromRGB(100, 200, 150), function(estado)
    Config.AntiLag = estado
    if estado then
        pcall(function()
            local lighting = game:GetService("Lighting")
            lighting.GlobalShadows = false
            lighting.FogEnd = 50
            settings().Rendering.QualityLevel = 1
        end)
        coros.AntiLag = task.spawn(function()
            while Config.AntiLag do
                task.wait(5)
                pcall(function()
                    for _, v in ipairs(Workspace:GetDescendants()) do
                        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                            v.Enabled = false
                        end
                        if v:IsA("BasePart") and v.Transparency < 0.5 and v.Size.Magnitude > 500 then
                            v.Transparency = 0.9
                        end
                    end
                end)
            end
        end)
    else
        pcall(function()
            local lighting = game:GetService("Lighting")
            lighting.GlobalShadows = true
            settings().Rendering.QualityLevel = 5
        end)
    end
end)

crearToggle(configCont, "📊 Mostrar FPS", Color3.fromRGB(255, 200, 100), function(estado)
    Config.ShowFps = estado
    if estado then
        if fpsLabel then fpsLabel:Destroy() end
        fpsLabel = Instance.new("TextLabel")
        fpsLabel.Size = UDim2.new(0, 80, 0, 24)
        fpsLabel.Position = UDim2.new(0, 10, 0, 200)
        fpsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        fpsLabel.BackgroundTransparency = 0.4
        fpsLabel.TextColor3 = COLORS.success
        fpsLabel.Text = "FPS: 60"
        fpsLabel.TextSize = 14
        fpsLabel.Font = Enum.Font.GothamBold
        fpsLabel.ZIndex = 10
        fpsLabel.Parent = gui

        local fpsCorner = Instance.new("UICorner")
        fpsCorner.CornerRadius = UDim.new(0, 6)
        fpsCorner.Parent = fpsLabel

        local frames = 0
        local lastTime = tick()
        coros.Fps = task.spawn(function()
            while Config.ShowFps do
                frames = frames + 1
                local elapsed = tick() - lastTime
                if elapsed >= 1 then
                    local fps = math.floor(frames / elapsed)
                    if fpsLabel then
                        pcall(function()
                            fpsLabel.Text = "📊 FPS: " .. fps
                            fpsLabel.TextColor3 = fps > 30 and COLORS.success or (fps > 15 and COLORS.accent2 or COLORS.danger)
                        end)
                    end
                    frames = 0
                    lastTime = tick()
                end
                task.wait()
            end
        end)
    else
        if fpsLabel then fpsLabel:Destroy() fpsLabel = nil end
    end
end)

-- ==================== ACTIVAR PRIMERA SECCIÓN ====================
task.wait(0.1)
for _, child in ipairs(container:GetChildren()) do
    if child:IsA("Frame") then
        local btn = child:FindFirstChildOfClass("TextButton")
        if btn then btn:Click() break end
    end
end

-- ==================== ANTI-AFK GLOBAL ====================
LP.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(0, 0))
end)

-- ==================== RE-SPAWN ====================
LP.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    local hum = char:WaitForChild("Humanoid")
    hum.WalkSpeed = Config.WalkSpeed
end)

-- ==================== PRINT ====================
print("╔══════════════════════════════════════════════════════╗")
print("║     JoseAngel_Blox Kick v1.2 CARGADO ✅            ║")
print("║     Creado por: JoseAngel_Blox                     ║")
print("║     ¡Disfruta del script! 🚀                       ║")
print("╚══════════════════════════════════════════════════════╝")
