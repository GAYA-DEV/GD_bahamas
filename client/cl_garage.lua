Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- MENU FUNCTION --

local open = false 
local mainMenu6 = RageUI.CreateMenu('Garage', 'Véhicule')
mainMenu6.Display.Header = true 
mainMenu6.Closed = function()
  open = false
end

function OpenMenu6()
     if open then 
         open = false
         RageUI.Visible(mainMenu6, false)
         return
     else
         open = true 
         RageUI.Visible(mainMenu6, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(mainMenu6,function() 

              RageUI.Button("Ranger votre véhicule", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                  local playerPed = PlayerPedId()
      
                  if IsPedSittingInAnyVehicle(playerPed) then
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
            
                    if GetPedInVehicleSeat(vehicle, -1) == playerPed then
                      ESX.ShowNotification('La voiture a été mis en dans le garage')
                      ESX.Game.DeleteVehicle(vehicle)
                       
                    else
                      ESX.ShowNotification('Mais toi place conducteur, ou sortez de la voiture.')
                    end
                  else
                    local vehicle = ESX.Game.GetVehicleInDirection()
            
                    if DoesEntityExist(vehicle) then
                      ESX.ShowNotification('La voiture à été placer dans le garage.')
                      ESX.Game.DeleteVehicle(vehicle)
            
                    else
                      ESX.ShowNotification('Aucune voitures autours')
                    end
                  end
              end,})

              RageUI.Separator("~h~↓ Véhicules ↓")

                RageUI.Button("Limousine", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                      local model = GetHashKey("stretch")
                      RequestModel(model)
                      while not HasModelLoaded(model) do Citizen.Wait(10) end
                      local pos = GetEntityCoords(PlayerPedId())
                      local vehicle = CreateVehicle(model, 104.92, -1277.76, 29.02, 277.51, true, true)
                      RageUI.CloseAll()
                    end
                })

                RageUI.Button("le mon sur le menu", nil, {RightLabel = "→→"}, true , {
                  onSelected = function()
                    local model = GetHashKey("Nightshade")
                    RequestModel(model)
                    while not HasModelLoaded(model) do Citizen.Wait(10) end
                    local pos = GetEntityCoords(PlayerPedId())
                    local vehicle = CreateVehicle(model, 104.92, -1277.76, 29.02, 277.51, true, true)
                    RageUI.CloseAll()
                  end
              })

              RageUI.Button("le mon sur le menu", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                  local model = GetHashKey("Nightshade")
                  RequestModel(model)
                  while not HasModelLoaded(model) do Citizen.Wait(10) end
                  local pos = GetEntityCoords(PlayerPedId())
                  local vehicle = CreateVehicle(model, 104.92, -1277.76, 29.02, 277.51, true, true)
                  RageUI.CloseAll()
                end
            })

            RageUI.Button("le mon sur le menu", nil, {RightLabel = "→→"}, true , {
              onSelected = function()
                local model = GetHashKey("Nightshade")
                RequestModel(model)
                while not HasModelLoaded(model) do Citizen.Wait(10) end
                local pos = GetEntityCoords(PlayerPedId())
                local vehicle = CreateVehicle(model, 104.92, -1277.76, 29.02, 277.51, true, true)
                RageUI.CloseAll()
              end
          })

            end)
          Wait(0)
         end
      end)
   end
end

----OUVRIR LE MENU------------

local position = {
	{x = 90.87, y = -1284.62, z = 29.3}
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'bahamas' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 5.0 then
            wait = 0
            DrawMarker(22, 90.87, -1284.62, 29.3, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 123, 31, 162, 255, true, true, p19, true)  

        
            if dist <= 1.0 then
               wait = 0
                Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour intéragir avec le garage", 1) 
                if IsControlJustPressed(1,51) then
                  OpenMenu6()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)


