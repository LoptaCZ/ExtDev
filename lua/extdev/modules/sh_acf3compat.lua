local Temp={}
	Temp.Name="Test Weapon"
	Temp.Description="Test"
	Temp.Sound=""
	Temp.Model=""
	Temp.MuzzleFlash=""
	Temp.Cleanup=nil
	Temp.DefaultAmmo=""
	Temp.IsScalable=false
	Temp.IsBoxed=false
	Temp.Spread=5
	Temp.Mass=69
	Temp.Cyclic=5
	Temp.MagSize=1
	Temp.LimitConVar=nil
	Temp.Round=nil
	Temp.Preview=nil
	Temp.Caliber=nil
	Temp.MagReload=nil

local function registerWeaponGroup(id,data)
	local W=table.Copy(Temp)

	Weapons.RegisterItem(id,data["gunclass"],W)
	for k,v in pairs(Temp)do
		if k!=null then
			Weapons.Register(id,mix)
		end
	end
end

function ACF_defineGunClass(id,data)//	STRING | TABLE
	Temp.Name=data[""]
	Temp.Description=data[""]
	Temp.Sound=data[""]
	Temp.Model=data[""]
	Temp.MuzzleFlash=data[""]
	Temp.Cleanup=data[""]
	Temp.DefaultAmmo=data[""]
	Temp.IsScalable=data[""]
	Temp.IsBoxed=data[""]
	Temp.Spread=data[""]
	Temp.Mass=data[""]
	Temp.Cyclic=data[""]
	Temp.MagSize=data[""]
	Temp.LimitConVar=data[""]
	Temp.Round=data[""]
	Temp.Preview=data[""]
	Temp.Caliber=data[""]
	Temp.MagReload=data[""]

	registerGroup(id,data)
	registerWeapon(id,data)
end

function ACF_defineGun(id,data)//	STRING | TABLE


	registerGroup(id,data)
	registerWeapon(id,data)
end


function ACF_DefineEngine(id,data)//	STRING | TABLE
	local E={}
	E["Name"]=data["name"]
	E["Description"]=data["desc"]
	E["Model"]=data["model"]
	E["Sound"]=data["sound"]
	//E["Fuel"]=data[""]
	E["Type"]=data["enginetype"]
	E["Mass"]=data["weight"]
	E["Torque"]=data["torque"]
	E["FlywheelMass"]=data["flywheelmass"]
	E["RPM"]={Idle=data["idlerpm"],Limit=data["limitrpm"]}
	E["Preview"]={FOV=80}

	Engines.RegisterItem(id,data["category"],E)
end

function ACF_DefineGearbox(id,data)//	STRING | TABLE
	local GB={}
	GB["Name"]=data["name"]
	GB["Description"]=data["desc"]
	GB["Model"]=data["model"]
	GB["Mass"]=data["weight"]
	GB["Switch"]=data["switch"]
	GB["MaxTorque"]=data["maxtq"]
	GB["Preview"]={FOV=125}

	Gearboxes.RegisterItem(id,data["category"].." Gearbox",GB)
end

function ACF_DefineFuelTank(id,data)//	STRING | TABLE
	local FT={}
	FT["Name"]=data["name"]
	FT["Description"]=data["desc"]

	FuelTanks.Register(id,FT)
end

function ACF_DefineFuelTankSize(id,data)//	STRING | TABLE
	local FT={}
	FT["Name"]=data["name"]
	FT["Description"]=data["desc"]
	FT["Model"]=data["model"]
	FT["SurfaceArea"]=data["dims"]["S"]
	FT["Volume"]=data["dims"]["V"]
	FT["Shape"]=data[""]
	if isbool(data["nolinks"]) and data["nolinks"] then FT["Unlinkable"]=data["nolinks"]end
	if isbool(data["explosive"]) and data["explosive"] then FT["IsExplosive"]=data["explosive"]end

	FuelTanks.RegisterItem(id,cat,FT)
end