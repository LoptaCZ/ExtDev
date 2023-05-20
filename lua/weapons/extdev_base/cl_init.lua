include("shared.lua")
SWEP.PrintName = "EXTDEV SWEP Base"
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false

function SWEP:Initialize()
	self:StartUp()
end

function SWEP:Think()
end

function SWEP:GetViewModelPosition(Pos, Ang)
	local Mul = 1
	local ModPos = Vector(0, 0, 0)

	if self:GetDTBool(0) then
		ModPos = self.IronSightsPos
	end

	local Right = Ang:Right()
	local Up = Ang:Up()
	local Forward = Ang:Forward()
	Pos = Pos + ModPos.x * Right * Mul
	Pos = Pos + ModPos.y * Forward * Mul
	Pos = Pos + ModPos.z * Up * Mul

	return Pos, Ang
end

function SWEP:CalcView(_, Origin, Angles, FOV)
	return Origin, Angles, FOV
end

--Clientside effect, for Viewmodel stuff
function SWEP:MuzzleEffect()
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self:GetOwner():MuzzleFlash()
end

function SWEP:StartUp()
	self.FOV = self:GetOwner():GetFOV()
	self.ViewModelFOV = self.FOV
end

function SWEP:CleanUp()
	--print("Stopping Client")
	--hook.Remove("InputMouseApply","ACF_SWEPFloatingCrosshair")
end

function SWEP:OnRestore()
	self:StartUp()

	return true
end

function SWEP:OnRemove()
	self:CleanUp()

	return true
end

function SWEP:OwnerChanged()
	self:CleanUp()

	return true
end