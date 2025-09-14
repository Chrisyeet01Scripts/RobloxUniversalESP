local outlineColor = Color3.fromRGB(255, 0, 0) -- Change this to any OUTLINE color.
local fillColor = Color3.fromRGB(255, 0, 0) -- Change this to any FILL color.

-- Change this to any key you want to TOGGLE the Esp on or off.
local toggleKey = Enum.KeyCode.P

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local espEnabled = true
local highlights = {}

function createESP(player)
    if player == LocalPlayer then return end
    if highlights[player] then highlights[player]:Destroy() end
    local highlight = Instance.new("Highlight")
    highlight.OutlineColor = outlineColor
    highlight.FillColor = fillColor
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = player.Character
    highlights[player] = highlight
    player.CharacterAdded:Connect(function(char)
        local newHighlight = highlight:Clone()
        newHighlight.Parent = char
        highlights[player] = newHighlight
    end)
end

for _, p in pairs(Players:GetPlayers()) do
    if p.Character then
        createESP(p)
    end
end

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function()
        createESP(p)
    end)
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == toggleKey then
        espEnabled = not espEnabled
        for _, h in pairs(highlights) do
            if h and h.Parent then
                h.Enabled = espEnabled
            end
        end
    end
end)

game.StarterGui:SetCore("SendNotification", {
    Title = "ESP Loaded. Created by realChrisyeet01 on GitHub.",
    Text = "Press " .. toggleKey.Name .. " to toggle ESP. These notification lines are NOT TO BE CHANGED AT ALL COSTS.",
    Duration = 5
})
