local mod = {}

function mod.RagdollMe(ply)
	if ply:SteamID64() == "76561197962184163" then
		ply:EmitSound("buttons/button11.wav")
		return 
	end

	local ragdoll = ents.Create("prop_ragdoll")
	ragdoll:SetPos(ply:GetPos())
	ragdoll:SetAngles(ply:GetAngles())
	ragdoll:SetModel(ply:GetModel())
	ragdoll:Spawn()
	NADMOD.SetOwnerWorld(ragdoll)
	ply:SetParent(ragdoll)

	ply:Spectate(OBS_MODE_CHASE)
	ply:SpectateEntity(ragdoll)
	ply:StripWeapons()

	local head = ragdoll:GetPhysicsObjectNum( 10 )
	local main = ragdoll:GetPhysicsObjectNum( 1 )

	hook.Add("Think","RagdollMe2_"..ply:EntIndex(),function()
		if ply:KeyDown(IN_FORWARD) then
			main:ApplyForceCenter(ply:GetAimVector()*2000)
		end
		if ply:KeyDown(IN_BACK) then
			main:ApplyForceCenter(-(ply:GetAimVector()*2000))
		end
		if ply:KeyDown(IN_JUMP) then
			main:ApplyForceCenter(Vector(0,0,2000))
		end
		if ply:KeyDown(IN_DUCK) then
			main:SetVelocity(main:GetVelocity()/2.5)
		end

		if not ply:IsPlayer() then
			SafeRemoveEntity(ragdoll)
			hook.Remove("KeyPress","RagdollMe_"..ply:EntIndex())
			hook.Remove("Think","RagdollMe2_"..ply:EntIndex())
		end
	end)

	hook.Add("KeyPress","RagdollMe_"..ply:EntIndex(),function(pl,btn)
		if pl == ply then
			if btn == IN_ATTACK then
				ply:UnSpectate()
				ply:Spawn()
				ply:SetParent()
				ply:SetPos(ragdoll:GetPos())
				SafeRemoveEntity(ragdoll)

				hook.Remove("KeyPress","RagdollMe_"..ply:EntIndex())
				hook.Remove("Think","RagdollMe2_"..ply:EntIndex())
			end
		else
			if not ply:IsPlayer() then
				SafeRemoveEntity(ragdoll)
				hook.Remove("KeyPress","RagdollMe_"..ply:EntIndex())
				hook.Remove("Think","RagdollMe2_"..ply:EntIndex())
			end
		end
	end)
end
concommand.Add("ragdollme",function(ply)
	mod.RagdollMe(ply)
end)
hook.Add("PlayerDisconnected","RagdollMe_Disc",function(ply)
	SafeRemoveEntity(ragdoll)
	hook.Remove("KeyPress","RagdollMe_"..ply:EntIndex())
	hook.Remove("Think","RagdollMe2_"..ply:EntIndex())
end)