if not EXTDEV then
	EXTDEV={}
	EXTDEV.Version="1.0-Rusty"
	EXTDEV.Name="Extreme Developement"
	EXTDEV.NameShort="ExtDev"

	EXTDEV.Modules={}
	EXTDEV.Modules.Directory="modules"
	EXTDEV.Modules.Check=10
end

local function LogThis(input,isErr,lvl I)
	if isErr then
		local col=Color(200,200,200,255)
			if lvl==-1 then	col=Color(50,50,50,255)
		elseif lvl==0 then col=Color(200,200,200,255)
		elseif lvl==1 then col=Color(250,150,50)
		elseif lvl==2 then col=Color(200,50,50)
		elseif lvl==3 then col=Color(255,0,0)
		end
		if not isstring(EXTDEV.NameShort)then name="ExtDev"else name=EXTDEV.NameShort end
		ErrorNoHalt(Color(180,130,255),"[",Color(233,138,34),name,Color(180,130,255),"]",col,input)
	else
		if istable(input)then
			PrintTable(input)
		elseif isfunction(input)then
			print(jit.util.funcuvname(input,0))
		else
			print(input)
		end
	end
end

function EXTDEV.LoadPhysics()
	MsgC(Color(180,130,255),"[",Color(250,150,30),EXTDEV.NameShort,Color(180,130,255),"]",Color(50,200,150)," Removing Speed limits!\n")
	local physics=physenv.GetPerformanceSettings()
	physics.MaxAngularVelocity=11784960000
	physics.MaxVelocity=11784960000
	physenv.SetPerformanceSettings(physics)
end

function EXTDEV.RegisterModule(name,side,info,func)
	print("EXTDEV.RegisterModule(name,side,info,func) has been called!")
	if string.len(name)>=3 then
		if table.HasValue(side,CLIENT)then
			if not table.IsEmpty(info)then
				if isfunction(func)then
					jit.util.funck(func,1)
					EXTDEV.Modules[name]={side,info,func}
				end
			end
		elseif table.HasValue(side,SERVER)then
			if not table.IsEmpty(info)then
			end
		else
			MsgC(Color(180,130,255),"[",Color(250,150,30),EXTDEV.NameShort,Color(180,130,255),"]",Color(200,50,50),name.."has invalid realm!\n")
			return
		end
	else
		MsgC(Color(180,130,255),"[",Color(250,150,30),EXTDEV.NameShort,Color(180,130,255),"]",Color(200,50,50),"Invalid Name!\n")
	end
end

function EXTDEV.LoadModules(path)//	extdev/<path>
	local find=string.format("extdev/%s/",string.lower(path))
	local _f,paths=file.Find(find.."*","LSV","nameasc")
	for num,dir in pairs(paths)do
		local files,_=file.Find(find.."/"..dir.."/*.*","LSV","nameasc")
		for _,_file in pairs(files)do
			if string.find(_file,".lua") and dir==string.Replace(_file,".lua","") then
				local str=find..dir.."/".._file
				/*
				if file.Exists(str,"LSV")then
					local f=file.Read(str,"LSV")
					RunString(f)
				end
				*/
			elseif string.find(_file,".png")then
				//print(dir.." icon: ".._file)
				//
			else
				//print(_file.." in "..dir.." won't be executed. Becouse it doesn't have right formating.")
			end
		end
	end
end

function EXTDEV.Restart()
	MsgC(Color(180,130,255),"[",Color(250,150,30),EXTDEV.NameShort,Color(180,130,255),"]",Color(200,50,50),string.format(" Restarting %s framework!\n",EXTDEV.Name))
	EXTDEV=nil
	include("autorun/extdev.lua")
end

function EXTDEV.Load()
	if not EXTDEV then
		EXTDEV={}
		EXTDEV.Version="1.0-Rusty"
		EXTDEV.Name="Extreme Developement"
		EXTDEV.NameShort="ExtDev"

		EXTDEV.Modules={}
		EXTDEV.Modules.Directory="modules"
		EXTDEV.Modules.Check=10
	end
	EXTDEV.LoadPhysics()
	EXTDEV.LoadModules(EXTDEV.Modules.Directory or "modules")
end

function EXTDEV.Error(string)
	//	|XXXXXXX|XXXXXXXXXXX|
	//	|	-1 	|	DEBUG 	|
	//	|	0 	|	INFO 	|
	//	|	1	|	WARN 	|
	//	|	2 	|	ERROR 	|
	//	|	3 	|	FATAL 	|
	//	|XXXXXXX|XXXXXXXXXXX|
	logThis(string,true,2)
end

concommand.Add("extdev",
	function(ply,cmd,args,argStr)//	Player | String | Table | String
		//	CMDs:
		//	|	SERVER_SIDE |	SHARED_SIDE	|	CLIENT_SIDE	|
		//	|				|	restart		|	resend		|
		//	|				|				|	view		|
		//	|				|				|	skybox		|
		//	|				|				|				|
		//	|				|				|				|
		//	|				|				|				|
		if args[1]=="restart"then
			EXTDEV.Restart()
		elseif args[1]=="cum_demon"then
		elseif args[1]=="cuc_dened"then
		end
	end,
	function(cmd,arg)//			String | String
		//
	end,
"ExtDev base Commands",0)

EXTDEV.Load()