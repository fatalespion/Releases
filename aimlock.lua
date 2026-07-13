local function FindNPCsFolder()
	for _,child in ipairs(workspace:GetChildren()) do
		if child:IsA("Model") then
			local npcs = child:FindFirstChild("NPCs")
			if npcs then
				return npcs
			end
		end
	end

	return nil
end

local FixUsername = function(String)
		local Result

		for _, Value in next, players:GetPlayers() do
			local Name = Value.Name

			if stringsub(stringlower(Name), 1, #String) == stringlower(String) then
				Result = Name
			end
		end

		return Result
	end

	local GetRainbowColor = function()
		local RainbowSpeed = Environment.DeveloperSettings.RainbowSpeed

		return Color3fromHSV(tick() % RainbowSpeed / RainbowSpeed, 1, 1)
	end

	local ConvertVector = function(Vector)
		return Vector2new(Vector.X, Vector.Y)
	end

	local CancelLock = function()
		Environment.Locked = nil

		local FOVCircle = Environment.FOVCircle--Degrade and Environment.FOVCircle or Environment.FOVCircle.__OBJECT

		setrenderproperty(FOVCircle, "Color", Environment.FOVSettings.Color)
		inputService.MouseDeltaSensitivity = OriginalSensitivity
	end

	local GetClosestPlayer = function()
		local Settings = Environment.Settings
		local LockPart = Settings.LockPart

		if not Environment.Locked then
			RequiredDistance = Environment.FOVSettings.Enabled and Environment.FOVSettings.Radius or 2000

			--// Players
			if Settings.PlayerTarget then
				for _, Value in next, players:GetPlayers() do
					local Character = Value.Character
					local Humanoid = Character and FindFirstChildOfClass(Character, "Humanoid")

					if Value ~= localPlayer
						and not tablefind(Environment.Blacklisted, Value.Name)
						and Character
						and FindFirstChild(Character, LockPart)
						and Humanoid then

						local PartPosition = Character[LockPart].Position
						local TeamCheckOption = Environment.DeveloperSettings.TeamCheckOption

						if Settings.TeamCheck and Value[TeamCheckOption] == localPlayer[TeamCheckOption] then
							continue
						end

						if Settings.AliveCheck and Humanoid.Health <= 0 then
							continue
						end

						if Settings.WallCheck then
							local BlacklistTable = GetDescendants(localPlayer.Character)

							for _, v in next, GetDescendants(Character) do
								BlacklistTable[#BlacklistTable + 1] = v
							end

							if #GetPartsObscuringTarget(workspace.CurrentCamera, {PartPosition}, BlacklistTable) > 0 then
								continue
							end
						end

						if Settings.FriendlyCheck and Value:IsFriendsWith(localPlayer.UserId) then
							continue
						end

						local Vector, OnScreen = WorldToViewportPoint(workspace.CurrentCamera, PartPosition)
						Vector = ConvertVector(Vector)

						local Distance = (GetMouseLocation(inputService) - Vector).Magnitude

						if Distance < RequiredDistance and OnScreen then
							RequiredDistance = Distance
							Environment.Locked = Value
						end
					end
				end
			end

			--// NPCs
			if Settings.NPCTarget then
				local NPCFolder = FindNPCsFolder()

				if NPCFolder then
					for _, NPC in next, NPCFolder.Parent:GetChildren() do
						local isNPC =
							NPC:FindFirstChild("ActiveScripts")
							and NPC.ActiveScripts:FindFirstChild("Server")
							and not NPC.ActiveScripts:FindFirstChild("Client")

						if not isNPC then
							continue
						end

						local Humanoid = FindFirstChildOfClass(NPC, "Humanoid")

						if Humanoid
							and FindFirstChild(NPC, LockPart)
							and (not Settings.AliveCheck or Humanoid.Health > 0) then

							local PartPosition = NPC[LockPart].Position

							if Settings.WallCheck then
								local BlacklistTable = GetDescendants(localPlayer.Character)

								for _, v in next, GetDescendants(NPC) do
									BlacklistTable[#BlacklistTable + 1] = v
								end

								if #GetPartsObscuringTarget(workspace.CurrentCamera, {PartPosition}, BlacklistTable) > 0 then
									continue
								end
							end

							local Vector, OnScreen = WorldToViewportPoint(workspace.CurrentCamera, PartPosition)
							Vector = ConvertVector(Vector)

							local Distance = (GetMouseLocation(inputService) - Vector).Magnitude

							if Distance < RequiredDistance and OnScreen then
								RequiredDistance = Distance
								Environment.Locked = {
									Character = NPC,
									IsNPC = true,
								}
							end
						end
					end
				end
			end

		else
			local Character = Environment.Locked.Character or Environment.Locked.Character

			if Character
				and FindFirstChild(Character, LockPart)
				and (GetMouseLocation(inputService) - ConvertVector(
					WorldToViewportPoint(workspace.CurrentCamera, Character[LockPart].Position)
				)).Magnitude > RequiredDistance then
				CancelLock()
			end
		end
	end

	local Load = function()
		OriginalSensitivity = inputService.MouseDeltaSensitivity

		local Settings, FOVCircle, FOVCircleOutline, FOVSettings, Offset = Environment.Settings, Environment.FOVCircle, Environment.FOVCircleOutline, Environment.FOVSettings

		LPH_NO_VIRTUALIZE(function()
			ServiceConnections.RenderSteppedConnection = runService.RenderStepped:Connect(function()
				local OffsetToMoveDirection, LockPart = Settings.OffsetToMoveDirection, Settings.LockPart

				if FOVSettings.Enabled and Settings.Enabled then
					for Index, Value in next, FOVSettings do
						if Index == "Color" then
							continue
						end

						if pcall(getrenderproperty, FOVCircle, Index) then
							setrenderproperty(FOVCircle, Index, Value)
							setrenderproperty(FOVCircleOutline, Index, Value)
						end
					end

					setrenderproperty(FOVCircle, "Color", FOVSettings.RainbowColor and GetRainbowColor() or FOVSettings.Color)
					setrenderproperty(FOVCircleOutline, "Color", FOVSettings.RainbowOutlineColor and GetRainbowColor() or FOVSettings.OutlineColor)

					setrenderproperty(FOVCircleOutline, "Thickness", FOVSettings.Thickness + 1)
					setrenderproperty(FOVCircle, "Position", GetMouseLocation(inputService))
					setrenderproperty(FOVCircleOutline, "Position", GetMouseLocation(inputService))
				else
					setrenderproperty(FOVCircle, "Visible", false)
					setrenderproperty(FOVCircleOutline, "Visible", false)
				end

				if Running and Settings.Enabled then
					GetClosestPlayer()

					Offset = OffsetToMoveDirection and Environment.Locked["Character"]:FindFirstChildOfClass("Humanoid").MoveDirection * (mathclamp(Settings.OffsetIncrement, 1, 30) / 10) or Vector3zero

					if Environment.Locked then
						local LockedPosition_Vector3 = Environment.Locked["Character"][LockPart].Position
						local LockedPosition = WorldToViewportPoint(workspace.CurrentCamera, LockedPosition_Vector3 + Offset)

						mousemoverel((LockedPosition.X - GetMouseLocation(inputService).X) / Settings.Sensitivity, (LockedPosition.Y - GetMouseLocation(inputService).Y) / Settings.Sensitivity)
					end
				end
			end)
		end)()

		ServiceConnections.InputBeganConnection = inputService.InputBegan:Connect(function(Input)
			local TriggerKey, Toggle = Settings.TriggerKey, Settings.Toggle

			if Typing then
				return
			end

			if Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode == TriggerKey or Input.UserInputType == TriggerKey then
				if Toggle then
					Running = not Running

					if not Running then
						CancelLock()
					end
				else
					Running = true
				end
			end
		end)

		ServiceConnections.InputEndedConnection = inputService.InputEnded:Connect(function(Input)
			local TriggerKey, Toggle = Settings.TriggerKey, Settings.Toggle

			if Toggle or Typing then
				return
			end

			if Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode == TriggerKey or Input.UserInputType == TriggerKey then
				if CancelLock then
					CancelLock()
					Running = false
				end
			end
		end)
	end

	--// Typing Check

	connections.TypingStartedConnection = inputService.TextBoxFocused:Connect(function()
		Typing = true
	end)

	connections.TypingStartedConnection = inputService.TextBoxFocusReleased:Connect(function()
		Typing = false
	end)

	--// Functions

	function Environment.Exit(self) -- METHOD | ExunysDeveloperAimbot:Exit(<void>)
		assert(self, "EXUNYS_AIMBOT-V3.Exit: Missing parameter #1 \"self\" <table>.")

		Load = nil; ConvertVector = nil; CancelLock = nil; GetClosestPlayer = nil; GetRainbowColor = nil; FixUsername = nil

		self.FOVCircle:Remove()
		self.FOVCircleOutline:Remove()
		getgenv().ExunysDeveloperAimbot = nil
	end

	function Environment.Restart() -- ExunysDeveloperAimbot.Restart(<void>)
		for Index, _ in next, ServiceConnections do
			Disconnect(ServiceConnections[Index])
		end

		Load()
	end

	function Environment.Blacklist(self, Username) -- METHOD | ExunysDeveloperAimbot:Blacklist(<string> Player Name)
		assert(self, "EXUNYS_AIMBOT-V3.Blacklist: Missing parameter #1 \"self\" <table>.")
		assert(Username, "EXUNYS_AIMBOT-V3.Blacklist: Missing parameter #2 \"Username\" <string>.")

		Username = FixUsername(Username)

		assert(self, "EXUNYS_AIMBOT-V3.Blacklist: User "..Username.." couldn't be found.")

		self.Blacklisted[#self.Blacklisted + 1] = Username
	end

	function Environment.Whitelist(self, Username) -- METHOD | ExunysDeveloperAimbot:Whitelist(<string> Player Name)
		assert(self, "EXUNYS_AIMBOT-V3.Whitelist: Missing parameter #1 \"self\" <table>.")
		assert(Username, "EXUNYS_AIMBOT-V3.Whitelist: Missing parameter #2 \"Username\" <string>.")

		Username = FixUsername(Username)

		assert(Username, "EXUNYS_AIMBOT-V3.Whitelist: User "..Username.." couldn't be found.")

		local Index = tablefind(self.Blacklisted, Username)

		assert(Index, "EXUNYS_AIMBOT-V3.Whitelist: User "..Username.." is not blacklisted.")

		tableremove(self.Blacklisted, Index)
	end

	function Environment.GetClosestPlayer()
		GetClosestPlayer()
		local Value = Environment.Locked
		CancelLock()

		return Value
	end

	setmetatable(Environment, {__call = Load})
