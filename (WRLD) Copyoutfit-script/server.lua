RegisterCommand('copyfit', function(source, args, rawCommand)
    local targetId = tonumber(args[1])
    if not targetId or not GetPlayerName(targetId) then
        TriggerClientEvent('copyfit:notify', source, 'Invalid player ID. Usage: /copyfit [playerid]')
        return
    end

    TriggerClientEvent('copyfit:requestOutfit', targetId, source)
end)

RegisterNetEvent('copyfit:sendOutfit')
AddEventHandler('copyfit:sendOutfit', function(requestingPlayer, outfitData)
    TriggerClientEvent('copyfit:applyOutfit', requestingPlayer, outfitData)
end)