Config = {}

-- Utility
Config.Framework = "qb" -- Framework: "qb" or "esx"
Config.mInsurance = false -- You use m-Insurance?

Config.Mechanic = {
    enable = true, -- If enable the script gona check if have mechanics online
    online_need = 2, -- If have at least 2 mechanics online, they can't use the repair stations
    jobs = {
        "mechanic", -- Add your mechanic job here
        "mechanic2", -- Add more if you have multiple mechanic jobs
    },
}

Config.RepairStations = {
    [1] = {
        ped_position = vector4(734.93, -1088.74, 22.17, 101.06), -- Replace with actual coordinates
        ped_model = "mp_m_waremech_01", -- Model of the repair station NPC
        car_position = vector3(731.58, -1088.78, 21.74), -- Replace with actual coordinates
        repair_type = "full", -- Type of repair: "all" or "engine" or "body"
        repair_time = 5000, -- Time in milliseconds for the repair
        repair_price = 100, -- Price for repairing the vehicle
        insurance_discount = 0.1, -- 10% discount if insured
        change_colour = true, -- If true, the vehicle color will random change after repair
    }
}