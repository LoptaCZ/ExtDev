AddCSLuaFile("cl_init.lua")
AddCSLuaFile()

ENT.Base = "base_anim"
ENT.PrintName = "Visualizer"
ENT.Category = "[ExtDev]"
ENT.Spawnable = true
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()
	local phys=self:GetPhysicsObject()
	self:SetModel("models/sprops/cuboids/height06/size_1/cube_6x6x6.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	if IsValid(phys) then 
		phys:Wake()
	end
end
