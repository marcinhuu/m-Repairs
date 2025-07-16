if Config.Framework == "qb" then
    QBCore = exports["qb-core"]:GetCoreObject()
elseif Config.Framework == "esx" then
    ESX = exports.es_extended:getSharedObject()
end

function GetPlayer(source)
    if Config.Framework == "qb" then
        return QBCore.Functions.GetPlayer(source)
    elseif Config.Framework == "esx" then
        return ESX.GetPlayerFromId(source)
    else
        print("Invalid framework specified in Config.Framework")
    end
end

lib.callback.register('m-Repairs:Server:HasInsurance', function(source, plate)
    local hasInsurance = promise.new()

    exports['m-Insurance']:HasCarInsurance(plate, function(result)
        hasInsurance:resolve(result == true)
    end)

    return Citizen.Await(hasInsurance)
end)

lib.callback.register('m-Repairs:Server:CheckMoney', function(source, amount)
    local player = GetPlayer(source)
    if Config.Framework == "qb" then
        if player.Functions.RemoveMoney('cash', amount) then
            return true
        else
            return false
        end
    elseif Config.Framework == "esx" then
        if player.getMoney() >= amount then
            player.removeMoney(amount)
            return true
        else
            return false
        end
    else
        print("Invalid framework specified in Config.Framework")
        return false
    end
end)

lib.callback.register('m-Repairs:Server:MechanicsOnline', function(source)
    local count = 0

    for _, playerId in pairs(GetPlayers()) do
        local player = GetPlayer(tonumber(playerId))
        if player then
            local jobName = nil
            if Config.Framework == 'qb' then
                jobName = player.PlayerData.job.name
            elseif Config.Framework == 'esx' then
                jobName = player.getJob().name
            end

            for _, job in ipairs(Config.Mechanic.jobs) do
                if jobName == job then
                    count = count + 1
                    break
                end
            end
        end
    end

    return count
end)
