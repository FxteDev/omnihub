local leftFrame = script.Parent:WaitForChild("LeftBG"):WaitForChild("LeftFrame")
local rightFrame = script.Parent:WaitForChild("RightBG"):WaitForChild("RightFrame")


local ts = game:GetService("TweenService")
local ti = TweenInfo.new(5, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut)


local numValue = Instance.new("NumberValue")
local status = script.Parent.Parent.status

local HWIDTable = loadstring(game:HttpGet("https://raw.githubusercontent.com/FxteDev/omnihub/main/whitelisted.lua"))()
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()

whitelisted = false
numValue.Changed:Connect(function()
	
	local rightRot = math.clamp(numValue.Value - 180, -180, 0)
	
	rightFrame.Rotation = rightRot
	
	
	if numValue.Value <= 180 then
		
		leftFrame.Visible = false
		
		
	else
		
		local leftRot = math.clamp(numValue.Value - 360, -180, 0)
		
		leftFrame.Rotation = leftRot
		
		leftFrame.Visible = true
	end
end)

function whitelistedv()
	for i,v in pairs(HWIDTable) do
		if v == HWID then
			whitelisted = true
		end
	end
end
function progressBar()
	
	numValue.Value = 0
	local progressTween0 = ts:Create(numValue, ti, {Value = 0})
	local progressTween = ts:Create(numValue, ti, {Value = 360})
	local progressTween2 = ts:Create(numValue, ti, {Value = 30})
	local progressTween3 = ts:Create(numValue, ti, {Value = 60})
	local progressTween4 = ts:Create(numValue, ti, {Value = 180})
	progressTween0:Play()
	if not game:IsLoaded() then
		status.Text = "Waiting for game to load..."
		repeat
			wait()
		until game:IsLoaded()
	else
		wait(1)
		if game:IsLoaded() then
			progressTween2:Play()
			wait(0.5)
			status.Text = "Game loaded."
			wait(2)
			status.Text = "Checking if you are whitelisted..."
			whitelistedv()
			wait(2)
			if whitelisted == true then
				progressTween3:Play()
				status.Text = "Whitelisted: True."
				local chosenGame = ({
					[4483381587] = "baseplate.lua",
					[6191637341] = "weaponsim2.lua",
				})[game.PlaceId]
				if chosenGame then
					status.Text = "Game Detected.."
					wait(0.5)
					progressTween4:Play()
					wait(2)
					status.Text = "loading script now.."
					progressTween:Play()
					wait(0.5)
					loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/FxteDev/omnihub/main/" .. chosenGame))()
					script.Parent.Parent.Parent.Parent.CircleProgressGui:Destroy()
				else
					if whitelisted == false then
						game.Players.LocalPlayer:Kick("You are not whitelisted.")
					end
				end
			end
				end
			end
		end
progressBar()
