local mod = {}

-- Ignore
	local function CollapseTableToArray( t )
		
		local array = {}
		local q = {}
		local min, max = 0, 0
		--get the bounds
		for k in pairs(t) do
			if not min and not max then min,max = k,k end
			min = (k < min) and k or min
			max = (k > max) and k or max	
		end
		for i=min, max do
			if t[i] then
				array[#array+1] = t[i]
			end
		end

		return array
	end

	local phys_constraint_system_types = {
		Weld = true,
		Rope = true,
		Elastic = true,
		Slider = true,
		Axis = true,
		AdvBallsocket = true,
		NoCollide = true,
		Motor = true,
		Pulley = true,
		Ballsocket = true,
		Winch = true,
		Hydraulic = true,
		WireMotor = true,
		WireHydraulic = true
	}
	
	local function GroupConstraintOrder( ply, constraints )
		--First seperate the nocollides, sorted, and unsorted constraints
		local nocollide, sorted, unsorted = {}, {}, {}
		for k, v in pairs(constraints) do
			if v.Type == "NoCollide" then
				nocollide[#nocollide+1] = v
			elseif phys_constraint_system_types[v.Type] then
				sorted[#sorted+1] = v
			else
				unsorted[#unsorted+1] = v
			end
		end

		local sortingSystems = {}
		local fullSystems = {}
		local function buildSystems(input)
			while next(input) ~= nil do
				for k, v in pairs(input) do
					for systemi, system in pairs(sortingSystems) do
						for _, target in pairs(system) do
							for x = 1, 4 do
								if v.Entity[x] then
									for y = 1, 4 do
										if target.Entity[y] and v.Entity[x].Index == target.Entity[y].Index then
											system[#system + 1] = v
											if #system==100 then
												fullSystems[#fullSystems + 1] = system
												table.remove(sortingSystems, systemi)
											end
											input[k] = nil
											goto super_loopbreak
										end
									end
								end
							end
						end
					end
				end

				--Normally skipped by the goto unless no cluster is found. If so, make a new one.
				local k = next(input)
				sortingSystems[#sortingSystems + 1] = {input[k]}
				input[k] = nil

				::super_loopbreak::
			end
		end
		buildSystems(sorted)
		buildSystems(nocollide)

		local ret = {}
		for _, system in pairs(fullSystems) do
			for _, v in pairs(system) do
				ret[#ret + 1] = v
			end
		end
		for _, system in pairs(sortingSystems) do
			for _, v in pairs(system) do
				ret[#ret + 1] = v
			end
		end
		for k, v in pairs(unsorted) do
			ret[#ret + 1] = v
		end

		if #fullSystems ~= 0 then
			ply:ChatPrint("DUPLICATOR: WARNING, Number of constraints exceeds 100: (".. #ret .."). Constraint sorting might not work as expected.")
		end

		return ret
	end

	local function CreationConstraintOrder( constraints )
		local ret = {}
		for k, v in pairs( constraints ) do
			ret[#ret + 1] = k
		end
		table.sort(ret)
		for i=1, #ret do
			ret[i] = constraints[ret[i]]
		end
		return ret
	end

	local function GetSortedConstraints( ply, constraints )
		if ply:GetInfo("advdupe2_sort_constraints") ~= "0" then
			return GroupConstraintOrder( ply, constraints )
		else
			return CreationConstraintOrder( constraints )
		end
	end
-- Ignore

function mod.SaveMap(ply)
	local Entities = ents.GetAll()

	if ply:GetCount("props") == 0 then return end

	for k,v in pairs(Entities) do
		if v:CPPIGetOwner() != ply then
			Entities[k] = nil
		end
	end

	MsgC(Color(255,255,255),string.format("[%s:%s:%s]",os.date("%H"),os.date("%M"),os.date("%S")),Color(255,200,0)," Saving ",ply:GetPlayerColor():ToColor(),ply:Name(),Color(255,200,0)," contraption. \n")
	extdev.Logger(string.format("{MapSaver} Saving %s contraption.",ply:Name()))


	local Tab = {Entities={}, Constraints={}, HeadEnt={}, Description=""}
	Tab.HeadEnt.Index = table.GetFirstKey(Entities)
	Tab.HeadEnt.Pos = Entities[Tab.HeadEnt.Index]:GetPos()

	local WorldTrace = util.TraceLine( {mask=MASK_NPCWORLDSTATIC, start=Tab.HeadEnt.Pos+Vector(0,0,1), endpos=Tab.HeadEnt.Pos-Vector(0,0,50000)} )
	if(WorldTrace.Hit)then Tab.HeadEnt.Z = math.abs(Tab.HeadEnt.Pos.Z-WorldTrace.HitPos.Z) else Tab.HeadEnt.Z = 0 end
	Tab.Entities, Tab.Constraints = AdvDupe2.duplicator.AreaCopy(Entities, Tab.HeadEnt.Pos, true)
	Tab.Constraints = GetSortedConstraints(ply, Tab.Constraints)

	AdvDupe2.Encode(Tab,AdvDupe2.GenerateDupeStamp(ply),function(data)
		if not file.Exists("archos_mapsaver/"..ply:SteamID64(),"DATA") then 
			file.CreateDir("archos_mapsaver")
			file.CreateDir("archos_mapsaver/"..ply:SteamID64())
		end
		//local bordel = os.date("%H-%M-%S",os.time())

		local txt=string.format("archos_mapsaver/%s/%s.txt",ply:SteamID64(),ply:SteamID64())

		file.Write("archos_mapsaver/"..ply:SteamID64()..".txt",data)
		//file.Write(txt,data)
	end)
end

function mod.LoadMap(ply)
	local map
    //print("Attempting to load "..ply:Nick().." dupe.")
    if not file.Exists("archos_mapsaver/"..ply:SteamID64()..".txt","DATA") then print(ply:Nick().." dupe file not found.") return end
    map = file.Read("archos_mapsaver/"..ply:SteamID64()..".txt")

    //print("Attempting to decode "..ply:Nick().." dupe.")
    local success, dupe, moreinfo = AdvDupe2.Decode(map)

    if not success then
        //print("Failed to decode "..ply:Nick().." dupe.")
        return
    end
    
    local Tab = {Entities=dupe["Entities"], Constraints=dupe["Constraints"], HeadEnt=dupe["HeadEnt"]}
    local Entities = AdvDupe2.duplicator.Paste(ply, table.Copy(Tab.Entities), Tab.Constraints, nil, nil, Tab.HeadEnt.Pos, true)
    local PhysObj
    local valid

    for k,v in pairs(Entities) do
        valid = Entities[k]
        if(IsValid(valid))then
            for i=0, #Tab.Entities[k].PhysicsObjects do
                PhysObj = valid:GetPhysicsObjectNum( i )
                if IsValid(PhysObj) then
                    PhysObj:EnableMotion(false)
                end
            end
        end
    end

    ply:SetPos(Tab.HeadEnt.Pos)
    ply:ConCommand("ulx noclip "..ply:Nick())
end

function mod.SaveAll()
	for k,v in pairs(player.GetHumans()) do
		if v:GetCount("prop_physics")>=1 then
			mod.SaveMap(v)
		end
	end
	BroadcastLua([[chat.AddText(Color(255,255,255),string.format("[%s:%s:%s]",os.date("%H"),os.date("%M"),os.date("%S")),Color(50,200,50)," Saving all spawned contraptions.")]])
	BroadcastLua([[chat.AddText(Color(255,255,255),string.format("[%s:%s:%s]",os.date("%H"),os.date("%M"),os.date("%S")),Color(200,50,50)," Expect lags. (Freezing moving contraptions.)")]])
end

function mod.Restore(ply)
	local files=file.Find("archos_mapsaver/*","DATA")
	for k,v in pairs(files)do
		if not string.find(v," - ")then
			if not file.Exists("archos_mapsaver/"..ply..".txt","DATA") then print(ply.." dupe file not found.") return end
    		map = file.Read("archos_mapsaver/"..ply..".txt")
    		local success, dupe, moreinfo = AdvDupe2.Decode(map)

    		if not success then
        		return
    		end
    
    		local Tab = {Entities=dupe["Entities"], Constraints=dupe["Constraints"], HeadEnt=dupe["HeadEnt"]}
    		local Entities = AdvDupe2.duplicator.Paste(ply, table.Copy(Tab.Entities), Tab.Constraints, nil, nil, Tab.HeadEnt.Pos, true)
    		local PhysObj
    		local valid

    		for k,v in pairs(Entities) do
    		    valid = Entities[k]
    		    if(IsValid(valid))then
    		        for i=0, #Tab.Entities[k].PhysicsObjects do
    		            PhysObj = valid:GetPhysicsObjectNum( i )
    		            if IsValid(PhysObj) then
    		                PhysObj:EnableMotion(false)
    		            end
    		        end
    		    end
    		end
		end
	end
end

timer.Create("ARCHOS_MapSaver",300,0,mod.SaveAll)

hook.Add("PlayerSay","Chat_MapLoad",function(ply,txt,team)
	if string.lower(txt) == "!load" then
		mod.LoadMap(ply)
		return ""
	elseif string.lower(txt)=="!save"then
		mod.SaveMap(ply)
		return ""
	elseif string.lower(txt)=="!save-all"then
		if ply:IsSuperAdmin()then
			for k,v in pairs(player.GetHumans())do
				mod.SaveMap(v)
			end
			return ""
		end
	elseif string.lower(txt)=="!restore"then
		mod.Restore(ply:SteamID64())
		return ""
	end
end)
