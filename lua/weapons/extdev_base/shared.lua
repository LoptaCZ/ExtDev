SWEP.Author			= "Lopta CZ"
SWEP.Contact		= ""
SWEP.Purpose		= "Pure Autism"
SWEP.Instructions	= "ExtDev IDFK"

SWEP.Spawnable			= false
SWEP.AdminOnly		= false

SWEP.ViewModel			= "models/weapons/v_357.mdl"
SWEP.WorldModel			= "models/weapons/w_357.mdl"

SWEP.Weight				= 10

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 32
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "GaussEnergy"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos 			= Vector(0,0,0)		--Lateral, Depth, Vertical
SWEP.IronSightsAng 			= Vector(0,0,0)				--Pitch, Yaw, Roll

function SWEP:UseACFDamage()
	if SERVER then
		local trs = {}
			trs.start  = self.Owner:GetShootPos()
			trs.endpos = self.Owner:GetShootPos()+(self.Owner:GetAimVector()*999999999999999999999999)
			trs.filter = self.Owner
		local tr = util.TraceLine(trs)
		local ent = tr.Entity

		if tr.HitNonWorld then
			if ent:GetClass()=="prop_physics"and ACF.Check(ent) then
				local DmgInfo=ACF.Damage.Objects.DamageInfo(self:GetOwner(),ent,DMG_ENERGYBEAM,tr.StartPos,tr.HitPos,tr.HitGroup)
				local DmgRes=ACF.Damage.Objects.DamageResult(math.pi * 2 ^ 2, 1)

				DmgInfo:SetAttacker(self:GetOwner())
				DmgInfo:SetOrigin(tr.StartPos)
				DmgInfo:SetHitPos(tr.HitPos)
				DmgInfo:SetHitGroup(tr.HitGroup)

				local HitRes=ACF.Damage.dealDamage(ent,DmgRes,DmgInfo)

				if HitRes.Kill then
					ACF.APKill(ent,tr.Normal,1,DmgInfo)
				end

				
			end
		end
	end
end

function SWEP:PrimaryAttack()
	return true
end
function SWEP:SecondaryAttack()

end
