_G.AuraAliveCheck = false
_G.AuraWallCheck = false
_G.AuraEnabled = false
_G.AuraRange = 20
_G.AuraBlacklistPlayers = {} 
_G.AuraFriendsBlacklist = false
_G.AuraLockPart = "Head"

coroutine.wrap(function()
	game:GetService("RunService").RenderStepped:Connect(function()
		wait(1)

		if not _G.AuraEnabled then return end

		local player = game.Players.LocalPlayer
		local playerCharacter = player.Character
		local playerHRP = playerCharacter and playerCharacter:FindFirstChild("HumanoidRootPart")
		local closestEntity = nil
		local closestDistance = math.huge
		
		if not playerHRP then return end

		-- Function to check entities in a given folder
		local function checkAndAddEntities(folder)
			if folder then
				for _, entity in pairs(folder:GetChildren()) do
					local entityHRP = entity:FindFirstChild("HumanoidRootPart")
					local entityHumanoid = entity:FindFirstChild("Humanoid")
					local entityAlive = (entityHumanoid and entityHumanoid.Health > 0)

					if entityHRP and (not _G.AuraAliveCheck or entityAlive) then
						local distance = (playerHRP.Position - entityHRP.Position).Magnitude
						if distance < closestDistance then
							closestDistance = distance
							closestEntity = entity
						end
					end
				end
			end
		end
		
		-- Check for NPCs in the "Hostile" and "Custom" folders within "NPCs"
		local npcsFolder = game:GetService("Workspace"):FindFirstChild("NPCs")
		if npcsFolder then
			checkAndAddEntities(npcsFolder:FindFirstChild("Hostile"))
			checkAndAddEntities(npcsFolder:FindFirstChild("Custom"))
		end
		
		-- Check for entities in the "Tutorial" folder
		checkAndAddEntities(game:GetService("Workspace"):FindFirstChild("Tutorial"))

		-- Check for other players
		for _, otherPlayer in pairs(game.Players:GetPlayers()) do
			if otherPlayer ~= player then
				-- Skip blacklisted players and friends
				local otherPlayerName = otherPlayer.Name
				local isBlacklisted = _G.AuraBlacklistPlayers[otherPlayerName]
				local isFriend = player:IsFriendsWith(otherPlayer.UserId)

				if not isBlacklisted and (not _G.AuraFriendsBlacklist or not isFriend) then
					local otherCharacter = otherPlayer.Character
					local otherHRP = otherCharacter and otherCharacter:FindFirstChild("HumanoidRootPart")
					local otherHumanoid = otherCharacter and otherCharacter:FindFirstChild("Humanoid")
					local otherAlive = (otherHumanoid and otherHumanoid.Health > 0)

					if otherHRP and (not _G.AuraAliveCheck or otherAlive) then
						local distance = (playerHRP.Position - otherHRP.Position).Magnitude
						if distance < closestDistance then
							closestDistance = distance
							closestEntity = otherCharacter
						end
					end
				end
			end
		end
		
		-- Function to check if there's a wall between player and target
		local function isLineOfSightClear(startPos, endPos)
			local rayParams = RaycastParams.new()
			rayParams.FilterDescendantsInstances = {playerCharacter}
			rayParams.FilterType = Enum.RaycastFilterType.Blacklist
			rayParams.IgnoreWater = true

			local direction = (endPos - startPos).Unit * (endPos - startPos).Magnitude
			local result = workspace:Raycast(startPos, direction, rayParams)
			
			if result then
				-- If something is hit, we check if it's part of the target entity
				local hitPartParent = result.Instance.Parent
				if hitPartParent == closestEntity or hitPartParent.Parent == closestEntity then
					return true
				end
				return false
			end
			
			return true -- No hit means no obstacle
		end
		
		-- Perform action if closest entity is within range
		if closestEntity and closestDistance < _G.AuraRange then
			local closestHRP = closestEntity:FindFirstChild("HumanoidRootPart")
			if closestHRP then
				if not _G.AuraWallCheck or isLineOfSightClear(playerHRP.Position, closestHRP.Position) then
					local targetHead = closestEntity:FindFirstChild(_G.AuraLockPart)
					if targetHead then
						game:GetService("ReplicatedStorage").MeleeStorage.Events["Swing"]:InvokeServer(false)
						game:GetService("ReplicatedStorage").MeleeStorage.Events["Hit"]:FireServer(targetHead, targetHead.Position)
					end
				end
			end
		end
	end)
end)()
