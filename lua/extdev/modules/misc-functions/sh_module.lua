module("extdev",package.seeall)
if CLIENT then
	local Default={}
	Default.BGColor=Color(0,0,0,150)
	Default.FGColor=Color(35,35,35,150)
	Default.Language="en"
	Default.Fonts={"Akbar","Roboto","Arial","Tahoma","Calibri","Comic Sans MS"}
	Default.Offset=Vector(0,0,0)//	Left/Right Offset | Up/Down Offset | NOTHING
	Default.Scale=1.125
	Default.ChatSnd=""
	Default.AvatarPoly=50
	
	Data=table.Copy(Default)
	
	function LoadCFG(ply)
		//print("Loading",ply:Name(),"file.")
		if IsValid(ply)then
			if file.Exists("extdev/"..ply:SteamID64()..".txt","DATA")then
				local f=util.JSONToTable(file.Read("extdev/"..ply:SteamID64()..".txt","DATA"))
				if istable(f) then
					Data.BGColor=f.BGColor
					Data.FGColor=f.FGColor
					Data.Language=f.Language
					Data.Fonts=f.Fonts
					Data.Offset=f.Offset
					Data.Scale=f.Scale
					Data.ChatSnd=f.ChatSnd
					Data.AvatarPoly=f.AvatarPoly
					ReloadCFG(ply)
				elseif f==nil then
					RedoCFG(ply)
				else
					RedoCFG(ply)
				end
			end
		end
		return Data
	end//	LoadCFG
//			
	function UpdateCFG(ply,data)
		//print("Updating",ply:Name(),"file.")
		if IsValid(ply) then
			if file.Exists("extdev/"..ply:SteamID64()..".txt","DATA")then
				local f=util.JSONToTable(file.Read("extdev/"..ply:SteamID64()..".txt","DATA"))
				PrintTable(f)
				if istable(f) then
					f.BGColor=data.BGColor
					f.FGColor=data.FGColor
					f.Language=data.Language
					f.Fonts=data.Fonts
					f.Offset=data.Offset
					f.Scale=data.Scale
					f.ChatSnd=data.ChatSnd
					f.AvatarPoly=data.AvatarPoly
					local File="extdev/"..ply:SteamID64()..".txt"
					if file.Exists(File,"DATA") then
						file.Write(File,util.TableToJSON(f,true))
					end
					ReloadCFG(ply)
				else
					RedoCFG(ply)
				end
			else
				RedoCFG(ply)
			end
		end
		return data
	end//	UpdateSettings
//			
	function RedoCFG(ply)
		local play=LocalPlayer()
		if IsValid(ply)then play=ply end		
		//print("Recreating",(play:Name()),"file.")
		MsgC(Color(0,0,0),"[",Color(255,255,255),"ExtDev",Color(0,0,0),"]",Color(200,0,0)," Unexpected error while loading settings.","\n")
		MsgC(Color(0,0,0),"[",Color(255,255,255),"ExtDev",Color(0,0,0),"]",Color(200,200,0)," Recreating file!.","\n")
		local File=Format("extdev/%s.txt",(play:SteamID64()))
		if file.IsDir("extdev","DATA")then
			file.Write(File,util.TableToJSON(Default,true))
		else
			file.CreateDir("extdev")
			RedoCFG(play)
		end
		return Default
	end//	RedoSettings
//			
	function ReloadCFG(ply)
		//print("Reloading",ply:Name(),"file.")
		if IsValid(ply) then
			local File="extdev/"..ply:SteamID64()..".txt"
			if file.Exists(File,"DATA") then
				local f=file.Read(File,"DATA")
				local t=util.JSONToTable(f)
				//PrintTable(t)
				if istable(t)then
					Data.BGColor=t.BGColor
					Data.FGColor=t.FGColor
					Data.Fonts=t.Fonts
					Data.Language=t.Language
					Data.Offset=t.Offset
					Data.ChatSnd=t.ChatSnd
					Data.AvatarPoly=t.AvatarPoly
					surface.CreateFont("extdev_hp",{font=Data.Fonts[1],size=20*Data.Scale,weight=1000})
					surface.CreateFont("extdev_time",{font=Data.Fonts[2],size=20*Data.Scale,weight=1000})
					surface.CreateFont("extdev_rank",{font=Data.Fonts[3],size=20*Data.Scale,weight=5000})
					surface.CreateFont("extdev_nick",{font=Data.Fonts[4],size=20*Data.Scale,weight=1000})
					surface.CreateFont("extdev_header",{font=Data.Fonts[5],size=20*Data.Scale,weight=1000})
					surface.CreateFont("extdev_misc",{font=Data.Fonts[6],size=20*Data.Scale,weight=1000})
				end
			else
				RedoCFG(ply)
			end
		end
		return Data
	end//	ReloadCFG
end//	if CLIENT

function HasChanged(value)
	local chg = var
	if value == chg then return 0 end
		chg = value
	return 1
end

function Notification(ply,text,type,length)
	if SERVER then
		local img="icon16/page.png"

		if type=="GENERIC" then
			img="vgui/notices/generic"
		elseif type=="ERROR" then
			img="vgui/notices/error"
		elseif type=="UNDO" then
			img="vgui/notices/undo"
		elseif type=="HINT" then
			img="vgui/notices/hint"
		elseif type=="CLEANUP" then
			img="vgui/notices/cleanup"
		else
			img=tostring(type)
		end

		net.Start("EXTDEV_NOTIF")
			net.WriteString(text)
			net.WriteString(img)
			net.WriteString(type)
			net.WriteInt(length,8)
		net.Send(ply)

		Logger(string.format("Sending notification to %s which is %s, have %s as image and lasts %s sec.",tostring(ply:Name()),tostring(type),tostring(img),tostring(length)))
	end
end

function Logger(cont)
	if SERVER then
		local Time = EXTDEV.InitTime or "[Unknown Time]"
		local f_name1=tostring(os.date("%y-%m-%d",os.time()))
		local f_name2 = f_name2 or Time
		local ED_Time = "["..os.date("%H:%M:%S",os.time()).."] "
		local name="extdev/logs/"..f_name1.."/"..f_name2..".txt"
		local content=ED_Time..cont.."\n"

		//print("Attempt to log something.")
		//print("Current file name is "..f_name2.." in "..f_name1)
		if file.Exists(name,"DATA")then
			//print("Attempt append to current file.")
			file.Append(name,content)
		else
			//print("Attempt make a new file.")
			file.CreateDir("extdev/logs/"..f_name1)
			file.Write(name,content)
		end
	end
end
