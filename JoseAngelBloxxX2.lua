local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- Obtener el RemoteEvent capturado por SimpleSpy
local RemoteEvent = ReplicatedStorage:WaitForChild("Shared")
    :WaitForChild("Packages")
    :WaitForChild("Network")
    :WaitForChild("rev_TaviMishkal")

-- Crear la interfaz base
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngelBloxx_x2_UI"
ScreenGui.ResetOnSpawn = false

-- Asignar al CoreGui para Delta Executor
local success, err = pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not success then
    ScreenGui.Parent = player:WaitForChild("PlayerGui")
end

-- ==========================================
-- BURBUJA FLOTANTE (Para ocultar/mostrar)
-- ==========================================
local Bubble = Instance.new("TextButton")
local BubbleCorner = Instance.new("UICorner")
local BubbleGlow = Instance.new("UIStroke")

Bubble.Name = "OpenCloseBubble"
Bubble.Parent = ScreenGui
Bubble.BackgroundColor3 = Color3.fromRGB(0, 0, 128)
Bubble.Position = UDim2.new(0, 20, 0, 20)
Bubble.Size = UDim2.new(0, 50, 0, 50)
Bubble.Font = Enum.Font.GothamBold
Bubble.Text = "O/C"
Bubble.TextColor3 = Color3.fromRGB(255, 215, 0)
Bubble.TextSize = 18
Bubble.Active = true
Bubble.Draggable = true

BubbleCorner.CornerRadius = UDim.new(1, 0)
BubbleCorner.Parent = Bubble

BubbleGlow.Parent = Bubble
BubbleGlow.Color = Color3.fromRGB(255, 223, 0)
BubbleGlow.Thickness = 2

-- ==========================================
-- MENÚ PRINCIPAL (Cuadrado azul marino)
-- ==========================================
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")

MainFrame.Name = "Main"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 128)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -150)
MainFrame.Size = UDim2.new(0, 250, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- Título ("JoseAngelBloxx x2")
local Title = Instance.new("TextLabel")
local TitleGlow = Instance.new("UIStroke")

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 15)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "JoseAngelBloxx x2"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 22

TitleGlow.Parent = Title
TitleGlow.Color = Color3.fromRGB(255, 223, 0)
TitleGlow.Thickness = 2.5
TitleGlow.Transparency = 0.4

-- Botón Multiplicar x2
local MultiplyButton = Instance.new("TextButton")
local ButtonCorner = Instance.new("UICorner")

MultiplyButton.Name = "MultiplyButton"
MultiplyButton.Parent = MainFrame
MultiplyButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MultiplyButton.Position = UDim2.new(0.1, 0, 0.28, 0)
MultiplyButton.Size = UDim2.new(0.8, 0, 0, 45)
MultiplyButton.Font = Enum.Font.GothamBold
MultiplyButton.Text = "Multiplicar x2"
MultiplyButton.TextColor3 = Color3.fromRGB(0, 0, 0)
MultiplyButton.TextSize = 18

ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = MultiplyButton

-- ==========================================
-- PERFIL DEL JUGADOR
-- ==========================================
local ProfileImage = Instance.new("ImageLabel")
local ProfileCorner = Instance.new("UICorner")
local UsernameLabel = Instance.new("TextLabel")

ProfileImage.Name = "ProfileImage"
ProfileImage.Parent = MainFrame
ProfileImage.BackgroundTransparency = 1
ProfileImage.Position = UDim2.new(0.5, -35, 0.55, 0)
ProfileImage.Size = UDim2.new(0, 70, 0, 70)
ProfileCorner.CornerRadius = UDim.new(1, 0)
ProfileCorner.Parent = ProfileImage

local userId = player.UserId
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size420x420
local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
if isReady then
    ProfileImage.Image = content
end

UsernameLabel.Name = "Username"
UsernameLabel.Parent = MainFrame
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.Position = UDim2.new(0, 0, 0.82, 0)
UsernameLabel.Size = UDim2.new(1, 0, 0, 30)
UsernameLabel.Font = Enum.Font.GothamSemibold
UsernameLabel.Text = "@" .. player.Name
UsernameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
UsernameLabel.TextSize = 16

-- ==========================================
-- FUNCIONALIDAD
-- ==========================================

-- Abrir / Cerrar con la burbuja
Bubble.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Evento de multiplicación automática al presionar el botón
local autoMulti = false

MultiplyButton.MouseButton1Click:Connect(function()
    autoMulti = not autoMulti
    
    if autoMulti then
        MultiplyButton.Text = "Activado [ON]"
        MultiplyButton.TextColor3 = Color3.fromRGB(0, 180, 0)
        
        task.spawn(function()
            while autoMulti do
                task.wait(0.1) -- Intervalo de envío en segundos
                pcall(function()
                    RemoteEvent:FireServer()
                end)
            end
        end)
    else
        MultiplyButton.Text = "Multiplicar x2"
        MultiplyButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    end
end)
