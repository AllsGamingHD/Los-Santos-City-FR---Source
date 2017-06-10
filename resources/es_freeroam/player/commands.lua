TriggerEvent("es:addGroup", "admin", "user", function(group) end)

--Help Commands
TriggerEvent('es:addCommand', 'help', function(source, args, user)
	for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", -1, {
					text = "Commandes du joueurs<br/><br/>-----------------------------------------------------------<br/><br/>Utilisez la touche H pour afficher votre menu personnel.<br/><br/>Utilisez la touche B a à cotez d'un autre joueurs pour accèder au menu d'intéraction (Donner argents etc...).<br/><br/>Utilisez la touche K pour ouvrir votre inventaire.<br/><br/>Utilisez la touche F5 en tant que policer pour ouvrir le menu pour les forces de l'ordres.<br/><br/>Utilisez la touche K pour ouvrir votre inventaire.",
					type = "info",
					queue = "right",
					timeout = 20000,
					layout = "topCenter"
				})
			end
  --TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "Player Commands ")
	--TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "-------------------------------------------------------")
	--TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "/pv - pour récupérer son véhicule personnel du début.")
	--TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "Utilisez la touche H pour afficher votre menu personnel.")
	--TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "Utilisez la touche B a à cotez d'un autre joueurs pour accèder au menu d'intéraction (Donner argents etc...).")
	--TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "Utilisez la touche K pour ouvrir votre inventaire.")
	--TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "Utilisez la touche F5 en tant que policer pour ouvrir le menu pour les forces de l'ordres.")
	--TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "Utilisez la touche K pour ouvrir votre inventaire.")
end)

TriggerEvent('es:addCommand', 'group', function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Group: ^2" .. user.group.group)
end)

-- Kicking
TriggerEvent('es:addGroupCommand', 'kick', "admin", function(source, args, user)
		if(GetPlayerName(tonumber(args[2])))then
			local player = tonumber(args[2])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)
				if(tonumber(target.permission_level) > tonumber(user.permission_level))then
					TriggerClientEvent("chatMessage", source, "SYSTEM", {255, 0, 0}, "You're not allowed to target this person!")
					return
				end

				local reason = args
				table.remove(reason, 1)
				table.remove(reason, 1)
				if(#reason == 0)then
					reason = "Kicked: You have been kicked from the server"
				else
					reason = "Kicked: " .. table.concat(reason, " ")
				end

				TriggerClientEvent('chatMessage', -1, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 has been kicked(^2" .. reason .. "^0)")
				DropPlayer(player, reason)
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
		end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end)
