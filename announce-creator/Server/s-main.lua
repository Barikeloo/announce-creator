ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('announce:send', function(data)
    TriggerClientEvent('announce:sendForAll', -1, data)
end)