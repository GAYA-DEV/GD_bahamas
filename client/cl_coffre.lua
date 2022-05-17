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
AddEventHandler('esx:setJob2', function(job)
	ESX.PlayerData.job = job 
end)

-- MENU FUNCTION --

local open = false 
local mainMenu7 = RageUI.CreateMenu('bahamas', 'Interaction')
mainMenu7.Display.Header = true 
mainMenu7.Closed = function()
  open = false
end

function Coffrebahamas()
     if open then 
         open = false
         RageUI.Visible(mainMenu7, false)
         return
     else
         open = true 
         RageUI.Visible(mainMenu7, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(mainMenu7,function() 

				RageUI.Button("Prendre Objet(s)", nil, {RightLabel = "→"}, true , {
					onSelected = function()
						OpenGetStocksbahamasMenu()
					RageUI.CloseAll()
					end
				})

				RageUI.Button("Déposer Objet(s)", nil, {RightLabel = "→"}, true , {
					onSelected = function()
						OpenPutStocksLSPDMenu()
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
-- coffre blare
local position = {
	{x = -1391.18, y = -607.94, z = 30.32}
}

--coffre  garage
local position2 = {
	{x = -1392.6, y = -630.95, z = 28.7}
}
-- coffre blare

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'bahamas' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 5.0 then
            wait = 0
            DrawMarker(22, -1388.32, -612.39, 30.32, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 123, 31, 162, 255, true, true, p19, true)  -- coffre blare


        
            if dist <= 1.0 then
               wait = 0
                Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour le Coffre", 1) 
                if IsControlJustPressed(1,51) then
					Coffrebahamas()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)
--coffre  garage
Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'bahamas' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position2[k].x, position2[k].y, position2[k].z)

            if dist <= 5.0 then
            wait = 0
            DrawMarker(22, -1392.6, -630.95, 28.7, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 123, 31, 162, 255, true, true, p19, true)  -- coffre garage

        
            if dist <= 1.0 then
               wait = 0
                Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour le Coffre", 1) 
                if IsControlJustPressed(1,51) then
					Coffrebahamas()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)

-----FONCTION
function OpenGetStocksbahamasMenu()
	ESX.TriggerServerCallback('esx_bahamasjob:prendreitem', function(items)
		local elements = {}

		for i=1, #items, 1 do
            table.insert(elements, {
                label = 'x' .. items[i].count .. ' ' .. items[i].label,
                value = items[i].name
            })
        end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'bahamas',
			title    = 'bahamas stockage',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
                css      = 'bahamas',
				title = 'quantité'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification('quantité invalide')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_bahamasjob:prendreitems', itemName, count)

					Citizen.Wait(300)
					OpenGetStocksbahamasMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksLSPDMenu()
	ESX.TriggerServerCallback('esx_bahamasjob:inventairejoueur', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'police',
			title    = 'inventaire',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
                css      = 'police',
				title = 'quantité'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification('quantité invalide')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_bahamasjob:stockitem', itemName, count)

					Citizen.Wait(300)
					OpenPutStocksLSPDMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end