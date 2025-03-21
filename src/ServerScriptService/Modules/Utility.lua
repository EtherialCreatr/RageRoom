local Utility = {}
local tag = "Destructible"
local CollectionService = game:GetService("CollectionService")

--// 

local CoinsPerDamage = 15

function Utility.AwardCoins(Player,Coins)
    local PlayerStats = game.Players:FindFirstChild(Player.Name).leaderstats
    PlayerStats.RageCoins.Value += Coins
end

function Utility.InitTags()
    for _, asset in CollectionService:GetTagged(tag) do
        if asset.Parent == workspace or asset.Parent:IsA("Folder") then
            local Config = asset:WaitForChild("Configuration")
            local Health
            local debounce = false

            if Config then
                Health = Config.Health
            else
                Config = Instance.new("Configuration")
                Config.Parent = asset

                Health = Instance.new("IntValue")
                Health.Name = "Health"
                Health.Value = 25
                Health.Parent = Config
            end

            asset.Hitbox.Touched:Connect(function(HitPart)
                if HitPart.Parent:IsA("Tool") and not debounce  then
                    Utility.AwardCoins(game.Players:GetPlayerFromCharacter(HitPart.Parent.Parent),CoinsPerDamage)
                    Utility.UnAnchorPart(asset)
                    debounce = true
                elseif debounce == true then
                    task.wait(.5)
                    debounce = false
                end
            end)
        end
    end
end

function Utility.UnAnchorPart(model: Model)
    local parts = model:GetChildren()
    local rand = math.random(1,#parts)
    local randpart = parts[rand]
    if randpart.Name ~= "Hitbox" and randpart.Anchored == true and randpart:IsA("BasePart") then
        randpart.Anchored = false
    else
        repeat
            parts = model:GetChildren()
            rand = math.random(1,#parts)
            randpart = parts[rand]
        until randpart.Name ~= "Hitbox" and randpart.Anchored == true and randpart:IsA("BasePart")
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