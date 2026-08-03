-- ==========================================
-- Script: JoseAngel_Blox premium no key
-- Versión: 3.2 Delta Lite (Con Auto Train)
-- ==========================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- 1. CACHÉ DE REMOTOS
-- ==========================================
local Network = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network")
local KickEvent = Network:WaitForChild("rev_KickEvent")
local MultiplierEvent = Network:WaitForChild("rev_TaviMishkal")
local kickArgs = {1, 1}

-- Variables globales
getgenv().AutoKick = false
getgenv().AutoFarm = false
getgenv().VelocidadFarm = 500
getgenv().MultiplierX2 = false
getgenv().AutoClickX2 = false
getgenv().IntervaloX2 = 1
getgenv().AutoCollectCash = false
getgenv().AutoTrain = false -- NUEVO: Variable para Auto Train

-- ==========================================
-- 2. AUTO CLICK X2 (VERSIÓN ULTRA COMPATIBLE)
-- ==========================================
local function reclamarBotonesX2Delta()
    pcall(function()
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
        if not playerGui then return end
        
        local kickUpgrades = playerGui:FindFirstChild("KickUpgrades")
        if not kickUpgrades then return end
        
        for _, bonus in pairs(kickUpgrades:GetChildren()) do
            if (bonus.Name == "Bonus" or bonus.Name == "PopBonus") and bonus.Visible then
                if bonus:GetAttribute("AutoClicked") then return end
                bonus:SetAttribute("AutoClicked", true)
                
                task.spawn(function()
                    task.wait(0.1)
                    pcall(function()
                        local detector = bonus:FindFirstChild("ClickDetector")
                        if detector then fireclickdetector(detector) end
                    end)
                    pcall(function()
                        if bonus.MouseButton1Click then bonus.MouseButton1Click:Fire() end
                    end)
                    pcall(function()
                        if bonus.Activated then bonus.Activated:Fire() end
                    end)
                    pcall(function()
                        if bonus.InputBegan then
                            bonus.InputBegan:Fire({UserInputType = Enum.UserInputType.MouseButton1, UserInputState = Enum.UserInputState.Begin})
                            task.wait(0.05)
                            if bonus.InputEnded then
                                bonus.InputEnded:Fire({UserInputType = Enum.UserInputType.MouseButton1, UserInputState = Enum.UserInputState.End})
                            end
                        end
                    end)
                    task.wait(0.3)
                    pcall(function() bonus:SetAttribute("AutoClicked", nil) end)
                end)
            else
                pcall(function()
                    if bonus:GetAttribute("AutoClicked") then bonus:SetAttribute("AutoClicked", nil) end
                end)
            end
        end
    end)
end

-- ==========================================
-- 3. AUTO COLLECT CASH
-- ==========================================
local lockedPlot = nil

local function ForcedTP(targetCFrame)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.Velocity = Vector3.new(0, 0, 0)
        hrp.CFrame = targetCFrame
    end
end

local function collectCash()
    if not lockedPlot then
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local closestDist = math.huge
            local plots = Workspace:FindFirstChild("Plots")
            if plots then
                for _, plot in pairs(plots:GetChildren()) do
                    if (plot:IsA("Model") or plot:IsA("Folder")) then
                        local dist = (hrp.Position - plot:GetPivot().Position).Magnitude
                        if dist < closestDist then
                            closestDist = dist
                            lockedPlot = plot
                        end
                    end
                end
            end
        end
    end

    if lockedPlot then
        local buttonsFolder = lockedPlot:FindFirstChild("Buttons")
        if buttonsFolder then
            for i = 1, 30 do
                if not getgenv().AutoCollectCash then break end
                local slotPart = buttonsFolder:FindFirstChild("Slot" .. i)
                if slotPart then
                    local targetCFrame
                    if slotPart:IsA("BasePart") then
                        targetCFrame = slotPart.CFrame
                    elseif (slotPart:IsA("Model") and slotPart.PrimaryPart) then
                        targetCFrame = slotPart.PrimaryPart.CFrame
                    elseif slotPart:FindFirstChildWhichIsA("BasePart") then
                        targetCFrame = slotPart:FindFirstChildWhichIsA("BasePart").CFrame
                    end
                    
                    if targetCFrame then
                        pcall(function()
                            ForcedTP(targetCFrame + Vector3.new(0, 1.5, 0))
                            task.wait(0.1)
                            -- Nota: Asegúrate de que "rev_B_Collect" sea el nombre correcto del remoto en el juego
                            if Network:FindFirstChild("rev_B_Collect") then
                                Network.rev_B_Collect:FireServer(i)
                            end
                        end)
                    end
                end
            end
        end
    end
end

-- ==========================================
-- 4. CREACIÓN DE LA GUI
-- ==========================================
if CoreGui:FindFirstChild("JoseAngel_Blox_GUI") then
    CoreGui.JoseAngel_Blox_GUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_GUI"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 430, 0, 320)
MainFrame.Position = UDim2.new(0.5, -215, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = "rbxthumb://type=Asset&id=130801971957660&w=720&h=720"
BackgroundImage.ScaleType = Enum.ScaleType.Crop
BackgroundImage.ZIndex = 1
BackgroundImage.Parent = MainFrame
Instance.new("UICorner", BackgroundImage).CornerRadius = UDim.new(0, 14)

local DarkOverlay = Instance.new("Frame")
DarkOverlay.Size = UDim2.new(1, 0, 1, 0)
DarkOverlay.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
DarkOverlay.BackgroundTransparency = 0.45
DarkOverlay.ZIndex = 2
DarkOverlay.Parent = MainFrame
Instance.new("UICorner", DarkOverlay).CornerRadius = UDim.new(0, 14)

local HeaderFrame = Instance.new("Frame")
HeaderFrame.Size = UDim2.new(1, 0, 0, 50)
HeaderFrame.BackgroundTransparency = 1
HeaderFrame.ZIndex = 3
HeaderFrame.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 28)
TitleLabel.Position = UDim2.new(0, 0, 0, 4)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "JoseAngel_Blox premium no key"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 18
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.ZIndex = 3
TitleLabel.Parent = HeaderFrame

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Parent = TitleLabel

task.spawn(function()
    local offsetHue = 0
    while task.wait() do
        offsetHue = (offsetHue + 0.006) % 1
        local keypoints = {}
        for i = 0, 10 do
            local time = i / 10
            local hue = (time + offsetHue) % 1
            table.insert(keypoints, ColorSequenceKeypoint.new(time, Color3.fromHSV(hue, 0.85, 1)))
        end
        TitleGradient.Color = ColorSequence.new(keypoints)
    end
end)

local SubTitleLabel = Instance.new("TextLabel")
SubTitleLabel.Size = UDim2.new(1, 0, 0, 18)
SubTitleLabel.Position = UDim2.new(0, 0, 0, 28)
SubTitleLabel.BackgroundTransparency = 1
SubTitleLabel.Text = "Creado por JoseAngel_Blox"
SubTitleLabel.TextColor3 = Color3.fromRGB(190, 190, 200)
SubTitleLabel.Font = Enum.Font.Gotham
SubTitleLabel.TextSize = 12
SubTitleLabel.ZIndex = 3
SubTitleLabel.Parent = HeaderFrame

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 110, 1, -60)
TabContainer.Position = UDim2.new(0, 10, 0, 55)
TabContainer.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
TabContainer.BackgroundTransparency = 0.25
TabContainer.ZIndex = 3
TabContainer.Parent = MainFrame
Instance.new("UICorner", TabContainer).CornerRadius = UDim.new(0, 10)

local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -140, 1, -60)
ContentContainer.Position = UDim2.new(0, 130, 0, 55)
ContentContainer.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
ContentContainer.BackgroundTransparency = 0.25
ContentContainer.ZIndex = 3
ContentContainer.Parent = MainFrame
Instance.new("UICorner", ContentContainer).CornerRadius = UDim.new(0, 10)

local InfoPage = Instance.new("ScrollingFrame")
InfoPage.Size = UDim2.new(1, -16, 1, -16)
InfoPage.Position = UDim2.new(0, 8, 0, 8)
InfoPage.BackgroundTransparency = 1
InfoPage.Visible = true
InfoPage.ScrollBarThickness = 3
InfoPage.ZIndex = 4
InfoPage.Parent = ContentContainer

local MainPage = Instance.new("ScrollingFrame")
MainPage.Size = UDim2.new(1, -16, 1, -16)
MainPage.Position = UDim2.new(0, 8, 0, 8)
MainPage.BackgroundTransparency = 1
MainPage.Visible = false
MainPage.ScrollBarThickness = 3
MainPage.CanvasSize = UDim2.new(0, 0, 0, 400) -- Aumentado para que quepa el nuevo botón
MainPage.ZIndex = 4
MainPage.Parent = ContentContainer

local function switchTab(tab)
    InfoPage.Visible = (tab == "Info")
    MainPage.Visible = (tab == "Main")
end

local InfoBtn = Instance.new("TextButton")
InfoBtn.Size = UDim2.new(1, -16, 0, 35)
InfoBtn.Position = UDim2.new(0, 8, 0, 10)
InfoBtn.BackgroundColor3 = Color3.fromRGB(48, 48, 62)
InfoBtn.Text = "Info"
InfoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoBtn.Font = Enum.Font.GothamBold
InfoBtn.TextSize = 14
InfoBtn.ZIndex = 4
InfoBtn.Parent = TabContainer
Instance.new("UICorner", InfoBtn).CornerRadius = UDim.new(0, 8)
InfoBtn.MouseButton1Click:Connect(function() switchTab("Info") end)

local MainBtn = Instance.new("TextButton")
MainBtn.Size = UDim2.new(1, -16, 0, 35)
MainBtn.Position = UDim2.new(0, 8, 0, 55)
MainBtn.BackgroundColor3 = Color3.fromRGB(48, 48, 62)
MainBtn.Text = "Main"
MainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MainBtn.Font = Enum.Font.GothamBold
MainBtn.TextSize = 14
MainBtn.ZIndex = 4
MainBtn.Parent = TabContainer
Instance.new("UICorner", MainBtn).CornerRadius = UDim.new(0, 8)
MainBtn.MouseButton1Click:Connect(function() switchTab("Main") end)

local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(1, 0, 1, 0)
InfoText.BackgroundTransparency = 1
InfoText.TextXAlignment = Enum.TextXAlignment.Left
InfoText.TextYAlignment = Enum.TextYAlignment.Top
InfoText.TextColor3 = Color3.fromRGB(230, 230, 240)
InfoText.Font = Enum.Font.Gotham
InfoText.TextSize = 12
InfoText.TextWrapped = true
InfoText.ZIndex = 4
InfoText.Text = "Nombre del Creador: JoseAngel_Blox\n\n" ..
                "Fecha de lanzamiento: 02/08/2026\n\n" ..
                "Versión: 3.2 Delta Lite\n\n" ..
                "Características:\n" ..
                "✅ Auto Kick\n" ..
                "✅ Auto Farm (Safe Zone)\n" ..
                "✅ Multiplier x2\n" ..
                "✅ Auto Click x2 (Bonuses)\n" ..
                "✅ Auto Collect Cash\n" ..
                "✅ Auto Train & x2 (NUEVO)\n\n" ..
                "Ejecutor: Delta Executor"
InfoText.Parent = InfoPage

-- ==========================================
-- 5. GENERADOR DE TOGGLES
-- ==========================================
local function createToggle(name, posY, callback)
    local container = Instance.new("TextButton")
    container.Size = UDim2.new(1, 0, 0, 38)
    container.Position = UDim2.new(0, 0, 0, posY)
    container.BackgroundColor3 = Color3.fromRGB(42, 42, 54)
    container.BackgroundTransparency = 0.15
    container.Text = ""
    container.AutoButtonColor = false
    container.ZIndex = 4
    container.Parent = MainPage
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 8)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -65, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(230, 230, 230)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 5
    label.Parent = container
    
    local switchBG = Instance.new("Frame")
    switchBG.Size = UDim2.new(0, 46, 0, 24)
    switchBG.Position = UDim2.new(1, -56, 0.5, -12)
    switchBG.BackgroundColor3 = Color3.fromRGB(190, 45, 45)
    switchBG.ZIndex = 5
    switchBG.Parent = container
    Instance.new("UICorner", switchBG).CornerRadius = UDim.new(1, 0)
    
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new(0, 3, 0.5, -9)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.ZIndex = 6
    knob.Parent = switchBG
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    
    local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local state = false
    
    container.MouseButton1Click:Connect(function()
        state = not state
        if state then
            TweenService:Create(switchBG, tweenInfo, {BackgroundColor3 = Color3.fromRGB(45, 200, 75)}):Play()
            TweenService:Create(knob, tweenInfo, {Position = UDim2.new(1, -21, 0.5, -9)}):Play()
            label.TextColor3 = Color3.fromRGB(100, 255, 120)
        else
            TweenService:Create(switchBG, tweenInfo, {BackgroundColor3 = Color3.fromRGB(190, 45, 45)}):Play()
            TweenService:Create(knob, tweenInfo, {Position = UDim2.new(0, 3, 0.5, -9)}):Play()
            label.TextColor3 = Color3.fromRGB(230, 230, 230)
        end
        callback(state)
    end)
    return container
end

-- ==========================================
-- 6. TOGGLES Y SELECTORES
-- ==========================================

createToggle("Auto Kick", 0, function(state)
    getgenv().AutoKick = state
    if state then
        task.spawn(function()
            while getgenv().AutoKick do
                pcall(function() KickEvent:FireServer(unpack(kickArgs)) end)
                task.wait(0.05)
            end
        end)
    end
end)

createToggle("Auto Farm (Safe Zone)", 44, function(state)
    getgenv().AutoFarm = state
    if state then
        task.spawn(function()
            while getgenv().AutoFarm do
                pcall(function()
                    KickEvent:FireServer(unpack(kickArgs))
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("Humanoid") then
                        char.Humanoid.WalkSpeed = getgenv().VelocidadFarm
                        local areas = Workspace:FindFirstChild("Areas")
                        if areas and areas:FindFirstChild("KickReady") then
                            local safeZone = areas.KickReady
                            if safeZone:IsA("BasePart") then
                                char.Humanoid:MoveTo(safeZone.Position)
                            elseif safeZone:IsA("Model") and safeZone.PrimaryPart then
                                char.Humanoid:MoveTo(safeZone.PrimaryPart.Position)
                            else
                                local parte = safeZone:FindFirstChildWhichIsA("BasePart", true)
                                if parte then char.Humanoid:MoveTo(parte.Position) end
                            end
                        end
                    end
                end)
                task.wait(0.05)
            end
        end)
    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

createToggle("Multiplier x2", 88, function(state)
    getgenv().MultiplierX2 = state
    if state then
        task.spawn(function()
            while getgenv().MultiplierX2 do
                pcall(function() MultiplierEvent:FireServer() end)
                task.wait(2)
            end
        end)
    end
end)

createToggle("Auto Click x2 (Bonuses)", 132, function(state)
    getgenv().AutoClickX2 = state
    if state then
        task.spawn(function()
            while getgenv().AutoClickX2 do
                reclamarBotonesX2Delta()
                task.wait(math.min(getgenv().IntervaloX2, 0.5))
            end
        end)
    end
end)

createToggle("Auto Collect Cash 💰", 176, function(state)
    getgenv().AutoCollectCash = state
    if state then
        task.spawn(function()
            while getgenv().AutoCollectCash do
                pcall(collectCash)
                task.wait(1.5)
            end
        end)
    else
        lockedPlot = nil
    end
end)

-- ==========================================
-- 7. AUTO TRAIN (INTEGRADO A TU UI)
-- ==========================================
local validWeights = {
    ["Wooden Stick"] = true, ["Copper Plate"] = true, ["Stone Block"] = true,
    ["Bone Barbell"] = true, ["Donut Barbell"] = true, ["Ice Barbell"] = true,
    ["Iron Plate"] = true, ["Heaven Plate"] = true, ["Gold Barbell"] = true,
    ["Golden Barbell"] = true, ["Giant Gold Star Barbell"] = true, ["Neon Pulse"] = true,
    ["Mega Gold Barbell"] = true, ["Mega Golden Barbell"] = true, ["Emerald Barbell"] = true,
    ["Planet Barbell"] = true
}

createToggle("Auto Train & x2 🏋️", 220, function(state)
    getgenv().AutoTrain = state
    if state then
        task.spawn(function()
            while getgenv().AutoTrain do
                pcall(function()
                    local char = LocalPlayer.Character
                    local hum = char and char:FindFirstChild("Humanoid")
                    local backpack = LocalPlayer:FindFirstChild("Backpack")
                    local currentTool = char and char:FindFirstChildOfClass("Tool")
                    
                    local isHoldingValidWeight = currentTool and validWeights[currentTool.Name]
                    
                    if not isHoldingValidWeight then
                        if currentTool then hum:UnequipTools() end
                        task.wait(0.1)
                        if backpack and hum then
                            for _, tool in pairs(backpack:GetChildren()) do
                                if tool:IsA("Tool") and validWeights[tool.Name] then
                                    hum:EquipTool(tool)
                                    break
                                end
                            end
                        end
                    else
                        if currentTool then
                            currentTool:Activate()
                        end
                    end
                end)
                task.wait(0.15)
            end
        end)
    end
end)

-- ==========================================
-- 8. SELECTORES (POSICIONES AJUSTADAS)
-- ==========================================
local opcionesVelocidad = {
    {"Velocidad Farm: 
