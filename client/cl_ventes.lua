--credit : GAYA DEV  pour la src du RageUI V1 

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
	end
end)

--- MENU ---

local open = false 
local mainMenu = RageUI.CreateMenu('Ventes', 'bahamas')
mainMenu.Display.Header = true 
mainMenu.Closed = function()
  open = false
end

--- FUNCTION OPENMENU ---

function VentesUni()
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

			RageUI.Button("Vendre Bouteille remplie", nil, {RightLabel = "40$"}, true , {
				onSelected = function()
                    TriggerServerEvent('sellbouteilleremplie')
				end
			}, subMenu)

		   end)
		Wait(0)
	   end
	end)
 end
end
		-------------------------------------------------------------------------------------------------------

local position = {
	{x = 106.24, y = -1564.28, z = 29.6} 
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'bahamas' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 4.0 then
            wait = 0
			DrawMarker(22, 106.24, -1564.28, 29.6, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 1.0, 1.0, 1.0, 123, 31, 162, 255, true, true, p19, true)   

        
            if dist <= 10.0 then
               wait = 0
                Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour intéragir", 1) 
                if IsControlJustPressed(1,51) then
					VentesUni()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)
