local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Drawing = {}
pcall(function()
Drawing = loadstring(game:HttpGet("https://raw.githubusercontent.com/richie0866/orca/master/public/drawing.lua"))()
end)
if not Drawing or not Drawing.new then
local drawingLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/richie0866/orca/master/public/drawing.lua"))()
Drawing = drawingLib
end

local ESPEnabled = false
local TeleportEnabled = false
local AutoShootEnabled = false
local MasterEnabled = false
local ToggleKey = Enum.KeyCode.RightShift

local mainGui = Instance.new("ScreenGui")
mainGui.Name = "EnserSSHub"
mainGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
mainGui.ResetOnSpawn = false
mainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = mainGui
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
mainFrame.Size = UDim2.new(0, 300, 0, 350)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true
mainFrame.Visible = false

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Parent = mainFrame
titleLabel.BackgroundTransparency = 1
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Text = "EnserSSHub"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 24
titleLabel.TextStrokeTransparency = 0.5

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Parent = mainFrame
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.BorderSizePixel = 0
closeButton.Position = UDim2.new(1, -30, 0, 5)
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 16
closeButton.AutoButtonColor = false

local masterToggle = Instance.new("TextButton")
masterToggle.Name = "MasterToggle"
masterToggle.Parent = mainFrame
masterToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
masterToggle.BorderSizePixel = 0
masterToggle.Position = UDim2.new(0.05, 0, 0.15, 0)
masterToggle.Size = UDim2.new(0.9, 0, 0, 40)
masterToggle.Font = Enum.Font.SourceSansBold
masterToggle.Text = "Enable Cheat: OFF"
masterToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
masterToggle.TextSize = 18
masterToggle.AutoButtonColor = false

local espButton = Instance.new("TextButton")
espButton.Name = "ESPButton"
espButton.Parent = mainFrame
espButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espButton.BorderSizePixel = 0
espButton.Position = UDim2.new(0.05, 0, 0.28, 0)
espButton.Size = UDim2.new(0.9, 0, 0, 35)
espButton.Font = Enum.Font.SourceSansBold
espButton.Text = "ESP: OFF"
espButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espButton.TextSize = 16
espButton.AutoButtonColor = false

local teleportButton = Instance.new("TextButton")
teleportButton.Name = "TeleportButton"
teleportButton.Parent = mainFrame
teleportButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
teleportButton.BorderSizePixel = 0
teleportButton.Position = UDim2.new(0.05, 0, 0.4, 0)
teleportButton.Size = UDim2.new(0.9, 0, 0, 35)
teleportButton.Font = Enum.Font.SourceSansBold
teleportButton.Text = "Teleport: OFF"
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.TextSize = 16
teleportButton.AutoButtonColor = false

local autoShootButton = Instance.new("TextButton")
autoShootButton.Name = "AutoShootButton"
autoShootButton.Parent = mainFrame
autoShootButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
autoShootButton.BorderSizePixel = 0
autoShootButton.Position = UDim2.new(0.05, 0, 0.52, 0)
autoShootButton.Size = UDim2.new(0.9, 0, 0, 35)
autoShootButton.Font = Enum.Font.SourceSansBold
autoShootButton.Text = "Auto-Shoot: OFF"
autoShootButton.TextColor3 = Color3.fromRGB(255, 255, 255)
autoShootButton.TextSize = 16
autoShootButton.AutoButtonColor = false

local toggleKeyButton = Instance.new("TextButton")
toggleKeyButton.Name = "ToggleKeyButton"
toggleKeyButton.Parent = mainFrame
toggleKeyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleKeyButton.BorderSizePixel = 0
toggleKeyButton.Position = UDim2.new(0.05, 0, 0.64, 0)
toggleKeyButton.Size = UDim2.new(0.9, 0, 0, 35)
toggleKeyButton.Font = Enum.Font.SourceSansBold
toggleKeyButton.Text = "Toggle Key: RightShift"
toggleKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleKeyButton.TextSize = 16
toggleKeyButton.AutoButtonColor = false

local targetLabel = Instance.new("TextLabel")
targetLabel.Name = "TargetLabel"
targetLabel.Parent = mainFrame
targetLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
targetLabel.BorderSizePixel = 0
targetLabel.Position = UDim2.new(0.05, 0, 0.76, 0)
targetLabel.Size = UDim2.new(0.9, 0, 0, 25)
targetLabel.Font = Enum.Font.SourceSans
targetLabel.Text = "Target: None"
targetLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
targetLabel.TextSize = 14
targetLabel.Visible = false

local espSettingsLabel = Instance.new("TextLabel")
espSettingsLabel.Name = "SettingsLabel"
espSettingsLabel.Parent = mainFrame
espSettingsLabel.BackgroundTransparency = 1
espSettingsLabel.Position = UDim2.new(0.05, 0, 0.84, 0)
espSettingsLabel.Size = UDim2.new(0.9, 0, 0, 20)
espSettingsLabel.Font = Enum.Font.SourceSans
espSettingsLabel.Text = "Settings"
espSettingsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
espSettingsLabel.TextSize = 14

local rainbowHue = 0
local rainbowConnection
rainbowConnection = RunService.RenderStepped:Connect(function()
rainbowHue = (rainbowHue + 0.005) % 1
local color = Color3.fromHSV(rainbowHue, 1, 1)
titleLabel.TextColor3 = color
masterToggle.TextColor3 = color
espButton.TextColor3 = color
teleportButton.TextColor3 = color
autoShootButton.TextColor3 = color
toggleKeyButton.TextColor3 = color
targetLabel.TextColor3 = color
espSettingsLabel.TextColor3 = color
end)

local function setMasterEnabled(enabled)
MasterEnabled = enabled
masterToggle.Text = "Enable Cheat: " .. (enabled and "ON" or "OFF")
if not enabled then
ESPEnabled = false
TeleportEnabled = false
AutoShootEnabled = false
espButton.Text = "ESP: OFF"
teleportButton.Text = "Teleport: OFF"
autoShootButton.Text = "Auto-Shoot: OFF"
if targetLabel then
targetLabel.Visible = false
end
pcall(function()
for _, drawing in pairs(DrawingObjects) do
if drawing then
drawing:Remove()
end
end
DrawingObjects = {}
end)
end
end

local DrawingObjects = {}
local espPool = {}
local function getDrawing(type)
if espPool[type] and #espPool[type] > 0 then
local obj = table.remove(espPool[type])
obj.Visible = true
return obj
end
local obj
pcall(function()
obj = Drawing.new(type)
end)
return obj
end
local function releaseDrawing(obj, type)
if not obj then return end
pcall(function()
obj.Visible = false
obj:Remove()
end)
end

local function clearESP()
for type, objects in pairs(DrawingObjects) do
for _, obj in pairs(objects) do
pcall(function()
if obj then
obj:Remove()
end
end)
end
end
DrawingObjects = {}
end

local function getRole(player)
local success, role = pcall(function()
return player:GetRole()
end)
if success and role then
return string.lower(role)
end
local leaderstats = player:FindFirstChild("leaderstats")
if leaderstats then
local roleValue = leaderstats:FindFirstChild("Role")
if roleValue then
return string.lower(roleValue.Value)
end
end
local playerGui = player:FindFirstChild("PlayerGui")
if playerGui then
local roleLabel = playerGui:FindFirstChild("RoleLabel")
if roleLabel and roleLabel:IsA("TextLabel") then
return string.lower(roleLabel.Text)
end
end
return "innocent"
end

local function getMurderer()
local murderer = nil
for _, player in pairs(Players:GetPlayers()) do
local role = getRole(player)
if role == "murderer" then
murderer = player
break
end
end
return murderer
end

local function updateESP()
if not MasterEnabled or not ESPEnabled then
return
end
pcall(function()
for type, objects in pairs(DrawingObjects) do
for _, obj in pairs(objects) do
pcall(function()
if obj then
obj:Remove()
end
end)
end
end
DrawingObjects = {}
local localCharacter = LocalPlayer.Character
if not localCharacter or not localCharacter:FindFirstChild("Humanoid") or localCharacter.Humanoid.Health <= 0 then
return
end
local localHumanoid = localCharacter.Humanoid
local localRootPart = localCharacter:FindFirstChild("HumanoidRootPart")
if not localRootPart then return end
for _, player in pairs(Players:GetPlayers()) do
if player ~= LocalPlayer then
local character = player.Character
if character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
local rootPart = character:FindFirstChild("HumanoidRootPart")
local head = character:FindFirstChild("Head")
if rootPart and head then
local role = getRole(player)
local color
if role == "murderer" then
color = Color3.fromRGB(255, 0, 0)
elseif role == "sheriff" then
color = Color3.fromRGB(0, 0, 255)
else
color = Color3.fromRGB(0, 255, 0)
end
local box = getDrawing("Square")
local nameTag = getDrawing("Text")
local tracer = getDrawing("Line")
if box and nameTag and tracer then
DrawingObjects["Square"] = DrawingObjects["Square"] or {}
DrawingObjects["Text"] = DrawingObjects["Text"] or {}
DrawingObjects["Line"] = DrawingObjects["Line"] or {}
table.insert(DrawingObjects["Square"], box)
table.insert(DrawingObjects["Text"], nameTag)
table.insert(DrawingObjects["Line"], tracer)
box.Color = color
box.Thickness = 2
box.Filled = false
box.Transparency = 1
box.Visible = false
nameTag.Color = color
nameTag.Size = 14
nameTag.Transparency = 0.5
nameTag.Center = true
nameTag.Outline = true
nameTag.OutlineColor = Color3.new(0,0,0)
nameTag.Visible = false
tracer.Color = color
tracer.Thickness = 1
tracer.Transparency = 0.8
tracer.Visible = false
local rootPos, rootOnScreen = Camera:WorldToViewportPoint(rootPart.Position)
local headPos = head.Position
local headWorldPos = Vector3.new(rootPart.Position.X, headPos.Y, rootPart.Position.Z)
local topPos, topOnScreen = Camera:WorldToViewportPoint(headWorldPos + Vector3.new(0, 1.5, 0))
local bottomPos, bottomOnScreen = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 2, 0))
if rootOnScreen and topOnScreen and bottomOnScreen then
local width = math.abs(topPos.X - bottomPos.X)
local height = math.abs(topPos.Y - bottomPos.Y)
box.Size = Vector2.new(width, height)
box.Position = Vector2.new(topPos.X - width/2, topPos.Y)
box.Visible = true
nameTag.Text = player.Name .. " [" .. role .. "]"
nameTag.Position = Vector2.new(topPos.X, topPos.Y - 20)
nameTag.Visible = true
tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
tracer.To = Vector2.new(topPos.X, topPos.Y)
tracer.Visible = true
end
end
end
end
end
end
end)
end

local function teleportToGun()
if not MasterEnabled or not TeleportEnabled then
return
end
pcall(function()
local character = LocalPlayer.Character
if not character or not character:FindFirstChild("Humanoid") or character.Humanoid.Health <= 0 then
return
end
local rootPart = character:FindFirstChild("HumanoidRootPart")
if not rootPart then return end
local gun = nil
for _, obj in pairs(Workspace:GetDescendants()) do
if obj:IsA("Tool") and (obj.Name == "Gun" or string.find(string.lower(obj.Name), "sheriff")) then
gun = obj
break
end
end
if not gun then return end
local handle = gun:FindFirstChild("Handle")
if not handle then return end
rootPart.CFrame = CFrame.new(handle.Position + Vector3.new(0, 3, 0))
wait(0.1)
if LocalPlayer.Backpack then
local backpackGun = LocalPlayer.Backpack:FindFirstChild(gun.Name)
if not backpackGun and character:FindFirstChild(gun.Name) == nil then
local humanoid = character.Humanoid
if humanoid then
humanoid:EquipTool(gun)
end
end
end
end)
end

local sheriffDiedConnections = {}
local function monitorSheriffDeaths()
for _, conn in pairs(sheriffDiedConnections) do
pcall(function() conn:Disconnect() end)
end
sheriffDiedConnections = {}
for _, player in pairs(Players:GetPlayers()) do
if player ~= LocalPlayer then
local function onCharacterAdded(character)
local humanoid = character:WaitForChild("Humanoid")
local conn
conn = humanoid.Died:Connect(function()
if getRole(player) == "sheriff" then
teleportToGun()
end
end)
table.insert(sheriffDiedConnections, conn)
end
if player.Character then
onCharacterAdded(player.Character)
end
player.CharacterAdded:Connect(onCharacterAdded)
end
end
end

local autoShootConnection
local autoShootActive = false
local fireRemote = nil
local function findFireRemote()
fireRemote = nil
for _, child in pairs(ReplicatedStorage:GetDescendants()) do
if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
local lowerName = string.lower(child.Name)
if string.find(lowerName, "shoot") or string.find(lowerName, "fire") or string.find(lowerName, "gunfire") then
fireRemote = child
break
end
end
end
end

local function aimAtMurderer(murderer)
local character = murderer.Character
if not character then return end
local head = character:FindFirstChild("Head")
if not head then return end
Camera.CFrame = CFrame.new(Camera.CFrame.Position, head.Position)
end

local function fireGun()
if not MasterEnabled or not AutoShootEnabled then
return
end
pcall(function()
local character = LocalPlayer.Character
if not character or not character:FindFirstChild("Humanoid") or character.Humanoid.Health <= 0 then
return
end
local murderer = getMurderer()
if not murderer then return end
if targetLabel then
targetLabel.Text = "Target: " .. murderer.Name
targetLabel.Visible = true
end
aimAtMurderer(murderer)
local gun = nil
if character:FindFirstChildOfClass("Tool") then
gun = character:FindFirstChildOfClass("Tool")
elseif LocalPlayer.Backpack then
local tool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
if tool then
gun = tool
character.Humanoid:EquipTool(gun)
end
end
if not gun then return end
if fireRemote then
fireRemote:FireServer()
else
pcall(function()
gun:Activate()
wait(0.1)
gun:Deactivate()
end)
end
end)
end

local function startAutoShoot()
if autoShootConnection then
autoShootConnection:Disconnect()
autoShootConnection = nil
end
autoShootActive = true
autoShootConnection = RunService.RenderStepped:Connect(function()
if AutoShootEnabled and MasterEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.Health > 0 then
local delay = math.random(0.08, 0.12)
wait(delay)
fireGun()
end
end)
end

local function stopAutoShoot()
if autoShootConnection then
autoShootConnection:Disconnect()
autoShootConnection = nil
end
autoShootActive = false
if targetLabel then
targetLabel.Visible = false
end
end

local function onMasterToggleClicked()
setMasterEnabled(not MasterEnabled)
if MasterEnabled then
if ESPEnabled then
updateESP()
end
if AutoShootEnabled then
startAutoShoot()
end
else
if autoShootConnection then
stopAutoShoot()
end
clearESP()
end
end

local function onESPButtonClicked()
ESPEnabled = not ESPEnabled
espButton.Text = "ESP: " .. (ESPEnabled and "ON" or "OFF")
if not ESPEnabled then
clearESP()
end
end

local function onTeleportButtonClicked()
TeleportEnabled = not TeleportEnabled
teleportButton.Text = "Teleport: " .. (TeleportEnabled and "ON" or "OFF")
end

local function onAutoShootButtonClicked()
AutoShootEnabled = not AutoShootEnabled
autoShootButton.Text = "Auto-Shoot: " .. (AutoShootEnabled and "ON" or "OFF")
if AutoShootEnabled then
if MasterEnabled then
startAutoShoot()
end
else
stopAutoShoot()
end
end

local function onToggleKeyButtonClicked()
local newKey = nil
local keyPrompt = Instance.new("TextBox")
keyPrompt.Name = "KeyPrompt"
keyPrompt.Parent = mainGui
keyPrompt.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
keyPrompt.BorderSizePixel = 0
keyPrompt.Position = UDim2.new(0.3, 0, 0.4, 0)
keyPrompt.Size = UDim2.new(0, 200, 0, 50)
keyPrompt.Font = Enum.Font.SourceSansBold
keyPrompt.Text = "Press any key..."
keyPrompt.TextColor3 = Color3.fromRGB(255, 255, 255)
keyPrompt.TextSize = 18
keyPrompt.ZIndex = 10
local keyConnection
keyConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
newKey = input.KeyCode
ToggleKey = newKey
toggleKeyButton.Text = "Toggle Key: " .. tostring(newKey):gsub("Enum.KeyCode.", "")
keyConnection:Disconnect()
keyPrompt:Destroy()
end
end)
end

masterToggle.MouseButton1Click:Connect(onMasterToggleClicked)
espButton.MouseButton1Click:Connect(onESPButtonClicked)
teleportButton.MouseButton1Click:Connect(onTeleportButtonClicked)
autoShootButton.MouseButton1Click:Connect(onAutoShootButtonClicked)
toggleKeyButton.MouseButton1Click:Connect(onToggleKeyButtonClicked)
closeButton.MouseButton1Click:Connect(function()
mainFrame.Visible = false
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
if gameProcessed then return end
if input.KeyCode == ToggleKey then
mainFrame.Visible = not mainFrame.Visible
end
end)

Players.PlayerAdded:Connect(function(player)
if player ~= LocalPlayer then
local function onCharacterAdded(character)
local humanoid = character:WaitForChild("Humanoid")
local conn
conn = humanoid.Died:Connect(function()
if getRole(player) == "sheriff" then
teleportToGun()
end
end)
table.insert(sheriffDiedConnections, conn)
end
if player.Character then
onCharacterAdded(player.Character)
end
player.CharacterAdded:Connect(onCharacterAdded)
end
end)

Players.PlayerRemoving:Connect(function(player)
for _, conn in pairs(sheriffDiedConnections) do
pcall(function() conn:Disconnect() end)
end
end)

findFireRemote()
monitorSheriffDeaths()

RunService.RenderStepped:Connect(function()
if MasterEnabled and ESPEnabled then
updateESP()
end
end)

while true do
wait(1)
end
