-- Server Script in ServerScriptService
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ChatService = game:GetService("Chat")

-- Replace with your Discord webhook URL
local webhookUrl = "YOUR_DISCORD_WEBHOOK_URL"

-- Function to send the chat message to Discord
local function sendToDiscord(username, message)
	-- Prepare the data to send to Discord
	local data = {
		["content"] = "**" .. username .. "** said: " .. message
	}

	-- Convert the Lua table to JSON
	local jsonData = HttpService:JSONEncode(data)

	-- Send the HTTP POST request
	HttpService:PostAsync(
		webhookUrl,
		jsonData,
		Enum.HttpContentType.ApplicationJson
	)
end

-- Listen for when a player sends a message in chat
Players.PlayerAdded:Connect(function(player)
	-- Hook into the player's chat
	player.Chatted:Connect(function(message)
		sendToDiscord(player.Name, message)
	end)
end)
