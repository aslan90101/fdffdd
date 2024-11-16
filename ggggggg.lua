local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Создание основного GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CustomGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.1, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0.5
frame.Parent = screenGui

-- Закругление углов
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = frame

-- Функция для создания чекбокса
local function createCheckbox(labelText, position, toggleFunction)
    local checkboxFrame = Instance.new("Frame")
    checkboxFrame.Size = UDim2.new(0, 250, 0, 50)
    checkboxFrame.Position = position
    checkboxFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    checkboxFrame.BorderSizePixel = 0
    checkboxFrame.Parent = frame

    local checkboxLabel = Instance.new("TextLabel")
    checkboxLabel.Size = UDim2.new(0.8, 0, 1, 0)
    checkboxLabel.BackgroundTransparency = 1
    checkboxLabel.Text = labelText
    checkboxLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    checkboxLabel.Parent = checkboxFrame

    local checkboxButton = Instance.new("TextButton")
    checkboxButton.Size = UDim2.new(0, 30, 0, 30)
    checkboxButton.Position = UDim2.new(0.8, 0, 0, 0)
    checkboxButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Красный цвет по умолчанию
    checkboxButton.Parent = checkboxFrame

    local isChecked = false

    checkboxButton.MouseButton1Click:Connect(function()
        isChecked = not isChecked
        toggleFunction(isChecked)
        checkboxButton.BackgroundColor3 = isChecked and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0) -- Зеленый если включен, красный если выключен
    end)
end

-- Функции для переключателей
local function toggleInfiniteJump(enabled)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    if enabled then
        humanoid.Jumping:Connect(function()
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end)
    end
end

local function toggleTeleport(enabled)
    if enabled then
        local teleportPosition = Vector3.new(0, 50, 0) -- Задайте позицию телепорта
        player.Character.HumanoidRootPart.CFrame = CFrame.new(teleportPosition)
    end
end

local function toggleHighJump(enabled)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    if enabled then
        humanoid.JumpPower = 100 -- Увеличьте JumpPower для высокого прыжка
    else
        humanoid.JumpPower = 23 -- Верните к стандартному значению
    end
end

-- Создание чекбоксов
createCheckbox("хуйня не рабочая", UDim2.new(0, 25, 0, 25), toggleInfiniteJump)
createCheckbox("Телепорт на спавн", UDim2.new(0, 25, 0, 80), toggleTeleport)
createCheckbox("Высокий прыжок", UDim2.new(0, 25, 0, 135), toggleHighJump)

