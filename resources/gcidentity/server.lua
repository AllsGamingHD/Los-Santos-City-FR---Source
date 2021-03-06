--====================================================================================
-- #Author: Jonathan D @ Gannon
-- 
-- Développée pour la communauté n3mtv
--      https://www.twitch.tv/n3mtv
--      https://twitter.com/n3m_tv
--      https://www.facebook.com/lan3mtv
--====================================================================================

-- Configuration BDD
require "resources/essentialmode/lib/MySQL"
MySQL:open("127.0.0.1", "gta5_gamemode_essential", "root", "1202")

--====================================================================================
--  Teste si un joueurs a donnée ces infomation identitaire
--====================================================================================
function hasIdentity(source)
    local identifier = GetPlayerIdentifiers(source)[1]
    -- local _hasIdentity = function (identifier)
        local executed_query, result = MySQL:executeQuery("select nom, prenom from users where identifier = '@identifier'", {
            ['@identifier'] = identifier
        })
        local result = MySQL:getResults(executed_query, {"nom", "prenom"})
        local user = result[1]
        return not (user['nom'] == '' or user['prenom'] == '')
    -- end
    -- return pcall(_hasIdentity, identifier)  
end

function getIdentity(source)
    local identifier = GetPlayerIdentifiers(source)[1]
    local executed_query, result = MySQL:executeQuery("select users.* , jobs.job_name as jobs  from users join jobs WHERE users.job = jobs.job_id and users.identifier = '@identifier'", {
        ['@identifier'] = identifier
    })
    local result = MySQL:getResults(executed_query, {"nom", "prenom", "dateNaissance", "sexe", "taille", "jobs"})
    if #result == 1 then
        return result[1]
    else
        return {}
    end
end

function setIdentity(identifier, data)
    MySQL:executeQuery("UPDATE users SET nom = '@nom', prenom = '@prenom', dateNaissance = '@dateNaissance', sexe = '@sexe', taille = '@taille' WHERE identifier = '@identifier'", {
        ['@nom'] = data.nom,
        ['@prenom'] = data.prenom,
        ['@dateNaissance'] = data.dateNaissance,
        ['@sexe'] = data.sexe,
        ['@taille'] = data.taille,
        ['@identifier'] = identifier
    })
			for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", -1, {
					text = "Bienvenue est bon jeu à toi.",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end
				for i = 0 , 0 do 
				TriggerClientEvent("pNotify:SendNotification", -1, {
					text = "Rendez-vous au hangar de location juste en face! vous pourrais y recupérer un véhicule de location gratuitement!",
					type = "info",
					queue = "right",
					timeout = 10000,
					layout = "topCenter"
				})
			end
end

AddEventHandler('es:playerLoaded', function(source)
    local result = hasIdentity(source)
    if result == false then
        TriggerClientEvent('gc:showRegisterItentity', source, {})
    end
end)

RegisterServerEvent('gc:openIdentity')
AddEventHandler('gc:openIdentity',function(other)
    local data = getIdentity(other)
    if data ~= nil then 
        TriggerClientEvent('gc:showItentity', source, {
            nom = data.nom,
            prenom = data.prenom,
            sexe = data.sexe,
            dateNaissance = tostring(data.dateNaissance),
            jobs = data.jobs,
            taille = data.taille
        })
    end
    ---- ... Date conversion error
    -- TriggerClientEvent('gc:showItentity', source, data)
end)

RegisterServerEvent('gc:openMeIdentity')
AddEventHandler('gc:openMeIdentity',function()
    local data = getIdentity(source)
    if data ~= nil then 
        TriggerClientEvent('gc:showItentity', source, {
            nom = data.nom,
            prenom = data.prenom,
            sexe = data.sexe,
            dateNaissance = tostring(data.dateNaissance),
            jobs = data.jobs,
            taille = data.taille
        })
    end
end)

RegisterServerEvent('gc:setIdentity')
AddEventHandler('gc:setIdentity', function(data)
    setIdentity(GetPlayerIdentifiers(source)[1], data)
end)