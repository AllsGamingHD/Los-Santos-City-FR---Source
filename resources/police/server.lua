require "resources/essentialmode/lib/MySQL"
MySQL:open("localhost", "gta5_gamemode_essential", "root", "1202")

local inServiceCops = {}

function addCop(identifier)
	MySQL:executeQuery("INSERT INTO police (`identifier`) VALUES ('@identifier')", { ['@identifier'] = identifier})
end

function remCop(identifier)
	MySQL:executeQuery("DELETE FROM police WHERE identifier = '@identifier'", { ['@identifier'] = identifier})
end

function checkIsCop(identifier)
	local query = MySQL:executeQuery("SELECT * FROM police WHERE identifier = '@identifier'", { ['@identifier'] = identifier})
	local result = MySQL:getResults(query, {'rank'}, "identifier")
	
	if(not result[1]) then
		TriggerClientEvent('police:receiveIsCop', source, "inconnu")
	else
		TriggerClientEvent('police:receiveIsCop', source, result[1].rank)
	end
end

function s_checkIsCop(identifier)
	local query = MySQL:executeQuery("SELECT * FROM police WHERE identifier = '@identifier'", { ['@identifier'] = identifier})
	local result = MySQL:getResults(query, {'rank'}, "identifier")
	
	if(not result[1]) then
		return "nil"
	else
		return result[1].rank
	end
end

function checkInventory(target)
	local strResult = GetPlayerName(target).." own : "
	local identifier = ""
    TriggerEvent("es:getPlayerFromId", target, function(player)
		identifier = player.identifier
		local executed_query = MySQL:executeQuery("SELECT * FROM `user_inventory` JOIN items ON items.id = user_inventory.item_id WHERE user_id = '@username'", { ['@username'] = identifier })
		local result = MySQL:getResults(executed_query, { 'quantity', 'libelle', 'item_id', 'isIllegal' }, "item_id")
		if (result) then
			for _, v in ipairs(result) do
				if(v.quantity ~= 0) then
					strResult = strResult .. v.quantity .. " de " .. v.libelle .. ", "
				end
				if(v.isIllegal == "True") then
					TriggerClientEvent('police:dropIllegalItem', target, v.item_id)
				end
			end
		end
		
		strResult = strResult .. " / "
		
		local executed_query = MySQL:executeQuery("SELECT * FROM user_weapons WHERE identifier = '@username'", { ['@username'] = identifier })
		local result = MySQL:getResults(executed_query, { 'weapon_model' }, 'identifier' )
		if (result) then
			for _, v in ipairs(result) do
					strResult = strResult .. "possession de " .. v.weapon_model .. ", "
			end
		end
	end)
	
    return strResult
end

AddEventHandler('playerDropped', function()
	if(inServiceCops[source]) then
		inServiceCops[source] = nil
		
		for i, c in pairs(inServiceCops) do
			TriggerClientEvent("police:resultAllCopsInService", i, inServiceCops)
		end
	end
end)

AddEventHandler('es:playerDropped', function(player)
		local isCop = s_checkIsCop(player.identifier)
		if(isCop ~= "nil") then
			TriggerEvent("jobssystem:disconnectReset", player, 7)
		end
end)

RegisterServerEvent('police:checkIsCop')
AddEventHandler('police:checkIsCop', function()
	TriggerEvent("es:getPlayerFromId", source, function(user)
		local identifier = user.identifier
		checkIsCop(identifier)
	end)
end)

RegisterServerEvent('police:takeService')
AddEventHandler('police:takeService', function()

	if(not inServiceCops[source]) then
		inServiceCops[source] = GetPlayerName(source)
		
		for i, c in pairs(inServiceCops) do
			TriggerClientEvent("police:resultAllCopsInService", i, inServiceCops)
		end
	end
end)

RegisterServerEvent('police:breakService')
AddEventHandler('police:breakService', function()

	if(inServiceCops[source]) then
		inServiceCops[source] = nil
		
		for i, c in pairs(inServiceCops) do
			TriggerClientEvent("police:resultAllCopsInService", i, inServiceCops)
		end
	end
end)

RegisterServerEvent('police:getAllCopsInService')
AddEventHandler('police:getAllCopsInService', function()
	TriggerClientEvent("police:resultAllCopsInService", source, inServiceCops)
end)

RegisterServerEvent('police:checkingPlate')
AddEventHandler('police:checkingPlate', function(plate)
	local executed_query = MySQL:executeQuery("SELECT Nom FROM user_vehicle JOIN users ON user_vehicle.identifier = users.identifier WHERE vehicle_plate = '@plate'", { ['@plate'] = plate })
	local result = MySQL:getResults(executed_query, { 'Nom' }, "identifier")
	if (result[1]) then
		for _, v in ipairs(result) do
		for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Le véhicule #"..plate.." appartient à " .. v.Nom,
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "bottomRight"
				})
			end
		end
	else
	for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Le véhicule #"..plate.." n'est pas enregistrée",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "bottomRight"
				})
			end
	end
end)

RegisterServerEvent('police:confirmUnseat')
AddEventHandler('police:confirmUnseat', function(t)
			for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = GetPlayerName(t).. " est sortie du véhicule !",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "bottomRight"
				})
			end
	TriggerClientEvent('police:unseatme', t)
end)

RegisterServerEvent('police:targetCheckInventory')
AddEventHandler('police:targetCheckInventory', function(t)
			for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = checkInventory(t),
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "bottomRight"
				})
			end
end)

RegisterServerEvent('police:finesGranted')
AddEventHandler('police:finesGranted', function(t, amount)
			for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = GetPlayerName(t).. " à payer une amande de " ..amount.."€",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "bottomRight"
				})
			end
	TriggerClientEvent('police:payFines', t, amount)
end)

RegisterServerEvent('police:cuffGranted')
AddEventHandler('police:cuffGranted', function(t)
			for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = GetPlayerName(t).. " est menotter",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "bottomRight"
				})
			end
	TriggerClientEvent('police:getArrested', t)
end)

RegisterServerEvent('police:forceEnterAsk')
AddEventHandler('police:forceEnterAsk', function(t, v)
			for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = GetPlayerName(t).. " est dans le véhicule",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "bottomRight"
				})
			end
	TriggerClientEvent('police:forcedEnteringVeh', t, v)
end)

-----------------------------------------------------------------------
----------------------EVENT SPAWN POLICE VEH---------------------------
-----------------------------------------------------------------------
RegisterServerEvent('CheckPoliceVeh')
AddEventHandler('CheckPoliceVeh', function(vehicle)
	TriggerEvent('es:getPlayerFromId', source, function(user)

			TriggerClientEvent('FinishPoliceCheckForVeh',source)
			-- Spawn police vehicle
			TriggerClientEvent('policeveh:spawnVehicle', source, vehicle)
	end)
end)

-----------------------------------------------------------------------
---------------------COMMANDE ADMIN AJOUT / SUPP COP-------------------
-----------------------------------------------------------------------
TriggerEvent('es:addGroupCommand', 'copadd', "admin", function(source, args, user)
     if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Usage : /copadd [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				addCop(target.identifier)
				for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Fêtons sa!",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "bottomRight"
				})
			end
			for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", player, {
					text = "Félicitations vous êtes maintenant un policer !",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "bottomRight"
				})
			end
				TriggerClientEvent('police:nowCop', player)
			end)
		else
		for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Aucun joueur as cette ID!",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "bottomRight"
				})
			end
		end
	end
end, function(source, args, user) 
for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Tu as pas les permissions :D",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "bottomRight"
				})
			end
end)

TriggerEvent('es:addGroupCommand', 'coprem', "admin", function(source, args, user) 
     if(not args[2]) then
	 for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Utilisation : /coprem [ID]",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "bottomRight"
				})
			end
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				remCop(target.identifier)
				for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Vous n'êtes plus policer!",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "bottomRight"
				})
			end
			for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = GetPlayerName(t).. "A quitter son service est ne fait plus parti de la police.",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "bottomRight"
				})
			end
				TriggerClientEvent('police:noLongerCop', player)
			end)
		else
		for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Aucun joueur as cette ID",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "bottomRight"
				})
			end
		end
	end
end, function(source, args, user) 
for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Tu n'a pas les permissions",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "bottomRight"
				})
			end
end)