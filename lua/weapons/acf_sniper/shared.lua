AddCSLuaFile()
SWEP.Base = "weapon_base"
SWEP.Category = "ACF Weapons/Tools"
SWEP.PrintName = "ACF Sniper Rifle"
SWEP.HoldType = "ar2"
SWEP.ReloadSound = "acf_base/weapons/sniper_reload.mp3"
SWEP.Slot = 1
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AutoSwitchFrom = true
SWEP.AutoSwitchTo = true
SWEP.DrawWeaponInfoBox = false
SWEP.UseHands = false

SWEP.ViewModel = Model("models/weapons/v_sniper.mdl")
SWEP.WorldModel = Model("models/weapons/w_sniper.mdl")
SWEP.ViewModelFOV = 64

SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 15
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "acf_sniper"
SWEP.Primary.Sound = "acf_base/weapons/sniper_fire.mp3"
SWEP.Primary.Damage		= math.random(130,150)
SWEP.Primary.NumShots		= 1
SWEP.Primary.Recoil			= 3
SWEP.Primary.Cone			= 0.1
SWEP.Primary.Tracer			= 1
SWEP.Primary.Force			= 700
SWEP.Primary.Delay			= 1.44
SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 25
SWEP.Primary.Tracer			= 1
SWEP.Primary.Force			= 700
SWEP.Primary.Automatic		= 1

SWEP.Secondary.Ammo = ""

SWEP.DrawAmmo = true
SWEP.AdminOnly = false

SWEP.CSMuzzleFlashes  = true
SWEP.AccurateCrosshair = false

SWEP.IronSightsPos = Vector(-4.64,-7.84,0.699)
SWEP.IronSightsAng = Vector(0,0,0)

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self:SetNetworkedBool("Ironsights",true)
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
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	//	ACF PART
	if SERVER then
		local Entity=nil
		local Trace=self:GetOwner():GetEyeTrace()
		if not ACF.Check(Entity)then return end
		local DmgResult=ACF.Damage.Objects.DamageResult(math.pi*2^2,1)
		local DmgInfo=ACF.Damage.Objects.DamageInfo(self,nil,DMG_PLASMA)
		local HitPos=Trace.HitPos

		DmgResult:SetThickness(Entity.ACF.Armour)

		DmgInfo:SetAttacker(self:GetOwner())
		DmgInfo:SetOrigin(Trace.StartPos)
		DmgInfo:SetHitPos(HitPos)
		DmgInfo:SetLastHitGroup(Trace.HitGroup)

		local HitRes = ACF.Damage.dealDamage(Entity, DmgResult, self.DamageInfo)

		if HitRes.Kill then
			ACF.APKill(Entity, Trace.Normal, 1, DmgInfo)
		end
	end
end

function SWEP:SecondaryAttack()
	return false
end

function SWEP:Reload()				
	self:DefaultReload(ACT_VM_RELOAD)
	if self:Clip1()==0 then
		sound.Play(self.ReloadSound,self:GetPos(),75,100,1)
	end
	return true
end

function SWEP:Deploy()				
	return true
end

function SWEP:Holster()				
	return true
end

function SWEP:OnRemove()			
end

function SWEP:OnRestore()			
end

function SWEP:Precache()			
end

function SWEP:OwnerChanged()		
end
