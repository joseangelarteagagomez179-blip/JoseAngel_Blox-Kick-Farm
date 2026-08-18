-- Buscamos dónde poner la GUI (Delta usa gethui() para ocultarla de los anti-cheats)
local guiParent = (gethui and gethui()) or game:GetService("CoreGui")

-- Si ya existe una versión anterior, la borramos para no duplicarla
if guiParent:FindFirstChild("JoseAngel_Menu") then
    guiParent.JoseAngel_Menu:Destroy()
end

-- Creamos la Interfaz (ScreenGui)
local gui = Instance.new("ScreenGui")
gui.Name = "JoseAngel_Menu"
gui.Parent = guiParent

-- Creamos el cuadrado principal (Frame)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 220) -- Cuadrado pequeño
mainFrame.Position = UDim2.new(0.5, -110, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- Gris oscuro/Negro
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- Hace que lo puedas mover por la pantalla
mainFrame.Parent = gui

-- Redondeamos las esquinas del cuadrado principal
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 15)
uiCorner.Parent = mainFrame

-- Título actualizado: JoseAngel_Blox x2
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 15)
title.BackgroundTransparency = 1
title.Text = "JoseAngel_Blox x2" -- Nombre corregido aquí
title.Font = Enum.Font.GothamBold
title.TextSize = 20 -- Reduje un poquito la letra para que encaje perfecto el "x2"
title.TextColor3 = Color3.fromRGB(255, 215, 0) -- Dorado
title.Parent = mainFrame

-- Efecto de brillo para las letras doradas usando UIStroke
local glow = Instance.new("UIStroke")
glow.Color = Color3.fromRGB(255, 255, 100) -- Amarillo brillante
glow.Transparency = 0.5
glow.Thickness = 1.5
glow.Parent = title

-- Botón (Interruptor / Toggle)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 160, 0, 45)
toggleBtn.Position = UDim2.new(0.5, -80, 0.5, -10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40) -- Rojo (Apagado)
toggleBtn.Text = "Multiplicador x2: OFF"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 14
toggleBtn.Parent = mainFrame

-- Redondeamos el botón
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = toggleBtn

-- Lógica del Interruptor
local isToggled = false

toggleBtn.MouseButton1Click:Connect(function()
    isToggled = not isToggled -- Cambiamos el estado
    
    if isToggled then
        -- Encendido
        toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 40) -- Verde
        toggleBtn.Text = "Multiplicador x2: ON"
        
        -- Iniciamos el bucle del script
        task.spawn(function()
            while isToggled do
                pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network"):WaitForChild("rev_TaviMishkal"):FireServer()
                end)
                -- Pausa de 0.2 segundos para no crashear
                task.wait(0.2) 
            end
        end)
    else
        -- Apagado
        toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40) -- Rojo
        toggleBtn.Text = "Multiplicador x2: OFF"
    end
end)
