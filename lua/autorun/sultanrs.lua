AddCSLuaFile()

local light_table = {
	L_HeadLampPos = Vector(-70.9,-27.4,8.4),
	L_HeadLampAng = Angle(15,180,0),
	R_HeadLampPos = Vector(-70.9,27.4,8.4),
	R_HeadLampAng = Angle(15,-180,0),
	
	L_RearLampPos = Vector(-115,20,5),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-115,-20,5),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {
		{pos = Vector(-70.9,-27.4,8.4),material = "sprites/light_ignorez",size = 20, color = Color( 220,205,160,120)},
		{pos = Vector(-70.9,27.4,8.4),material = "sprites/light_ignorez",size = 20, color = Color( 220,205,160,120)},
		
		{pos = Vector(-70.9,-27.4,8.4),material = "sprites/light_ignorez",size = 60, color = Color( 220,205,160,50)},
		{pos = Vector(-70.9,27.4,8.4),material = "sprites/light_ignorez",size = 60, color = Color( 220,205,160,50)},
	},
	Headlamp_sprites = {
		{pos = Vector(-77.1,-21.3,8),material = "sprites/light_ignorez",size = 80, color = Color( 220,205,160,120)},
		{pos = Vector(-77.1,21.3,8),material = "sprites/light_ignorez",size = 80, color = Color( 220,205,160,120)},

		{pos = Vector(-77.1,-21.3,8),material = "sprites/light_ignorez",size = 80, color = Color( 220,205,160,50)},
		{pos = Vector(-77.1,21.3,8),material = "sprites/light_ignorez",size = 80, color = Color( 220,205,160,50)},
	},
	Rearlight_sprites = {
		{pos = Vector(91,-17.2,13.2),material = "sprites/light_ignorez",size = 45,color = Color( 255, 0, 0,  150)},
		{pos = Vector(91,17.2,13.2),material = "sprites/light_ignorez",size = 45,color = Color( 255, 0, 0,  150)},
		{pos = Vector(89.6,-24.8,13.4),material = "sprites/light_ignorez",size = 45,color = Color( 255, 0, 0,  150)},
		{pos = Vector(89.6,24.8,13.4),material = "sprites/light_ignorez",size = 45,color = Color( 255, 0, 0,  150)},
		{pos = Vector(90.6,-20.4,13.4),material = "sprites/light_ignorez",size = 45,color = Color( 255, 0, 0,  150)},
		{pos = Vector(90.6,20.4,13.4),material = "sprites/light_ignorez",size = 45,color = Color( 255, 0, 0,  150)},
		{pos = Vector(87,-27.5,13.4),material = "sprites/light_ignorez",size = 45,color = Color( 255, 0, 0,  150)},
		{pos = Vector(87,27.5,13.4),material = "sprites/light_ignorez",size = 45,color = Color( 255, 0, 0,  150)},
		{pos = Vector(83.8,-29.5,13.4),material = "sprites/light_ignorez",size = 45,color = Color( 255, 0, 0,  150)},
		{pos = Vector(83.8,29.5,13.4),material = "sprites/light_ignorez",size = 45,color = Color( 255, 0, 0,  150)},
	},
	Brakelight_sprites = {
		{pos = Vector(0,0,0),material = "sprites/light_ignorez",size = 45,color = Color( 255, 0, 0,  150)},
		{pos = Vector(0,0,0),material = "sprites/light_ignorez",size = 45,color = Color( 255, 0, 0,  150)},
	},
	Reverselight_sprites = {
		{pos = Vector(90.5,-18,16.4),material = "sprites/light_ignorez",size = 25,color = Color( 255, 255, 255, 255)},
		{pos = Vector(90.5,18,16.4),material = "sprites/light_ignorez",size = 25,color = Color( 255, 255, 255, 255)},
		{pos = Vector(90.2,-22.1,16.4),material = "sprites/light_ignorez",size = 25,color = Color( 255, 255, 255, 255)},
		{pos = Vector(90.2,22.1,16.4),material = "sprites/light_ignorez",size = 25,color = Color( 255, 255, 255, 255)},
		{pos = Vector(88.7,-26,16.4),material = "sprites/light_ignorez",size = 25,color = Color( 255, 255, 255, 255)},
		{pos = Vector(88.7,26,16.4),material = "sprites/light_ignorez",size = 25,color = Color( 255, 255, 255, 255)},
	},
	
	DelayOn = 0.25,
	DelayOff = 0.25,
	
	Turnsignal_sprites = {
		Left = {
			{pos = Vector(89.8,-22.8,18.8),material = "sprites/light_ignorez",size = 55},
			{pos = Vector(88.4,-25.3,18.3),material = "sprites/light_ignorez",size = 55},
			{pos = Vector(86.6,-26.8,17.5),material = "sprites/light_ignorez",size = 55},
			{pos = Vector(84.7,-27.9,16.5),material = "sprites/light_ignorez",size = 55},
		},
		Right = {
			{pos = Vector(89.8,22.8,18.8),material = "sprites/light_ignorez",size = 55},
			{pos = Vector(88.4,25.3,18.3),material = "sprites/light_ignorez",size = 55},
			{pos = Vector(86.6,26.8,17.5),material = "sprites/light_ignorez",size = 55},
			{pos = Vector(84.7,27.9,16.5),material = "sprites/light_ignorez",size = 55},
		},
	},
}
list.Set( "simfphys_lights", "gta5_sultanrs", light_table)

local V = {
    Name = "[WIP] Sultan RS",
    Model = "models/gta-online/sultanrs/sultanrs_hi_5.mdl",
    Class = "gmod_sent_vehicle_fphysics_base",
    Category = "GTA V",
    SpawnOffset = Vector(0,0,10),
    SpawnAngleOffset = 90,
    OnSpawn = function(ent)
    	local prop=ents.Create("prop_dynamic_ornament")
    	prop:SetModel("models/gta-online/sultanrs/sultanrs_hi_666_2.mdl")
    	prop:SetPos(ent:GetPos())
    	prop:SetAngles(ent:GetAngles())
    	prop:Spawn()
    	prop:SetParent(ent)
	end,
    Members = {
        Mass = 1260,
        LightsTable = "gta5_sultanrs",
        EnginePos = Vector(-54,0.0,12.7),

        StrengthenSuspension = false,
        
        CustomWheels = true,
        CustomWheelModel = "models/gta-online/sultanrs/sultanrs_wheel.mdl",
        CustomWheelPosFL = Vector(-53.2,-33.2,0),
        CustomWheelPosFR = Vector(-53.2,33.2,0),
        CustomWheelPosRL = Vector(53.5,-33.2,0),
        CustomWheelPosRR = Vector(53.5,33.2,0),
        CustomWheelAngleOffset = Angle(0,90,0),
        CustomSuspensionTravel = 0,
        CustomSteerAngle = 35,

		      SeatOffset = Vector(-5,-13.5,25),
		      SeatPitch = -15,
		      SeatYaw = -90,
        SeatRoll = 0,

		      PassengerSeats = {
			         {
				            pos = Vector(6.8,13.5,-7.0),
				            ang = Angle(0,90,15)
			         }
		      },
		      ExhaustPositions = {
			         {
				            pos = Vector(-14.3,-31.2,-7.8),
				            ang = Angle(90,-45,0),
			         }
		      },

		      FrontHeight = 10,
		      FrontConstant = 50000,
		      FrontDamping = 2800,
		      FrontRelativeDamping = 2800,

		      RearHeight = 10,
		      RearConstant = 50000,
		      RearDamping = 2800,
		      RearRelativeDamping = 2800,

		      FastSteeringAngle = 12.5,
		      SteeringFadeFastSpeed = 535,

		      TurnSpeed = 8,

		      MaxGrip = 65,
		      Efficiency = 1,
		      GripOffset = -0.05,
		      BrakePower = 40,
		      BulletProofTires = false,

		      IdleRPM = 1000,
		      LimitRPM = 10000,
		      PeakTorque = 193,
		      PowerbandStart = 1750,
		      PowerbandEnd = 7000,
		      Turbocharged = true,
		      Supercharged = false,
		      Revlimiter = true,

		      FuelFillPos = Vector(44.6,27.0,26.3),
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
		      Gears = {-0.12,0,0.12,0.21,0.32,0.41,0.55}
    }
}

list.Set( "simfphys_vehicles", "gta5_sultanrs", V )
