local QBCore = exports['qb-core']:GetCoreObject()

local boostLocation = vector3(454.53, -1020.79, 28.32) -- Can change location

local function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData()
end)


CreateThread(function()
    -- Player near location? Is player in a police car?
    while (true) do
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local distance = #(pedCoords - boostLocation)

        if distance < 8 then
            if IsPedInAnyPoliceVehicle(ped) then
                DrawText3Ds(454.53, -1020.79, 28.32, "[~g~E~w~] - Emergency Boost")

                if IsControlJustReleased(0, 38) then
                    if QBCore.Functions.GetPlayerData().job.name == 'police' then
                        QBCore.Functions.Notify("Your cruiser now goes fast!", 'success')
                        SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(ped, true), 55.0) -- Change power increase here (55 is pretty high, will depend on vehicles)
                    else
                        QBCore.Functions.Notify("You need to be a cop!", 'error')
                    end
                end 
            end 
            Wait(0)
        end
        Wait(100)
    end 
end)