local DataStoreService = game:GetService("DataStoreService")
local RageCoinsStore = DataStoreService:GetDataStore("RageCoins")
local Utility = require(game:GetService("ServerScriptService").Modules.Utility)

game.Players.PlayerAdded:Connect(function(player)
    local stats = Instance.new("Folder")
    stats.Name = "leaderstats"
    stats.Parent = player
    
    local RageCoins = Instance.new("IntValue")
    RageCoins.Name = "RageCoins"
    RageCoins.Value = RageCoinsStore:GetAsync(player.UserId) or 100 -- Default Start Amount
    RageCoins.Parent = stats

    local DamagePlayerCanDo = Instance.new("IntValue")
    DamagePlayerCanDo.Value = 5
    DamagePlayerCanDo.Name = "Damage"
    DamagePlayerCanDo.Parent = player


    game.Players.PlayerRemoving:Connect(function(PlayerRemoving)
        local success,error = pcall(function()
            RageCoinsStore:SetAsync(PlayerRemoving.UserId,RageCoins.Value)
        end)

        if success then
            warn("Player Data Saved Successfully")
        elseif error then
            warn("Failed to Save Player Data!")
        end
    end)
end)