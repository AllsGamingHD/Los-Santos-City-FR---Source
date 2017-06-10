--Private Messages
TriggerEvent('es:addCommand', 'mp', function(source, args, user)
if(GetPlayerName(tonumber(args[2])) or GetPlayerName(tonumber(args[3])))then
local player = tonumber(args[2])
table.remove(args, 2)
table.remove(args, 1)

TriggerEvent("es:getPlayerFromId", player, function(target)
			for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", player, {
					text = ""..GetPlayerName(source).. " vous à envoyez un message <br/><br/> son ID pour lui répondre est : " .. player .. "<br/><br/>Message : <br/><br/>" ..table.concat(args),
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "bottomRight"
				})
			end
			for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Vous avez envoyez un message à "..GetPlayerName(player).. "<br/><br/><center>Contenu du message : <center/><br/>" ..table.concat(args, " "),
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "bottomRight"
				})
			end
end)
else
for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "ID du joueur incorrect",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "bottomRight"
				})
			end
end
end, function(source, args, user)
for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Permissions insuffisante",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "bottomRight"
				})
			end
end)