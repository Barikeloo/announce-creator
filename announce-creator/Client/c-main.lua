ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)
RegisterCommand('anuncios', function()
    local jobname = ESX.GetPlayerData().job.name
    if jobname == "police" or jobname == "ambulance" or jobname == "mechanic" then --Aqui puedes ir añadiendo los trabajos.
        SendNUIMessage({
            action = "anuncio",
            presets = presets,
            job = jobname
        })
        SetNuiFocus(true, true)
    else
        ESX.ShowNotification('No tienes acceso a esto.')
    end
end)
RegisterNUICallback('exit', function()
    SetNuiFocus(false, false)
end)
RegisterNUICallback('send', function(data)
    TriggerServerEvent('announce:send', data.obj)
end)
RegisterNetEvent('announce:sendForAll', function(data)
    SendNUIMessage({
        action = 'execute',
        content = data
    })
    print(json.encode(data))
end)