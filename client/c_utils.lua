if Config.Framework == "qb" then
    QBCore = exports["qb-core"]:GetCoreObject()
elseif Config.Framework == "esx" then
    ESX = exports.es_extended:getSharedObject()
end


function Notify(text, type, time)
    if Config.Framework == "qb" then
        QBCore.Functions.Notify(text, type, time)
    elseif Config.Framework == "esx" then
        ESX.ShowNotification(text)
    end
end


