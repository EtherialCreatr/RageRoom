local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local Modules = ServerScriptService.Modules
local Utility = require(Modules.Utility)

--// Round Settings
local PlayersToStart = 1
local IntermissionTime = 5
local RoundTime = 10
local RoundEnded = false
--//

function StartRound()
    --// Countdown
    if #game.Players:GetPlayers() < PlayersToStart then
        return
    end

    local ParticipatingPlayers = {}

    for i = IntermissionTime, 1, -1 do
        warn("Waiting for Intermission to End!")
        task.wait(1)
    end

    ParticipatingPlayers = game.Players:GetPlayers()

    local Map = ServerStorage.Maps.Map1
    Map = Map:Clone()
    Map.Parent = workspace
    Utility.InitTags()

    coroutine.resume(coroutine.create(function()
        for i = RoundTime, 1, -1 do
            warn("Waiting for Round to End!")
            task.wait(1)
        end
        RoundEnded = true
    end))

    repeat
        task.wait(1)
    until #Map:GetChildren() == 0 or RoundEnded == true

    for _, player in ParticipatingPlayers do
        if game.Players:FindFirstChild(player.Name) then
            Utility.AwardCoins(player,20) -- Award Coins for Participation
        end
        warn("Awarded Participation Coins!")
    end

    Map:Destroy()
    warn("Destroyed Map")

    RoundEnded = false
    StartRound()
end

task.wait(2)
StartRound()
