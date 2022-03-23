ESX = nil
Config = {}
Config.Webhook = ""
Config.Avatar = ""
Config.Colour = 345001
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('announce:send', function(data)
    SendLog("New annoucement", "Name: " .. GetPlayerName(source) .. "\nMessage: " .. data.msg)
    TriggerClientEvent('announce:sendForAll', -1, data)
end)


function SendLog(title, message)
    local embedMsg = {}
    embedMsg = {
        {
            ["color"] = Config.Colour,
            ["title"] = title,
            ["description"] =  ""..message.."",
            ["footer"] ={
                ["text"] = os.date("%c"),
            },
        }
    }
    PerformHttpRequest(Config.Webhook, function(err, text, headers)end, 'POST', json.encode({username = "Announce-creator", avatar_url= Config.Avatar ,embeds = embedMsg}), { ['Content-Type']= 'application/json' })
end
