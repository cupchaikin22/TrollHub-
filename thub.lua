local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Создаём экранное меню
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 400, 0, 350)
menuFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
menuFrame.Parent = screenGui
menuFrame.BackgroundTransparency = 0.2
menuFrame.Visible = true

-- Добавляем анимацию для меню (открытие и закрытие)
local function toggleMenu()
    menuFrame.Visible = not menuFrame.Visible
end

local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, 0, 1, 0)
tabFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
tabFrame.Visible = true
tabFrame.Parent = menuFrame

local creditLabel = Instance.new("TextLabel")
creditLabel.Text = "by C0MEREW5"
creditLabel.Size = UDim2.new(1, 0, 0, 20)
creditLabel.Position = UDim2.new(0, 0, 1, -20)
creditLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
creditLabel.TextScaled = true
creditLabel.TextSize = 14
creditLabel.BackgroundTransparency = 1
creditLabel.Parent = menuFrame

-- Переключатели вкладок
local tabButtons = {}
local tab1Button = Instance.new("TextButton")
tab1Button.Text = "Speed/Jump"
tab1Button.Size = UDim2.new(0, 200, 0, 50)
tab1Button.Position = UDim2.new(0, 0, 0, 0)
tab1Button.TextColor3 = Color3.fromRGB(255, 255, 255)
tab1Button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
tab1Button.Parent = menuFrame
tabButtons["tab1"] = tab1Button

local tab2Button = Instance.new("TextButton")
tab2Button.Text = "Teleport"
tab2Button.Size = UDim2.new(0, 200, 0, 50)
tab2Button.Position = UDim2.new(0, 0, 0, 50)
tab2Button.TextColor3 = Color3.fromRGB(255, 255, 255)
tab2Button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
tab2Button.Parent = menuFrame
tabButtons["tab2"] = tab2Button

local function switchTab(tabName)
    for _, button in pairs(tabButtons) do
        button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    end
    tabButtons[tabName].BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    
    if tabName == "tab1" then
        tabFrame:ClearAllChildren()
        -- === Вкладка 1: Speed и Jump ===
        
        -- Текст для ползунка скорости
        local speedLabel = Instance.new("TextLabel")
        speedLabel.Text = "Speed"
        speedLabel.Size = UDim2.new(0, 200, 0, 20)
        speedLabel.Position = UDim2.new(0, 100, 0, 40)
        speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        speedLabel.TextScaled = true
        speedLabel.BackgroundTransparency = 1
        speedLabel.Parent = tabFrame

        -- ===== Ползунок скорости =====
        local speedSlider = Instance.new("Frame")
        speedSlider.Size = UDim2.new(0, 250, 0, 20)
        speedSlider.Position = UDim2.new(0, 75, 0, 70)
        speedSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        speedSlider.Parent = tabFrame

        local speedFill = Instance.new("Frame")
        speedFill.Size = UDim2.new(0, 100, 1, 0) -- Начальная скорость
        speedFill.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        speedFill.Parent = speedSlider

        local speedButton = Instance.new("ImageButton")
        speedButton.Size = UDim2.new(0, 20, 1, 0)
        speedButton.Position = UDim2.new(0, 100, 0, 0) -- Начальная позиция
        speedButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        speedButton.Image = "rbxassetid://3926307971" -- Иконка для кнопки ползунка
        speedButton.ImageRectOffset = Vector2.new(324, 4)
        speedButton.ImageRectSize = Vector2.new(36, 36)
        speedButton.Parent = speedSlider

        -- Обработка перемещения ползунка для скорости
        local dragging = false
        speedButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
            end
        end)

        speedButton.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local newX = math.clamp(input.Position.X - speedSlider.AbsolutePosition.X, 0, speedSlider.AbsoluteSize.X)
                speedButton.Position = UDim2.new(0, newX, 0, 0)
                speedFill.Size = UDim2.new(0, newX, 1, 0)

                -- Изменяем скорость
                humanoid.WalkSpeed = math.floor(newX / speedSlider.AbsoluteSize.X * 100) + 10
                -- Сохраняем скорость
                player:SetAttribute("SavedSpeed", humanoid.WalkSpeed)
            end
        end)

        -- Текст для ползунка прыжка
        local jumpLabel = Instance.new("TextLabel")
        jumpLabel.Text = "JumpPower"
        jumpLabel.Size = UDim2.new(0, 200, 0, 20)
        jumpLabel.Position = UDim2.new(0, 100, 0, 120)
        jumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        jumpLabel.TextScaled = true
        jumpLabel.BackgroundTransparency = 1
        jumpLabel.Parent = tabFrame

        -- ===== Ползунок прыжка =====
        local jumpSlider = Instance.new("Frame")
        jumpSlider.Size = UDim2.new(0, 250, 0, 20)
        jumpSlider.Position = UDim2.new(0, 75, 0, 150)
        jumpSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        jumpSlider.Parent = tabFrame

        local jumpFill = Instance.new("Frame")
        jumpFill.Size = UDim2.new(0, 50, 1, 0) -- Начальная сила прыжка
        jumpFill.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        jumpFill.Parent = jumpSlider

        local jumpButton = Instance.new("ImageButton")
        jumpButton.Size = UDim2.new(0, 20, 1, 0)
        jumpButton.Position = UDim2.new(0, 50, 0, 0) -- Начальная позиция
        jumpButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        jumpButton.Image = "rbxassetid://3926307971" -- Иконка для кнопки ползунка
        jumpButton.ImageRectOffset = Vector2.new(324, 4)
        jumpButton.ImageRectSize = Vector2.new(36, 36)
        jumpButton.Parent = jumpSlider

        -- Обработка перемещения ползунка для прыжка
        local jumpDragging = false
        jumpButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                jumpDragging = true
            end
        end)

        jumpButton.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                jumpDragging = false
            end
        end)

        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if jumpDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local newX = math.clamp(input.Position.X - jumpSlider.AbsolutePosition.X, 0, jumpSlider.AbsoluteSize.X)
                jumpButton.Position = UDim2.new(0, newX, 0, 0)
                jumpFill.Size = UDim2.new(0, newX, 1, 0)

                -- Изменяем силу прыжка
                humanoid.JumpPower = math.floor(newX / jumpSlider.AbsoluteSize.X * 50) + 10
                -- Сохраняем силу прыжка
                player:SetAttribute("SavedJump", humanoid.JumpPower)
            end
        end)

    elseif tabName == "tab2" then
        tabFrame:ClearAllChildren()
        -- === Вкладка 2: Телепортация ===
        
        local playersList = game.Players:GetPlayers()
        for i, p in ipairs(playersList) do
            if p ~= player then
                local playerButton = Instance.new("TextButton")
                playerButton.Size = UDim2.new(0, 200, 0, 50)
                playerButton.Position = UDim2.new(0, 100, 0, 50 * i)
                playerButton.Text = "Телепортироваться к " .. p.Name
                playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                playerButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                playerButton.Parent = tabFrame

                playerButton.MouseButton1Click:Connect(function()
                    character:SetPrimaryPartCFrame(p.Character.HumanoidRootPart.CFrame)
                end)
            end
        end
    end
end

-- По умолчанию переключаем на первую вкладку
switchTab("tab1")

-- Привязываем клавишу для открытия/закрытия меню
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.M then
        toggleMenu()
    end
end)

-- Мобильная оптимизация для кнопки
local mobileButton = Instance.new("TextButton")
mobileButton.Text = "Меню"
mobileButton.Size = UDim2.new(0, 100, 0, 50)
mobileButton.Position = UDim2.new(0, 10, 0, 10)
mobileButton.TextColor3 = Color3.fromRGB(255, 255, 255)
mobileButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
mobileButton.Parent = screenGui

mobileButton.MouseButton1Click:Connect(function()
    toggleMenu()
end)