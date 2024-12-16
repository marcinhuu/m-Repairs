local QBCore = exports[Config.CoreName]:GetCoreObject()

QBCore.Functions.CreateCallback('m-Repairs:server:VerificarMecanicos', function(source, cb)
    local MecanicosOnline = 0

    for _, player in ipairs(QBCore.Functions.GetPlayers()) do
        local job = QBCore.Functions.GetPlayerData(player).job
        if job and job.name == Config.MechanicJob then
            MecanicosOnline = MecanicosOnline + 1
        end
    end

    cb(MecanicosOnline >= Config.MechanicNecessary)
end)

QBCore.Functions.CreateCallback('m-Repairs:server:VerificarGuita', function(source, cb)
    local player = QBCore.Functions.GetPlayer(source)
    if Config.Payment == "bank" then
        if player and player.Functions.RemoveMoney("bank", Config.Amount) then
            cb({ state = true })
        else
            TriggerClientEvent('QBCore:Notify', source, Config.Language.noMoney, 'error', 3500)
        end
    elseif Config.Payment == "cash" then
        if player and player.Functions.RemoveMoney("cash", Config.Amount) then
            cb({ state = true })
        else
            TriggerClientEvent('QBCore:Notify', source, Config.Language.noMoney, 'error', 3500)
        end
    else
        print("Missing payment type on Config.Payment")
    end
end)
