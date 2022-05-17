Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job2 == nil do
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
AddEventHandler('esx:setJob', function(job2)
	ESX.PlayerData.job2 = job2
end)


-- MENU FUNCTION --

local open = false 
local mainMenu8 = RageUI.CreateMenu('bahamas', 'Interaction')
local subMenu8 = RageUI.CreateSubMenu(mainMenu8, "Annonces", "Interaction")
local subMenu9 = RageUI.CreateSubMenu(mainMenu8, "Farm bahamas", "Interaction")
mainMenu8.Display.Header = true 
mainMenu8.Closed = function()
  open = false
end

function OpenMenu8()
	if open then 
		open = false
		RageUI.Visible(mainMenu8, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu8, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(mainMenu8,function() 


			RageUI.Checkbox("Prendre son service", nil, servicebahamas, {}, {
                onChecked = function(index, items)
                    servicebahamas = true
					ESX.ShowNotification("~g~Vous avez pris votre service !")
                end,
                onUnChecked = function(index, items)
                    servicebahamas = false
					ESX.ShowNotification("~r~Vous avez quitter votre service !")
                end
            })

			if servicebahamas then
			RageUI.Separator("↓ Annonces ↓")
			RageUI.Button("Annonces", nil, {RightLabel = "→→"}, true , {
				onSelected = function()
				end
			}, subMenu8)

			RageUI.Separator("↓ Farm bahamas ↓")

			RageUI.Button("Pour accéder au farms", nil, {RightLabel = "→"}, true , {
				onSelected = function()
				end
			}, subMenu9)

			RageUI.Separator("↓ Factures ↓")
			RageUI.Button("Faire une Facture", nil, {RightLabel = "→→"}, true , {
				onSelected = function()
					OpenBillingMenu2()
                    RageUI.CloseAll()
				end
			})

		end
			end)

			RageUI.IsVisible(subMenu8,function() 

			 RageUI.Button("Annonce Ouvertures", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					TriggerServerEvent('Ouvre:bahamas')
				end
			})

			RageUI.Button("Annonce Fermetures", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					TriggerServerEvent('Ferme:bahamas')
				end
			})

			RageUI.Button("Annonce Recrutement", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					TriggerServerEvent('Recru:bahamas')
				end
			})

			RageUI.Button("Message Personnalisé", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					local te = KeyboardInput("Message", "", 100)
					ExecuteCommand("uni " ..te)
				end
			})

		end)
				
				RageUI.IsVisible(subMenu9,function() 

					RageUI.Button("Obtenir le point de récolte", nil, {RightLabel = "→"}, true , {
						onSelected = function()
							SetNewWaypoint(528.5, -1603.1, 29.31)  
						end
					})
		
					RageUI.Button("Obtenir le point de traitement", nil, {RightLabel = "→"}, true , {
						onSelected = function()
							SetNewWaypoint(-1927.8, 2054.23, 140.81) 
						end 
					})
		
					RageUI.Button("Obtenir le point de vente", nil, {RightLabel = "→"}, true , {
						onSelected = function()
							SetNewWaypoint(106.24, -1564.28, 29.6)
						end
					})

		   end)
		 Wait(0)
		end
	 end)
  end
end

-- FUNCTION BILLING --

function OpenBillingMenu2()

	ESX.UI.Menu.Open(
	  'dialog', GetCurrentResourceName(), 'billing',
	  {
		title = "Facture"
	  },
	  function(data, menu)
	  
		local amount = tonumber(data.value)
		local player, distance = ESX.Game.GetClosestPlayer()
  
		if player ~= -1 and distance <= 3.0 then
  
		  menu.close()
		  if amount == nil then
			  ESX.ShowNotification("Problèmes~s~: Montant invalide")
		  else
			local playerPed        = GetPlayerPed(-1)
			TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
			Citizen.Wait(5000)
			TriggerServerEvent('esx_billing:sendBill1', GetPlayerServerId(player), 'society_bahamas', ('bahamas'), amount)
			  Citizen.Wait(100)
			  ESX.ShowNotification("Vous avez bien envoyer la facture")
		  end
  
		else
		  ESX.ShowNotification("Problèmes~s~: Aucun joueur à proximitée")
		end
  
	  end,
	  function(data, menu)
		  menu.close()
	  end
	)
  end

-- OUVERTURE DU MENU --

Keys.Register('F7', 'bahamas', 'Ouvrir le menu bahamas', function()
	if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'bahamas' then
    	OpenMenu8()
	end
end)

-- Blips 

Citizen.CreateThread(function()

        local bahamas = AddBlipForCoord(130.44, -1301.1, 17.53)
    
        SetBlipSprite(bahamas, 93)
        SetBlipColour(bahamas, 48)
        SetBlipScale(bahamas, 0.50)
        SetBlipAsShortRange(bahamas, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("bahamas Club")
        EndTextCommandSetBlipName(bahamas)
    end)