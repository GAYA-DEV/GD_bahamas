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


RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	ESX.PlayerData.job2 = job2
end)

-- Function --

function bahamas()

  local model = GetEntityModel(GetPlayerPed(-1))

  TriggerEvent('skinchanger:getSkin', function(skin)

      if model == GetHashKey("mp_m_freemode_01") then

          clothesSkin = {

            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 40,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 40,
            ['pants_1'] = 28,   ['pants_2'] = 2,
            ['shoes_1'] = 38,   ['shoes_2'] = 4,
            ['chain_1'] = 118,  ['chain_2'] = 0

          }

      else

          clothesSkin = {

            ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
            ['torso_1'] = 8,    ['torso_2'] = 2,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 5,
            ['pants_1'] = 44,   ['pants_2'] = 4,
            ['shoes_1'] = 0,    ['shoes_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 2

          }

      end

      TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

  end)

end



function vcivil()

ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

TriggerEvent('skinchanger:loadSkin', skin)

end)

end

-- MENU FUNCTION --

local open = false 
local mainMenu6 = RageUI.CreateMenu('Vestaire', 'Ouverture du cassier..')
mainMenu6.Display.Header = true 
mainMenu6.Closed = function()
  open = false
end

function OpenVestiaire()
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

              RageUI.Separator("↓ ~y~   Vestiaire  ~s~↓")

              RageUI.Button("Mettre sa tenue : Civile", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                    vcivil()
                  end
                })	

               RageUI.Button("Mettre sa tenue : ~g~Barman", nil, {RightLabel = "→→"}, true , {
                  onSelected = function()
                    bahamas()
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
	{x = -1367.61, y = -613.68, z = 30.32}
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
            DrawMarker(22, -1367.61, -613.68, 30.32, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 123, 31, 162, 255, true, true, p19, true)  

        
            if dist <= 1.0 then
               wait = 0
                Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour intéragir avec les vestiaire", 1) 
                if IsControlJustPressed(1,51) then
                  OpenVestiaire()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)


