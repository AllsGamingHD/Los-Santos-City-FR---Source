require "resources/essentialmode/lib/MySQL"
MySQL:open("localhost", "gta5_gamemode_essential", "root", "1202")

---------------------------------- FUNCTION ---------------------------------

-- FR -- Fonction : Récupère le travail du joueur
-- FR -- Paramètre(s) : player = ID du joueur
---------------------------------------------------------
-- EN -- Function : Get Job User
-- EN -- Param(s) : player = ID Player
function whereIsJob(player)
  local executed_query = MySQL:executeQuery("SELECT job FROM users WHERE identifier = '@identifier'", {['@identifier'] = player})
  local result = MySQL:getResults(executed_query, {'job'}, "job")
  return result[1].job
end

---------------------------------- EVENEMENT ---------------------------------

-- FR -- Evenement : Récupère le travail du joueur
-- FR -- Paramètre(s) : info = Résultat de la requête (Job)
---------------------------------------------------------
-- EN -- Evenement : Get Job User
-- EN -- Param(s) : info = Request result (Job)
RegisterServerEvent('menuint:getInfos')
AddEventHandler('menuint:getInfos', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
        -- jobuser = user.job
        whereIsJob(user.identifier)
        TriggerClientEvent("int:getInfos", source, jobuser)
  end)
end)

