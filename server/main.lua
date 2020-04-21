print("^0======================================================================^7")
print("^3Copyright 2020 esx_brasseriejob ^5V1.0 ^3by ^1FproGeek^0")
print("^5https://github.com/FproGeek/esx_brasseriejob^0")
print("^0======================================================================^7")

ESX = nil
local PlayersTransforming, PlayersSelling, PlayersHarvesting = {}, {}, {}
local brune, blonde = 1, 1

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'brasseur', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'brasseur', _U('brasseur_customer'), true, true)
TriggerEvent('esx_society:registerSociety', 'brasseur', 'brasseur', 'society_brasseur', 'society_brasseur', 'society_brasseur', {type = 'private'})

local function Harvest(source, zone)
    if PlayersHarvesting[source] == true then

        local xPlayer  = ESX.GetPlayerFromId(source)
        if zone == "HoublonFarm" then
            local itemQuantity = xPlayer.getInventoryItem('houblon').count
            if itemQuantity > 50 then
                TriggerClientEvent('esx:showNotification', xPlayer.source, _U('not_enough_place')) 
                return
            else
                SetTimeout(1800, function()
                    xPlayer.addInventoryItem('houblon', 1)
                    Harvest(source, zone)
                end)
            end
        end
    end
end

RegisterServerEvent('esx_brasseriejob:startHarvest')
AddEventHandler('esx_brasseriejob:startHarvest', function(zone)
    local _source = source
    
    if PlayersHarvesting[_source] == false then
        TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
        PlayersHarvesting[_source]=false
    else
        PlayersHarvesting[_source]=true
        TriggerClientEvent('esx:showNotification', _source, _U('houblon_taken'))  
        Harvest(_source,zone)
        return
    end
end)

RegisterServerEvent('esx_brasseriejob:stopHarvest')
AddEventHandler('esx_brasseriejob:stopHarvest', function()
    local _source = source
    
    if PlayersHarvesting[_source] == true then
        PlayersHarvesting[_source]=false
        TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
    else
        TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~ramasser')
        PlayersHarvesting[_source]=true
        return
    end
end)

local function TransformBrune(source, zone)

  if PlayersTransforming[source] == true then

    local xPlayer  = ESX.GetPlayerFromId(source)
    if zone == "TraitementBrune" then
      local itemQuantity = xPlayer.getInventoryItem('houblon').count
      local itemQuantityBrune = xPlayer.getInventoryItem('brune').count
      if itemQuantityBrune > 50 then
                TriggerClientEvent('esx:showNotification', xPlayer.source, _U('not_enough_place')) 
                return
      elseif itemQuantity < 0 then
        TriggerClientEvent('esx:showNotification', xPlayer.source, _U('not_enough_houblon'))
        return
      else
          SetTimeout(1800, function()
            xPlayer.removeInventoryItem('houblon', 1)
            xPlayer.addInventoryItem('brune', 1)
            TransformBrune(source, zone)
          end)
        end
      end
  end 
end

local function TransformBlonde(source, zone)

  if PlayersTransforming[source] == true then

    local xPlayer  = ESX.GetPlayerFromId(source)
    if zone == "TraitementBlonde" then
      local itemQuantity = xPlayer.getInventoryItem('houblon').count
      local itemQuantityBlonde = xPlayer.getInventoryItem('blonde').count
       if itemQuantityBlonde > 50 then
                TriggerClientEvent('esx:showNotification', xPlayer.source, _U('not_enough_place')) 
                return
      elseif itemQuantity < 0 then
        TriggerClientEvent('esx:showNotification', xPlayer.source, _U('not_enough_houblon'))
        return
      else
        SetTimeout(1800, function()
          xPlayer.removeInventoryItem('houblon', 1)
          xPlayer.addInventoryItem('blonde', 1)
      
          TransformBlonde(source, zone)   
        end)
      end
    end
  end 
end

RegisterServerEvent('esx_brasseriejob:startTransform')
AddEventHandler('esx_brasseriejob:startTransform', function(zone)
    local _source = source
    
    if PlayersTransforming[_source] == false then
        TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
        PlayersTransforming[_source]=false
    else
        PlayersTransforming[_source]=true
        TriggerClientEvent('esx:showNotification', _source, _U('transforming_in_progress')) 
        TransformBrune(_source,zone)
        TransformBlonde(_source,zone)
        return
    end
end)

RegisterServerEvent('esx_brasseriejob:stopTransform')
AddEventHandler('esx_brasseriejob:stopTransform', function()
    local _source = source
    
    if PlayersTransforming[_source] == true then
        PlayersTransforming[_source]=false
        TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
        
    else
        TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~transformer votre houblon')
        PlayersTransforming[_source]=true
        return
    end
end)

local function Sell(source, zone)

  if PlayersSelling[source] == true then
    local xPlayer  = ESX.GetPlayerFromId(source)
    
    if zone == 'SellFarm' then
      if xPlayer.getInventoryItem('brune').count <= 0 then
        brune = 0
      else
        brune = 1
      end
      
      if xPlayer.getInventoryItem('blonde').count <= 0 then
        blonde = 0
      else
        blonde = 1
      end
    
      if brune == 0 and blonde == 0 then
        TriggerClientEvent('esx:showNotification', xPlayer.source, _U('no_product_sale'))
        return
      elseif xPlayer.getInventoryItem('brune').count <= 0 and blonde == 0 then
        TriggerClientEvent('esx:showNotification', xPlayer.source, _U('no_brune_sale'))
        brune = 0
        return
      elseif xPlayer.getInventoryItem('blonde').count <= 0 and brune == 0then
        TriggerClientEvent('esx:showNotification', xPlayer.source, _U('no_blonde_sale'))
        blonde = 0
        return
      else
        if (blonde == 1) then
          SetTimeout(1100, function()

            local money = math.random(7,9)
            local moneyprivate = math.random(1,2)

            xPlayer.removeInventoryItem('blonde', 1)
            xPlayer.addMoney(moneyprivate)
            TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned_private') .. moneyprivate)

            local societyAccount = nil

            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_brasseur', function(account)
              societyAccount = account
            end)
            if societyAccount ~= nil then
              societyAccount.addMoney(money)
              TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
            end
            Sell(source,zone)
          end)
        elseif (brune == 1) then
          SetTimeout(1100, function()

            local money = math.random(7,9)
            local moneyprivate = math.random(1,2)

            xPlayer.removeInventoryItem('brune', 1)
            xPlayer.addMoney(moneyprivate)
            TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned_private') .. moneyprivate)

            local societyAccount = nil

            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_brasseur', function(account)
              societyAccount = account
            end)
            if societyAccount ~= nil then
              societyAccount.addMoney(money)
              TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
            end
            Sell(source,zone)
          end)
        end
      end
    end
  end
end

RegisterServerEvent('esx_brasseriejob:startSell')
AddEventHandler('esx_brasseriejob:startSell', function(zone)
    local _source = source

    if PlayersSelling[_source] == false then
        TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
        PlayersSelling[_source]=false
    else
        PlayersSelling[_source]=true
        TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
        Sell(_source, zone)
        return
    end
end)

RegisterServerEvent('esx_brasseriejob:stopSell')
AddEventHandler('esx_brasseriejob:stopSell', function()
    local _source = source
    
    if PlayersSelling[_source] == true then
        PlayersSelling[_source]=false
        TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
        
    else
        TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
        PlayersSelling[_source]=true
        return
    end
end)


RegisterServerEvent('esx_brasseriejob:getStockItem')
AddEventHandler('esx_brasseriejob:getStockItem', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_brasseur', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= count then
      inventory.removeItem(itemName, count)
      xPlayer.addInventoryItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_removed') .. count .. ' ' .. item.label)

  end)

end)

ESX.RegisterServerCallback('esx_brasseriejob:getStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_brasseur', function(inventory)
    cb(inventory.items)
  end)

end)

RegisterServerEvent('esx_brasseriejob:putStockItems')
AddEventHandler('esx_brasseriejob:putStockItems', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_brasseur', function(inventory)

    local item = inventory.getItem(itemName)
    local playerItemCount = xPlayer.getInventoryItem(itemName).count

    if item.count >= 0 and count <= playerItemCount then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_added') .. count .. ' ' .. item.label)

  end)

end)

ESX.RegisterServerCallback('esx_brasseriejob:getVaultWeapons', function(source, cb)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_brasseur', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    cb(weapons)

  end)

end)

ESX.RegisterServerCallback('esx_brasseriejob:addVaultWeapon', function(source, cb, weaponName)

  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.removeWeapon(weaponName)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_brasseur', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    local foundWeapon = false

    for i=1, #weapons, 1 do
      if weapons[i].name == weaponName then
        weapons[i].count = weapons[i].count + 1
        foundWeapon = true
      end
    end

    if not foundWeapon then
      table.insert(weapons, {
        name  = weaponName,
        count = 1
      })
    end

     store.set('weapons', weapons)

     cb()

  end)

end)

ESX.RegisterServerCallback('esx_brasseriejob:removeVaultWeapon', function(source, cb, weaponName)

  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.addWeapon(weaponName, 1000)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_brasseur', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    local foundWeapon = false

    for i=1, #weapons, 1 do
      if weapons[i].name == weaponName then
        weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
        foundWeapon = true
      end
    end

    if not foundWeapon then
      table.insert(weapons, {
        name  = weaponName,
        count = 0
      })
    end

     store.set('weapons', weapons)

     cb()

  end)

end)

ESX.RegisterServerCallback('esx_brasseriejob:getPlayerInventory', function(source, cb)

  local xPlayer    = ESX.GetPlayerFromId(source)
  local items      = xPlayer.inventory

  cb({
    items      = items
  })

end)
