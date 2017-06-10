---------------------------------- PARAMS ----------------------------------

local perimetre = 2 -- Meters for menu interaction

---------------------------------- VAR ----------------------------------

local jobuser = ""
local backlock = false
local interactionmenu = {
  opened = false,
  title = "Menu Intéraction",
  currentmenu = "main",
  lastmenu = nil,
  currentpos = nil,
  selectedbutton = 0,
  marker = { r = 0, g = 155, b = 255, a = 200, type = 1 },
  menu = {
    x = 0.104,
    y = 0.313,
    width = 0.2,
    height = 0.04,
    buttons = 5,
    from = 1,
    to = 5,
    scale = 0.4,
    font = 0,
    ["main"] = { 
      title = "MENU INTERACTION", 
      name = "main",
      buttons = {
        {name = "DonnerArgent", title = "Donner de l'argent"},
		{name = "DonnerArgentSale", title = "Donner de l'argent sales"},
        {name = "PresenterCarte", title = "Présenter sa carte d'identité"},
      }
    },
    ["MenuPolice"] = { 
      title = "MENU POLICE", 
      name = "MenuPolice",
      buttons = { 
        {name = "Amende", title = "Mettre une amende"},
        {name = "Inspect", title = "Inspecter"},
        {name = "Menotte", title = "Menotter (SOON)"},
      }
    },
  }
}

---------------------------------- FUNCTION ---------------------------------

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
  SetTextFont(font)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(centre)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x , y) 
end

function f(n)
  return n + 0.0001
end

function LocalPed()
  return GetPlayerPed(-1)
end

function try(f, catch_f)
local status, exception = pcall(f)
if not status then
catch_f(exception)
end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
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


function OpenCreator()
  boughtcar = false
  interactionmenu.currentmenu = "main"
  interactionmenu.opened = true
  interactionmenu.selectedbutton = 0
end

function CloseCreator()
  Citizen.CreateThread(function()
    local ped = LocalPed()
    if not boughtcar then
      local pos = currentlocation.pos.entering
    else
            
    end
    interactionmenu.opened = false
    interactionmenu.menu.from = 1
    interactionmenu.menu.to = 5
  end)
end

function drawMenuButton(button,x,y,selected)
  local menu = interactionmenu.menu
  SetTextFont(menu.font)
  SetTextProportional(0)
  SetTextScale(menu.scale, menu.scale)
  if selected then
    SetTextColour(0, 0, 0, 255)
  else
    SetTextColour(255, 255, 255, 255)
  end
  SetTextCentre(0)
  SetTextEntry("STRING")
  AddTextComponentString(button.title)
  if selected then
    DrawRect(x,y,menu.width,menu.height,255,255,255,255)
  else
    DrawRect(x,y,menu.width,menu.height,0,0,0,150)
  end
  DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)  
end

function drawMenuInfo(text)
  local menu = interactionmenu.menu
  SetTextFont(menu.font)
  SetTextProportional(0)
  SetTextScale(0.45, 0.45)
  SetTextColour(255, 255, 255, 255)
  SetTextCentre(0)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawRect(0.675, 0.95,0.65,0.050,0,0,0,150)
  DrawText(0.365, 0.934)  
end

function drawMenuRight(txt,x,y,selected)
  local menu = interactionmenu.menu
  SetTextFont(menu.font)
  SetTextProportional(0)
  SetTextScale(menu.scale, menu.scale)
  SetTextRightJustify(1)
  if selected then
    SetTextColour(0, 0, 0, 255)
  else
    SetTextColour(255, 255, 255, 255)
  end
  SetTextCentre(0)
  SetTextEntry("STRING")
  AddTextComponentString(txt)
  DrawText(x + menu.width/2 - 0.03, y - menu.height/2 + 0.0028) 
end

function drawMenuTitle(txt,x,y)
local menu = interactionmenu.menu
  SetTextFont(2)
  SetTextProportional(0)
  SetTextScale(0.5, 0.5)
  SetTextColour(255, 255, 255, 255)
  SetTextEntry("STRING")
  AddTextComponentString(txt)
  DrawRect(x,y,menu.width,menu.height,0,0,0,150)
  DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)  
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function Notify(text)
  SetNotificationTextEntry('STRING')
  AddTextComponentString(text)
  DrawNotification(false, false)
end

function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end


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

-- FR -- Fonction : Affiche une boite de dialogue, puis renvoie la valeur à l'evenement
-- FR -- Paramètre(s) : Aucun
---------------------------------------------------------
-- EN -- Function : Displays a dialog box, then returns the value to the event
-- EN -- Param(s) : None
function DemandeTextBank()
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result5 = GetOnscreenKeyboardResult()
        TriggerServerEvent("bank:transfertsource", joueur_proche, tonumber(result5))
    end
end

-- FR -- Fonction : Affiche une boite de dialogue, puis renvoie la valeur à l'evenement
-- FR -- Paramètre(s) : Aucun
---------------------------------------------------------
-- EN -- Function : Displays a dialog box, then returns the value to the event
-- EN -- Param(s) : None
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

function Inspect()
    TriggerServerEvent("id_card:fouille", joueur_proche)
end

function DonnerCarte()
    TriggerServerEvent('gc:openMeIdentity', joueur_proche)
end

function Menotte()
  TriggerServerEvent("police:cuff", joueur_proche)
end

function ButtonSelected(button)
  local ped = GetPlayerPed(-1)
  local this = interactionmenu.currentmenu
  local btn = button.name
  if this == "main" then
    if btn == "DonnerArgent" then
      DemandeText()
      boughtcar = true
      CloseCreator()
    elseif btn == "DonnerArgentSale" then
      DemandeTextSale()
      boughtcar = true
      CloseCreator()
    elseif btn == "TranferArgent" then
      DemandeTextBank()
      boughtcar = true
      CloseCreator()
    elseif btn == "PresenterCarte" then
      DonnerCarte()
      boughtcar = true
      CloseCreator()
    elseif btn ==  'MenuPolice' then
      OpenMenu('MenuPolice')
    elseif btn == 'Animations' then
      OpenMenu('Animations')
    end
  elseif this == "MenuPolice" then
    if btn == "Menotte" then
      Menotte()
      boughtcar = true
      CloseCreator()
    elseif btn ==  'Inspect' then
      Inspect()
      boughtcar = true
      CloseCreator()
    elseif btn == 'Amende' then
      Amende()
      boughtcar = true
      CloseCreator()
    end
  end
end

function OpenMenu(menu)
  interactionmenu.lastmenu = interactionmenu.currentmenu
  if menu == "Contact" then
    interactionmenu.lastmenu = "main"
  elseif menu == "main"  then
    interactionmenu.lastmenu = nil
  elseif menu == "MenuPolice"  then
    interactionmenu.lastmenu = "main"
  end
  interactionmenu.menu.from = 1
  interactionmenu.menu.to = 5
  interactionmenu.selectedbutton = 0
  interactionmenu.currentmenu = menu
end


function Back()
  if backlock then
    return
  end
  backlock = true
  if interactionmenu.currentmenu == "main" then
    boughtcar = true
    CloseCreator()
  elseif interactionmenu.currentmenu == "Contact" then
    OpenMenu(interactionmenu.lastmenu)
  elseif interactionmenu.currentmenu == "MenuPolice" then
    OpenMenu(interactionmenu.lastmenu)
  else
    OpenMenu(interactionmenu.lastmenu)
  end
end

function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end


function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
  SetTextFont(font)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(centre)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x , y)
end

---------------------------------- CITIZEN ---------------------------------

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlJustPressed(1,29) then -- FR -- Modifier la valeur 29 pour modifier la touche sur le quel le joueur doit appuyer pour afficher le menu -- EN -- Change the value 29 to change the key on which the player must press to display the menu
      if interactionmenu.opened then 
        CloseCreator()
      else
        TriggerServerEvent('menuint:getInfos') -- FR -- Récupère le travail du joueur -- EN -- Get Job User
        Wait(500) -- FR -- Cette attente permet de laisser le temps que les informations arrive au client si le serveur est lent -- EN -- This waiting time allows the time that the information arrived at the client if the server is slow
        PrendrePlayers()
      end
    end
    if interactionmenu.opened then
      local ped = LocalPed()
      local menu = interactionmenu.menu[interactionmenu.currentmenu]
      drawTxt(interactionmenu.title,1,1,interactionmenu.menu.x,interactionmenu.menu.y,1.0, 255,255,255,255)
      drawMenuTitle(menu.title, interactionmenu.menu.x,interactionmenu.menu.y + 0.08)
      drawTxt(interactionmenu.selectedbutton.."/"..tablelength(menu.buttons),0,0,interactionmenu.menu.x + interactionmenu.menu.width/2 - 0.0385,interactionmenu.menu.y + 0.067,0.4, 255,255,255,255)
      local y = interactionmenu.menu.y + 0.12
      buttoncount = tablelength(menu.buttons)
      local selected = false
      
      for i,button in pairs(menu.buttons) do
        if i >= interactionmenu.menu.from and i <= interactionmenu.menu.to then
          
          if i == interactionmenu.selectedbutton then
            selected = true
          else
            selected = false
          end
          drawMenuButton(button,interactionmenu.menu.x,y,selected)
          y = y + 0.04
          if selected and IsControlJustPressed(1,201) then
            ButtonSelected(button)
          end
        end
      end 
    end
    if interactionmenu.opened then
      if IsControlJustPressed(1,202) then
        Back()
      end
      if IsControlJustReleased(1,202) then
        backlock = false
      end
      if IsControlJustPressed(1,188) then
        if interactionmenu.selectedbutton > 1 then
          interactionmenu.selectedbutton = interactionmenu.selectedbutton -1
          if buttoncount > 5 and interactionmenu.selectedbutton < interactionmenu.menu.from then
            interactionmenu.menu.from = interactionmenu.menu.from -1
            interactionmenu.menu.to = interactionmenu.menu.to - 1
          end
        end
      end
      if IsControlJustPressed(1,187)then
        if interactionmenu.selectedbutton < buttoncount then
          interactionmenu.selectedbutton = interactionmenu.selectedbutton +1
          if buttoncount > 5 and interactionmenu.selectedbutton > interactionmenu.menu.to then
            interactionmenu.menu.to = interactionmenu.menu.to + 1
            interactionmenu.menu.from = interactionmenu.menu.from + 1
          end
        end 
      end
    end
    
  end
end)

---------------------------------- EVENEMENT ---------------------------------

-- FR -- Evenement : Récupère le travail du joueur
-- FR -- Paramètre(s) : info = Résultat de la requête (Job)
---------------------------------------------------------
-- EN -- Evenement : Get Job User
-- EN -- Param(s) : info = Request result (Job)
RegisterNetEvent("int:getInfos")
AddEventHandler("int:getInfos", function(info)
    jobuser = ""
    jobuser = info
end)
