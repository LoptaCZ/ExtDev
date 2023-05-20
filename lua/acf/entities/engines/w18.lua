local ACF     = ACF
local Engines = ACF.Classes.Engines


Engines.Register("W18", {
	Name = "W18 Engine",
})

do
	Engines.RegisterItem("tatra-v955", "W18", {
		Name		 = "22.2L W18 Engine Diesel",
		Description	 = "This little banger was used in Tatra V955",
		Model		 = "models/engines/v12l.mdl",
		Sound		 = "acf_base/engines/v12_petrolsmall.wav",
		Fuel		 = { Diesel = true },
		Type		 = "GenericDiesel",
		Mass		 = 2000,
		Torque		 = 4639,
		FlywheelMass = 0.75,
		RPM = {
			Idle	= 1000,
			Limit	= 5000,
		},
		Preview = {
			FOV = 95,
		},
	})

	Engines.RegisterItem("bugatti-eb-118", "W18", {
		Name		 = "6.3L W18 Petrol",
		Description	 = "TORQUE.",
		Model		 = "models/engines/v12s.mdl",
		Sound		 = "acf_base/engines/v12_petrolsmall.wav",
		Fuel		 = { Petrol = true },
		Type		 = "GenericPetrol",
		Mass		 = 800,
		Torque		 = 2000,
		FlywheelMass = 7,
		RPM = {
			Idle	= 350,
			Limit	= 1200,
		},
		Preview = {
			FOV = 95,
		},
	})

	Engines.RegisterItem("bugatti-eb-218", "W18", {
		Name		 = "6.3L W18 Petrol",
		Description	 = "TORQUE.",
		Model		 = "models/engines/v12s.mdl",
		Sound		 = "acf_base/engines/v12_petrolsmall.wav",
		Fuel		 = { Diesel = true },
		Type		 = "GenericDiesel",
		Mass		 = 800,
		Torque		 = 2000,
		FlywheelMass = 0.7,
		RPM = {
			Idle	= 350,
			Limit	= 1200,
		},
		Preview = {
			FOV = 95,
		},
	})

	Engines.RegisterItem("bugatti-18-3-chiron", "W18", {
		Name		 = "6.3L W18 Petrol",
		Description	 = "TORQUE.",
		Model		 = "models/engines/v12s.mdl",
		Sound		 = "acf_base/engines/v12_petrolsmall.wav",
		Fuel		 = { Diesel = true },
		Type		 = "GenericDiesel",
		Mass		 = 2000,
		Torque		 = 4639,
		FlywheelMass = 0.75,
		RPM = {
			Idle	= 350,
			Limit	= 1200,
		},
		Preview = {
			FOV = 95,
		},
	})

	Engines.RegisterItem("bugatti-veyron", "W18", {
		Name		 = "6.3L W18 Petrol",
		Description	 = "TORQUE.",
		Model		 = "models/engines/v12s.mdl",
		Sound		 = "acf_base/engines/v12_petrolsmall.wav",
		Fuel		 = { Diesel = true },
		Type		 = "GenericDiesel",
		Mass		 = 2000,
		Torque		 = 4639,
		FlywheelMass = 0.75,
		RPM = {
			Idle	= 350,
			Limit	= 1200,
		},
		Preview = {
			FOV = 95,
		},
	})

end

ACF.SetCustomAttachment("models/engines/v12l.mdl", "driveshaft", Vector(-34, 0, 7.3), Angle(0, 90, 90))
ACF.SetCustomAttachment("models/engines/v12m.mdl", "driveshaft", Vector(-22.61, 0, 4.85), Angle(0, 90, 90))
ACF.SetCustomAttachment("models/engines/v12s.mdl", "driveshaft", Vector(-18.09, 0, 3.88), Angle(0, 90, 90))

local Models = {
	{ Model = "models/engines/v12l.mdl", Scale = 1.85 },
	{ Model = "models/engines/v12m.mdl", Scale = 1.25 },
	{ Model = "models/engines/v12s.mdl", Scale = 1 },
}

for _, Data in ipairs(Models) do
	local Scale = Data.Scale

	ACF.AddHitboxes(Data.Model, {
		Main = {
			Pos   = Vector(-1.25, 0, 7.5) * Scale,
			Scale = Vector(36, 11.5, 16.5) * Scale,
			Sensitive = true
		},
		LeftBank = {
			Pos   = Vector(-0.25, -6.5, 11) * Scale,
			Scale = Vector(34, 8, 11.25) * Scale,
			Angle = Angle(0, 0, 45)
		},
		RightBank = {
			Pos   = Vector(-0.25, 6.5, 11) * Scale,
			Scale = Vector(34, 8, 11.25) * Scale,
			Angle = Angle(0, 0, -45)
		}
	})
end
