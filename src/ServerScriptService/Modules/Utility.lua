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
            local Detector = Instance.new("ClickDetector")
            Detector.Parent = asset
            
            local Config = asset:WaitForChild("Configuration")
            local Health
            if Config then
                Health = Config.Health
            else
                Config = Instance.new("Configuration")
                Config.Parent = asset
            end

            Detector.MouseClick:Connect(function(playerWhoClicked)
                Utility.AwardCoins(playerWhoClicked,playerWhoClicked.Damage.Value)
                warn(asset.Name)
                Health.Value = Health.Value - playerWhoClicked.Damage.Value
                warn(Health.Value)
                if Health.Value <= 0 then
                    Detector:Destroy()
                    asset:Destroy()
                end
            end)
        end
    end
end

return Utility