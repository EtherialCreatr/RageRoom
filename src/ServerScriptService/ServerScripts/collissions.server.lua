local PhysicsService = game:GetService("PhysicsService")

game.Players.PlayerAdded:Connect(function(player)
    local Character = player.Character or player.CharacterAdded:Wait()
    for i,v:Instance in pairs(Character:GetChildren()) do
        if v:IsA("BasePart") then
            v.CollisionGroup = "Character"
        end
    end
end)