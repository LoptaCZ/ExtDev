AddCSLuaFile("shared.lua")
ENT.Base 	= "base_anim"

ENT.PrintName 		= "R4v3 Cub3"
ENT.Author 			= "Architekt"
ENT.Information 	= "Som lights m9"
ENT.Category 		= "ArchOS [Main]"

ENT.Spawnable 		= true
ENT.AdminOnly 		= true
ENT.RenderGroup 	= RENDERGROUP_TRANSLUCENT

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Song")
end