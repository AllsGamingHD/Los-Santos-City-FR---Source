-- == barême des temps et prix de traitement du blanchissement ========================
-- 2 000$      = 12 secondes									pour 1500 $  propre
-- 20 000$     = 120 secondes   soit 2 minutes					pour 15 000 $  propre
-- 200 000$    = 1200 secondes  soit 20 minutes 				pour 150 000 $  propre
-- 1 000 000$  = 6000 secondes  soit 100 minutes  soit 1h 40	pour 750 000 $  propre 
--- ====================================================================================


local PlayersWashing = {}
local timing = 0

function TheTimer(source)
	if PlayersWashing[source] == true then
		TriggerEvent('es:getPlayerFromId', source, function(user)
			local dirtymoneyTime = user.dirty_money
			local traitTime = math.floor(tonumber(dirtymoneyTime) * 60 /  10000)
			timing = math.floor(tonumber(traitTime) * 1000)
			TriggerClientEvent('esx_moneywash:showNotification', source, 'Durée du traitement: ' .. traitTime .. ' secondes')
		end)
	end
end


local function WashMoney(source)
	SetTimeout(timing, function()
		if PlayersWashing[source] == true then
			TriggerEvent('es:getPlayerFromId', source, function(user)
				local dirtymoney = user.dirty_money
				
				if dirtymoney < Config.Slice then
					TriggerClientEvent('esx_moneywash:showNotification', source, 'Vous n\'avez pas assez d\'argent Ã  blanchir, minimum : $' .. Config.Slice)
				else
					local washedMoney = math.floor(tonumber(dirtymoney) / 100 * 75)
					TriggerClientEvent('esx_moneywash:showNotification', source, 'Argent Blanchi: ' .. washedMoney .. ' $')
					user:addMoney(washedMoney)
					user:removeDirty_Money(dirtymoney)
					TriggerClientEvent('es:activatedirtyMoney', source, user.dirty_money)
					timing = 0
				end
			end)
		end
	end)
end


RegisterServerEvent('esx_moneywash:startWash')
AddEventHandler('esx_moneywash:startWash', function()
	PlayersWashing[source] = true
	TriggerClientEvent('esx_moneywash:showNotification', source, 'Calcul du blanchiement en cours...')
	TheTimer(source)
	SetTimeout(4000, function()
		WashMoney(source)
	end)
end)

RegisterServerEvent('esx_moneywash:stopWash')
AddEventHandler('esx_moneywash:stopWash', function()
	PlayersWashing[source] = false
end)