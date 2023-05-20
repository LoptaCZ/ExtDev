if CLIENT then
	local Data={}
	AddCSLuaFile()
	local Shape1={
		{x=ScrW()/35,y=ScrH()/1.045},{x=ScrW()/35,y=ScrH()/1.205},{x=ScrW()/10.5,y=ScrH()/1.205},{x=ScrW()/8,y=ScrH()/1.185},{x=ScrW()/6.3,y=ScrH()/1.185},
		{x=ScrW()/5.3,y=ScrH()/1.205},{x=ScrW()/3.53,y=ScrH()/1.205},{x=ScrW()/3.17,y=ScrH()/1.15},{x=ScrW()/3.17,y=ScrH()/1.045}
	}
	local Shape2={
		{x=ScrW()/32,y=ScrH()/1.05},{x=ScrW()/32,y=ScrH()/1.2},{x=ScrW()/10.5,y=ScrH()/1.2},{x=ScrW()/8,y=ScrH()/1.18},{x=ScrW()/6.2,y=ScrH()/1.18},
		{x=ScrW()/5.3,y=ScrH()/1.2},{x=ScrW()/3.55,y=ScrH()/1.2},{x=ScrW()/3.2,y=ScrH()/1.15},{x=ScrW()/3.2,y=ScrH()/1.05}
	}
	local MiniShape1={
		{x=ScrW()/1.33,y=ScrH()/1.8},{x=ScrW()/1.33,y=ScrH()/2.2},{x=ScrW()/1.27,y=ScrH()/2.2},{x=ScrW()/1.24,y=ScrH()/2.15},{x=ScrW()/1.2,y=ScrH()/2.15},{x=ScrW()/1.18,y=ScrH()/2.2},
		{x=ScrW()/1.03,y=ScrH()/2.2},{x=ScrW()/1.002,y=ScrH()/2.1},{x=ScrW()/1.002,y=ScrH()/1.8}
	}
	local MiniShape2={
		{x=ScrW()/1.32,y=ScrH()/1.82},{x=ScrW()/1.32,y=ScrH()/2.17},{x=ScrW()/1.27,y=ScrH()/2.17},{x=ScrW()/1.245,y=ScrH()/2.125},{x=ScrW()/1.195,y=ScrH()/2.125},{x=ScrW()/1.18,y=ScrH()/2.17},
		{x=ScrW()/1.03,y=ScrH()/2.17},{x=ScrW()/1.0075,y=ScrH()/2.095},{x=ScrW()/1.0075,y=ScrH()/1.82}
	}
	local Warn1 = {
		{x=ScrW(),y=0},
		{x=ScrW(),y=ScrH()/16},
		{x=ScrW()/1.05,y=ScrH()/16},
		{x=ScrW()/1.075,y=ScrH()/20},
		{x=ScrW()/1.11,y=ScrH()/20},--
		{x=ScrW()/1.15,y=ScrH()/16},
		{x=ScrW()/1.235,y=ScrH()/16},
		{x=ScrW()/1.25,y=ScrH()/24},
		{x=ScrW()/1.25,y=0.001}
	}
	local Warn2 = {
		{x=ScrW()-6,y=6},
		{x=ScrW()-6,y=(ScrH()/16)-6},
		{x=ScrW()/1.05,y=(ScrH()/16)-6},
		{x=ScrW()/1.0725,y=(ScrH()/20)-6},
		{x=ScrW()/1.11,y=(ScrH()/20)-6},--
		{x=(ScrW()/1.15)-6,y=(ScrH()/16)-6},
		{x=(ScrW()/1.235)+2,y=(ScrH()/16)-6},
		{x=(ScrW()/1.25)+6,y=ScrH()/24},
		{x=(ScrW()/1.25)+6,y=6}
	}
	local Color1 = Color(0,0,0,150)
	local Color2 = Color(35,35,35,150)
	local Language = "en"
	local Font = string.Explode(",","Akbar,Roboto,Arial,Tahoma,Calibri,Comic Sans MS")

	if IsValid(LocalPlayer())then
		if file.Exists("extdev/"..LocalPlayer():SteamID64()..".txt","DATA")then
			local File = file.Read("extdev/"..LocalPlayer():SteamID64()..".txt","DATA")

			local Exp = string.Explode(";",File)
			Color1    = string.ToColor(Exp[1])--Outter
			Color2    = string.ToColor(Exp[2])--Inner
			Language  = Exp[3]--Language
			Font      = string.Explode(",",Exp[4]or"Akbar,Roboto,Arial,Tahoma,Calibri,Comic Sans MS")
		else
			Color1=Color(0,0,0,150)
			Color2=Color(35,35,35,150)
		end
	else
		if IsValid(LocalPlayer())and file.Exists("extdev/"..LocalPlayer():SteamID64()..".txt","DATA")then
			if Color1==Color(0,0,0,150)and Color2==Color(35,35,35,150)then
				timer.Simple(5,function()
					RunString("extdev/modules/cl_hud.lua")
				end)
			else
				return
			end
		end
	end
	
	local Props = NADMOD.PropOwners
	local PropNames = NADMOD.PropNames
	net.Receive("nadmod_propowners",function(len)
		local nameMap = {}
		for i=1, net.ReadUInt(8) do
			nameMap[i] = {SteamID = net.ReadString(), Name = net.ReadString()}
		end
		for i=1, net.ReadUInt(32) do
			local id, owner = net.ReadUInt(16), nameMap[net.ReadUInt(8)]
			if owner.SteamID == "-" then Props[id] = nil PropNames[id] = nil
			elseif owner.SteamID == "W" then PropNames[id] = "World"
			elseif owner.SteamID == "O" then PropNames[id] = "Ownerless"
			else
				Props[id] = owner.SteamID
				PropNames[id] = owner.Name
			end
		end
	end)

	surface.CreateFont("HUD_Time",{font=""..Font[1],size=22,weight=500})     //	Time
	surface.CreateFont("HUD_Nums",{font=""..Font[2],size=20,weight=500})     //	HP/AP
	surface.CreateFont("HUD_ScBo",{font=""..Font[3],size=22,weight=500})     //	ScoreBoard thing
	surface.CreateFont("HUD_Head",{font=""..Font[4],size=32,weight=500})     //	Header
	surface.CreateFont("HUD_Rank",{font=""..Font[5],size=22,weight=500})	 //	Rank
	surface.CreateFont("HUD_Name",{font=""..Font[6],size=20,weight=500})	 //	Name

	hook.Add("HUDPaint","EXTDEV_HUD_PAINT",function()
		if LocalPlayer then 
			local ply = LocalPlayer()
			if ply:Alive() then
				if ply.ragdoll then
					A:SetPos(-ScrW(),-ScrH())
				elseif ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon():GetClass()=="gmod_camera" then
					A:SetPos(-ScrW(),-ScrH())
				else
					if ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon():GetClass()=="gmod_camera" then
						return
					else
						local HP = ""
						local AP = ""

						if ply:Health()>999 then HP="999+"else HP=""..ply:Health()end
						if ply:Armor()>999 then AP="999+"else AP=""..ply:Armor()end

						draw.NoTexture()
						surface.SetDrawColor(Color1.r,Color1.g,Color1.b,150)
						surface.DrawPoly(Shape1)
						surface.SetDrawColor(Color2.r,Color2.g,Color2.b,150)
						surface.DrawPoly(Shape2)

						draw.SimpleText(os.date("%H:%M",os.time()),"HUD_Time",ScrW()/7.75,ScrH()/1.175,Color(255,127,39))

						draw.RoundedBox(0,ScrW()/30,ScrH()/1.195,110,22,Color(0,100,0,200))
						draw.RoundedBox(0,ScrW()/27.5,ScrH()/1.193,math.Clamp(ply:Health(),0,100),16,Color(0,150,0,200))
						draw.SimpleText("Health: "..HP,"HUD_Nums",ScrW()/27,ScrH()/1.197,Color(255,255,255,255))

						draw.RoundedBox(0,ScrW()/30,ScrH()/1.16,110,22,Color(0,100,100,200))
						draw.RoundedBox(0,ScrW()/27.5,ScrH()/1.157,math.Clamp(ply:Armor(),0,100),16,Color(0,150,150,200))
						draw.SimpleText("Armor: "..AP,"HUD_Nums",ScrW()/27,ScrH()/1.162,Color(255,255,255,255))

						if A==nil and LocalPlayer != nil then
							A = vgui.Create("AvatarImage")
							A:SetSize(64,64)
							A:SetPlayer(LocalPlayer(),64)
						else
							A:SetPos(ScrW()/30,ScrH()/1.125)
						end

						draw.SimpleText(""..ply:Name(),"HUD_Name",ScrW()/13,ScrH()/1.125,ply:GetPlayerColor()*255)
						draw.SimpleText(""..team.GetName(ply:Team()),"HUD_Rank",ScrW()/13,ScrH()/1.105,team.GetColor(ply:Team()))
						draw.SimpleText("Ping: "..ply:Ping(),"HUD_Nums",ScrW()/4.75,ScrH()/1.18,Color(200,200,200,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

						if ply:InVehicle() then
							local Speed = math.floor(ply:GetVehicle():GetVelocity():Length() or ply:GetVehicle():GetParent():GetVelocity():Length())
							if ply:GetVehicle():GetClass()=="prop_vehicle_prisoner_pod" then
								if IsValid(ply:GetVehicle():GetParent()) and ply:GetVehicle():GetParent():GetClass()=="gmod_sent_vehicle_fphysics_base" then
									return
								else
									local Spd = math.Round(Speed*3600*0.0000254*0.75)
									draw.SimpleText(""..Spd.." KM/H","HUD_Head",ScrW()/3.25,ScrH()/1.09,Color(255,127,39),TEXT_ALIGN_RIGHT,TEXT_ALIGN_RIGHT)
								end
							else
								local Spd = math.Round(Speed*3600*0.0000254*0.75)
								draw.SimpleText(""..Spd.." KM/H","HUD_Head",ScrW()/3.25,ScrH()/1.09,Color(255,127,39),TEXT_ALIGN_RIGHT,TEXT_ALIGN_RIGHT)
							end
						end--[[]]

						if NADMOD then
							hook.Remove("HUDPaint","NADMOD.HUDPaint")

							surface.SetMaterial(Material("icon16/package.png"))
							surface.SetDrawColor(255,255,255,255)
							surface.DrawTexturedRect(ScrW()/13.25,ScrH()/1.08,24,24)
							draw.SimpleText("Props: "..ply:GetCount("props"),"HUD_ScBo",ScrW()/10.5,ScrH()/1.0675,Color(255,127,39),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

							local tr = LocalPlayer():GetEyeTrace()
							if !tr.HitNonWorld then return end

							local ent = tr.Entity
							if ent:IsValid() && !ent:IsPlayer() then
								local owner = PropNames[ent:EntIndex()] or "Nevíš co? Já taky ne"
								local text = "Owner: "..tostring(owner)
								local text2 = "'"..string.sub(table.remove(string.Explode("/", ent:GetModel() or "?")), 1,-5).."' ["..ent:EntIndex().."]"
								local text3 = ent:GetClass()

								draw.NoTexture()
								surface.SetDrawColor(Color1.r,Color1.g,Color1.b,150)
								surface.DrawPoly(MiniShape1)
								surface.SetDrawColor(Color2.r,Color2.g,Color2.b,150)
								surface.DrawPoly(MiniShape2)

								draw.SimpleText(text, "HUD_Name", ScrW()-385, ScrH()/2-25, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
								draw.SimpleText(text2, "HUD_Nums", ScrW()-385, ScrH()/2+35, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
								draw.SimpleText(text3, "HUD_Head", ScrW()-385, ScrH()/2, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
							end
						end

						local Text = "%VIOLATION_ERROR%"
						if (1/engine.ServerFrameTime())<33.333333333 then
							Text = "Low Server Tickrate"
							surface.SetDrawColor(100,100,0,100)
							surface.DrawPoly(Warn1)
							surface.SetDrawColor(200,200,0,100)
							surface.DrawPoly(Warn2)

							draw.SimpleText(Text,"HUD_Head",ScrW()/1.175,ScrH()/56,Color(math.Clamp(math.sin(CurTime()*10)*255,200,255),math.Clamp(math.sin(CurTime()*10)*255,200,255),math.Clamp(math.sin(CurTime()*10)*255,200,255)))
						else
							return
						end--Tickrate
					end--checking if ply have camera
				end--checking if ply is ragdoll
			else
				A:SetPos(-1024,-1024)
			end --Player Alive
		else return end--if LocalPlayer
	end)--Function

	hook.Add("HUDShouldDraw","EXTDEV_HUD_REMOVE",function(name)
		local HUD = {"CHudHealth","CHudBattery","CHudHintDisplay","CHudGeiger"}
		for k,element in pairs(HUD)do
			if name==element then return false end
		end
		return true
	end)

	hook.Add("PostPlayerDraw","EXTDEV_PLAYER_NAMES",function(ply)
		if(!IsValid(ply))then return end
		if(ply==LocalPlayer())then return end
		if(!ply:Alive())then return end
		local Distance = LocalPlayer():GetPos():Distance(ply:GetPos())
	
		if Distance < 500 then
			local off = Vector(0,0,85)
			local ang = LocalPlayer():EyeAngles()
			local pos = ply:GetPos()+off+ang:Up()
			local x_,y_,v_ = pos:ToScreen()

			ang:RotateAroundAxis(ang:Forward(),90)
			ang:RotateAroundAxis(ang:Right(),90)
	
			if 500 > Distance then X=Distance/500 Y=Vector(0,0,X*75)else X=0 Y=Vector(0,0,0) end
	
			cam.Start3D2D(pos+Y,Angle(0,ang.y,90),0.25+X)
				draw.DrawText(ply:Nick(),"HUD_Name",0,0,ply:GetPlayerColor()*255,TEXT_ALIGN_CENTER)
				draw.DrawText(team.GetName(ply:Team()),"HUD_Rank",0,20,team.GetColor(ply:Team()),TEXT_ALIGN_CENTER)
				draw.RoundedBox(0,-26,44,52,7,Color(50,150,50))
				draw.RoundedBox(5,-25,45,math.Clamp(ply:Health(),0,100)/2,5,Color(50,200,50))
				draw.RoundedBox(0,-26,54,52,7,Color(50,50,150))
				draw.RoundedBox(5,-25,55,math.Clamp(ply:Armor(),0,100)/2,5,Color(50,50,200))
				draw.DrawText(""..ply:Health(),"HUD_Nums",35,40,Color(255,255,255),TEXT_ALIGN_CENTER)
				draw.DrawText(""..ply:Armor(),"HUD_Nums",35,50,Color(255,255,255),TEXT_ALIGN_CENTER)
			cam.End3D2D()
		else
			local tr = LocalPlayer():GetEyeTrace()
			local off = Vector(0,0,85)
			local ang = LocalPlayer():EyeAngles()
			local ent= tr.Entity
			local pos = ply:GetPos()+off+ang:Up()
			local x_,y_,v_ = pos:ToScreen()
			if !tr.HitNonWorld then return end
			if IsValid(ent) and ent:IsPlayer()then
				local oldW, oldH = ScrW(), ScrH()
				local W,H = input.GetCursorPos()
				render.SetViewPort(0,0,oldW,oldH)
				cam.Start2D()
					draw.DrawText(ent:Nick(),"HUD_Name",W,H-50,ent:GetPlayerColor():ToColor(),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					draw.DrawText(ent:Health().."%","HUD_Nums",W,H-25,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					draw.DrawText(team.GetName(ent:Team()),"HUD_Rank",W,H-75,team.GetColor(ent:Team()),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				cam.End2D()
				render.SetViewPort(0,0,oldW,oldH)
			end
		end
	end)
	hook.Add("HUDDrawTargetID","EXTDEV_PLAYER_NAME_HIDER",function()
		return false
	end)
end-- if CLIENT
