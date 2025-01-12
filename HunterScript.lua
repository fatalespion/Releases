local function OperatorCheck(CurrentGear)
	if CurrentGear:FindFirstChild("Operator Vest") and CurrentGear:FindFirstChild("Operator Leggings") and (CurrentGear:FindFirstChild("Operator Helmet") or CurrentGear:FindFirstChild("Operator Helmet MK2")) then
		return true
	else
		return false
	end
end

local function CommanderCheck(CurrentGear)
	if CurrentGear:FindFirstChild("Commander Helmet") and CurrentGear:FindFirstChild("Commander Leggings") and CurrentGear:FindFirstChild("Commander Vest") then
		return true
	else
		return false
	end
end

local function BladedancerCheck(CurrentGear)
	if CurrentGear:FindFirstChild("Bladedancer Helmet") and CurrentGear:FindFirstChild("Bladedancer Leggings") and CurrentGear:FindFirstChild("Bladedancer Vest") then
		return true
	else
		return false
	end
end

local function LeaveCheck(plr, type)
	game.Players.PlayerRemoving:Connect(function(ply)
		if ply == plr then
			game:GetService("StarterGui"):SetCore("SendNotification",{
				Title = "[KIT FINDER]",
				Text = ply.Name.." has left he was a ["..type.."]",
				Icon = "6264845452"
			})
		end
	end)
end

local function GetBounty(plr)
	return tostring(plr:GetAttribute("Bounty")).."$"
end

local Found = 0

if game.GameId == 3326279937 then
	print("CorrectGameID")

	for _, Chars in pairs(workspace.Chars:GetChildren()) do
		if Chars:FindFirstChild("CurrentGear") then
			local CurrentGear = Chars:FindFirstChild("CurrentGear")
			local Player = game.Players:GetPlayerFromCharacter(Chars)

			if OperatorCheck(CurrentGear) then
				warn(Chars.Name.." Is an [OPERATOR] level: "..tostring(Player:GetAttribute("Level")).." and Bounty: "..GetBounty())
				Found += 1
				LeaveCheck(Player, "OPERATOR")
			elseif CommanderCheck(CurrentGear) then
				warn(Chars.Name.." Is an [COMMANDER] level: "..tostring(Player:GetAttribute("Level")).." and Bounty: "..GetBounty())
				Found += 1
				LeaveCheck(Player, "COMMANDER")
			elseif BladedancerCheck(CurrentGear) then
				warn(Chars.Name.." Is an [BLADEDANCER] level: "..tostring(Player:GetAttribute("Level")).." and Bounty: "..GetBounty())
				Found += 1
				LeaveCheck(Player, "BLADEDANCER")
			end
		end
	end

	if Found == 0 then
		warn("[FINDER]: No {OPERATORS/COMMANDER/BLADEDANCER} FOUND")
	end
end
