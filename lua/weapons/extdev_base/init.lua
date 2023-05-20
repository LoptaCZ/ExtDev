AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

function SWEP:Initialize()

end

function SWEP:Reload()

end

function SWEP:Think()

end

function SWEP:MuzzleEffect()

end

function SWEP:StartUp()
	local Owner = self:GetOwner()

	self:SetDTBool(0, false)
	self.LastIrons = 0

	if Owner then
		self.OwnerIsNPC = Owner:IsNPC() -- This ought to be better than getting it every time we fire
	end
end

function SWEP:CleanUp()
end

function SWEP:CreateShell()
	--This gets overwritten by the ammo function
end

function SWEP:NetworkData()
	--This gets overwritten by the ammo function
end

function SWEP:ShouldDropOnDie()
	return true
end

function SWEP:Equip()
	self:StartUp()

	return true
end

function SWEP:OnRestore()
	self:StartUp()

	return true
end

function SWEP:Deploy()
	self:StartUp()

	return true
end

function SWEP:Holster()
	self:CleanUp()

	return true
end

function SWEP:OnRemove()
	self:CleanUp()

	return true
end

function SWEP:OnDrop()
	self:CleanUp()

	return true
end

function SWEP:OwnerChanged()
	self:CleanUp()

	return true
end