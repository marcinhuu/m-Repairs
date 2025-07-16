if Config.Framework == "qb" then
    QBCore = exports["qb-core"]:GetCoreObject()
elseif Config.Framework == "esx" then
    ESX = exports.es_extended:getSharedObject()
end

local Colours = { 000, 001, 002, 003, 004, 005, 006, 007, 008, 009, 010, 011, 012, 013, 014, 015, 016, 017, 018, 019, 020, 021, 022, 023, 024, 025, 026, 027, 028, 029, 030, 031, 032, 033, 034, 035, 036, 037, 038, 039, 040, 041, 042, 043, 044, 045, 046, 047, 048, 049, 050, 051, 052, 053, 054, 055, 056, 057, 058, 059, 060, 061, 062, 063, 064, 065, 066, 067, 068, 069, 070, 071, 072, 073, 074, 075, 076, 077, 078, 079, 080, 081, 082, 083, 084, 085, 086, 087, 088, 089, 090, 091, 092, 093, 094, 095, 096, 097, 098, 099, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146}

CreateThread(function()
    for k,v in pairs(Config.RepairStations) do
        if v.ped_position and v.ped_model and v.car_position then
            RequestModel(GetHashKey(v.ped_model))
            while not HasModelLoaded(GetHashKey(v.ped_model)) do
                Wait(100)
            end
            local ped = CreatePed(0, GetHashKey(v.ped_model), v.ped_position.x, v.ped_position.y, v.ped_position.z - 1.0, v.ped_position.w, false, true)
            SetEntityInvincible(ped, true)
            FreezeEntityPosition(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            SetModelAsNoLongerNeeded(GetHashKey(v.ped_model))
        else
            print("Repair station configuration is missing required fields.")
        end

        local box = lib.zones.box({
            coords = vec3(v.car_position.x, v.car_position.y, v.car_position.z),
            size = vec3(3.0, 3.0, 3.0),
            rotation = 45,
            debug = false,
            inside = function()
                lib.showTextUI("[E] - Repair Vehicle", {
                    position = "right-center",
                    icon = "fas fa-wrench",
                })
                if IsControlJustPressed(0, 38) then
                    RepairVehicle(v)
                end
            end,
            onExit = function()
                lib.hideTextUI()
            end
        })
    end
end)

function RepairVehicle(v)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if not DoesEntityExist(vehicle) or not IsEntityAVehicle(vehicle) then
        Notify("You are not in a vehicle!", "error", 3000)
        return
    end

    if Config.Mechanic.enable then
        local mechanicsOnline = lib.callback.await('m-Repairs:Server:MechanicsOnline', false)
        if mechanicsOnline >= Config.Mechanic.online_need then
            Notify("There are enough mechanics online. Go to a mechanic shop for repairs!", "primary", 5000)
            return
        end
    end

    local vehiclePlate = GetVehicleNumberPlateText(vehicle)
    local haveInsurance = false

    if Config.mInsurance then
        haveInsurance = lib.callback.await('m-Repairs:Server:HasInsurance', false, vehiclePlate)
        if not haveInsurance then
            Notify("You don't have insurance to use repair stations!", "error", 5000)
            return
        end
    end

    local repairCost = v.repair_price
    if haveInsurance then
        repairCost = math.floor(repairCost * (1 - v.insurance_discount))
    end

    local success = lib.callback.await('m-Repairs:Server:CheckMoney', false, repairCost)
    if not success then
        Notify("You don't have enough money!", "error", 5000)
        return
    end

    if lib.progressCircle({
        label = "Repairing Vehicle...",
        duration = v.repair_time,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
        },
    }) then
        if v.repair_type == "full" then
            SetVehicleFixed(vehicle)
            SetVehicleDirtLevel(vehicle, 0.0)
            SetVehicleEngineHealth(vehicle, 1000.0)
            SetVehicleBodyHealth(vehicle, 1000.0)
            SetVehiclePetrolTankHealth(vehicle, 1000.0)
            Notify("Vehicle repaired successfully!", "success", 3000)
        elseif v.repair_type == "engine" then
            SetVehicleEngineHealth(vehicle, 1000.0)
            Notify("Engine repaired successfully!", "success", 3000)
        elseif v.repair_type == "body" then
            SetVehicleBodyHealth(vehicle, 1000.0)
            Notify("Body repaired successfully!", "success", 3000)
        end

        if v.change_colour then
            local randomColour = Colours[math.random(1, #Colours)]
            SetVehicleColours(vehicle, randomColour, randomColour)
        end
    end
end
