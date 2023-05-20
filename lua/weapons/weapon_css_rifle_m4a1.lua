AddCSLuaFile()
SWEP.Base = "weapon_base"
SWEP.Category = "Counter Strike: Source"
SWEP.PrintName = "M4A1 - S"
SWEP.HoldType		= "ar2"
SWEP.Slot = 1
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AutoSwitchFrom = true
SWEP.AutoSwitchTo = true
SWEP.DrawWeaponInfoBox = false
SWEP.UseHands = true

SWEP.ViewModel = Model("models/weapons/cstrike/c_rif_m4a1.mdl")
SWEP.WorldModel = Model("models/weapons/w_rif_m4a1.mdl")
SWEP.ViewModelFOV = 64
SWEP.Deploy = 5

SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 120
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "csgo_5.56x45mm"
SWEP.Primary.Damage		= math.random(23,32)
SWEP.Primary.NumShots		= 1
SWEP.Primary.Recoil			= 0.75
SWEP.Primary.Cone			= 0.1
SWEP.Primary.Tracer			= 1
SWEP.Primary.Force			= 700
SWEP.Primary.Delay			= 0.1
SWEP.Primary.Tracer			= 1

SWEP.Secondary.Ammo = ""

SWEP.DrawAmmo = true
SWEP.AdminOnly = false

SWEP.CSMuzzleFlashes  = true
SWEP.AccurateCrosshair = false

SWEP.IronSightsPos = Vector(-7.651, -7.631, -0.24)
SWEP.IronSightsAng = Vector(1.799, 1.1, -5)

SWEP.ShowViewModel = false
SWEP.ShowWoldModel = false
SWEP.Reloading = false
SWEP.Silencer = true

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self:SetNetworkedBool("Silencer",true)
end

function SWEP:Think()
	if SERVER then
		if self.Owner:KeyDown(IN_WALK) then
			if self.Owner:KeyPressed(IN_RELOAD) then
				self.Owner:DropWeapon(self)
			end
		end
	end
	if self.Silencer then
		self.WorldModel="models/weapons/w_rif_m4a1_silencer.mdl"
	else
		self.WorldModel="models/weapons/w_rif_m4a1.mdl"
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
		bullet.AmmoType = self.Primary.Ammo
		self.Owner:FireBullets(bullet)

	self.Owner:MuzzleFlash()
	self.Owner:SetAnimation(PLAYER_ATTACK1)

	if self.Silencer then
		self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK_SILENCED)
		self.Weapon:EmitSound(Sound("weapons/m4a1/m4a1-1.wav"))
	else
		self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		self.Weapon:EmitSound(Sound("weapons/m4a1/m4a1_unsil-1.wav"))
	end
	self.Owner:ViewPunch(Angle( -self.Primary.Recoil,0,0))
	self.Owner:SetEyeAngles(self.Owner:GetAngles()-Angle(math.sin(CurTime())/10,math.cos(CurTime())/10,0))
	if (self.Primary.TakeAmmoPerBullet) then
		self:TakePrimaryAmmo(self.Primary.NumShots)
	else
		self:TakePrimaryAmmo(1)
	end
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
end

function SWEP:SecondaryAttack()
	if self.Silencer then
		self.Weapon:ResetSequenceInfo()
		self.Weapon:SendWeaponAnim(ACT_VM_DETACH_SILENCER)
		self.Silencer = false
		self.WorldModel="models/weapons/w_rif_m4a1_silencer.mdl"
	else
		self.Weapon:ResetSequenceInfo()
		self.Weapon:SendWeaponAnim(ACT_VM_ATTACH_SILENCER)
		self.Silencer = true
		self.WorldModel="models/weapons/w_rif_m4a1.mdl"
	end
	
	self.Weapon:SetNextPrimaryFire(CurTime()+2)
	self.Weapon:SetNextSecondaryFire(CurTime()+2)
	return false
end

function SWEP:Reload()
	if self.Silencer then
		self.Weapon:DefaultReload(ACT_VM_RELOAD_SILENCED)
	else
		self.Weapon:DefaultReload(ACT_VM_RELOAD)
	end
	return true
end

function SWEP:SetDeploySpeed(x)
	self.m_WeaponDeploySpeed=tonumber(x)
end

function SWEP:Deploy()
	self:SetDeploySpeed(self.Deploy)
	if self.Silencer then
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW_SILENCED)
		self.WorldModel="models/weapons/w_rif_m4a1_silencer.mdl"
	else
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
		self.WorldModel="models/weapons/w_rif_m4a1.mdl"
	end
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
	if self.Silencer then
		self.WorldModel="models/weapons/w_rif_m4a1_silencer.mdl"
	else
		self.WorldModel="models/weapons/w_rif_m4a1.mdl"
	end
end

function SWEP:Precache()
end

function SWEP:OwnerChanged()
end
