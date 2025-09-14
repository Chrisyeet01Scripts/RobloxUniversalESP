local outlineColor = Color3.fromRGB(255, 0, 0) -- Change this to any OUTLINE color.
local fillColor = Color3.fromRGB(255, 0, 0) -- Change this to any FILL color.

-- Change this to any key you want to TOGGLE the Esp on or off.
local toggleKey = Enum.KeyCode.P

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local espEnabled = true
local highlights = {}

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
