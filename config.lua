Config = Config or {}

-- Utility
Config.CoreName = "qb-core" -- Your core name
Config.MechanicJob = "mechanic" -- Job name
Config.MechanicNecessary = 1 -- Number of mechanics needed to use the service
Config.OnlyUseWithMechanicOFF = true -- If you want to use this script only with the mechanic off, set to true
Config.Function = 'repair' -- Functions: "repair" - Only repair vehicle. | "colour" - Only change a colour. | "all" - Repair & Colour
Config.Payment = 'cash' -- "cash" or "bank"
Config.Amount = 500 -- Payment amount if you use 'cash'

-- Stations
Config["Repairs"] = {
    vector3(736.74, -1088.87, 22.17), --LSCustoms Industrial sector
    vector3(-323.35, -145.67, 39.02), --LSCustoms main
    vector3(-1159.13, -2011.46, 13.18), --LSCustoms airport
    vector3(1174.91, 2636.33, 37.76), --Desert Sector
    vector3(108.31, 6629.19, 31.79), --Sandy Shores
    vector3(-572.88, -938.75, 23.89), --Redline
    -- You can add more locations
}

-- Language
Config.Language = {
    speak = "Speak",
    repair = "Repair",
    paint = "Paint",
    icon = "fas fa-car",
    progressRepair = "Repairing the vehicle...",
    progressPaint = "Painting the car...",
    noMoney = "You don't have enough money",
    insideVeh = "You need to be inside a vehicle.",
}

-- Blip
Config.BlipRepair = {
    Enable = true,
    Name = "Repairs",
    Sprite = 544,
    Scale = 1.0,
    Colour = 45,
}

-- Peds
Config.Peds = {
    [1] = {type = 4, hash = GetHashKey("mp_m_waremech_01"), vector4 = vector4(737.27, -1088.88, 22.17, 85.72)}, --LScustoms Industrial sector
    [2] = {type = 4, hash = GetHashKey("mp_m_waremech_01"), vector4 = vector4(-1160.03, -2011.93, 13.18, 312.81)}, --LScustoms airport
    [3] = {type = 4, hash = GetHashKey("mp_m_waremech_01"), vector4 = vector4(-323.4, -145.7, 39.02, 67.87)}, --LSCustoms main
    [4] = {type = 4, hash = GetHashKey("mp_m_waremech_01"), vector4 = vector4(1174.92, 2636.56, 37.75, 356.12)}, --Desert Sector
    [5] = {type = 4, hash = GetHashKey("mp_m_waremech_01"), vector4 = vector4(108.31, 6629.19, 31.79, 220.97)}, --Sandy Shores
    [6] = {type = 4, hash = GetHashKey("mp_m_waremech_01"), vector4 = vector4(-572.88, -938.98, 23.89, 15.11)}, --redline
}
