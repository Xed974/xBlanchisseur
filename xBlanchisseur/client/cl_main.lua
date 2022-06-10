ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)

local open = false
local mainMenu = RageUI.CreateMenu('Blanchiment', 'interaction', nil, nil, 'root_cause5', 'img_bleu')
mainMenu.Display.Header = true
mainMenu.Closed = function()
    open = false
    FreezeEntityPosition(PlayerPedId(), false)
end

function MenuBlanchiment()
    if open then
        open = false
        RageUI.Visible(mainMenu, false)
    else
        open = true
        RageUI.Visible(mainMenu, true)
        Citizen.CreateThread(function()
            while open do
                Wait(0)
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Separator(('Temps: ~b~%s minutes~s'):format(Config.TimeForWait))
                    RageUI.Separator('Taxe: ~b~'..Config.Taxe..'%~s~')
                    RageUI.Line()
                    RageUI.Button('Blanchir votre argent', nil, {RightBadge = RageUI.BadgeStyle.Star}, true, {
                        onSelected = function()
                            local amount = KeyboardInput("Combien souhaitez vous blanchir ?", "", 5)
                            if amount ~= "" then
                                TriggerServerEvent('xBlanchisseur:blanchiment', tonumber(amount))
                            else 
                                ESX.ShowNotification('~r~Montant invalid.~s~')
                            end
                        end
                    })
                end)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do
        local wait = 750

        for k in pairs(Config.Position.Menu) do
            local pPos = GetEntityCoords(PlayerPedId())
            local pos = Config.Position.Menu
            local dst = Vdist(pPos.x, pPos.y, pPos.z, pos[k].x, pos[k].y, pos[k].z)

            if dst <= 1.0 then
                wait = 0
                ESX.ShowHelpNotification('Appuyez sur ~b~E~s~ pour intéragir avec Florian.', 1)
                if IsControlJustPressed(0, 38) then
                    if Config.JobRequired == true then
                        if ESX.PlayerData.job2.name == Config.JobRequiredName then
                            FreezeEntityPosition(PlayerPedId(), true)
                            MenuBlanchiment()
                        else
                            ESX.ShowAdvancedNotification('Florian', '~b~Discussion', 'T\'es qui toi ? Casse toi d\'ici !', 'CHAR_ORTEGA', 1)
                        end
                    else
                        FreezeEntityPosition(PlayerPedId(), true)
                        MenuBlanchiment()
                    end
                end
            end
        end
        Citizen.Wait(wait)
    end
end)

--- Xed#1188