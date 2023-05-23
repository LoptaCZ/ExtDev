EXTDEV.Props = {}
EXTDEV.Props.Spawned = EXTDEV.Props.Spawned or false

if SERVER then
	EXTDEV.Props.Meshes = {}
	util.AddNetworkString("EXTDEV_MESHER")
	local function SpawnProps()
		if !(EXTDEV.Spawned) then
			EXTDEV.Spawned=true
			timer.Simple(1,function()
				local Name=game.GetMap()
				if file.Exists("extdev/maps/"..Name..".txt","DATA")then
					local Data=util.JSONToTable(file.Read("extdev/maps/"..Name..".txt","DATA"))
					for k,v in pairs(Data)do
						// V = Table
						local Prop=ents.Create("prop_dynamic")
						Prop:SetPos(v[2])
						Prop:SetAngles(v[3])
						Prop:SetModel(v[1])
						Prop:Spawn()
						Prop:SetUnFreezable(true)
						Prop:SetSolid(SOLID_BSP)
						//timer.Simple(5,function()Prop:Remove()end)
						table.insert(EXTDEV.Props,Prop)
					end
				else
					local Table={{"models/gta-online/arcade/ch_chint02_robotgum_mural.mdl",Vector(-9.5,-3071.6,-11877.2),Angle(0.0,-135.0,0.0)}}
					file.CreateDir("extdev/maps")
					file.Append("extdev/maps/"..Name..".txt",util.TableToJSON(Table,true))
				end
			end)
		end
	end
	hook.Add("PostGamemodeLoaded","SpawnProps",function()
		EXTDEV.Spawned=false
		SpawnProps()
		end)
	hook.Add("PreCleanupMap","SpawnProps_CLEAR",function()
		EXTDEV.Spawned=false
		for k,v in pairs(EXTDEV.Props)do
			if IsValid(v)then
				v:Remove()
				EXTDEV.Props[k]=nil
			else
				return
			end
		end
	end)
	hook.Add("PostCleanupMap","SpawnProps",function()
		EXTDEV.Spawned=false
		SpawnProps()
	end)

	net.Receive("EXTDEV_MESHER",function(len,ply)
		local Func=net.ReadString()
		local Ent=net.ReadEntity()
		local Model=net.ReadString()
		if Func=="GETMESH"then
			//print(ply:Name(),Model)
			if file.Exists(string.format("extdev/meshes/%s.txt",ply:SteamID64()),"DATA") then
				File=file.Read(string.format("extdev/meshes/%s.txt",ply:SteamID64()),"DATA")
				JSON=util.JSONToTable(File)
				if istable(JSON) then
					if not table.HasValue(JSON,Model) then
						table.insert(JSON,Model)
						file.Write(string.format("extdev/meshes/%s.txt",ply:SteamID64()),util.TableToJSON(JSON,true))
					end
				else
					JSON={Model}
					file.Write(string.format("extdev/meshes/%s.txt",ply:SteamID64()),util.TableToJSON(JSON,true))
				end
			else
				file.CreateDir("extdev/meshes")
				file.Write(string.format("extdev/meshes/%s.txt",ply:SteamID64()),"")
			end
		end
	end)-- net.Receive
else//  ^^ SERVER
	timer.Destroy("EXTDEV_MESHER")
	timer.Create("EXTDEV_MESHER",5,0,function()
		local Ents = ents.GetAll()
		for k,v in pairs(Ents)do
			local Class = tostring(v:GetClass())
			if string.find(Class,"gmod_") then
				if not util.IsValidModel(v:GetModel()) then
					net.Start("EXTDEV_MESHER")
						net.WriteString("GETMESH")
						net.WriteEntity(v)
						net.WriteString(v:GetModel())
					net.SendToServer()
				end
			elseif string.find(Class,"prop_") then
				if not util.IsValidModel(v:GetModel()) then
					net.Start("EXTDEV_MESHER")
						net.WriteString("GETMESH")
						net.WriteEntity(v)
						net.WriteString(v:GetModel())
					net.SendToServer()
				end
			elseif string.find(Class,"weapon_") then
				if not util.IsValidModel(v:GetModel()) then
					net.Start("EXTDEV_MESHER")
						net.WriteString("GETMESH")
						net.WriteEntity(v)
						net.WriteString(v:GetModel())
					net.SendToServer()
				end
			end-- if string.find
		end-- for k,v
	end)-- timer
end