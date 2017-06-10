require "resources/essentialmode/lib/MySQL"
MySQL:open("127.0.0.1", "gta5_gamemode_essential", "root", "1202")

-- HELPER FUNCTIONS
function bankBalance(player)
  local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE identifier = '@name'", {['@name'] = player})
  local result = MySQL:getResults(executed_query, {'bankbalance'}, "identifier")
  return tonumber(result[1].bankbalance)
end

function deposit(player, amount)
  local bankbalance = bankBalance(player)
  local new_balance = bankbalance + amount
  MySQL:executeQuery("UPDATE users SET `bankbalance`='@value' WHERE identifier = '@identifier'", {['@value'] = new_balance, ['@identifier'] = player})
end

function withdraw(player, amount)
  local bankbalance = bankBalance(player)
  local new_balance = bankbalance - amount
  MySQL:executeQuery("UPDATE users SET `bankbalance`='@value' WHERE identifier = '@identifier'", {['@value'] = new_balance, ['@identifier'] = player})
end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.abs(math.floor(num * mult + 0.5) / mult)
end

-- Check Bank Balance
TriggerEvent('es:addCommand', 'checkbalance', function(source, args, user)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local bankbalance = bankBalance(player)
	for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", -1, {
					text = "Votre solde de compte actuelle : ".. bankbalance,
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end
    TriggerClientEvent("banking:updateBalance", source, bankbalance)
    CancelEvent()
  end)
end)

-- Bank Deposit
TriggerEvent('es:addCommand', 'deposit', function(source, args, user)
  local amount = ""
  local player = user.identifier
  for i=1,#args do
    amount = args[i]
  end
  TriggerClientEvent('bank:deposit', source, amount)
end)

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
  TriggerEvent('es:getPlayerFromId', source, function(user)
      local rounded = round(tonumber(amount), 0)
      if(string.len(rounded) >= 9) then
	  for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Montant trop élevée",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end
        CancelEvent()
      else
      	if(tonumber(rounded) <= tonumber(user:money)) then
          user:removeMoney((rounded))
          local player = user.identifier
          deposit(player, rounded)
          local new_balance = bankBalance(player)
		  for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Vous avez déposer: ".. rounded .."<br />Nouveau solde : ".. new_balance,
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end
          TriggerClientEvent("banking:updateBalance", source, new_balance)
          TriggerClientEvent("banking:addBalance", source, rounded)
          CancelEvent()
        else
          TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Not enough cash!^0")
          CancelEvent()
        end
      end
  end)
end)

-- Bank Withdraw
TriggerEvent('es:addCommand', 'withdraw', function(source, args, user)
  local amount = ""
  local player = user.identifier
  for i=1,#args do
    amount = args[i]
  end
  TriggerClientEvent('bank:withdraw', source, amount)
end)

RegisterServerEvent('bank:withdrawAmende')
AddEventHandler('bank:withdrawAmende', function(amount)
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local player = user.identifier
        local bankbalance = bankBalance(player)
		withdraw(player, amount)
		local new_balance = bankBalance(player)
		for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Nouveau solde: " .. new_balance,
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end
		TriggerClientEvent("banking:updateBalance", source, new_balance)
		TriggerClientEvent("banking:removeBalance", source, amount)
		CancelEvent()
    end)
end)

RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
  TriggerEvent('es:getPlayerFromId', source, function(user)
      local rounded = round(tonumber(amount), 0)
      if(string.len(rounded) >= 9) then
	  for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Montant trop élevée",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end
			CancelEvent()
      else
        local player = user.identifier
        local bankbalance = bankBalance(player)
        if(tonumber(rounded) <= tonumber(bankbalance)) then
          withdraw(player, rounded)
          user:addMoney((rounded))
          local new_balance = bankBalance(player)
		  for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Argent retiré: ".. rounded .."<br />Nouveau solde : " .. new_balance,
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end
          TriggerClientEvent("banking:updateBalance", source, new_balance)
          TriggerClientEvent("banking:removeBalance", source, rounded)
          CancelEvent()
        else
		for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Pas assez d'argent sur le compte",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end
          CancelEvent()
        end
      end
  end)
end)

-- Bank Transfer
TriggerEvent('es:addCommand', 'transfer', function(source, args, user)
  local fromPlayer
  local toPlayer
  local amount
  if (args[2] ~= nil and tonumber(args[3]) > 0) then
    fromPlayer = tonumber(source)
    toPlayer = tonumber(args[2])
    amount = tonumber(args[3])
    TriggerClientEvent('bank:transfer', source, fromPlayer, toPlayer, amount)
	else
	for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Utilisez le format /transfer [id] [montant]",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end
    return false
  end
end)

RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(fromPlayer, toPlayer, amount)
  if tonumber(fromPlayer) == tonumber(toPlayer) then
  for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Impossible de transférer vers sois-même",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end
    CancelEvent()
  else
    TriggerEvent('es:getPlayerFromId', fromPlayer, function(user)
        local rounded = round(tonumber(amount), 0)
        if(string.len(rounded) >= 9) then
		for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Montant trop élevée",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end
          CancelEvent()
        else
          local player = user.identifier
          local bankbalance = bankBalance(player)
          if(tonumber(rounded) <= tonumber(bankbalance)) then
            withdraw(player, rounded)
            local new_balance = bankBalance(player)
			for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Vous avez transferer : ".. rounded .."<br /> Nouveau solde : " .. new_balance,
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end
            TriggerClientEvent("banking:updateBalance", source, new_balance)
            TriggerClientEvent("banking:removeBalance", source, rounded)
            TriggerEvent('es:getPlayerFromId', toPlayer, function(user2)
                local recipient = user2.identifier
                deposit(recipient, rounded)
                new_balance2 = bankBalance(recipient)
							for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", toPlayer, {
					text = "Vous avez reçu : ".. rounded .."<br /> Nouveau solde : " .. new_balance2,
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end
                TriggerClientEvent("banking:updateBalance", toPlayer, new_balance2)
                TriggerClientEvent("banking:addBalance", toPlayer, rounded)
                CancelEvent()
            end)
            CancelEvent()
          else
		  for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Pas assez d'argents sur le compte!",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end
            CancelEvent()
          end
        end
    end)
  end
end)

-- Give Cash
TriggerEvent('es:addCommand', 'givecash', function(source, args, user)
  local fromPlayer
  local toPlayer
  local amount
  if (args[2] ~= nil and tonumber(args[3]) > 0) then
    fromPlayer = tonumber(source)
    toPlayer = tonumber(args[2])
    amount = tonumber(args[3])
    TriggerClientEvent('bank:givecash', source, toPlayer, amount)
	else
	for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Utilisez le format /givecash [id] [montant]",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end
    return false
  end
end)

RegisterServerEvent('bank:givecash')
AddEventHandler('bank:givecash', function(toPlayer, amount)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (tonumber(user.money) >= tonumber(amount)) then
			local player = user.identifier
			user:removeMoney(amount)
			TriggerEvent('es:getPlayerFromId', toPlayer, function(recipient)
				recipient:addMoney(amount)
				for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Argents envoyé : ".. amount .."<br />Nouveau solde : " .. user.money,
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end
			for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", toPlayer, {
					text = "Argents reçu : ".. amount .."<br />Nouveau solde : " .. recipient.money,
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end
			end)
		else
			if (tonumber(user.money) < tonumber(amount)) then
			for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Vous essayez de donner plus que vous avez!",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end       
			CancelEvent()
			end
		end
	end)
end)

-- Give Cash
TriggerEvent('es:addCommand', 'givedirty', function(source, args, user)
  local fromPlayer
  local toPlayer
  local amount
  if (args[2] ~= nil and tonumber(args[3]) > 0) then
    fromPlayer = tonumber(source)
    toPlayer = tonumber(args[2])
    amount = tonumber(args[3])
    TriggerClientEvent('bank:givedirty', source, toPlayer, amount)
	else
    TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Use format /givedirty [id] [amount]^0")
    return false
  end
end)

RegisterServerEvent('bank:givedirty')
AddEventHandler('bank:givedirty', function(toPlayer, amount)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (tonumber(user.dirty_money) >= tonumber(amount)) then
			local player = user.identifier
			user:removeDirty_Money(amount)
			TriggerEvent('es:getPlayerFromId', toPlayer, function(recipient)
				recipient:addDirty_Money(amount)
				for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Argents sales envoyé : ".. amount .."<br />Nouveau solde : " .. user.dirty_money,
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end
			for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", toPlayer, {
					text = "Argents sales reçu : ".. amount .."<br />Nouveau solde : " .. recipient.dirty_money,
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end
			end)
		else
			if (tonumber(user.dirty_money) < tonumber(amount)) then
			for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Vous essayez de donner plus que vous avez!",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end
        CancelEvent()
			end
		end
	end)
end)

AddEventHandler('es:playerLoaded', function(source)
  TriggerEvent('es:getPlayerFromId', source, function(user)
      local player = user.identifier
      local bankbalance = bankBalance(player)
      TriggerClientEvent("banking:updateBalance", source, bankbalance)
    end)
end)
