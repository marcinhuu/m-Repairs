if Config.Framework == "NEW" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == "OLD" then 
    QBCore = nil
    TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end) 
else
    print("The Framework '", Config.Framework, "' is not support, please change in config.lua")
end

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
    if player and player.Functions.RemoveMoney("cash", Config.Amount) then
        cb({ state = true })
    else
        TriggerClientEvent('QBCore:Notify', source, Config["Language"]['Notificacoes']['SemGuita'], 'error', 3500)
    end
end)
