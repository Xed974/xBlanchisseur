ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('xBlanchisseur:blanchiment')
AddEventHandler('xBlanchisseur:blanchiment', function(amount)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local pMoney = xPlayer.getAccount('black_money').money
    local moneyblanchi = (amount * (1 - (Config.Taxe/100)))

    if (not xPlayer) then return else
        if pMoney >= amount then
            TriggerClientEvent('esx:showAdvancedNotification', source, 'Florian', '~b~Discussion~s~', 'Merci pour l\'argent, une fois le blanchiment effectué je vous l\'enverrai sur votre compte bancaire !', 'CHAR_ORTEGA', 1)
            xPlayer.removeAccountMoney('black_money', amount)
            Wait(Config.TimeForWait * 60000)
            xPlayer.addAccountMoney('bank', moneyblanchi)
            TriggerClientEvent('esx:showAdvancedNotification', source, 'Fleeca Bank', '~g~Virement~s~', ('Vous avez reçu un virement de ~g~%s$~s~'):format(moneyblanchi), 'CHAR_BANK_FLEECA', 9)
        else
            TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas ~r~autant d\'argent~s~ sur vous !')
        end
    end
end)

--- Xed#1188