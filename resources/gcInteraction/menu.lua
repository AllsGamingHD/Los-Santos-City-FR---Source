--====================================================================================
-- #Author: Jonathan D @ Gannon
-- 
-- Développée pour la communauté n3mtv
--      https://www.twitch.tv/n3mtv
--      https://twitter.com/n3m_tv
--      https://www.facebook.com/lan3mtv
--====================================================================================


-- FR -- Fonction : Affiche une boite de dialogue, puis renvoie la valeur à l'evenement
-- FR -- Paramètre(s) : Aucun
---------------------------------------------------------
-- EN -- Function : Displays a dialog box, then returns the value to the event
-- EN -- Param(s) : None
function DemandeText()
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        TriggerServerEvent("bank:givecash", joueur_proche, tonumber(result))
    end
end

-- FR -- Fonction : Affiche une boite de dialogue, puis renvoie la valeur à l'evenement
-- FR -- Paramètre(s) : Aucun
---------------------------------------------------------
-- EN -- Function : Displays a dialog box, then returns the value to the event
-- EN -- Param(s) : None
function DemandeTextSale()
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result4 = GetOnscreenKeyboardResult()
        TriggerServerEvent("bank:givedirty", joueur_proche, tonumber(result4))
    end
end
function Amende()
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result3 = GetOnscreenKeyboardResult()
        TriggerServerEvent("ap:amende", joueur_proche, result3)
    end
end

--====================================================================================
--  Build Menu
--====================================================================================
Menu = {}
Menu.item = {
    ['Title'] = 'Interactions',
    ['Items'] = {
        {['Title'] = 'Personnel', ['SubMenu'] = {
            ['Title'] = 'Menu',
                ['Items'] = {
                    { ['Title'] = 'Regarder sa carte d\'identité', ['Event'] = 'gcl:openMeIdentity'},
                }
            }
        },
        {['Title'] = 'Police', ['SubMenu'] = {
            ['Title'] = 'Menu Police',
                ['Items'] = {
                    { ['Title'] = 'Regarde carte d\'identité', ['Event'] = 'gcl:showItentity'},
                    { ['Title'] = 'Fouille', ['Event'] = 'police:fouille'},
                    { ['Title'] = 'Menotté', ['Event'] = 'police:cuff'},
                    { ['Title'] = 'Force enter', ['Event'] = 'police:forceEnter'},
                }
            }
        }
    }
}
--====================================================================================
--  Option Menu
--====================================================================================
Menu.backgroundColor = { 52, 73, 94, 196 }
Menu.backgroundColorActive = { 243, 156, 18, 255 }
Menu.tileTextColor = { 243, 156, 18, 255 }
Menu.tileBackgroundColor = { 255,255,255, 255 }
Menu.textColor = { 255,255,255,255 }
Menu.textColorActive = { 255,255,255, 255 }

Menu.keyOpenMenu = 170 -- F3    
Menu.keyUp = 172 -- PhoneUp
Menu.keyDown = 173 -- PhoneDown
Menu.keyLeft = 174 -- PhoneLeft || Not use next release Maybe 
Menu.keyRight =	175 -- PhoneRigth || Not use next release Maybe 
Menu.keySelect = 176 -- PhoneSelect
Menu.KeyCancel = 177 -- PhoneCancel

Menu.posX = 0.05
Menu.posY = 0.05

Menu.ItemWidth = 0.20
Menu.ItemHeight = 0.03

Menu.isOpen = false   -- /!\ Ne pas toucher
Menu.currentPos = {1} -- /!\ Ne pas toucher

--====================================================================================
--  Menu System
--====================================================================================

function Menu.drawRect(posX, posY, width, heigh, color)
    DrawRect(posX + width / 2, posY + heigh / 2, width, heigh, color[1], color[2], color[3], color[4])
end

function Menu.initText(textColor, font, scale)
    font = font or 0
    scale = scale or 0.35
    SetTextFont(font)
    SetTextScale(0.0,scale)
    SetTextCentre(true)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextColour(textColor[1], textColor[2], textColor[3], textColor[4])
    SetTextEntry("STRING")
end

function Menu.draw() 
    -- Draw Rect
    local pos = 0
    local menu = Menu.getCurrentMenu()
    local selectValue = Menu.currentPos[#Menu.currentPos]
    local nbItem = #menu.Items
    -- draw background title & title
    Menu.drawRect(Menu.posX, Menu.posY , Menu.ItemWidth, Menu.ItemHeight * 2, Menu.tileBackgroundColor)    
    Menu.initText(Menu.tileTextColor, 4, 0.7)
    AddTextComponentString(menu.Title)
    DrawText(Menu.posX + Menu.ItemWidth/2, Menu.posY)

    -- draw bakcground items
    Menu.drawRect(Menu.posX, Menu.posY + Menu.ItemHeight * 2, Menu.ItemWidth, Menu.ItemHeight + (nbItem-1)*Menu.ItemHeight, Menu.backgroundColor)
    -- draw all items
    for pos, value in pairs(menu.Items) do
        if pos == selectValue then
            Menu.drawRect(Menu.posX, Menu.posY + Menu.ItemHeight * (1+pos), Menu.ItemWidth, Menu.ItemHeight, Menu.backgroundColorActive)
            Menu.initText(Menu.textColorActive)
        else
            Menu.initText(Menu.textColor)
        end
        AddTextComponentString(value.Title)
        DrawText(Menu.posX + Menu.ItemWidth/2, Menu.posY + Menu.ItemHeight * (pos+1))
    end
    
end

function Menu.getCurrentMenu()
    local currentMenu = Menu.item
    for i=1, #Menu.currentPos - 1 do
        local val = Menu.currentPos[i]
        currentMenu = currentMenu.Items[val].SubMenu
    end
    return currentMenu
end

function Menu.initMenu()
    Menu.currentPos = {1}
end

function Menu.keyControl()
    if IsControlJustPressed(1, Menu.keyDown) then 
        local cMenu = Menu.getCurrentMenu()
        local size = #cMenu.Items
        local slcp = #Menu.currentPos
        Menu.currentPos[slcp] = (Menu.currentPos[slcp] % size) + 1

    elseif IsControlJustPressed(1, Menu.keyUp) then 
        local cMenu = Menu.getCurrentMenu()
        local size = #cMenu.Items
        local slcp = #Menu.currentPos
        Menu.currentPos[slcp] = ((Menu.currentPos[slcp] - 2 + size) % size) + 1

    elseif IsControlJustPressed(1, Menu.KeyCancel) then 
        table.remove(Menu.currentPos)
        if #Menu.currentPos == 0 then
            Menu.isOpen = false 
        end

    elseif IsControlJustPressed(1, Menu.keySelect)  then
        local cSelect = Menu.currentPos[#Menu.currentPos]
        local cMenu = Menu.getCurrentMenu()
        if cMenu.Items[cSelect].SubMenu ~= nil then
            Menu.currentPos[#Menu.currentPos + 1] = 1
        else
            if cMenu.Items[cSelect].Function ~= nil then
                cMenu.Items[cSelect].Function(cMenu.Items[cSelect])
            end
            if cMenu.Items[cSelect].Event ~= nil then
                TriggerEvent(cMenu.Items[cSelect].Event, cMenu.Items[cSelect])
            end
            if cMenu.Items[cSelect].Close == nil or cMenu.Items[cSelect].Close == true then
                Menu.isOpen = false
            end
        end
    end

end

-- FR -- Fonction : Récupère l'ID du joueur le plus proche
-- FR -- Paramètre(s) : distance = La distance maximum pour récupérer l'ID
---------------------------------------------------------
-- EN -- Function : Get Near ID Player
-- EN -- Param(s) : distance = Maximum distance to retrieve ID
function GetNearPlayer(distance)
  local players = GetPlayers()
  local nearPlayerDistance = distance or -1
  local nearPlayer = -1
  local playerCd = GetEntityCoords(GetPlayerPed(-1), 0)
  for i,v in ipairs(players) do
    local target = GetPlayerPed(v)
    if(target ~= GetPlayerPed(-1)) then
      local targetCoords = GetEntityCoords(GetPlayerPed(v), 0)
      local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], playerCd["x"], playerCd["y"], playerCd["z"], true)
      if(nearPlayerDistance == -1 or nearPlayerDistance > distance) then
        nearPlayer = v
      end
    end
  end
  return nearPlayer
end


-- FR -- Fonction : Récupère l'ID de tout les joueurs actifs
-- FR -- Paramètre(s) : Aucun
---------------------------------------------------------
-- EN -- Function : Get All ID Player Active
-- EN -- Param(s) : None
function GetPlayers()
    local players = {}
    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end
    return players
end


function PrendrePlayers()
  joueur = GetNearPlayer(perimetre) -- FR -- La valeur 2 veut dire 2 mètre de périmètre -- EN -- If the player has as a job number 2 (Font in this case), displays a button to access the font menu
  joueur_proche = GetPlayerServerId(joueur)
  if joueur_proche == 0 then
    Notify("Personne à proximité !")
  else
    interactionmenu.menu["main"].buttons = {}
    if jobuser == 2 then -- FR -- Si le joueur à comme job le numéro 2 (Police dans ce cas), affiche un bouton pour accèdez au menu police -- EN -- If the player has as a job number 2 (Font in this case), displays a button to access the font menu
      table.insert(interactionmenu.menu["main"].buttons, {name = "MenuPolice", title = "Ouvrir menu police"})
    end
    table.insert(interactionmenu.menu["main"].buttons, {name = "DonnerArgent", title = "Donner de l'argent"})
    table.insert(interactionmenu.menu["main"].buttons, {name = "DonnerArgentSale", title = "Donner de l'argent sale"})
    table.insert(interactionmenu.menu["main"].buttons, {name = "TranferArgent", title = "Transfère bancaire"})
    table.insert(interactionmenu.menu["main"].buttons, {name = "PresenterCarte", title = "Présenter sa carte d'identité"})
    OpenCreator()
  end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
        if IsControlJustPressed(1, Menu.keyOpenMenu) then
            Menu.initMenu()
            Menu.isOpen = not Menu.isOpen
        end
        if Menu.isOpen then
            Menu.draw()
            Menu.keyControl()
        end
	end
end)
