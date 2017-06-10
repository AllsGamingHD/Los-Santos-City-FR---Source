---------------------------------- VAR ----------------------------------

playing_emote = false
local backlock = false
local personnelmenu = {
  opened = false,
  title = "Menu Personnel",
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
      title = "MENU PERSONNEL", 
      name = "main",
      buttons = { 
        {name = "Rehabille", title = "Se réhabiller"},
        {name = "CarteIdentite", title = "Votre carte d'identité"},
        {name = "Animations", title = "Animations"},
      }
    },
    ["Animations"] = { 
      title = "ANIMATIONS", 
      name = "Animations",
      buttons = {
        {name = "Stop", title = "Stopper l'animation"},
        {name = "Animation", title = "Fumer", anim = "WORLD_HUMAN_SMOKING"},
        {name = "Animation", title = "Boire", anim = "WORLD_HUMAN_DRINKING"},
        {name = "Animation", title = "Filmer avec son téléphone", anim = "WORLD_HUMAN_MOBILE_FILM_SHOCKING"},
        {name = "Animation", title = "Impatient", anim = "WORLD_HUMAN_STAND_IMPATIENT"},
        {name = "Animation", title = "Yoga", anim = "WORLD_HUMAN_YOGA"},
        {name = "Animation", title = "Pompe", anim = "WORLD_HUMAN_PUSH_UPS"},
        {name = "Animation", title = "Abdos", anim = "WORLD_HUMAN_SIT_UPS"},
        {name = "Animation", title = "Statue", anim = "WORLD_HUMAN_HUMAN_STATUE"},
        {name = "Animation", title = "Flexion", anim = "WORLD_HUMAN_MUSCLE_FLEX"},
        {name = "Animation", title = "Plante", anim = "WORLD_HUMAN_GARDENER_PLANT"},
        -- FR -- Pour ajouter une animation il vous suffit de créer un bouton (title = Nom du bouton, anim = L'animation joué) -- EN -- To add an animation you just have to create a button (title = Name of the button, anim = The animation played)
        -- {name = "Animation", title = "Example", anim = "WORLD_HUMAN_EXAMPLE"},
      }
    },
  }
}

---------------------------------- FUNCTION ----------------------------------

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

function OpenCreator()
  boughtcar = false
  personnelmenu.currentmenu = "main"
  personnelmenu.opened = true
  personnelmenu.selectedbutton = 0
end

function CloseCreator()
  Citizen.CreateThread(function()
    local ped = LocalPed()
    if not boughtcar then
      local pos = currentlocation.pos.entering
    else
            
    end
    personnelmenu.opened = false
    personnelmenu.menu.from = 1
    personnelmenu.menu.to = 5
  end)
end

function drawMenuButton(button,x,y,selected)
  local menu = personnelmenu.menu
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
  local menu = personnelmenu.menu
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
  local menu = personnelmenu.menu
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
local menu = personnelmenu.menu
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


-- FR -- Fonction : Permet d'envoyer une notification à l'utilisateur
-- FR -- Paramètre(s) : text = Texte à afficher dans la notification
---------------------------------------------------------
-- EN -- Function : Sends a notification to the user
-- EN -- Param(s) : text = Text to display in the notification
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

function ButtonSelected(button)
  local ped = GetPlayerPed(-1)
  local this = personnelmenu.currentmenu
  local btn = button.name
  if this == "main" then
    if btn == "Rehabille" then
      changeSkin()
      boughtcar = true
      CloseCreator()
    elseif btn ==  'CarteIdentite' then
      boughtcar = true
      CloseCreator()
      TriggerServerEvent('gc:openMeIdentity')
    elseif btn == 'Animations' then
      OpenMenu('Animations')
    end
  elseif this == "Animations" then
      if btn == "Stop" then
        boughtcar = true
        ClearPedTasks(ped);
        playing_emote = false
        CloseCreator()
      elseif btn == "Animation" then
        ped = GetPlayerPed(-1);
        if ped then
          TaskStartScenarioInPlace(ped, button.anim, 0, true);
          playing_emote = true;
        end
      end
     
  end
end

function OpenMenu(menu)
  personnelmenu.lastmenu = personnelmenu.currentmenu
  if menu == "Contact" then
    personnelmenu.lastmenu = "main"
  elseif menu == "main"  then
    personnelmenu.lastmenu = nil
  elseif menu == "ActionContact"  then
    personnelmenu.lastmenu = "Contact"
  elseif menu == "Animations" then
    personnelmenu.lastmenu = "main"
  end
  personnelmenu.menu.from = 1
  personnelmenu.menu.to = 5
  personnelmenu.selectedbutton = 0
  personnelmenu.currentmenu = menu
end


function Back()
  if backlock then
    return
  end
  backlock = true
  if personnelmenu.currentmenu == "main" then
    boughtcar = true
    CloseCreator()
  elseif personnelmenu.currentmenu == "Contact" then
    OpenMenu(personnelmenu.lastmenu)
  elseif personnelmenu.currentmenu == "Animations" then
    OpenMenu(personnelmenu.lastmenu)
  elseif personnelmenu.currentmenu == "ActionContact" then
    OpenMenu(personnelmenu.lastmenu)
  else
    OpenMenu(personnelmenu.lastmenu)
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


-- FR -- Fonction : Permet de remettre le skin du joueur
-- FR -- Paramètre(s) : Aucun
---------------------------------------------------------
-- EN -- Function : Allows to reset the skin of the player
-- EN -- Param(s) : None
function changeSkin()
  TriggerServerEvent("menuuser:changeSkin")
end

---------------------------------- CITIZEN ----------------------------------

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlJustPressed(1,74) then -- FR -- Modifier la valeur 202 pour modifier la touche sur le quel le joueur doit appuyer pour afficher le menu -- EN -- Change the value 202 to change the key on which the player must press to display the menu
      if personnelmenu.opened then
        CloseCreator()
      else
        OpenCreator()
      end
    end
    if personnelmenu.opened then
      local ped = LocalPed()
      local menu = personnelmenu.menu[personnelmenu.currentmenu]
      drawTxt(personnelmenu.title,1,1,personnelmenu.menu.x,personnelmenu.menu.y,1.0, 255,255,255,255)
      drawMenuTitle(menu.title, personnelmenu.menu.x,personnelmenu.menu.y + 0.08)
      drawTxt(personnelmenu.selectedbutton.."/"..tablelength(menu.buttons),0,0,personnelmenu.menu.x + personnelmenu.menu.width/2 - 0.0385,personnelmenu.menu.y + 0.067,0.4, 255,255,255,255)
      local y = personnelmenu.menu.y + 0.12
      buttoncount = tablelength(menu.buttons)
      local selected = false
      
      for i,button in pairs(menu.buttons) do
        if i >= personnelmenu.menu.from and i <= personnelmenu.menu.to then
          
          if i == personnelmenu.selectedbutton then
            selected = true
          else
            selected = false
          end
          drawMenuButton(button,personnelmenu.menu.x,y,selected)
          y = y + 0.04
          if selected and IsControlJustPressed(1,201) then
            ButtonSelected(button)
          end
        end
      end 
    end
    if personnelmenu.opened then
      if IsControlJustPressed(1,202) then 
        Back()
      end
      if IsControlJustReleased(1,202) then
        backlock = false
      end
      if IsControlJustPressed(1,188) then
        if personnelmenu.selectedbutton > 1 then
          personnelmenu.selectedbutton = personnelmenu.selectedbutton -1
          if buttoncount > 5 and personnelmenu.selectedbutton < personnelmenu.menu.from then
            personnelmenu.menu.from = personnelmenu.menu.from -1
            personnelmenu.menu.to = personnelmenu.menu.to - 1
          end
        end
      end
      if IsControlJustPressed(1,187)then
        if personnelmenu.selectedbutton < buttoncount then
          personnelmenu.selectedbutton = personnelmenu.selectedbutton +1
          if buttoncount > 5 and personnelmenu.selectedbutton > personnelmenu.menu.to then
            personnelmenu.menu.to = personnelmenu.menu.to + 1
            personnelmenu.menu.from = personnelmenu.menu.from + 1
          end
        end 
      end
    end
    
  end
end)