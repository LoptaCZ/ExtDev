if EXTDEV then
	if not EXTDEV.InitTime then 
		EXTDEV.InitTime = tostring(os.date("%H-%M",os.time()))
	end
	file.CreateDir("extdev/logs")
	if SERVER then
		if game.SinglePlayer() then return end
		util.AddNetworkString("LoggerClient")
		local ED_Tool = "%s used %s on %s (%s)"
		local ED_Spawn = "%s spawned %s, %s as model (%s)"
		local ED_SWEP = "%s gave %s swep %s (%s)"

		net.Receive("LoggerClient",function()
			local text=net.ReadString()
			extdev.Logger(text)
		end)
		hook.Add("Initialize","EXTDEV_LOGGER",function()
			f_name2=tostring(os.date("%H_%M",os.time()))
			extdev.Logger("Server Loaded")
		end)
		hook.Add("PlayerConnect","EXTDEV_LOGGER",function(ply,ip)
			local text=ply.." connected {"..ip.."}."
			extdev.Logger(text)
		end)
		hook.Add("PlayerSpawn","EXTDEV_LOGGER",function(ply,tra)
			local text=ply:Name()..string.format(" {%s} spawned.",ply:SteamID64())
			extdev.Logger(text)
		end)
		hook.Add("PlayerDisconnected","EXTDEV_LOGGER",function(ply)
			local text=ply:Name().." discconnected."
			extdev.Logger(text)
		end)
		hook.Add("PlayerSay","EXTDEV_LOGGER",function(ply,s_txt,s_team)
			local text="["..team.GetName(ply:Team()).."] "..ply:Name()..": "..s_txt
			extdev.Logger(text)
		end)
		hook.Add("PlayerSpawnedEffect","EXTDEV_LOGGER",function(ply,model,ent)
			local text=string.format(ED_Spawn,ply:Nick(),ent:GetClass(),model,ent:GetPos())
			extdev.Logger(text)
		end)
		hook.Add("PlayerSpawnedNPC","EXTDEV_LOGGER",function(ply,ent)
			local text=string.format(ED_Spawn,ply:Nick(),ent:GetClass(),ent:GetModel(),ent:GetPos())
			extdev.Logger(text)
		end)
		hook.Add("PlayerSpawnedProp","EXTDEV_LOGGER",function(ply,model,ent)
			local text=string.format(ED_Spawn,ply:Nick(),ent:GetClass(),model,ent:GetPos())
			extdev.Logger(text)
		end)
		hook.Add("PlayerSpawnedRagdoll","EXTDEV_LOGGER",function(ply,model,ent)
			local text=string.format(ED_Spawn,ply:Nick(),ent:GetClass(),model,ent:GetPos())
			extdev.Logger(text)
		end)
		hook.Add("PlayerSpawnedSENT","EXTDEV_LOGGER",function(ply,ent)
			local text=string.format(ED_Spawn,ply:Nick(),ent:GetClass(),ent:GetModel(),ent:GetPos())
			extdev.Logger(text)
		end)
		hook.Add("PlayerSpawnedSWEP","EXTDEV_LOGGER",function(ply,ent)
			local text=string.format(ED_Spawn,ply:Nick(),ent:GetClass(),ent:GetModel(),ent:GetPos())
			extdev.Logger(text)
		end)
		hook.Add("PlayerSpawnedVehicle","EXTDEV_LOGGER",function(ply,ent)
			local text=string.format(ED_Spawn,ply:Nick(),ent:GetClass(),ent:GetModel(),ent:GetPos())
			extdev.Logger(text)
		end)
		hook.Add("PlayerGiveSWEP","EXTDEV_LOGGER",function(ply,model,table)
			local text=string.format(ED_SWEP,ply:Nick(),ply:Nick(),model,ply:GetPos())
			extdev.Logger(text)
		end)
		hook.Add("PlayerDeath","EXTDEV_LOGGER",function(victim,inflictor,attacker)
			local text=""
			if victim==atacker then
				text=victim:Name().." commited suicide."
			else
				if attacker:IsPlayer() then
					if IsValid(inflictor)then
						//text=victim:Name().." was killed by "..attacker:Name().." with "..inflictor:GetClass().."."
						text=string.format("%s was killed by %s with %s (%s).",victim:Name(),attacker:Name(),inflictor:GetClass(),inflictor:GetModel())
					else
						//text=victim:Name().." was killed by "..attacker:Name().." with "..inflictor:Name().."."
						text=string.format("%s was killed by %s with %s (%s).",victim:Name(),attacker:Name(),inflictor:Name(),inflictor:GetModel())
					end
				else
					local att=attacker:GetClass() or attacker
					local inf=inflictor:GetClass() or inflictor
					//text=victim:Name().." was killed by "..att.." with "..inf.."."
					text=string.format("%s was killed by %s with %s.",victim:Name(),att,inf)
				end
			end
			extdev.Logger(text)
		end)
		hook.Add("CanTool","EXTDEV_LOGGER",function(ply,trace,tool)
			local text=string.format(ED_Tool,ply:Name(),tool,trace.Entity,trace.HitPos)
			extdev.Logger(text)
		end)
	else
		hook.Add("PlayerStartVoice","EXTDEV_LOGGER",function(ply)
			local text=ply:Name().." has begun talking in voice."
			net.Start("LoggerClient")
				net.WriteString(text)
			net.SendToServer()
		end)
		hook.Add("PlayerEndVoice","EXTDEV_LOGGER",function(ply)
			local text=ply:Name().." has stopped talking in voice."
			net.Start("LoggerClient")
				net.WriteString(text)
			net.SendToServer()
		end)
		hook.Add("OnUndo","EXTDEV_LOGGER",function(type,txt)
			local text=""
			if !txt then 
				text=LocalPlayer():Name().." have undoned "..type
			else
				text=LocalPlayer():Name().." have undoned "..type..(string.sub(txt,7)or "<unknown>")
			end
			net.Start("LoggerClient")
				net.WriteString(text)
			net.SendToServer()
		end)
	end
end