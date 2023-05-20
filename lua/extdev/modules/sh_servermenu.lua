if SERVER then
	net.Receive("ARCHOS_RaveCube_SetSong",function(len,ply)
		print("Server got link, sending back to players")
		net.Start("ARCHOS_RaveCube_SetSong",false)
			net.WriteString(net.ReadString())
		net.Send(player.GetHumans())
		print("Sent to players")
	end)

	hook.Add("PlayerButtonDown","EXTDEV ServerMenu Bind",function(ply, bttn)
		if bttn==KEY_F2 then
			if IsValid(ply)then
				net.Start("EXTDEV_F2MENU",false)
					net.WriteString(util.Base64Encode("get.player.lang",false))
				net.Send(ply)
			end
		end
	end)

	concommand.Add("gmod_autoprop",function(ply,cmd,args,args_s)
		if IsValid(ply)then
			if table.HasValue(EXTDEV.Props,ply:SteamID64())then
				table.RemoveByValue(EXTDEV.Props,ply:SteamID64())
			else
				table.insert(EXTDEV.Props,ply:SteamID64())
			end
		end
	end,
	function(cmd,args)
	end,
	"Enables Auto-Prop nocollide for player.",
	FCVAR_USERINFO)

	net.Receive("EXTDEV_F2MENU",function(len,ply)
		if util.Base64Decode(net.ReadString(),false)=="send.player.lang"then
			local name=net.ReadString()
			local lang=file.Read("extdev/lang/"..name..".lua","LSV")
			net.Start("EXTDEV_F2MENU",false)
				net.WriteString(util.Base64Encode("show.menu",false))
				net.WriteUInt(#lang,16)
				net.WriteData(util.Compress(lang))
			net.Send(ply)
		end
	end)
else
	local Right

	local lang
	local data
	local RaveCube=nil

	local function switchPanel(name)
			if name==lang["EXTDEV.SMenu.SV_INFO"]then
				Right:Clear()
		elseif name==lang["EXTDEV.SMenu.CL_CFG"]then
			Right:Clear()
		elseif name==lang["EXTDEV.SMenu.SV_CFG"]then
			Right:Clear()
		elseif name==lang["EXTDEV.SMenu.Rave"]then
			Right:Clear()
			Right.Paint=function(s,w,h)draw.RoundedBox(0,0,0,w,h,HSVToColor(RaveCube.LastH, 1, 0.8))end

			local Spectrum=vgui.Create("DPanel",Right,"RaveCube FFT Spectrum")
			Spectrum:SetSize(Right:GetWide(),Right:GetTall()*0.45)
			Spectrum:Dock(BOTTOM)
			if isnumber(RaveCube.FFT[1]) and RaveCube.FFT[1]>=0.0 then
				Spectrum.Paint=function(s,w,h)//						FFT_2048
					draw.RoundedBox(0,0,0,w,h,Color(50,50,50,100))
					for k=1,57 do
						local v=RaveCube.FFT[k]
						surface.SetDrawColor(50+v*512,200-v*512,50,255)
						surface.SetTexture(surface.GetTextureID("color"))
						surface.DrawTexturedRectRotated(-4+8*k,h,8,8+v*1000,180)
					end
					
				end
			else Spectrum.Paint=nil end

			local Entry=vgui.Create("DTextEntry",Right,"RaveCube TextEntry")
			Entry:SetSize(Right:GetWide()*0.9,Right:GetTall()*0.05)
			Entry:Dock(TOP)
			Entry:DockMargin(5,5,5,0)
			Entry.OnEnter=function(self)
				if string.find(Entry:GetValue(),"https://")then
					net.Start("ARCHOS_RaveCube_SetSong",false)
						net.WriteString(Entry:GetValue())
					net.SendToServer()
					print("Sending link to Server")
				end
			end

			/*
			local Queue=vgui.Create("RichText",Right,"RaveCube Queue")
			Queue:SetSize(Right:GetWide()/2,Right:GetTall()*0.9)
			Queue:SetPos(0,0)
			Queue:InsertColorChange(255,255,255,255)
			if not table.IsEmpty(RaveCube.Queue)then
				for k,v in pairs(RaveCube.Queue)do
					Queue:AppendText(v)
				end
			else
				Queue:AppendText("Playlist is empty!")
			end*/


		elseif name==lang["EXTDEV.SMenu.Misc"]then
			Right:Clear()
		else return end
	end
	
	local function makePanel(data,lang)
		if istable(data) and istable(lang)then
			
			cubes=ents.FindByClass("ravecube")
			for k,v in pairs(cubes)do
				if v:GetPos():Distance(LocalPlayer():GetPos())<2048 then RaveCube=v end
			end
			if not IsValid(Framer)then
				Framer=vgui.Create("extdev_frame",nil,"Base Frame")
				Framer:SetTitle("ExtDev:/modules/ServerMenu.rap3")
				Framer:SetSize(ScrW()/2,ScrH()/2.5)
				Framer:Center()
				Framer:MakePopup()
				Framer:SetIcon("icon16/layout.png")

				local Frame=vgui.Create("DPanel",Framer,"Fake Frame")
				Frame:Dock(FILL)
				Frame:DockMargin(25,15,20,25)//	LEFT | TOP | RIGHT | DOWN
				//Frame.Paint=nil

				local SelectIMG=vgui.Create("DImage",Frame,"ComboBox IMG")
				SelectIMG:SetPos(15,15)
				SelectIMG:SetSize(Framer:GetTall()/15,Framer:GetTall()/15)
				SelectIMG:SetImage("icon16/information.png","vgui/avatar_default")

				local Select=vgui.Create("extdev_combobox",Frame,"ComboBox")
				Select:SetPos(50,15)
				Select:SetSize(Framer:GetWide()/4,Framer:GetTall()/15)
				Select:SetSortItems(false)
				Select:ChooseOption(lang["EXTDEV.SMenu.SV_INFO"],1)

				//	| Text | IDFK | Selected | Icon |
				Select:AddChoice(lang["EXTDEV.SMenu.SV_INFO"],nil,false,"icon16/information.png")//Server Info
				Select:AddChoice(lang["EXTDEV.SMenu.CL_CFG"],nil,false,"icon16/user_edit.png")//Client CFG
				if LocalPlayer():IsSuperAdmin()then Select:AddChoice(lang["EXTDEV.SMenu.SV_CFG"],nil,false,"icon16/user_suit.png")end//Server CFG
				
				if IsValid(RaveCube) then Select:AddChoice(lang["EXTDEV.SMenu.Rave"],nil,false,"icon16/ipod.png")end//Rave Cube
				Select:AddChoice(lang["EXTDEV.SMenu.Misc"],nil,false,"icon16/note_edit.png")
				Select.OnSelect=function(id,text,data)
					img=id:GetChildren()[2]:GetChildren()[1]:GetChildren()[Select:GetSelectedID()]:GetChildren()[1].ImageName
					SelectIMG:SetImage(img,"vgui/avatar_default")
					switchPanel(data)

					//var=id:GetChildren()[2]:GetChildren()[1]:GetChildren()[Select:GetSelectedID()]:GetTable().Panel:GetTable().Panel:GetChildren()
					//if istable(var)then PrintTable(var)else print(var)end
				end

				Right=vgui.Create("DPanel",Frame,"Right Panel")
				Right:SetSize(Framer:GetWide()/1.75,Framer:GetTall())
				Right:Dock(RIGHT)
				Right:DockMargin(0,0,0,0)
				Right.Paint=function(s,w,h)draw.RoundedBox(0,0,0,w,h,Color(150,50,50))end
			end
		end
	end

	net.Receive("EXTDEV_F2MENU",function(len,ply)
		data=extdev.LoadCFG(LocalPlayer())
		local func=util.Base64Decode(net.ReadString(),false)
		if func=="get.player.lang"then
			net.Start("EXTDEV_F2MENU",false)
				net.WriteString(util.Base64Encode("send.player.lang",false))
				net.WriteString(data["Language"])
			net.SendToServer()
		elseif func=="show.menu"then
			bytes=net.ReadUInt(16)
			lang=util.JSONToTable(util.Decompress(net.ReadData(bytes),nil))
			makePanel(data,lang)
		end
		
	end)-- net.Receive
end-- if SERVER