local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MatchConfig = ReplicatedStorage.MatchConfig

local Player = game.Players.LocalPlayer

MatchConfig.Status:GetPropertyChangedSignal("Value"):Connect(function()
    local MainUI = Player.PlayerGui:WaitForChild("Main")
    MainUI.Topbar.Text = MatchConfig.Status.Value
end)
