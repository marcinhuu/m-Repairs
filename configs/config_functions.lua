if Config.Framework == "qb" then
    QBCore = exports["qb-core"]:GetCoreObject()
elseif Config.Framework == "esx" then
    ESX = exports.es_extended:getSharedObject()
end

function Notify(text, type, time)
    if Config.Notify == "standalone" then
        BeginTextCommandThefeedPost("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandThefeedPostTicker(true, true)
    elseif Config.Notify == "qb" then
        QBCore.Functions.Notify(text, type, time)
    elseif Config.Notify == "okok" then
        exports['okokNotify']:Alert('Notification', text, time, type, true)
    elseif Config.Notify == "ox" then
        lib.notify({ title = 'Notification', description = text, type = type })
    elseif Config.Notify == "codem" then
        TriggerEvent('codem-notification:Create', text, type, 'Insurance', time)
    end
end