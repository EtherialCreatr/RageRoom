local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local Modules = ServerScriptService.Modules
local Utility = require(Modules.Utility)

--// Round Settings
local IntermissionTime = 10
local RoundTime = 10
local PlayersToStart = ReplicatedStorage.MatchConfig.PlayersNeeded.Value
local Status = ReplicatedStorage.MatchConfig.Status
local RoundEnded = false
--//

function StartRound()
    if #game.Players:GetPlayers() < PlayersToStart then
        return
    end
    
    local ParticipatingPlayers = {}
    
    --// Countdown
    for i = IntermissionTime, 1, -1 do
        Status.Value = "Intermission: "..i
        task.wait(1)
    end

    ParticipatingPlayers = game.Players:GetPlayers()

    local Map = ServerStorage.Maps.Map1
    Map = Map:Clone()
    Map.Parent = workspace
    Utility.InitTags()

    Status.Value = "Spawning Map"
    task.wait(2)
    
    for i = RoundTime, 1, -1 do
        Status.Value = "Round Ends In: "..i
        task.wait(1)
    end
    Status.Value = "Round Ended!"
    task.wait(2)
    Status.Value = "Resetting Game!"
    task.wait(5)
    RoundEnded = true

    repeat
        task.wait(1)
    until #Map:GetChildren() == 0 or RoundEnded == true

    for _, player in ParticipatingPlayers do
        if game.Players:FindFirstChild(player.Name) then
            Utility.AwardCoins(player,20) -- Award Coins for Participation
        end
    end

    Utility.Cleanup()
    Map:Destroy()
    RoundEnded = false

    task.wait(2)
    StartRound()
end

task.wait(2)
StartRound()
