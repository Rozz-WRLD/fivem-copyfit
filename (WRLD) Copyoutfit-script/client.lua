RegisterNetEvent('copyfit:requestOutfit')
AddEventHandler('copyfit:requestOutfit', function(requestingPlayer)
    local playerPed = PlayerPedId()
    local outfitData = {
        components = {},
        props = {}
    }

    for i = 0, 11 do
        table.insert(outfitData.components, {
            componentId = i,
            drawableId = GetPedDrawableVariation(playerPed, i),
            textureId = GetPedTextureVariation(playerPed, i)
        })
    end

    for i = 0, 7 do
        table.insert(outfitData.props, {
            propId = i,
            drawableId = GetPedPropIndex(playerPed, i),
            textureId = GetPedPropTextureIndex(playerPed, i)
        })
    end

    TriggerServerEvent('copyfit:sendOutfit', requestingPlayer, outfitData)
end)

RegisterNetEvent('copyfit:applyOutfit')
AddEventHandler('copyfit:applyOutfit', function(outfitData)
    local playerPed = PlayerPedId()

    for _, component in ipairs(outfitData.components) do
        SetPedComponentVariation(playerPed, component.componentId, component.drawableId, component.textureId, 0)
    end

    for _, prop in ipairs(outfitData.props) do
        if prop.drawableId == -1 then
            ClearPedProp(playerPed, prop.propId)
        else
            SetPedPropIndex(playerPed, prop.propId, prop.drawableId, prop.textureId, true)
        end
    end
end)

RegisterNetEvent('copyfit:notify')
AddEventHandler('copyfit:notify', function(message)
    TriggerEvent('chat:addMessage', { args = { '[CopyFit]', message } })
end)