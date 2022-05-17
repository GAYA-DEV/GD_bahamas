Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
	end
end)

--- MENU ---

local open = false 
local mainMenu = RageUI.CreateMenu('bahamas', 'Arme') 
local bahamasMain2 = RageUI.CreateMenu('Boisson', 'Interaction')
local bahamasMain3 = RageUI.CreateMenu('Nourriture', 'Interaction')
mainMenu.Display.Header = true 
mainMenu.Closed = function()
  open = false
end

--- FUNCTION OPENMENU ---

function Shopbahamasnation()
	if open then 
		open = false
		RageUI.Visible(mainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(mainMenu,function() 

			 RageUI.Button("Nourriture", nil, {RightLabel = "→→"}, true , {
				onSelected = function()
				end
			}, bahamasMain3)


			end)	

			RageUI.IsVisible(bahamasMain2,function() 

			            

		end)	

		RageUI.IsVisible(bahamasMain3,function() 

		RageUI.Button("Pain 🥖", "Pain", {RightLabel = ""}, true , {
			onSelected = function()
				TriggerServerEvent('aurezia:BuyPain')
			end
		})

		RageUI.Button("Donuts 🍩", "Donuts.", {RightLabel = ""}, true , {
			onSelected = function()
				TriggerServerEvent('aurezia:BuyBrownie')
			end
		})

		RageUI.Button("Cookie 🍪", "Cookie", {RightLabel = ""}, true , {
			onSelected = function()
				TriggerServerEvent('aurezia:BuyCookie')
			end
		})

		end)			
		Wait(0)
	   end
	end)
 end
end
		-------------------------------------------------------------------------------------------------------
----OUVRIR LE MENU------------

local position = {
	{x = -1388.32, y = -612.39, z = 30.32}
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
            DrawMarker(22, -1388.32, -612.39, 30.32, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 123, 31, 162, 255, true, true, p19, true)  

			
            if dist <= 1.0 then
               wait = 0
                Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour intéragir au shop", 1) 
                if IsControlJustPressed(1,51) then
					Shopbahamasnation()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)