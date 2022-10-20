if Config.Framework == "NEW" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == "OLD" then 
    QBCore = nil
    TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end) 
else
    print("The Framework '", Config.Framework, "' is not support, please change in config.lua")
end

QBCore.Functions.CreateCallback('m-Repairs:server:VerificarMecanicos', function(source, cb)
    local src = source
    local Players = QBCore.Functions.GetPlayers()
    local MecanicosOnline = 0

    for i = 1, #Players do
        local Player = QBCore.Functions.GetPlayer(Players[i])
        if Player.PlayerData.job.name == Config.MechanicJob or Config.MechanicJob2 or Config.MechanicJob3 then
            MecanicosOnline = MecanicosOnline + 1
        end
    end

    if MecanicosOnline >= Config.MechanicNecessary then
        cb(true)
    else
        cb(false)
    end
end)


QBCore.Functions.CreateCallback('m-Repairs:server:VerificarGuita', function(source, cb)
    if QBCore.Functions.GetPlayer(source).Functions.RemoveMoney("cash", Config.Amount) then
        cb({
            state   = true,
        })
    else
        TriggerClientEvent('QBCore:Notify', source,Config["Language"]['Notificacoes']['SemGuita'], 'error', 3500)
    end
end)