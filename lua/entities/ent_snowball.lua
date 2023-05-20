AddCSLuaFile()

ENT.Base = "base_anim"
ENT.PrintName = "Snowball!"
ENT.Category = "[ExtDev]"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.Pos = Vector()

function ENT:Initialize()
	local phys=self:GetPhysicsObject()
	self:SetModel("models/weapons/w_eq_snowball_dropped.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_NONE)

	if IsValid(phys) then 
		phys:Wake()
	end
end

function ENT:PhysicsCollide(c,collider)
	if SERVER then
		local Speed = c.HitSpeed
		local Ent = c.HitEntity
		local HitNormal = c.HitNormal
		local SoundName="weapons/bugbait/bugbait_squeeze2.wav"

		print(c)
		print(collider)

		print("Ouch ",Speed,Ent,HitNormal)

		util.Decal("Splash.Large",HitNormal,HitNormal,null)

		sound.Play(SoundName,HitNormal,75,100,1)

		self:Remove()
	else
	//	Some Client Functions
	end
end
