if SERVER then
local V={
    Name = "FSD Overrun",
    Model = "models/props_phx/trains/fsd-overrun2.mdl",
    Class = "prop_vehicle_prisoner_pod",
    Category = "GMod Custom",

    Author = "PhoeniX-Storms",
    Information = "FSD Overrun Monorail",

    KeyValues = {
        vehiclescript = "scripts/vehicles/prisoner_pod.txt",
        limitview = "0"
        },
    Members = {
        HandleAnimation = HandlePHXVehicleAnimation,
        }
    }
list.Set("Vehicles","phx_train",V)
--          Synergy Van
local V={
        Name = "Van",
        Model = "models/vehicles/7seatvan.mdl",
        Class = "prop_vehicle_jeep",
        Category = "Synergy",

        Author = "VALVe",
        Information = "The Van from Synergy.",

        KeyValues = {
            vehiclescript = "scripts/vehicles/van.txt"
        }
    }
list.Set("Vehicles","synergy_van",V)
--          Synergy Truck
local V={
        Name = "Truck",
        Model = "models/vehicles/8seattruck.mdl",
        Class = "prop_vehicle_jeep",
        Category = "Synergy",

        Author = "VALVe",
        Information = "The Truck from Synergy.",

        KeyValues = {
            vehiclescript = "scripts/vehicles/truck.txt"
        }
    }
list.Set("Vehicles","synergy_truck",V)
--          Synergy Elite Jeep
local V={
        Name = "Elite Jeep",
        Model = "models/vehicles/buggy_elite.mdl",
        Class = "prop_vehicle_jeep",
        Category = "Synergy",
        Author = "VALVe",
        Information = "The buggy from Synergy.",
        KeyValues = {
            vehiclescript = "scripts/vehicles/jeep_elite.txt"
        }
    }
list.Set("Vehicles","synergy_ejeep",V)
end