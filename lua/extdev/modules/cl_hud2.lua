AddCSLuaFile()
if CLIENT then
	//	MISC FONTS
	surface.CreateFont("counterstrikedeaths",{font="csd",size=64,weight=500})

	function ScrRatio()
		local W,H=ScrW(),ScrH()
		local Res = W/H
		return Res
	end
end
local Data={}
	Data.BGColor=Color(0,0,0,150)
	Data.FGColor=Color(35,35,35,150)
	Data.Language="en"
	Data.Fonts={"Akbar","Roboto","Arial","Tahoma","Calibri","Comic Sans MS"}
	Data.Offset=Vector(0,0,0)//	Left/Right Offset | Up/Down Offset | NOTHING
	Data.Scale=1.125
	Data.AvatarPoly=50
Data=extdev.LoadCFG(LocalPlayer())
Data=extdev.ReloadCFG(LocalPlayer())
Shapes={}
	local x_=(Data.Offset.x*Data.Scale)+ScrW()/35
	local y_=(Data.Offset.y*Data.Scale)+ScrH()/1.575
	Shapes.HUD1={
		{x=275+x_,y=237.5+y_},{x=0+x_,y=200+y_},{x=0+x_,y=150+y_},{x=25+x_,y=125+y_},{x=200+x_,y=125+y_},{x=225+x_,y=150+y_},{x=300+x_,y=150+y_},
		{x=325+x_,y=125+y_},
		{x=350+50+x_,y=125+y_},//
		{x=350+50+x_,y=200+y_},//
		{x=325+50+x_,y=225+y_},//
		{x=325+50+x_,y=250+y_},//
		{x=25+x_,y=250+y_},{x=25+x_,y=225+y_},{x=0+x_,y=200+y_}
	}
	Shapes.HUD2={
		{x=275+x_,y=237.5+y_},{x=-5+x_,y=205+y_},{x=-5+x_,y=145+y_},{x=20+x_,y=120+y_},{x=205+x_,y=120+y_},{x=230+x_,y=145+y_},{x=295+x_,y=145+y_},
		{x=320+x_,y=120+y_},
		{x=405+x_,y=120+y_},//
		{x=405+x_,y=205+y_},//
		{x=380+x_,y=230+y_},//
		{x=380+x_,y=255+y_},//
		{x=20+x_,y=255+y_},{x=20+x_,y=230+y_},{x=-5+x_,y=205+y_}
	}
	
	for num,vert in pairs(Shapes.HUD1)do
		vert.x=(Shapes.HUD1[num].x*Data.Scale)
		vert.y=(Shapes.HUD1[num].y*Data.Scale)
	end
	for num,vert in pairs(Shapes.HUD2)do
		vert.x=(Shapes.HUD2[num].x*Data.Scale)
		vert.y=(Shapes.HUD2[num].y*Data.Scale)
	end

local IsLoaded=false
//	16:9	1.77777
//	 4:3	1.3333

if EXTDEV then
	//extdev.ReloadCFG(LocalPlayer())
	if not IsLoaded then
		IsLoaded=true
		local AvatarMat=CreateMaterial("AvatarMat","UnlitGeneric",{
			["$basetexture"]="vgui/avatar_default",
			["$model"]=1,
			["$noclamp"]=1,
			["$translucent"]=1,
			["$vertexalpha"]=1,
			["$vertexcolor"]=1
		})
	//hook.Remove("HUDDrawTargetID","EXTDEV_HUD_TARGET")
	hook.Add("HUDShouldDraw","EXTDEV_HUD_REMOVE",function(name)
		local HUD = {"CHudHealth","CHudBattery","CHudHintDisplay","CHudGeiger"}
		for k,element in pairs(HUD)do
			if name==element then return false end
		end
		return true
	end)

	function EXTDEV.DrawHUD()
		//http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=1DA0EAA2D4F01B9E5D7EB303DE29747F&steamids=76561198110619643
		if CLIENT then
			//print("Player Table")
			//PrintTable(Data)
			if IsValid(A) then A:Remove() end
			local A=nil

			local start_a,start_h,AP_new,HP_new,AP_last,HP_last=0,0,0,0,0,0
			local Delay=0.5

			hook.Add("HUDPaint","EXTDEV_CUSTOM_HUD",function()
				if not IsValid(A) then
					A=vgui.Create("DHTML")
					http.Fetch(Format("http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=1DA0EAA2D4F01B9E5D7EB303DE29747F&steamids=%s",LocalPlayer():SteamID64()),
						function(responseText,contentLength,responseHeaders,statusCode)
							local url=util.JSONToTable(responseText)
							local size=512
							
							A:SetSize(size,size)
							A:SetVisible(false)
							A:SetHTML([[<html>
				<head>
				<style type="text/css">
					html
					{
						overflow:hidden;
						]] .. (true and "margin: -8px -8px;" or "margin: 0px 0px;") .. [[
					}
				</style>
				</head>

				<body>
					<img src="]]..url.response.players[1].avatarfull..[[" alt="" width="]]..size..[[" height="]]..size..[[" />
				</body>
			</html>]])
							A:Refresh()
							A:SetMouseInputEnabled(false)

							timer.Simple(2,function()
								//print("hoh jako hoh")
								if A:IsValid() then
									//print("s jako honális")
									A:UpdateHTMLTexture()
									local html_mat=A:GetHTMLMaterial()
									html_mat:GetTexture("$basetexture"):Download()
									AvatarMat:SetString("$basetexture",html_mat:GetName())
								end
							end)
						end,
						function(errorMessage)
							print(errorMessage)
						end,
						{
							["accept-encoding"] = "gzip, deflate",
            				["accept-language"] = "en"
       					}
       				)
				end// DHTML Panel

				local x=Shapes.HUD1[1].x
				local y=Shapes.HUD1[1].y
				
				local HP=LocalPlayer():Health()
				local AP=LocalPlayer():Armor()
				
				if HP_new ~= HP then
					start_h=SysTime()
					HP_new=HP
				elseif SysTime()-start_h>Delay then
					HP_last=HP
				end

				if AP_new ~= AP then
					start_a=SysTime()
					AP_new=AP
				elseif SysTime()-start_a>Delay then
					AP_last=AP
				end

				draw.NoTexture()
				surface.SetDrawColor(Data.BGColor.r,Data.BGColor.g,Data.BGColor.b,150)
				surface.DrawPoly(Shapes.HUD2)
				surface.SetDrawColor(Data.FGColor.r,Data.FGColor.g,Data.FGColor.b,150)
				surface.DrawPoly(Shapes.HUD1)

				surface.SetDrawColor(255,255,255,255)
				surface.SetMaterial(Material("vgui/avatar_default","noclamp smooth"))
				draw.Circle(x-230,y-42.5,48,Data.AvatarPoly)
				surface.SetTexture(surface.GetTextureID(AvatarMat:GetString("$basetexture")))
				draw.Circle(x-230,y-42.5,48,Data.AvatarPoly)

				draw.RoundedBox(5,x-175,y-45,275,22.222*Data.Scale,Color(0,100,0))
				draw.RoundedBox(5,x-175,y-45,math.Clamp(Lerp((SysTime()-start_h)/Delay,HP_last,HP_new),0,LocalPlayer():GetMaxHealth())/LocalPlayer():GetMaxHealth()*275,22.222*Data.Scale,Color(0,200,0))
				draw.RoundedBox(5,x-175,y-17,275,22.222*Data.Scale,Color(15,127,127))
				draw.RoundedBox(5,x-175,y-17,math.Clamp(Lerp((SysTime()-start_a)/Delay,AP_last,AP_new),0,LocalPlayer():GetMaxHealth())/LocalPlayer():GetMaxHealth()*275,22.222*Data.Scale,Color(30,255,255))
				
				//draw.RoundedBox(5,x-175,y-75,100,22.222*Data.Scale,Color(127,105,8))
				//draw.RoundedBox(5,x-175,y-75,math.Clamp(LocalPlayer():Ping(),0,150)/10,22.222*Data.Scale,Color(255,211,17))

				//draw.RoundedBox(5,x-70,y-75,100,22.222*Data.Scale,Color(127,99,33))
				//draw.RoundedBox(5,x-70,y-75,75,22.222*Data.Scale,Color(255,198,66))

				draw.SimpleText(LocalPlayer():Nick(),"extdev_nick",x-185,y-115,LocalPlayer():GetPlayerColor()*255,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("Health: "..math.Round(Lerp((SysTime()-start_h)/Delay,HP_last,HP_new,0,LocalPlayer():GetMaxHealth())),"extdev_hp",x-150,y-32.5,Color(15,127,127),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)//0,100,0
				draw.SimpleText("Armor: "..math.Round(Lerp((SysTime()-start_a)/Delay,AP_last,AP_new,0,LocalPlayer():GetMaxHealth())),"extdev_hp",x-150,y-5,Color(0,100,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)//15,127,127
				draw.SimpleText(os.date("%H:%M",os.time()),"extdev_time",x+95,y-115,Color(253,150,34),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(team.GetName(LocalPlayer():Team()),"extdev_rank",x+125,y-80,team.GetColor(LocalPlayer():Team()),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
				
				draw.SimpleText("Ping: "..LocalPlayer():Ping(),"extdev_misc",x-150,y-65,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				//if NADMOD then
				draw.SimpleText("Props: "..LocalPlayer():GetCount("props"),"extdev_misc",x-20,y-65,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				//end

			end)
			hook.Add("HUDDrawTargetID","EXTDEV_HUD_TARGET",function()
				rayTrace=util.TraceLine({Vector(0,0,0),LocalPlayer():GetAimVector(),LocalPlayer(),MASK_PLAYERSOLID,COLLISION_GROUP_NONE,false,nil})
				
				if istable(rayTrace) then
					name="nil 100%"
					if(IsValid(rayTrace[0]))then
						name=rayTrace[1]:GetName()
					end
					//draw.SimpleText(name,"extdev_nick",ScrW()/2,ScrH()/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				end
				return true
			end)
		end
	end
	end
	function EXTDEV.HideHUD()
		if CLIENT then
			if IsValid(A)then A:Remove() end
			hook.Remove("HUDPaint","EXTDEV_CUSTOM_HUD")
			hook.Remove("HUDDrawTargetID","EXTDEV_HUD_TARGET")
			hook.Add("HUDDrawTargetID","EXTDEV_HUD_TARGET",function(name)
				return true
			end)
		end
	end
	EXTDEV.HideHUD()
	if GetConVar("cl_drawhud") then
		if GetConVar("cl_drawhud"):GetBool()then
			EXTDEV.DrawHUD()
		else
			EXTDEV.HideHUD()
		end
	end
	cvars.AddChangeCallback("cl_drawhud",function(convar,old,new)
		if tobool(new) then
			EXTDEV.DrawHUD()
		else
			EXTDEV.HideHUD()
		end
	end)
end