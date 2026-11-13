-- Figgy Hub | Modern Purple Glassmorphism Key System
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

-- Cấu hình Key & Link
local CORRECT_KEY = "FiggyHubKeyJdkehKalowwjLalwhjwiwBskwowi"
local SCRIPT_URL = "https://raw.githubusercontent.com/Figgyscript/Figgy/main/Figgyhub"
local GET_KEY_LINK = "https://link4m.org/L2r6zQ2"
local SAVE_FILE_NAME = "FiggyHub_AuthCache.json"
local CACHE_DURATION = 86400 -- Lưu ẩn 24 giờ (tính bằng giây)

-- Kiểm tra file lưu key ẩn
local function isKeyValid()
    local ok, raw = pcall(function()
        if isfile and isfile(SAVE_FILE_NAME) then
            return readfile(SAVE_FILE_NAME)
        elseif readfile then
            return readfile(SAVE_FILE_NAME)
        end
        return nil
    end)

    if ok and raw and raw ~= "" then
        local decodedOk, data = pcall(function()
            return HttpService:JSONDecode(raw)
        end)
        if decodedOk and type(data) == "table" and data.key == CORRECT_KEY and type(data.time) == "number" then
            if (os.time() - data.time) < CACHE_DURATION then
                return true
            end
        end
    end
    return false
end

local function saveKey()
    pcall(function()
        if writefile then
            local data = {
                key = CORRECT_KEY,
                time = os.time()
            }
            writefile(SAVE_FILE_NAME, HttpService:JSONEncode(data))
        end
    end)
end

local function loadMainScript()
    local success, err = pcall(function()
        loadstring(game:HttpGet(SCRIPT_URL))()
    end)
    if not success then
        warn("[Figgy Hub] Error loading script: " .. tostring(err))
    end
end

-- Nếu đã lưu key hợp lệ thì tự động vào thẳng script chính
if isKeyValid() then
    loadMainScript()
    return
end

-- Xóa GUI cũ nếu tồn tại
if CoreGui:FindFirstChild("FiggyHubModernUI") then
    CoreGui.FiggyHubModernUI:Destroy()
end

-- Khởi tạo ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FiggyHubModernUI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Khung chính (Purple Glassmorphism)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 385, 0, 255)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 12, 38)
MainFrame.BackgroundTransparency = 0.18
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

-- Gradient nền tím sâu
local BgGradient = Instance.new("UIGradient")
BgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(48, 20, 88)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(22, 10, 42)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 7, 26))
})
BgGradient.Rotation = 135
BgGradient.Parent = MainFrame

-- Viền sáng Neon tím chuyển sắc
local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.8
MainStroke.Color = Color3.fromRGB(255, 255, 255)
MainStroke.Transparency = 0.25
MainStroke.Parent = MainFrame

local StrokeGradient = Instance.new("UIGradient")
StrokeGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(195, 95, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 40, 220)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 130, 255))
})
StrokeGradient.Rotation = 45
StrokeGradient.Parent = MainStroke

-- Tiêu đề Figgy Hub
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 0, 0, 18)
TitleLabel.Size = UDim2.new(1, 0, 0, 34)
TitleLabel.Font = Enum.Font.FredokaOne
TitleLabel.Text = "Figgy Hub"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 28
TitleLabel.TextXAlignment = Enum.TextXAlignment.Center

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(245, 220, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(185, 110, 255))
})
TitleGradient.Rotation = 90
TitleGradient.Parent = TitleLabel

local SubTitle = Instance.new("TextLabel")
SubTitle.Parent = MainFrame
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0, 0, 0, 52)
SubTitle.Size = UDim2.new(1, 0, 0, 16)
SubTitle.Font = Enum.Font.GothamMedium
SubTitle.Text = "AUTHENTICATION REQUIRED"
SubTitle.TextColor3 = Color3.fromRGB(180, 145, 225)
SubTitle.TextSize = 11
SubTitle.TextXAlignment = Enum.TextXAlignment.Center

-- Khung chứa ô nhập Key
local InputContainer = Instance.new("Frame")
InputContainer.Parent = MainFrame
InputContainer.BackgroundColor3 = Color3.fromRGB(14, 7, 26)
InputContainer.BackgroundTransparency = 0.35
InputContainer.Position = UDim2.new(0.08, 0, 0, 82)
InputContainer.Size = UDim2.new(0.84, 0, 0, 44)

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 10)
InputCorner.Parent = InputContainer

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(145, 75, 235)
InputStroke.Thickness = 1.2
InputStroke.Transparency = 0.4
InputStroke.Parent = InputContainer

local KeyBox = Instance.new("TextBox")
KeyBox.Parent = InputContainer
KeyBox.BackgroundTransparency = 1
KeyBox.Position = UDim2.new(0.04, 0, 0, 0)
KeyBox.Size = UDim2.new(0.92, 0, 1, 0)
KeyBox.Font = Enum.Font.GothamMedium
KeyBox.PlaceholderText = "Paste your access key here..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(245, 235, 255)
KeyBox.PlaceholderColor3 = Color3.fromRGB(135, 110, 170)
KeyBox.TextSize = 14
KeyBox.TextScaled = false
KeyBox.TextWrapped = false
KeyBox.ClipsDescendants = true
KeyBox.TextXAlignment = Enum.TextXAlignment.Center
KeyBox.ClearTextOnFocus = false

KeyBox.Focused:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.25), {Transparency = 0, Color = Color3.fromRGB(205, 130, 255)}):Play()
end)
KeyBox.FocusLost:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.25), {Transparency = 0.4, Color = Color3.fromRGB(145, 75, 235)}):Play()
end)

-- Nút Verify Key
local CheckBtn = Instance.new("TextButton")
CheckBtn.Parent = MainFrame
CheckBtn.BackgroundColor3 = Color3.fromRGB(140, 55, 245)
CheckBtn.BackgroundTransparency = 0.1
CheckBtn.Position = UDim2.new(0.08, 0, 0, 140)
CheckBtn.Size = UDim2.new(0.40, 0, 0, 38)
CheckBtn.Font = Enum.Font.GothamBold
CheckBtn.Text = "Verify Key"
CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckBtn.TextSize = 14
CheckBtn.AutoButtonColor = false

local CheckCorner = Instance.new("UICorner")
CheckCorner.CornerRadius = UDim.new(0, 10)
CheckCorner.Parent = CheckBtn

local CheckGradient = Instance.new("UIGradient")
CheckGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(175, 85, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(115, 35, 215))
})
CheckGradient.Rotation = 90
CheckGradient.Parent = CheckBtn

-- Nút Get Key
local GetBtn = Instance.new("TextButton")
GetBtn.Parent = MainFrame
GetBtn.BackgroundColor3 = Color3.fromRGB(55, 30, 95)
GetBtn.BackgroundTransparency = 0.25
GetBtn.Position = UDim2.new(0.52, 0, 0, 140)
GetBtn.Size = UDim2.new(0.40, 0, 0, 38)
GetBtn.Font = Enum.Font.GothamBold
GetBtn.Text = "Get Key"
GetBtn.TextColor3 = Color3.fromRGB(230, 210, 255)
GetBtn.TextSize = 14
GetBtn.AutoButtonColor = false

local GetCorner = Instance.new("UICorner")
GetCorner.CornerRadius = UDim.new(0, 10)
GetCorner.Parent = GetBtn

local GetStroke = Instance.new("UIStroke")
GetStroke.Color = Color3.fromRGB(165, 95, 255)
GetStroke.Thickness = 1
GetStroke.Transparency = 0.5
GetStroke.Parent = GetBtn

local function addHoverEffect(btn, normalTrans, hoverTrans)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = hoverTrans}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = normalTrans}):Play()
    end)
end
addHoverEffect(CheckBtn, 0.1, 0)
addHoverEffect(GetBtn, 0.25, 0.05)

-- Thẻ thông báo Pill Banner hiện đại ngay trong menu
local StatusBanner = Instance.new("Frame")
StatusBanner.Name = "StatusBanner"
StatusBanner.Parent = MainFrame
StatusBanner.AnchorPoint = Vector2.new(0.5, 0)
StatusBanner.Position = UDim2.new(0.5, 0, 0, 205)
StatusBanner.Size = UDim2.new(0.84, 0, 0, 34)
StatusBanner.BackgroundColor3 = Color3.fromRGB(45, 16, 32)
StatusBanner.BackgroundTransparency = 1
StatusBanner.BorderSizePixel = 0

local BannerCorner = Instance.new("UICorner")
BannerCorner.CornerRadius = UDim.new(0, 10)
BannerCorner.Parent = StatusBanner

local BannerStroke = Instance.new("UIStroke")
BannerStroke.Color = Color3.fromRGB(255, 80, 120)
BannerStroke.Thickness = 1.2
BannerStroke.Transparency = 1
BannerStroke.Parent = StatusBanner

local StatusBadge = Instance.new("Frame")
StatusBadge.Parent = StatusBanner
StatusBadge.AnchorPoint = Vector2.new(0, 0.5)
StatusBadge.Position = UDim2.new(0, 10, 0.5, 0)
StatusBadge.Size = UDim2.new(0, 20, 0, 20)
StatusBadge.BackgroundColor3 = Color3.fromRGB(255, 75, 115)
StatusBadge.BackgroundTransparency = 1

local BadgeCorner = Instance.new("UICorner")
BadgeCorner.CornerRadius = UDim.new(1, 0)
BadgeCorner.Parent = StatusBadge

local BadgeIcon = Instance.new("TextLabel")
BadgeIcon.Parent = StatusBadge
BadgeIcon.BackgroundTransparency = 1
BadgeIcon.Size = UDim2.new(1, 0, 1, 0)
BadgeIcon.Font = Enum.Font.GothamBlack
BadgeIcon.Text = "!"
BadgeIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
BadgeIcon.TextTransparency = 1
BadgeIcon.TextSize = 12

local StatusText = Instance.new("TextLabel")
StatusText.Parent = StatusBanner
StatusText.BackgroundTransparency = 1
StatusText.Position = UDim2.new(0, 38, 0, 0)
StatusText.Size = UDim2.new(1, -46, 1, 0)
StatusText.Font = Enum.Font.GothamMedium
StatusText.Text = ""
StatusText.TextColor3 = Color3.fromRGB(255, 220, 230)
StatusText.TextTransparency = 1
StatusText.TextSize = 12.5
StatusText.TextXAlignment = Enum.TextXAlignment.Left

local bannerThread = nil
local function showMenuNotification(msgType, message)
    if bannerThread then
        task.cancel(bannerThread)
    end

    local bgColor, strokeColor, badgeColor, textColor, iconChar
    if msgType == "error" then
        bgColor = Color3.fromRGB(58, 16, 36)
        strokeColor = Color3.fromRGB(255, 75, 115)
        badgeColor = Color3.fromRGB(240, 55, 95)
        textColor = Color3.fromRGB(255, 205, 218)
        iconChar = "!"
    elseif msgType == "success" then
        bgColor = Color3.fromRGB(16, 52, 42)
        strokeColor = Color3.fromRGB(70, 240, 165)
        badgeColor = Color3.fromRGB(45, 200, 130)
        textColor = Color3.fromRGB(205, 255, 230)
        iconChar = "✓"
    else
        bgColor = Color3.fromRGB(46, 22, 82)
        strokeColor = Color3.fromRGB(185, 105, 255)
        badgeColor = Color3.fromRGB(150, 70, 240)
        textColor = Color3.fromRGB(235, 215, 255)
        iconChar = "i"
    end

    StatusBanner.BackgroundColor3 = bgColor
    BannerStroke.Color = strokeColor
    StatusBadge.BackgroundColor3 = badgeColor
    StatusText.TextColor3 = textColor
    BadgeIcon.Text = iconChar
    StatusText.Text = message

    StatusBanner.Position = UDim2.new(0.5, 0, 0, 204)
    local tweenIn = TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

    TweenService:Create(StatusBanner, tweenIn, {
        Position = UDim2.new(0.5, 0, 0, 194),
        BackgroundTransparency = 0.22
    }):Play()
    TweenService:Create(BannerStroke, tweenIn, {Transparency = 0.25}):Play()
    TweenService:Create(StatusBadge, tweenIn, {BackgroundTransparency = 0.15}):Play()
    TweenService:Create(BadgeIcon, tweenIn, {TextTransparency = 0}):Play()
    TweenService:Create(StatusText, tweenIn, {TextTransparency = 0}):Play()

    if msgType ~= "success" then
        bannerThread = task.spawn(function()
            task.wait(3.5)
            local tweenOut = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(StatusBanner, tweenOut, {BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0, 202)}):Play()
            TweenService:Create(BannerStroke, tweenOut, {Transparency = 1}):Play()
            TweenService:Create(StatusBadge, tweenOut, {BackgroundTransparency = 1}):Play()
            TweenService:Create(BadgeIcon, tweenOut, {TextTransparency = 1}):Play()
            TweenService:Create(StatusText, tweenOut, {TextTransparency = 1}):Play()
        end)
    end
end

-- Kéo thả cửa sổ mượt mà
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        TweenService:Create(MainFrame, TweenInfo.new(0.08, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        }):Play()
    end
end)

-- Hiệu ứng lắc nhẹ giảm chấn siêu mượt khi nhập sai
local isShaking = false
local function smoothShake()
    if isShaking then return end
    isShaking = true

    local basePos = MainFrame.Position
    local offsets = {9, -9, 6, -6, 3.5, -3.5, 0}
    local tweenInfo = TweenInfo.new(0.045, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

    TweenService:Create(InputStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(255, 75, 115), Transparency = 0}):Play()
    TweenService:Create(MainStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(255, 85, 120)}):Play()

    for _, offset in ipairs(offsets) do
        local tween = TweenService:Create(MainFrame, tweenInfo, {
            Position = UDim2.new(basePos.X.Scale, basePos.X.Offset + offset, basePos.Y.Scale, basePos.Y.Offset)
        })
        tween:Play()
        tween.Completed:Wait()
    end

    TweenService:Create(InputStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(145, 75, 235), Transparency = 0.4}):Play()
    TweenService:Create(MainStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(255, 255, 255)}):Play()
    isShaking = false
end

-- Hiệu ứng mở menu mượt khi khởi chạy
MainFrame.Size = UDim2.new(0, 345, 0, 225)
MainFrame.BackgroundTransparency = 1
TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 385, 0, 255),
    BackgroundTransparency = 0.18
}):Play()

-- Xử lý nút Verify Key
CheckBtn.MouseButton1Click:Connect(function()
    local enteredKey = KeyBox.Text:gsub("%s+", "")
    if enteredKey == CORRECT_KEY then
        showMenuNotification("success", "Access granted! Loading Figgy Hub...")
        TweenService:Create(InputStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(70, 240, 165), Transparency = 0}):Play()
        saveKey()

        task.wait(0.55)
        local closeTween = TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 330, 0, 200),
            BackgroundTransparency = 1
        })
        closeTween:Play()
        closeTween.Completed:Wait()
        ScreenGui:Destroy()
        loadMainScript()
    else
        showMenuNotification("error", "Invalid key! Please check and try again.")
        KeyBox.Text = ""
        task.spawn(smoothShake)
    end
end)

-- Xử lý nút Get Key
GetBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(GET_KEY_LINK)
        showMenuNotification("info", "Key link copied to your clipboard!")
    else
        showMenuNotification("error", "Executor does not support clipboard.")
    end
end)
