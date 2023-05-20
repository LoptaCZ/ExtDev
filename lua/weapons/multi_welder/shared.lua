AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

SWEP.PrintName			= "Universal Welder"
SWEP.Slot				= 0
SWEP.SlotPos			= 6
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true
SWEP.Category			= "Universal Tools"
SWEP.HoldType 			= "pistol"
SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.Spawnable 			= true
SWEP.AdminOnly			= true
SWEP.UseHands           = true
SWEP.Instructions		= "Primary to repair.\nSecondary to damage."

SWEP.Primary.Ammo			= "none"
SWEP.Primary.Automatic		= false
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Purpose				= "Blah Blah Blah"
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.Automatic	= false
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1

SWEP.ViewModelFlip			= false
SWEP.ViewModelFOV			= 65
SWEP.ViewModel				= "models/weapons/c_pistol.mdl"
SWEP.ShowViewModel			= false
SWEP.WorldModel 			= "models/weapons/w_eq_taser.mdl"
SWEP.ShowWorldModel			= true

SWEP.VElements = {
	["scr"] = { type = "Model", model = "models/kobilica/wiremonitorrt.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "element_name", pos = Vector(4, -4, 3), angle = Angle(135, 0, 180), size = Vector(0.5, 0.4, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["pipes"] = { type = "Model", model = "models/props_c17/playground_teetertoter_stan.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scr", pos = Vector(0, -1.75, 1), angle = Angle(90, 0, -90), size = Vector(0.05, 0.05, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["element_name"] = { type = "Model", model = "models/weapons/w_eq_taser.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-1, 1, 0), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

function SWEP:Initialize()
	function table.FullCopy( tab )
		if (!tab) then return nil end
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) // recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end	
		return res
	end

	self.Weapon:SetHoldType( self.HoldType )
	self.LastSend = 0

	if CLIENT then
	
		// Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels
		
	end
end

function SWEP:PrimaryAttack()
	if SERVER then
		local O = self.Owner
		local D = 128

		if O:IsPlayer() then
			if string.lower(team.GetName(O:Team()))=="admin" then
				D=512
			elseif string.lower(team.GetName(O:Team()))=="superadmin" then
				D=2147483647
			else
				D=128
			end

			if O:KeyDown(IN_ATTACK) then
				hook.Remove("Think","MULTI_WELD_THINK_SEC")
				hook.Add("Think","MULTI_WELD_THINK_PRIM",function()
				local trs = {}
				trs.start  = O:GetShootPos()
				trs.endpos = O:GetShootPos()+(O:GetAimVector()*D)
				trs.filter = O
				local tr = util.TraceLine(trs)
				local ent = tr.Entity

				if tr.HitNonWorld then
					if ent:IsPlayer() then
						local HP = ent:Health()
						local AP = ent:Armor()
						ent:SetHealth(math.Clamp(HP+5,HP,ent:GetMaxHealth()))
						ent:SetArmor(math.Clamp(AP+5,AP,ent:GetMaxHealth()))
						ent:Ignite(0.001,0)
						ent:Extinguish()
						--if HP<=0 then ent:Kill() end
						--HitRes = ACF_Damage ( ent , {Kinetic = 0.05,Momentum = 0,Penetration = 0.05} , 2 , 0 , self.Owner )
						elseif ent:IsNPC() then
							local HP = ent:Health()
							ent:SetHealth(math.Clamp(HP+5,HP,ent:GetMaxHealth()))
							//ent:Ignite(0.001,0)
							ent:Extinguish()
						elseif ent:GetClass()==("gmod_sent_vehicle_fphysics_base"or"gmod_sent_vehicle_fphysics_wheel") then
							local HP = ent:GetCurHealth()
							ent:SetCurHealth(math.Clamp(HP+5,HP,ent:GetMaxHealth()))
							ent:SetFuel(math.Clamp(ent:GetFuel()+5,0,ent:GetMaxFuel()))
							ent:SetOnFire(false)
							ent:SetOnSmoke(false)
							for i=1,table.Count(ent.pSeat)do
								local HasPassenger = IsValid(ent.pSeat[i]:GetDriver())
								if HasPassenger then
									local Driv=ent.pSeat[i]:GetDriver()
									Driv:SetHealth(math.Clamp(Driv:Health()+5,0,Driv:GetMaxHealth()))
								else
									local Driv=ent:GetDriver()
									if IsValid(Driv)then
										Driv:SetHealth(math.Clamp(Driv:Health()+5,0,Driv:GetMaxHealth()))
									end
								end
							end
							net.Start( "simfphys_lightsfixall" )
								net.WriteEntity( ent )
							net.Broadcast()
							if istable(ent.Wheels) then
								for i = 1, table.Count( ent.Wheels ) do
									local Wheel = ent.Wheels[ i ]
									if IsValid(Wheel) then
										Wheel:SetDamaged(false)
										Wheel:Ignite(0.001,0)
										Wheel:Extinguish()
									end
								end
							end
							//ent:Ignite(0.001,0)
							ent:Extinguish()
						else
							local ACF_Walid = ACF_Check(ent)
							if ACF_Walid then
								local HP = ent.ACF.Health
								local AP = ent.ACF.Armour
								local MHP = ent.ACF.MaxHealth
								local MAP = ent.ACF.MaxArmour
								ent.ACF.Health = math.Clamp(HP+1,HP,MHP)
								ent.ACF.Armour = math.Clamp(AP+1,AP,MAP)
								--if CPPI and not ent:CPPICanTool( self.Owner, "multi_welder" ) then return false end
								--HitRes = ACF_Damage ( ent , {Kinetic = 5,Momentum = 0,Penetration = 5} , 2 , 0 , self.Owner )
							end
							ent:Ignite(0.001,0)
							ent:Extinguish()
						end-- ent:IsPlayer
					end--ir.HitNonWorld
				end)--hook
			else
				hook.Remove("Think","MULTI_WELD_THINK_PRIM")
				hook.Remove("Think","MULTI_WELD_THINK_SEC")
			end-- if O:Key
		else

		end-- is player
	end-- if SERVER
end--function

function SWEP:SecondaryAttack()
	if SERVER then
		local O=self.Owner
		local D = 128

		if string.lower(team.GetName(O:Team()))=="admin" then
			D=512
		elseif string.lower(team.GetName(O:Team()))=="superadmin" then
			D=2147483647
		else
			D=128
		end
		if O:KeyDown(IN_ATTACK2) then
			hook.Remove("Think","MULTI_WELD_THINK_PRIM")
			hook.Add("Think","MULTI_WELD_THINK_SEC",function()
				local trs = {}
				trs.start = O:GetShootPos()
				trs.endpos = O:GetShootPos()+(O:GetAimVector()*D)
				trs.filter = O
				local tr=util.TraceLine(trs)
				local ent=tr.Entity

				if tr.HitNonWorld then
					if ent:IsPlayer() then
						local HP = ent:Health()
						local AP = ent:Armor()
						ent:SetHealth(math.Clamp(HP-1,math.Clamp(ent:Health()-1,0,ent:Health()),ent:Health()))
						ent:SetArmor(math.Clamp(AP-1,math.Clamp(ent:Armor()-1,0,ent:Armor()),ent:Armor()))
						if HP<=0 then ent:Kill() end
						--HitRes = ACF_Damage ( ent , {Kinetic = 0.05,Momentum = 0,Penetration = 0.05} , 2 , 0 , self.Owner )
					elseif ent:IsNPC() then
						local HP = ent:Health()
						ent:SetHealth(math.Clamp(HP-1,0,ent:Health()))
						if HP<=0 then SafeRemoveEntity(ent) end
					elseif ent:GetClass()==("gmod_sent_vehicle_fphysics_base"or"gmod_sent_vehicle_fphysics_wheel") then
						local HP = ent:GetCurHealth()
						ent:SetCurHealth(math.Clamp(HP-1,1,ent:GetMaxHealth()))
						ent:SetFuel(math.Clamp(ent:GetFuel()-5,0,ent:GetMaxFuel()))
						for i=1,table.Count(ent.pSeat)do
							local HasPassenger = IsValid(ent.pSeat[i]:GetDriver())
							if HasPassenger then
								local Driv=ent.pSeat[i]:GetDriver()
								Driv:SetHealth(math.Clamp(Driv:Health()-1,0,Driv:GetMaxHealth()))
							else
								local Driv=ent:GetDriver()
								if IsValid(Driv)then
									Driv:SetHealth(math.Clamp(Driv:Health()-1,0,Driv:GetMaxHealth()))
								end
							end
						end
					else
						local ACF_Walid = ACF_Check(ent)
						if ACF_Walid then
							local HP = ent.ACF.Health
							local AP = ent.ACF.Armour
							local MHP = ent.ACF.MaxHealth
							local MAP = ent.ACF.MaxArmour
							ent.ACF.Health = math.Clamp(HP-1,math.Clamp(HP-1,0,MHP),MHP)
							ent.ACF.Armour = math.Clamp(AP-1,math.Clamp(AP-1,0,MAP),MAP)
							if(ent:IsPlayer()) then
								HitRes = ACF_Damage ( ent , {Kinetic = 0.05,Momentum = 0,Penetration = 0.05} , 2 , 0 , self.Owner )--We can use the damage function instead of direct access here since no numbers are negative.
							else
							if CPPI and not ent:CPPICanTool( self.Owner, "torch" ) then return false end
							HitRes = ACF_Damage ( ent , {Kinetic = 5,Momentum = 0,Penetration = 5} , 2 , 0 , self.Owner )--We can use the damage function instead of direct access here since no numbers are negative.
			end
						end
					end
				end--if tr.HitNon
			end)--hook
		else
			hook.Remove("Think","MULTI_WELD_THINK_PRIM")
			hook.Remove("Think","MULTI_WELD_THINK_SEC")
		end--if O:KeyPress
	end--if SERVER
end--function

function SWEP:Think()
	if SERVER then
		local O=self.Owner
		local D = 128
	
		if string.lower(team.GetName(O:Team()))=="admin" then
			D=512
		elseif string.lower(team.GetName(O:Team()))=="superadmin" then
			D=2147483647
		else
			D=128
		end

		if !(O:KeyDown(IN_ATTACK) or O:KeyDown(IN_ATTACK2)) then hook.Remove("Think","MULTI_WELD_THINK_PRIM") hook.Remove("Think","MULTI_WELD_THINK_SEC") end
	
		local trs={}
		trs.start  = O:GetShootPos()
		trs.endpos = O:GetShootPos()+(O:GetAimVector()*D)
		trs.filter = O

		local tr=util.TraceLine(trs)
		local ent=tr.Entity 
	
		if(tr.HitNonWorld)and tr.Entity:GetOwner()!="N/A" then	
			if ent:IsPlayer() then
				self.Weapon:SetNWBool("Hit",true)
				self.Weapon:SetNWFloat("HP",ent:Health())
				self.Weapon:SetNWFloat("AP",ent:Armor())
				self.Weapon:SetNWFloat("MHP",ent:GetMaxHealth())
				self.Weapon:SetNWFloat("MAP",ent:GetMaxHealth())
			elseif ent:IsNPC() then
				self.Weapon:SetNWBool("Hit",true)
				self.Weapon:SetNWFloat("HP",ent:Health())
				self.Weapon:SetNWFloat("AP",0)
				self.Weapon:SetNWFloat("MHP",ent:GetMaxHealth())
				self.Weapon:SetNWFloat("MAP",0)
	
			elseif ent:GetClass()==("gmod_sent_vehicle_fphysics_base"or"gmod_sent_vehicle_fphysics_wheel") then
			self.Weapon:SetNWBool("Hit",true)
				self.Weapon:SetNWFloat("HP",ent:GetCurHealth())
				self.Weapon:SetNWFloat("MHP",ent:GetMaxHealth())
			elseif ent:GetClass()=="prop_door_rotating"then
				self.Weapon:SetNWBool("Hit",false)
			else
				if IsValid(ent)and self.LastSend<CurTime() then
					self.LastSend=CurTime()+0.01
					local ACF_Walid = ACF_Check(ent)
					if ACF_Walid then
						self.Weapon:SetNWBool("Hit",true)
						self.Weapon:SetNWFloat("HP",ent.ACF.Health)
						self.Weapon:SetNWFloat("AP",ent.ACF.Armour)
						self.Weapon:SetNWFloat("MHP",ent.ACF.MaxHealth)
						self.Weapon:SetNWFloat("MAP",ent.ACF.MaxArmour)
					end
				end
			end
		else
			self.Weapon:SetNWBool("Hit",false)
			self.Weapon:SetNWFloat("HP",0)
			self.Weapon:SetNWFloat("AP",0)
			self.Weapon:SetNWFloat("MHP",0)
			self.Weapon:SetNWFloat("MAP",0)
		end

		self:NextThink(CurTime()+0.01)

		if self.Owner:KeyDown(IN_WALK) then
			if self.Owner:KeyPressed(IN_RELOAD) then
				self.Owner:DropWeapon(self)
			end
		end
	end
end

function SWEP:Reload()
	if SERVER then
		local O=self.Owner
		local D = 128
			if O:IsAdmin() then
				D=8192
			elseif O:IsSuperAdmin() then
				local _,Max=game.GetWorld():GetModelBounds()
				D=Max.x+Max.y+Max.z
			else
				D=128
			end

		local trs={}
		trs.start  = O:GetShootPos()
		trs.endpos = O:GetShootPos()+(O:GetAimVector()*D)
		trs.filter = O
		local tr=util.TraceLine(trs)
		local ent=tr.Entity

		local Inertia = ent:GetPhysicsObject():GetInertia() or "Doesn't have any"

		if not O:KeyDownLast(IN_RELOAD)then
			O:PrintMessage(HUD_PRINTTALK,"[ExtDev] Universal Welder: ")
			O:PrintMessage(HUD_PRINTTALK,"Current Object Inertia is: "..tostring(Inertia))
			if (tr.HitNonWorld) and ACF_Check(ent) then
				if ent:GetClass()=="acf_engine"then
					local SpecialBoost = ent.RequiresFuel and ACF.TorqueBoost or 1
					local Power_kW,Power_HP = math.Round( ent.peakkw * SpecialBoost ),math.Round( ent.peakkw * SpecialBoost * 1.34 )
					local Torque = ent.PeakTorque
					local PB_Min,PB_Max = ent.PeakMinRPM,ent.PeakMaxRPM
					local Redline = ent.LimitRPM
					local Weight = ent:GetPhysicsObject():GetMass()

					O:PrintMessage(HUD_PRINTTALK,"This Engine have "..Power_kW.." kW and "..Power_HP.." HP")
					O:PrintMessage(HUD_PRINTTALK,"This Engine have "..Torque.." Nm")
					O:PrintMessage(HUD_PRINTTALK,"This Engine have most Power between "..PB_Min.." & "..PB_Max.." RPM")
					O:PrintMessage(HUD_PRINTTALK,"This Engine have Redline at "..Redline.." RPM")
					O:PrintMessage(HUD_PRINTTALK,"This Engine weights "..Weight.." kg")
				elseif ent:GetClass()=="acf_gearbox"then
					local Wheels = ent.WheelLink
					local Gear = ent.Gear
					local Ratio = ent.GearRatio
					local RPM = ent.RPM
					local Weight = ent:GetPhysicsObject():GetMass()

					O:PrintMessage(HUD_PRINTTALK,"This Gearbox have: "..tostring(Gear).." as current gear.")
					O:PrintMessage(HUD_PRINTTALK,"This Gearbox have: "..tostring(Ratio).." as current gear ratio.")
					O:PrintMessage(HUD_PRINTTALK,"This Gearbox have: "..tostring(RPM[1]).." as current RPM.")
					O:PrintMessage(HUD_PRINTTALK,"This Gearbox weights: "..tostring(Weight))
					if Wheels[1] then
						O:PrintMessage(HUD_PRINTTALK,"This Gearbox have connected: ")
						for _,Wh in pairs(Wheels)do
							O:PrintMessage(HUD_PRINTTALK,"		"..Wh.Ent:GetClass().." ["..Wh.Ent:GetCreationID().."]")
						end
					end
				elseif ent:GetClass()=="acf_gun"then

				elseif ent:GetClass()=="acf_ammo"then

				elseif ent:GetClass()=="acf_fueltank"then
					local Fuel = ent.Fuel
					local Volume = ent.Volume
					local Capacity = ent.Capacity
					local Type = ent.FuelType
					local Weight = ent:GetPhysicsObject():GetMass()
					
					O:PrintMessage(HUD_PRINTTALK,"This fueltank have: "..tostring(Fuel).." liters.")
					O:PrintMessage(HUD_PRINTTALK,"This fueltank capacity: "..tostring(Capacity))
					O:PrintMessage(HUD_PRINTTALK,"This fueltank have volume: "..tostring(Volume))
					O:PrintMessage(HUD_PRINTTALK,"This fueltank is filled with: "..tostring(Type))
					O:PrintMessage(HUD_PRINTTALK,"This fueltank weights: "..tostring(Weight))
				end
			end
		end
	end
end

function SWEP:Holster()
	
	if CLIENT and IsValid(self.Owner) then
		if self.Owner:IsPlayer() then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
			end
		end
	end
	
	return true
end

function SWEP:OnRemove()
	self:Holster()
	hook.Remove("Think","MULTI_WELD_THINK_SEC")
	hook.Remove("Think","MULTI_WELD_THINK_PRIM")
end

