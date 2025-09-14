local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local outlineColor = Color3.fromRGB(255, 0, 0)
local fillColor = Color3.fromRGB(255, 0, 0)
local toggleKey = Enum.KeyCode.P

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local espEnabled = true
local highlights = {}

-- GUI Setup
local Window = Rayfield:CreateWindow({
    Name = "Universal ESP by Chrisyeet01 Scripts",
    LoadingTitle = "Version 1.0",
    ConfigurationSaving = {
        Enabled = false,
    }
})

local Tab = Window:CreateTab("ESP Settings")

Tab:CreateColorPicker({
    Name = "Outline Color",
    Color = outlineColor,
    Callback = function(Value)
        outlineColor = Value
        for _, h in pairs(highlights) do
            if h and h.Parent then
                h.OutlineColor = outlineColor
            end
        end
    end
})

Tab:CreateColorPicker({
    Name = "Fill Color",
    Color = fillColor,
    Callback = function(Value)
        fillColor = Value
        for _, h in pairs(highlights) do
            if h and h.Parent then
                h.FillColor = fillColor
            end
        end
    end
})

local waitingForKey = false
Tab:CreateButton({
    Name = "Change Toggle Key",
    Callback = function()
        waitingForKey = true
        Rayfield:Notify({
            Title = "ESP Toggle Key",
            Content = "Press a key to set as the new toggle.",
            Duration = 5
        })
    end
})

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if waitingForKey then
        toggleKey = input.KeyCode
        waitingForKey = false
        Rayfield:Notify({
            Title = "ESP Toggle Key Changed",
            Content = "New toggle key: " .. toggleKey.Name,
            Duration = 5
        })
    elseif input.KeyCode == toggleKey then
        espEnabled = not espEnabled
        for _, h in pairs(highlights) do
            if h and h.Parent then
                h.Enabled = espEnabled
            end
        end
    end
end)

-- ESP functions
function applyESP(player, char)
    if highlights[player] then highlights[player]:Destroy() end
    local highlight = Instance.new("Highlight")
    highlight.OutlineColor = outlineColor
    highlight.FillColor = fillColor
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Enabled = espEnabled
    highlight.Parent = char
    highlights[player] = highlight
end

function setupPlayer(player)
    if player == LocalPlayer then return end
    if player.Character then
        applyESP(player, player.Character)
    end
    player.CharacterAdded:Connect(function(char)
        char:WaitForChild("HumanoidRootPart", 5)
        applyESP(player, char)
    end)
end

for _, p in pairs(Players:GetPlayers()) do
    setupPlayer(p)
end

Players.PlayerAdded:Connect(setupPlayer)
Players.PlayerRemoving:Connect(function(p)
    if highlights[p] then
        highlights[p]:Destroy()
        highlights[p] = nil
    end
end)

game.StarterGui:SetCore("SendNotification", {
    Title = "Script Successfully Loaded.",
    Text = "Have Fun!",
    Duration = 5
})
