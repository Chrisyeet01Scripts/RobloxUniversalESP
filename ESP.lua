local outlineColor = Color3.fromRGB(255, 0, 0) -- Change Outline color here
local fillColor = Color3.fromRGB(0, 255, 0)    -- Change Fill color here

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

function createESP(player)
    if player == LocalPlayer then return end
    local highlight = Instance.new("Highlight")
    highlight.OutlineColor = outlineColor
    highlight.FillColor = fillColor
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = player.Character
    player.CharacterAdded:Connect(function(char)
        local newHighlight = highlight:Clone()
        newHighlight.Parent = char
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

game.StarterGui:SetCore("SendNotification", {
    Title = "ESP Loaded",
    Text = "Script by realchrisyeet01 on GitHub",
    Duration = 5
})
