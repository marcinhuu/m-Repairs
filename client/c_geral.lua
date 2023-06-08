if Config.Framework == "NEW" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == "OLD" then 
        local QBCore = nil
        CreateThread(function()
        while QBCore == nil do 
            TriggerEvent("QBCore:GetObject", function(obj)QBCore = obj end) 
            Wait(200) 
        end 
    end) 
else
    print("The Framework '", Config.Framework, "' is not support, please change in config.lua")
end

local Cores = { 000, 001, 002, 003, 004, 005, 006, 007, 008, 009, 010, 011, 012, 013, 014, 015, 016, 017, 018, 019, 020, 021, 022, 023, 024, 025, 026, 027, 028, 029, 030, 031, 032, 033, 034, 035, 036, 037, 038, 039, 040, 041, 042, 043, 044, 045, 046, 047, 048, 049, 050, 051, 052, 053, 054, 055, 056, 057, 058, 059, 060, 061, 062, 063, 064, 065, 066, 067, 068, 069, 070, 071, 072, 073, 074, 075, 076, 077, 078, 079, 080, 081, 082, 083, 084, 085, 086, 087, 088, 089, 090, 091, 092, 093, 094, 095, 096, 097, 098, 099, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146,}
local Reparar = false

local peds = Config.Peds

---------------------------------------- #### THREADS #### ----------------------------------------

CreateThread(function()
    for _, item in pairs(peds) do
        RequestModel(item.hash)
        while not HasModelLoaded(item.hash) do
            Wait(100)
        end
        if item.ped == nil then
            local ped = CreatePed(item.type, item.hash, item.vector4, item.a, false, true)
            SetBlockingOfNonTemporaryEvents(ped, false)
            SetPedDiesWhenInjured(ped, false)
            SetPedCanPlayAmbientAnims(ped, true)
            SetPedCanRagdollFromPlayerImpact(ped, false)
            SetEntityInvincible(ped, true)
            FreezeEntityPosition(ped, true)
            item.ped = ped
        end
    end
end)

--- BLIPS

CreateThread(function()
    if Config.BlipRepair.Enable then
        for k, v in pairs(Config["Repairs"]) do
            local blip = AddBlipForCoord(vector3(v.x, v.y, v.z)) 
            SetBlipSprite(blip, Config.BlipRepair.Sprite) 
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, Config.BlipRepair.Scale)
            SetBlipAsShortRange(blip, true)
            SetBlipColour(blip, Config.BlipRepair.Colour)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.BlipRepair.Name) 
            EndTextCommandSetBlipName(blip)
        end
    else
        return false
    end
end)

CreateThread(function ()
    for k, v in pairs(Config["Repairs"]) do
        local name = "Min"..k
        local label = ""
        if Config.Function == 'colour' then
            label = Config["Language"]["QBTarget"]["Pintar"]
        elseif Config.Function == 'repair' then
            label = Config["Language"]["QBTarget"]["Reparar"]
        elseif Config.Function == 'all' then
            label = Config["Language"]["QBTarget"]["Falar"]
        end
        exports["qb-target"]:AddBoxZone(name, vector3(v.x, v.y, v.z), 2, 2, {
            name = name,
            heading = 0,
            debugPoly = false,
        }, {
            options = {
                {
                    event = "m-Repairs:client:Reparar",
                    icon = Config["Language"]["QBTarget"]["Icon"],
                    label = label,
                },
            },
            distance = 5.0
        })
    end
end)


function RepararCarro()
    QBCore.Functions.Progressbar("RepararCarro", Config["Language"]["ProgressBars"]["Reparar"], 5000, false, true, {disableMovement = true,disableCarMovement = true,disableMouse = false,disableCombat = true}, {}, {}, {}, function() 
    end)
end

function PintarCarro()
    QBCore.Functions.Progressbar("PintarCarro", Config["Language"]["ProgressBars"]["Pintar"], 5000, false, true, {disableMovement = true,disableCarMovement = true,disableMouse = false,disableCombat = true}, {}, {}, {}, function() 
    end)
end

function RepararPopo(vehicle)
    FreezeEntityPosition(vehicle, true)  
    Wait(1000)
    SetVehicleFixed(vehicle)
    SetVehicleEngineHealth(vehicle, 1000.0)
    SetVehicleBodyHealth(vehicle, 1000.0)
    SetVehiclePetrolTankHealth(vehicle, 1000.0)
    SetVehicleDirtLevel(vehicle, 0)
    SetVehicleOnGroundProperly(vehicle)  
    FreezeEntityPosition(vehicle, false) 
end


RegisterNetEvent('m-Repairs:client:Reparar')
AddEventHandler("m-Repairs:client:Reparar", function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    
    if not vehicle then
        QBCore.Functions.Notify("You need to be inside a vehicle.", "error")
        return
    end
    
    local function repararCarro()
        RepararCarro()
        Wait(5000)
        SetVehicleColours(vehicle, math.random(1, #Cores), math.random(1, #Cores))
    end
    
    local function repararPopo()
        RepararPopo(vehicle)
    end
    
    local function verificarGuita()
        QBCore.Functions.TriggerCallback("m-Repairs:server:VerificarGuita", function(cb)
            if cb then
                repararCarro()
                Wait(5000)
                repararPopo()
            end
        end)
    end
    
    local function verificarMecanicos()
        QBCore.Functions.TriggerCallback("m-Repairs:server:VerificarMecanicos", function(cb)
            if cb then
                if Config.Function == 'all' then
                    if Config.Payment == 'off' then
                        repararCarro()
                        repararPopo()
                    elseif Config.Payment == 'cash' then
                        verificarGuita()
                    end
                elseif Config.Function == 'colour' then
                    if Config.Payment == 'off' then
                        PintarCarro()
                        Wait(5000)
                        SetVehicleColours(vehicle, math.random(1, #Cores), math.random(1, #Cores))
                    elseif Config.Payment == 'cash' then
                        verificarGuita()
                    end
                elseif Config.Function == 'repair' then
                    if Config.Payment == 'off' then
                        repararCarro()
                        Wait(5000)
                        SetVehicleColours(vehicle, math.random(1, #Cores), math.random(1, #Cores))
                    elseif Config.Payment == 'cash' then
                        verificarGuita()
                    end
                end
            else
                QBCore.Functions.Notify("Mechanics available :)", "error")
            end
        end)
    end
    
    if Config.OnlyUseWithMechanicOFF then
        verificarMecanicos()
    else
        if Config.Function == 'all' then
            if Config.Payment == 'off' then
                repararCarro()
                repararPopo()
            elseif Config.Payment == 'cash' then
                verificarGuita()
            end
        elseif Config.Function == 'colour' then
            if Config.Payment == 'off' then
                PintarCarro()
                Wait(5000)
                SetVehicleColours(vehicle, math.random(1, #Cores), math.random(1, #Cores))
            elseif Config.Payment == 'cash' then
                verificarGuita()
            end
        elseif Config.Function == 'repair' then
            if Config.Payment == 'off' then
                repararCarro()
                Wait(5000)
                SetVehicleColours(vehicle, math.random(1, #Cores), math.random(1, #Cores))
            elseif Config.Payment == 'cash' then
                verificarGuita()
            end
        end
    end
end)
