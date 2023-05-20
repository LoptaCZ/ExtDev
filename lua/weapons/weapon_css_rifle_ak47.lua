AddCSLuaFile()
SWEP.Base = "weapon_base"
SWEP.Category = "Counter Strike: Source"
SWEP.PrintName = "AK - 47"
SWEP.HoldType		= "ar2"
SWEP.Slot = 1
SWEP.SlotPos = 2
SWEP.IconLetter = "b"

SWEP.Spawnable = true
SWEP.AutoSwitchFrom = true
SWEP.AutoSwitchTo = true
SWEP.DrawWeaponInfoBox = false
SWEP.UseHands = true

SWEP.ViewModel = Model("models/weapons/cstrike/c_rif_ak47.mdl")
SWEP.WorldModel = Model("models/weapons/w_rif_ak47.mdl")
SWEP.ViewModelFOV = 64
SWEP.Deploy = 50

SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 90
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "csgo_7.62"
SWEP.Primary.Sound = "weapons/ak47/ak47-1.wav"
SWEP.Primary.Damage		    = 36
SWEP.Primary.NumShots		= 1
SWEP.Primary.Recoil			= 5
SWEP.Primary.Cone			= 3
SWEP.Primary.Tracer			= 1
SWEP.Primary.Force			= 200
SWEP.Primary.Delay			= 0.1

SWEP.Secondary.Ammo = ""

SWEP.DrawAmmo = true
SWEP.AdminOnly = false

SWEP.CSMuzzleFlashes  = true
SWEP.AccurateCrosshair = false

SWEP.IronSightsPos = Vector(-4.64, -7.84, 0.699)
SWEP.IronSightsAng = Vector(0, 0, 0)

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	if CLIENT then killicon.AddFont("weapon_css_rifle_ak47","counterstrikedeaths",self.IconLetter,Color(255,80,0,255)) end
end

function SWEP:Think()
	if SERVER then
		if self.Owner:KeyDown(IN_WALK) then
			if self.Owner:KeyPressed(IN_RELOAD) then
				self.Owner:DropWeapon(self)
			end
		end
	end
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end	
	local bullet={}
		bullet.Num = self.Primary.NumShots
		bullet.Src = self.Owner:GetShootPos()
		bullet.Dir = self.Owner:GetAimVector()
		bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 90, 0 )
		bullet.Tracer = self.Primary.Tracer
		bullet.Force = self.Primary.Force*self.Primary.Damage
		bullet.Damage = self.Primary.Damage
		bullet.Callback=function(Attacker,Trace,DmgInfo)
			if Trace.HitNonworld then
				local Bone = Trace.PhysicsBone
				local Ent  = Trace.Entity
				if Bone == 10 then
					bullet.Damage = self.Primary.Damage+110
				else
					bullet.Damage = self.Primary.Damage
				end
				
			end
		end
		
		bullet.AmmoType = self.Primary.Ammo
		self.Owner:FireBullets( bullet )
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:MuzzleFlash()
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:EmitSound(Sound(self.Primary.Sound))
	self.Owner:ViewPunch(Angle( -self.Primary.Recoil, 0, 0 ))
	if (self.Primary.TakeAmmoPerBullet) then
		self:TakePrimaryAmmo(self.Primary.NumShots)
	else
		self:TakePrimaryAmmo(1)
	end
	self:SetNextPrimaryFire(CurTime()+self.Primary.Delay)
	//	ACF PART
	if SERVER then
		local trs = {}
		trs.start  = self.Owner:GetShootPos()
		trs.endpos = self.Owner:GetShootPos()+(self.Owner:GetAimVector()*999999999999999999999999)
		trs.filter = self.Owner
		local tr = util.TraceLine(trs)
		local ent = tr.Entity

		if tr.HitNonWorld then
			if ACF_Check(ent)and ent:GetClass()=="prop_physics" then
				HitRes = ACF_Damage(ent,{Kinetic=5000,Momentum=5000,Penetration=1500},5,0,self.Owner,0)
			end
		end
	end
end

function SWEP:SecondaryAttack()
	return false
end

function SWEP:Reload()	
	self:DefaultReload(ACT_VM_RELOAD)
	return true
end

function SWEP:SetDeploySpeed(x)
	self.m_WeaponDeploySpeed=tonumber(x)
end

function SWEP:Deploy()
	self:SetDeploySpeed(self.Deploy)
	return true
end

function SWEP:Holster()
	self.Weapon:SendWeaponAnim(ACT_VM_HOLSTER)
	return true
end

function SWEP:OnRemove()
end

function SWEP:OnRestore()
	self:SetDeploySpeed(self.Deploy)
end

function SWEP:Precache()
end

function SWEP:OwnerChanged()
end
