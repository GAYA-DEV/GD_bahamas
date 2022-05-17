TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'bahamas', 'alerte bahamas', true, true)

TriggerEvent('esx_society:registerSociety', 'bahamas', 'bahamas', 'society_bahamas', 'society_bahamas', 'society_bahamas', {type = 'public'})

RegisterServerEvent('Ouvre:bahamas')
AddEventHandler('Ouvre:bahamas', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'bahamas', '~r~Annonce', '~g~L\'bahamas est désormais ouvert vient te faire plaisir chez nous !', 'CHAR_JOE', 8)
	end
end)

RegisterServerEvent('Ferme:bahamas')
AddEventHandler('Ferme:bahamas', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'bahamas', '~r~Annonce', '~r~L\'bahamas est désormais fermé à plus tard !', 'CHAR_JOE', 8)
	end
end)

RegisterServerEvent('Recru:bahamas')
AddEventHandler('Recru:bahamas', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'bahamas', '~r~Annonce', '~y~Recrutement en cours, rendez-vous a l\'bahamas!', 'CHAR_JOE', 8)
	end
end)

RegisterCommand('uni', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job2.name == "bahamas" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'bahamas', '~r~Annonce', ''..msg..'', 'CHAR_JOE', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~r~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_JOE', 0)
    end
else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~r~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_JOE', 0)
end
end, false)


RegisterServerEvent('esx_bahamasjob:prendreitems')
AddEventHandler('esx_bahamasjob:prendreitems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if count > 0 and inventoryItem.count >= count then

			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, 'Objet retiré', count, inventoryItem.label)
			end
		else
			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
		end
	end)
end)


RegisterNetEvent('esx_bahamasjob:stockitem')
AddEventHandler('esx_bahamasjob:stockitem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', _source, "Objet déposé "..count..""..inventoryItem.label.."")
		else
			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
		end
	end)
end)


ESX.RegisterServerCallback('esx_bahamasjob:inventairejoueur', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

ESX.RegisterServerCallback('esx_bahamasjob:prendreitem', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		cb(inventory.items)
	end)
end)

-- Shop

RegisterNetEvent('aurezia:BuyPain') 
AddEventHandler('aurezia:BuyPain', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_bahamas', function(account)
        societyAccount = account
        end)
        xPlayer.removeMoney(price)
        societyAccount.addMoney (price)
        xPlayer.addInventoryItem('bread', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Achats~w~ effectué !")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)

RegisterNetEvent('aurezia:BuyBrownie') 
AddEventHandler('aurezia:BuyBrownie', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_bahamas', function(account)
        societyAccount = account
        end)
        xPlayer.removeMoney(price)
        societyAccount.addMoney (price)
        xPlayer.addInventoryItem('brownie', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Achats~w~ effectué !")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)

RegisterNetEvent('aurezia:BuyCookie') 
AddEventHandler('aurezia:BuyCookie', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 0
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then

        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_bahamas', function(account)
        societyAccount = account
        end)
        xPlayer.removeMoney(price)
        societyAccount.addMoney (price)
        xPlayer.addInventoryItem('cookie', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Achats~w~ effectué !")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)


-- Farm

RegisterNetEvent('recoltboutilletvide')
AddEventHandler('recoltboutilletvide', function()
    local item = "boutilletvide"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "Ta pas assez de place dans ton inventaire!")
        recoltepossible = false
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
		return
    end
end)

RegisterNetEvent('traitementboutilletvide')
AddEventHandler('traitementboutilletvide', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local boutilletvide = xPlayer.getInventoryItem('boutilletvide').count
    local bouteilleremplie = xPlayer.getInventoryItem('bouteilleremplie').count

    if bouteilleremplie > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de boutillet vide...')
    elseif boutilletvide < 3 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de boutillet vide pour traiter...')
    else
        xPlayer.removeInventoryItem('boutilletvide', 5)
        xPlayer.addInventoryItem('bouteilleremplie', 1)    
    end
end)


RegisterServerEvent('sellbouteilleremplie')
AddEventHandler('sellbouteilleremplie', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local bouteilleremplie = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "bouteilleremplie" then
			bouteilleremplie = item.count
		end
	end
    
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_bahamas', function(account)
        societyAccount = account
    end)
    
    if bouteilleremplie > 0 then
        xPlayer.removeInventoryItem('bouteilleremplie', 1)
        xPlayer.addMoney(40)
        societyAccount.addMoney(40)
        TriggerClientEvent('esx:showNotification', xPlayer.source, "~g~Vous avez gagner ~r~40$~g~ pour chaque vente d'une bouteille remplie")
        TriggerClientEvent('esx:showNotification', xPlayer.source, "~g~La société gagne ~r~40$~g~ pour chaque vente d'une bouteille remplie")
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous n'avez plus rien à vendre")
    end
end)


