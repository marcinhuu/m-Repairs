Config = Config or {}

-------------------
-- Utility
-------------------
Config.Framework = "NEW" -- "NEW" -> New qbcore | "OLD" -> Old qbcore
Config.MechanicJob = "mechanic" 
Config.MechanicJob2 = "police"
Config.MechanicJob3 = "mechanic" -- You dont need 3 mechanics, delete the line 9 and 8 and go to server lua line: 14 and remove the config.
Config.MechanicNecessary = 2


Config.OnlyUseWithMechanicOFF = true
-------------------
-- Stations
-------------------
Config["Repairs"] = {
    vector3(734.93, -1088.77, 21.17), 
    -- You can add more locations
}

Config.Function = 'all' -- Functions: "repair" - Only repair vehicle. | "colour" - Only change a colour. | "all" - Repair & Colour
Config.Payment = 'cash' -- You can put: OFF or cash
Config.Amount = 500 -- Paymant amount if you use 'cash'

-------------------
-- Language
-------------------
Config["Language"] = {
    ["QBTarget"] = {
        ["Falar"] = "Speak",
        ["Reparar"] = "Repair",
        ["Pintar"] = "Paint",
        ["Icon"] = "fas fa-car",
    },
    ["ProgressBars"] = {
        ["Reparar"] = "Repairing the vehicle...",
        ["Pintar"] = "Painting the car..."
    },
    ['Notificacoes'] = {
        ["SemGuita"] = "You don't have enough money"
    }
}

----------------------
-- Blip
----------------------
Config.BlipRepair = {
    Enable = false,
    Name = "Repairs",
    Sprite = 253,
    Scale = 0.6,
    Colour = 4,
}

----------------------
-- Peds
----------------------
Config.PedListRepairs = {                                              -- Peds that will be spawned in
    {
        model = "s_m_y_armymech_01",                                                         
        coords = vector3(734.93, -1088.77, 21.17),           
        heading = 88.45,
        gender = "male",
        scenario = "WORLD_HUMAN_STAND_MOBILE_UPRIGHT" ,
    },
}