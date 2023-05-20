AddCSLuaFile()

local V = {
	Name = "Truffade Adder",
	Model = "models/tdmcars/gtav/adder.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "GTA V",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 90,

	Members = {
		Mass = 1600,
		
		EnginePos = Vector(0,80,35),

		StrengthenSuspension = true,
		FrontWheelRadius = 16,
		RearWheelRadius = 16,
		
		SeatOffset = Vector(-10,0,0),
		SeatPitch = -15,
		SeatYaw = 0,
		
		PassengerSeats = {
			{
				pos = Vector(17,7,18),
				ang = Angle(0,-90,0)
			}
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-34,-98,15),
				ang = Angle(45,90,0),
			},
			{
				pos = Vector(34,-98,15),
				ang = Angle(45,-90,180),
			}
		},
		
		FrontHeight = 10,
		FrontConstant = 27000,
		FrontDamping = 2800,
		FrontRelativeDamping = 2800,
		
		RearHeight = 10,
		RearConstant = 32000,
		RearDamping = 2900,
		RearRelativeDamping = 2900,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 8,
		
		MaxGrip = 64,
		Efficiency = 1.5,
		GripOffset = -0.01,
		BrakePower = 40,
		BulletProofTires = false,
		
		IdleRPM = 1000,
		LimitRPM = 6000,
		PeakTorque = 120,
		PowerbandStart = 2500,
		PowerbandEnd = 5500,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(40,-81,37.8),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 120,
		
		PowerBias = 1,
		
		EngineSoundPreset = -1,
		
		snd_pitch = 0.8,
		snd_idle = "simulated_vehicles/gta5_dukes/dukes_idle.wav",
		
		snd_low = "simulated_vehicles/gta5_dukes/dukes_low.wav",
		snd_low_revdown = "simulated_vehicles/gta5_dukes/dukes_revdown.wav",
		snd_low_pitch = 0.8,
		
		snd_mid = "simulated_vehicles/gta5_dukes/dukes_mid.wav",
		snd_mid_gearup = "simulated_vehicles/gta5_dukes/dukes_second.wav",
		snd_mid_pitch = 1,
		
		snd_horn = "acf_extra/vehiclefx/horn/horn9.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.12,0,0.12,0.21,0.32,0.41}
	}
}

list.Set( "simfphys_vehicles", "gta5_truffade_adder", V )

local V = {
	Name = "Downtown Bus",
	Model = "models/tdmcars/gtav/bus.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "GTA V",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 90,

	Members = {
		Mass = 9000,
		
		EnginePos = Vector(0,80,35),

		StrengthenSuspension = true,
		FrontWheelRadius = 20,
		RearWheelRadius = 20,
		
		SeatOffset = Vector(-5,0,-5),
		SeatPitch = 0,
		SeatYaw = 0,
		
		PassengerSeats = {
			{
				--32 Passengers
				pos = Vector(17,7,18),
				ang = Angle(0,-90,0)
			}
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-34,-98,15),
				ang = Angle(45,90,0),
			},
			{
				pos = Vector(34,-98,15),
				ang = Angle(45,-90,180),
			}
		},
		
		FrontHeight = 10,
		FrontConstant = 27000,
		FrontDamping = 2800,
		FrontRelativeDamping = 2800,
		
		RearHeight = 10,
		RearConstant = 32000,
		RearDamping = 2900,
		RearRelativeDamping = 2900,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 8,
		
		MaxGrip = 64,
		Efficiency = 1.5,
		GripOffset = -0.01,
		BrakePower = 40,
		BulletProofTires = false,
		
		IdleRPM = 1000,
		LimitRPM = 6000,
		PeakTorque = 120,
		PowerbandStart = 2500,
		PowerbandEnd = 5500,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(40,-81,37.8),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 120,
		
		PowerBias = 1,
		
		EngineSoundPreset = -1,
		
		snd_pitch = 0.8,
		snd_idle = "simulated_vehicles/gta5_dukes/dukes_idle.wav",
		
		snd_low = "simulated_vehicles/gta5_dukes/dukes_low.wav",
		snd_low_revdown = "simulated_vehicles/gta5_dukes/dukes_revdown.wav",
		snd_low_pitch = 0.8,
		
		snd_mid = "simulated_vehicles/gta5_dukes/dukes_mid.wav",
		snd_mid_gearup = "simulated_vehicles/gta5_dukes/dukes_second.wav",
		snd_mid_pitch = 1,
		
		snd_horn = "acf_extra/vehiclefx/horn/horn9.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.12,0,0.12,0.21,0.32,0.41}
	}
}

list.Set( "simfphys_vehicles", "gta5_downtown_bus", V )

local V = {
	Name = "Brute Camper",
	Model = "models/tdmcars/gtav/camper.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "GTA V",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 90,

	Members = {
		Mass = 6000,
		
		EnginePos = Vector(0,80,35),

		StrengthenSuspension = true,
		FrontWheelRadius = 18,
		RearWheelRadius = 18,
		
		SeatOffset = Vector(-10,0,-10),
		SeatPitch = 0,
		SeatYaw = 0,
		
		PassengerSeats = {
			{
				pos = Vector(25,35,35),
				ang = Angle(0,0,0)
			}
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-34,-98,15),
				ang = Angle(45,90,0),
			},
			{
				pos = Vector(34,-98,15),
				ang = Angle(45,-90,180),
			}
		},
		
		FrontHeight = 10,
		FrontConstant = 27000,
		FrontDamping = 2800,
		FrontRelativeDamping = 2800,
		
		RearHeight = 10,
		RearConstant = 32000,
		RearDamping = 2900,
		RearRelativeDamping = 2900,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 8,
		
		MaxGrip = 64,
		Efficiency = 1.5,
		GripOffset = -0.01,
		BrakePower = 40,
		BulletProofTires = false,
		
		IdleRPM = 1000,
		LimitRPM = 6000,
		PeakTorque = 120,
		PowerbandStart = 2500,
		PowerbandEnd = 5500,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(40,-81,37.8),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 120,
		
		PowerBias = 1,
		
		EngineSoundPreset = -1,
		
		snd_pitch = 0.8,
		snd_idle = "simulated_vehicles/gta5_dukes/dukes_idle.wav",
		
		snd_low = "simulated_vehicles/gta5_dukes/dukes_low.wav",
		snd_low_revdown = "simulated_vehicles/gta5_dukes/dukes_revdown.wav",
		snd_low_pitch = 0.8,
		
		snd_mid = "simulated_vehicles/gta5_dukes/dukes_mid.wav",
		snd_mid_gearup = "simulated_vehicles/gta5_dukes/dukes_second.wav",
		snd_mid_pitch = 1,
		
		snd_horn = "acf_extra/vehiclefx/horn/horn9.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.12,0,0.12,0.21,0.32,0.41}
	}
}

list.Set( "simfphys_vehicles", "gta5_brute_camper", V )

local V = {
	Name = "Karin Futo",
	Model = "models/tdmcars/gtav/futo.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "GTA V",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,

	Members = {
		Mass = 1200,
		
		EnginePos = Vector(0,67,36),

		StrengthenSuspension = true,
		FrontWheelRadius = 12,
		RearWheelRadius = 12,
		
		SeatOffset = Vector(-10,0,0),
		SeatPitch = -15,
		SeatYaw = 0,
		
		PassengerSeats = {
			{
				pos = Vector(15,0,10),
				ang = Angle(0,0,15)
			},
			{
				pos = Vector(-15,-35,10),
				ang = Angle(0,0,15)
			},
			{
				pos = Vector(15,-35,10),
				ang = Angle(0,0,15)
			}
		},
		
		ExhaustPositions = {
			{
				pos = Vector(14.2,-87,11.5),
				ang = Angle(-90,90,0)
			}
		},
		
		FrontHeight = 10,
		FrontConstant = 50000,
		FrontDamping = 1000,
		FrontRelativeDamping = 2000,
		
		RearHeight = 10,
		RearConstant = 50000,
		RearDamping = 1000,
		RearRelativeDamping = 2000,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 8,
		
		MaxGrip = 64,
		Efficiency = 1.5,
		GripOffset = -0.01,
		BrakePower = 40,
		BulletProofTires = false,
		
		IdleRPM = 1000,
		LimitRPM = 6000,
		PeakTorque = 120,
		PowerbandStart = 2500,
		PowerbandEnd = 5500,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(32.7,-61.8,36.5),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 120,
		
		PowerBias = 1,
		
		EngineSoundPreset = -1,
		
		snd_pitch = 0.8,
		snd_idle = "simulated_vehicles/gta5_dukes/dukes_idle.wav",
		
		snd_low = "simulated_vehicles/gta5_dukes/dukes_low.wav",
		snd_low_revdown = "simulated_vehicles/gta5_dukes/dukes_revdown.wav",
		snd_low_pitch = 0.8,
		
		snd_mid = "simulated_vehicles/gta5_dukes/dukes_mid.wav",
		snd_mid_gearup = "simulated_vehicles/gta5_dukes/dukes_second.wav",
		snd_mid_pitch = 1,
		
		snd_horn = "acf_extra/vehiclefx/horn/horn9.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.12,0,0.12,0.21,0.32,0.41}
	}
}

list.Set( "simfphys_vehicles", "gta5_karin_futo", V )

local V = {
	Name = "Bravado Gauntlet",
	Model = "models/tdmcars/gtav/gauntlet.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "GTA V",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 90,

	Members = {
		Mass = 1600,
		
		EnginePos = Vector(0,66,40),

		StrengthenSuspension = true,
		FrontWheelRadius = 16,
		RearWheelRadius = 16,
		
		SeatOffset = Vector(-10,0,0),
		SeatPitch = -15,
		SeatYaw = 0,
		
		PassengerSeats = {
			{
				pos = Vector(17,-5,15),
				ang = Angle(0,0,15)
			}
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-27,-110,20),
				ang = Angle(-90,90,0),
			},
			{
				pos = Vector(27,-110,20),
				ang = Angle(-90,90,0),
			}
		},
		
		FrontHeight = 10,
		FrontConstant = 27000,
		FrontDamping = 2800,
		FrontRelativeDamping = 2800,
		
		RearHeight = 10,
		RearConstant = 32000,
		RearDamping = 2900,
		RearRelativeDamping = 2900,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 8,
		
		MaxGrip = 64,
		Efficiency = 1.5,
		GripOffset = -0.01,
		BrakePower = 40,
		BulletProofTires = false,
		
		IdleRPM = 1000,
		LimitRPM = 6000,
		PeakTorque = 120,
		PowerbandStart = 2500,
		PowerbandEnd = 5500,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(40,-80,44),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 120,
		
		PowerBias = 1,
		
		EngineSoundPreset = -1,
		
		snd_pitch = 0.8,
		snd_idle = "simulated_vehicles/gta5_dukes/dukes_idle.wav",
		
		snd_low = "simulated_vehicles/gta5_dukes/dukes_low.wav",
		snd_low_revdown = "simulated_vehicles/gta5_dukes/dukes_revdown.wav",
		snd_low_pitch = 0.8,
		
		snd_mid = "simulated_vehicles/gta5_dukes/dukes_mid.wav",
		snd_mid_gearup = "simulated_vehicles/gta5_dukes/dukes_second.wav",
		snd_mid_pitch = 1,
		
		snd_horn = "acf_extra/vehiclefx/horn/horn9.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.12,0,0.12,0.21,0.32,0.41}
	}
}

list.Set( "simfphys_vehicles", "gta5_bravado_gauntlet", V )

local V = {
	Name = "Canis Mesa 3",
	Model = "models/tdmcars/gtav/mesa3.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "GTA V",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 90,

	Members = {
		Mass = 1600,
		
		EnginePos = Vector(0,67,65),

		StrengthenSuspension = true,
		FrontWheelRadius = 21,
		RearWheelRadius = 21,
		
		SeatOffset = Vector(-10,0,0),
		SeatPitch = -15,
		SeatYaw = 0,
		
		PassengerSeats = {
			{
				pos = Vector(17.5,0,40),
				ang = Angle(0,0,15)
			},
			{
				pos = Vector(-17.5,-35,45),
				ang = Angle(0,0,15)
			},
			{
				pos = Vector(17.5,-35,45),
				ang = Angle(0,0,15)
			}
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-32.4,-25.5,27.4),
				ang = Angle(-90,0,0),
			}
		},
		
		FrontHeight = 10,
		FrontConstant = 27000,
		FrontDamping = 2800,
		FrontRelativeDamping = 2800,
		
		RearHeight = 10,
		RearConstant = 32000,
		RearDamping = 2900,
		RearRelativeDamping = 2900,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 8,
		
		MaxGrip = 64,
		Efficiency = 1.5,
		GripOffset = -0.01,
		BrakePower = 40,
		BulletProofTires = false,
		
		IdleRPM = 1000,
		LimitRPM = 6000,
		PeakTorque = 120,
		PowerbandStart = 2500,
		PowerbandEnd = 5500,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(35.2,48.3,56.4),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 120,
		
		PowerBias = 1,
		
		EngineSoundPreset = -1,
		
		snd_pitch = 0.8,
		snd_idle = "simulated_vehicles/gta5_dukes/dukes_idle.wav",
		
		snd_low = "simulated_vehicles/gta5_dukes/dukes_low.wav",
		snd_low_revdown = "simulated_vehicles/gta5_dukes/dukes_revdown.wav",
		snd_low_pitch = 0.8,
		
		snd_mid = "simulated_vehicles/gta5_dukes/dukes_mid.wav",
		snd_mid_gearup = "simulated_vehicles/gta5_dukes/dukes_second.wav",
		snd_mid_pitch = 1,
		
		snd_horn = "acf_extra/vehiclefx/horn/horn9.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.12,0,0.12,0.21,0.32,0.41}
	}
}

list.Set( "simfphys_vehicles", "gta5_canis_mesa3", V )

local V = {
	Name = "Vapid Police Cruiser 1",
	Model = "models/tdmcars/gtav/police.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "GTA V",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 90,

	Members = {
		Mass = 1600,
		
		EnginePos = Vector(0,80,35),

		StrengthenSuspension = true,
		FrontWheelRadius = 16,
		RearWheelRadius = 16,
		
		SeatOffset = Vector(-10,0,-5),
		SeatPitch = -15,
		SeatYaw = 0,
		
		PassengerSeats = {
			{
				pos = Vector(20,10,15),
				ang = Angle(0,0,15)
			},
			{
				pos = Vector(-20,-35,15),
				ang = Angle(0,0,15)
			},
			{
				pos = Vector(20,-35,15),
				ang = Angle(0,0,15)
			}
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-24.5,-114,14.5),
				ang = Angle(-90,90,0),
			}
		},
		
		FrontHeight = 10,
		FrontConstant = 27000,
		FrontDamping = 2800,
		FrontRelativeDamping = 2800,
		
		RearHeight = 10,
		RearConstant = 32000,
		RearDamping = 2900,
		RearRelativeDamping = 2900,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 8,
		
		MaxGrip = 64,
		Efficiency = 1.5,
		GripOffset = -0.01,
		BrakePower = 40,
		BulletProofTires = false,
		
		IdleRPM = 1000,
		LimitRPM = 6000,
		PeakTorque = 120,
		PowerbandStart = 2500,
		PowerbandEnd = 5500,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(40,-81,37.8),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 120,
		
		PowerBias = 1,
		
		EngineSoundPreset = -1,
		
		snd_pitch = 0.8,
		snd_idle = "simulated_vehicles/gta5_dukes/dukes_idle.wav",
		
		snd_low = "simulated_vehicles/gta5_dukes/dukes_low.wav",
		snd_low_revdown = "simulated_vehicles/gta5_dukes/dukes_revdown.wav",
		snd_low_pitch = 0.8,
		
		snd_mid = "simulated_vehicles/gta5_dukes/dukes_mid.wav",
		snd_mid_gearup = "simulated_vehicles/gta5_dukes/dukes_second.wav",
		snd_mid_pitch = 1,
		
		snd_horn = "acf_extra/vehiclefx/horn/horn9.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.12,0,0.12,0.21,0.32,0.41}
	}
}

list.Set( "simfphys_vehicles", "gta5_vapid_police_1", V )

local V = {
	Name = "Vapid Police Cruiser 2",
	Model = "models/tdmcars/gtav/police3.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "GTA V",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 90,

	Members = {
		Mass = 1600,
		
		EnginePos = Vector(0,80,35),

		StrengthenSuspension = true,
		FrontWheelRadius = 16,
		RearWheelRadius = 16,
		
		SeatOffset = Vector(-10,0,-10),
		SeatPitch = -5,
		SeatYaw = 0,
		
		PassengerSeats = {
			{
				pos = Vector(20,10,15),
				ang = Angle(0,0,15)
			},
			{
				pos = Vector(-20,-35,20),
				ang = Angle(0,0,15)
			},
			{
				pos = Vector(20,-35,20),
				ang = Angle(0,0,15)
			}
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-24.5,-114,14.5),
				ang = Angle(-90,90,0),
			}
		},
		
		FrontHeight = 10,
		FrontConstant = 27000,
		FrontDamping = 2800,
		FrontRelativeDamping = 2800,
		
		RearHeight = 10,
		RearConstant = 32000,
		RearDamping = 2900,
		RearRelativeDamping = 2900,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 8,
		
		MaxGrip = 64,
		Efficiency = 1.5,
		GripOffset = -0.01,
		BrakePower = 40,
		BulletProofTires = false,
		
		IdleRPM = 1000,
		LimitRPM = 6000,
		PeakTorque = 120,
		PowerbandStart = 2500,
		PowerbandEnd = 5500,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(40,-81,37.8),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 120,
		
		PowerBias = 1,
		
		EngineSoundPreset = -1,
		
		snd_pitch = 0.8,
		snd_idle = "simulated_vehicles/gta5_dukes/dukes_idle.wav",
		
		snd_low = "simulated_vehicles/gta5_dukes/dukes_low.wav",
		snd_low_revdown = "simulated_vehicles/gta5_dukes/dukes_revdown.wav",
		snd_low_pitch = 0.8,
		
		snd_mid = "simulated_vehicles/gta5_dukes/dukes_mid.wav",
		snd_mid_gearup = "simulated_vehicles/gta5_dukes/dukes_second.wav",
		snd_mid_pitch = 1,
		
		snd_horn = "acf_extra/vehiclefx/horn/horn9.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.12,0,0.12,0.21,0.32,0.41}
	}
}

list.Set( "simfphys_vehicles", "gta5_vapid_police_2", V )

local V = {
	Name = "LSPD Riot Van",
	Model = "models/tdmcars/gtav/riot.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "GTA V",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 90,

	Members = {
		Mass = 1600,
		
		EnginePos = Vector(0,80,35),

		StrengthenSuspension = true,
		FrontWheelRadius = 22,
		RearWheelRadius = 22,
		
		SeatOffset = Vector(-5,0,-5),
		SeatPitch = 0,
		SeatYaw = 0,
		
		PassengerSeats = {
			{
				pos = Vector(17,7,18),
				ang = Angle(0,-90,0)
			}
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-34,-98,15),
				ang = Angle(45,90,0),
			},
			{
				pos = Vector(34,-98,15),
				ang = Angle(45,-90,180),
			}
		},
		
		FrontHeight = 10,
		FrontConstant = 27000,
		FrontDamping = 2800,
		FrontRelativeDamping = 2800,
		
		RearHeight = 10,
		RearConstant = 32000,
		RearDamping = 2900,
		RearRelativeDamping = 2900,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 8,
		
		MaxGrip = 64,
		Efficiency = 1.5,
		GripOffset = -0.01,
		BrakePower = 40,
		BulletProofTires = false,
		
		IdleRPM = 1000,
		LimitRPM = 6000,
		PeakTorque = 120,
		PowerbandStart = 2500,
		PowerbandEnd = 5500,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(40,-81,37.8),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 120,
		
		PowerBias = 1,
		
		EngineSoundPreset = -1,
		
		snd_pitch = 0.8,
		snd_idle = "simulated_vehicles/gta5_dukes/dukes_idle.wav",
		
		snd_low = "simulated_vehicles/gta5_dukes/dukes_low.wav",
		snd_low_revdown = "simulated_vehicles/gta5_dukes/dukes_revdown.wav",
		snd_low_pitch = 0.8,
		
		snd_mid = "simulated_vehicles/gta5_dukes/dukes_mid.wav",
		snd_mid_gearup = "simulated_vehicles/gta5_dukes/dukes_second.wav",
		snd_mid_pitch = 1,
		
		snd_horn = "acf_extra/vehiclefx/horn/horn9.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.12,0,0.12,0.21,0.32,0.41}
	}
}

list.Set( "simfphys_vehicles", "gta5_lspd_riot_van", V )

local V = {
	Name = "Tractor",
	Model = "models/tdmcars/gtav/tractor.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "GTA V",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 90,

	Members = {
		Mass = 1600,
		
		EnginePos = Vector(0,80,35),

		StrengthenSuspension = true,
		FrontWheelRadius = 16,
		RearWheelRadius = 16,
		
		SeatOffset = Vector(-10,0,0),
		SeatPitch = -15,
		SeatYaw = 0,
		
		PassengerSeats = {
			{
				pos = Vector(17,7,18),
				ang = Angle(0,-90,0)
			}
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-34,-98,15),
				ang = Angle(45,90,0),
			},
			{
				pos = Vector(34,-98,15),
				ang = Angle(45,-90,180),
			}
		},
		
		FrontHeight = 10,
		FrontConstant = 27000,
		FrontDamping = 2800,
		FrontRelativeDamping = 2800,
		
		RearHeight = 10,
		RearConstant = 32000,
		RearDamping = 2900,
		RearRelativeDamping = 2900,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 8,
		
		MaxGrip = 64,
		Efficiency = 1.5,
		GripOffset = -0.01,
		BrakePower = 40,
		BulletProofTires = false,
		
		IdleRPM = 1000,
		LimitRPM = 6000,
		PeakTorque = 120,
		PowerbandStart = 2500,
		PowerbandEnd = 5500,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(40,-81,37.8),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 120,
		
		PowerBias = 1,
		
		EngineSoundPreset = -1,
		
		snd_pitch = 0.8,
		snd_idle = "simulated_vehicles/gta5_dukes/dukes_idle.wav",
		
		snd_low = "simulated_vehicles/gta5_dukes/dukes_low.wav",
		snd_low_revdown = "simulated_vehicles/gta5_dukes/dukes_revdown.wav",
		snd_low_pitch = 0.8,
		
		snd_mid = "simulated_vehicles/gta5_dukes/dukes_mid.wav",
		snd_mid_gearup = "simulated_vehicles/gta5_dukes/dukes_second.wav",
		snd_mid_pitch = 1,
		
		snd_horn = "acf_extra/vehiclefx/horn/horn9.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.12,0,0.12,0.21,0.32,0.41}
	}
}

list.Set( "simfphys_vehicles", "gta5_tractor", V )

local V = {
	Name = "Grotti Turismor",
	Model = "models/tdmcars/gtav/turismor.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "GTA V",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 90,

	Members = {
		Mass = 1600,
		
		EnginePos = Vector(0,80,35),

		StrengthenSuspension = true,
		FrontWheelRadius = 16,
		RearWheelRadius = 16,
		
		SeatOffset = Vector(-10,0,0),
		SeatPitch = -15,
		SeatYaw = 0,
		
		PassengerSeats = {
			{
				pos = Vector(17,7,18),
				ang = Angle(0,-90,0)
			}
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-34,-98,15),
				ang = Angle(45,90,0),
			},
			{
				pos = Vector(34,-98,15),
				ang = Angle(45,-90,180),
			}
		},
		
		FrontHeight = 10,
		FrontConstant = 27000,
		FrontDamping = 2800,
		FrontRelativeDamping = 2800,
		
		RearHeight = 10,
		RearConstant = 32000,
		RearDamping = 2900,
		RearRelativeDamping = 2900,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 8,
		
		MaxGrip = 64,
		Efficiency = 1.5,
		GripOffset = -0.01,
		BrakePower = 40,
		BulletProofTires = false,
		
		IdleRPM = 1000,
		LimitRPM = 6000,
		PeakTorque = 120,
		PowerbandStart = 2500,
		PowerbandEnd = 5500,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(40,-81,37.8),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 120,
		
		PowerBias = 1,
		
		EngineSoundPreset = -1,
		
		snd_pitch = 0.8,
		snd_idle = "simulated_vehicles/gta5_dukes/dukes_idle.wav",
		
		snd_low = "simulated_vehicles/gta5_dukes/dukes_low.wav",
		snd_low_revdown = "simulated_vehicles/gta5_dukes/dukes_revdown.wav",
		snd_low_pitch = 0.8,
		
		snd_mid = "simulated_vehicles/gta5_dukes/dukes_mid.wav",
		snd_mid_gearup = "simulated_vehicles/gta5_dukes/dukes_second.wav",
		snd_mid_pitch = 1,
		
		snd_horn = "acf_extra/vehiclefx/horn/horn9.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.12,0,0.12,0.21,0.32,0.41}
	}
}

list.Set( "simfphys_vehicles", "gta5_grotti_turismor", V )

local V = {
	Name = "Brute Utility Truck",
	Model = "models/tdmcars/gtav/adder.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "GTA V",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 90,

	Members = {
		Mass = 1600,
		
		EnginePos = Vector(0,80,35),

		StrengthenSuspension = true,
		FrontWheelRadius = 16,
		RearWheelRadius = 16,
		
		SeatOffset = Vector(-10,0,0),
		SeatPitch = -15,
		SeatYaw = 0,
		
		PassengerSeats = {
			{
				pos = Vector(17,7,18),
				ang = Angle(0,-90,0)
			}
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-34,-98,15),
				ang = Angle(45,90,0),
			},
			{
				pos = Vector(34,-98,15),
				ang = Angle(45,-90,180),
			}
		},
		
		FrontHeight = 10,
		FrontConstant = 27000,
		FrontDamping = 2800,
		FrontRelativeDamping = 2800,
		
		RearHeight = 10,
		RearConstant = 32000,
		RearDamping = 2900,
		RearRelativeDamping = 2900,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 8,
		
		MaxGrip = 64,
		Efficiency = 1.5,
		GripOffset = -0.01,
		BrakePower = 40,
		BulletProofTires = false,
		
		IdleRPM = 1000,
		LimitRPM = 6000,
		PeakTorque = 120,
		PowerbandStart = 2500,
		PowerbandEnd = 5500,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(40,-81,37.8),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 120,
		
		PowerBias = 1,
		
		EngineSoundPreset = -1,
		
		snd_pitch = 0.8,
		snd_idle = "simulated_vehicles/gta5_dukes/dukes_idle.wav",
		
		snd_low = "simulated_vehicles/gta5_dukes/dukes_low.wav",
		snd_low_revdown = "simulated_vehicles/gta5_dukes/dukes_revdown.wav",
		snd_low_pitch = 0.8,
		
		snd_mid = "simulated_vehicles/gta5_dukes/dukes_mid.wav",
		snd_mid_gearup = "simulated_vehicles/gta5_dukes/dukes_second.wav",
		snd_mid_pitch = 1,
		
		snd_horn = "acf_extra/vehiclefx/horn/horn9.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.12,0,0.12,0.21,0.32,0.41}
	}
}

list.Set( "simfphys_vehicles", "gta5_brute_utruck", V )

local V = {
	Name = "Pegassi Zentorno",
	Model = "models/tdmcars/gtav/zentorno.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "GTA V",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 90,

	Members = {
		Mass = 1600,
		
		EnginePos = Vector(0,80,35),

		StrengthenSuspension = true,
		FrontWheelRadius = 16,
		RearWheelRadius = 16,
		
		SeatOffset = Vector(-10,0,0),
		SeatPitch = -15,
		SeatYaw = 0,
		
		PassengerSeats = {
			{
				pos = Vector(17,7,18),
				ang = Angle(0,-90,0)
			}
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-34,-98,15),
				ang = Angle(45,90,0),
			},
			{
				pos = Vector(34,-98,15),
				ang = Angle(45,-90,180),
			}
		},
		
		FrontHeight = 10,
		FrontConstant = 27000,
		FrontDamping = 2800,
		FrontRelativeDamping = 2800,
		
		RearHeight = 10,
		RearConstant = 32000,
		RearDamping = 2900,
		RearRelativeDamping = 2900,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 8,
		
		MaxGrip = 64,
		Efficiency = 1.5,
		GripOffset = -0.01,
		BrakePower = 40,
		BulletProofTires = false,
		
		IdleRPM = 1000,
		LimitRPM = 6000,
		PeakTorque = 120,
		PowerbandStart = 2500,
		PowerbandEnd = 5500,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(40,-81,37.8),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 120,
		
		PowerBias = 1,
		
		EngineSoundPreset = -1,
		
		snd_pitch = 0.8,
		snd_idle = "simulated_vehicles/gta5_dukes/dukes_idle.wav",
		
		snd_low = "simulated_vehicles/gta5_dukes/dukes_low.wav",
		snd_low_revdown = "simulated_vehicles/gta5_dukes/dukes_revdown.wav",
		snd_low_pitch = 0.8,
		
		snd_mid = "simulated_vehicles/gta5_dukes/dukes_mid.wav",
		snd_mid_gearup = "simulated_vehicles/gta5_dukes/dukes_second.wav",
		snd_mid_pitch = 1,
		
		snd_horn = "acf_extra/vehiclefx/horn/horn9.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.12,0,0.12,0.21,0.32,0.41}
	}
}

list.Set( "simfphys_vehicles", "gta5_pegassi_zentorno", V )

local V = {
	Name = "Karin Rebel",
	Model = "models/tdmcars/gtav/rebel.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "GTA V",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 90,

	Members = {
		Mass = 1600,
		
		EnginePos = Vector(0,80,35),

		StrengthenSuspension = true,
		FrontWheelRadius = 16,
		RearWheelRadius = 16,
		
		SeatOffset = Vector(-10,0,0),
		SeatPitch = -15,
		SeatYaw = 0,
		
		PassengerSeats = {
			{
				pos = Vector(17,7,18),
				ang = Angle(0,-90,0)
			}
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-34,-98,15),
				ang = Angle(45,90,0),
			},
			{
				pos = Vector(34,-98,15),
				ang = Angle(45,-90,180),
			}
		},
		
		FrontHeight = 10,
		FrontConstant = 27000,
		FrontDamping = 2800,
		FrontRelativeDamping = 2800,
		
		RearHeight = 10,
		RearConstant = 32000,
		RearDamping = 2900,
		RearRelativeDamping = 2900,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 8,
		
		MaxGrip = 64,
		Efficiency = 1.5,
		GripOffset = -0.01,
		BrakePower = 40,
		BulletProofTires = false,
		
		IdleRPM = 1000,
		LimitRPM = 6000,
		PeakTorque = 120,
		PowerbandStart = 2500,
		PowerbandEnd = 5500,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(40,-81,37.8),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 120,
		
		PowerBias = 1,
		
		EngineSoundPreset = -1,
		
		snd_pitch = 0.8,
		snd_idle = "simulated_vehicles/gta5_dukes/dukes_idle.wav",
		
		snd_low = "simulated_vehicles/gta5_dukes/dukes_low.wav",
		snd_low_revdown = "simulated_vehicles/gta5_dukes/dukes_revdown.wav",
		snd_low_pitch = 0.8,
		
		snd_mid = "simulated_vehicles/gta5_dukes/dukes_mid.wav",
		snd_mid_gearup = "simulated_vehicles/gta5_dukes/dukes_second.wav",
		snd_mid_pitch = 1,
		
		snd_horn = "acf_extra/vehiclefx/horn/horn9.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.12,0,0.12,0.21,0.32,0.41}
	}
}

list.Set( "simfphys_vehicles", "gta5_karin_rebel", V )
