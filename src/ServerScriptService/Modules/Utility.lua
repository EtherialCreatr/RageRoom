local Utility = {}
local tag = "Destructible"
local CollectionService = game:GetService("CollectionService")

function Utility.AwardCoins(Player,Coins)
    local PlayerStats = Player:FindFirstChild("leaderstats")
    PlayerStats.RageCoins.Value += Coins
end

function Utility.InitTags()
    for _, asset in CollectionService:GetTagged(tag) do
        if asset.Parent == workspace or asset.Parent:IsA("Folder") then
            local Config = asset:WaitForChild("Configuration")
            local Health
            if Config then
                Health = Config.Health
            else
                Config = Instance.new("Configuration")
                Config.Parent = asset
            end
        end
    end
end

function Utility.Cleanup()
    for i,v in CollectionService:GetTagged(tag) do
        if v.Parent == workspace or v.Parent:IsA("Folder") and v.Parent.Parent == workspace then
            v:Destroy()
        end
    end
end

return Utility