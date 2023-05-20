if SERVER then
	util.AddNetworkString("EXTDEV_F3MENU")
	local data=util.TableToJSON({{"Spawn","console/intro",Vector(0,0,0)}},true)
	local pos=Vector(0.0,0.0,0.0)

	local function manageFile(fileName)
		local returner={}
		table.Empty(returner)
		if file.IsDir("extdev","DATA")then
			if file.IsDir("extdev/qtp","DATA")then
				if file.Exists("extdev/qtp/"..fileName..".txt","DATA")then
					local tbl=util.JSONToTable(file.Read("extdev/qtp/"..fileName..".txt","DATA"))
					returner=tbl
				else
					PrintMessage(HUD_PRINTCONSOLE,"file '"..fileName.."' doesn't exist. Trying to create a new one.")
					file.Write("extdev/qtp/"..fileName..".txt",data)
				end
			else
				file.CreateDir("extdev/qtp")
				PrintMessage(HUD_PRINTCONSOLE,"Directory 'extdev/qtp' doesn't exist. Trying to create a new one.")
				manageFile(fileName)
			end
		else
			file.CreateDir("extdev")
			PrintMessage(HUD_PRINTCONSOLE,"Directory 'extdev' doesn't exist. Trying to create a new one.")
			manageFile(fileName)
		end
		return returner
	end// manageFile()

	hook.Add("PlayerButtonDown","EXTDEV_F3_MENU",function(ply, bttn)
		if bttn==KEY_F3 then
			if IsValid(ply)then
				net.Start("EXTDEV_F3MENU")
					net.WriteTable(manageFile(game.GetMap()))
				net.Send(ply)
			end
		end
	end)

	net.Receive("EXTDEV_F3MENU",function(length,ply)ply:SetPos(net.ReadVector())end)
else
	//	#####	#		#	#####	#     #		#####
	//	#   #	#		#	#		##    #		  #  
	//	#		#		#	#		# #   #		  #
	//	#		#		#	####	#  #  #		  #
	//	#		#		#	#		#   # #		  #
	//	#   #	#		#	#		#	 ##		  #
	//	#####	#####	#	#####	#	  #		  #
	local function makePanel(data,qtp)
		if not IsValid(Frame) then
			Frame=vgui.Create("extdev_frame")
			Frame:SetSize(ScrW()/3,ScrH()/2)
			Frame:Center()
			Frame:MakePopup()
			Frame:SetTitle("ExtDev:/modules/QTPMenu.rap3")
			Frame:SetIcon("icon16/world.png")
			//	Other Shits
			ScrollPanel=vgui.Create("DScrollPanel",Frame)
			ScrollPanel:Dock(FILL)
			ScrollPanel:DockMargin(0,0,0,Frame:GetTall()/10)
			ScrollPanel.Paint=nil
			ScrollPanel.VBar.Paint=nil
			ScrollPanel.VBar.btnGrip.Paint=nil
			ScrollPanel.VBar.btnUp.Paint=nil
			ScrollPanel.VBar.btnDown.Paint=nil
			for _number,v in pairs(qtp)do
				local Panel=ScrollPanel:Add("DPanel")
				Panel:SetSize(Frame:GetWide()*0.75,Frame:GetTall()/10)
				Panel:SetPos((Frame:GetWide()/2)-Panel:GetWide()/2,0)
				Panel:AlignTop((_number*Frame:GetWide()*0.75)/5)
				Panel.Paint=function(self,width,height)
					if isstring(v[4]) then
						surface.SetDrawColor(255,255,255,255)
						surface.SetTexture(surface.GetTextureID(v[4]))
						surface.DrawTexturedRect(5,5,width-5,height-5)
					else
						surface.SetDrawColor(255,255,255,255)
						surface.SetTexture(surface.GetTextureID("hlmv/background"))
						surface.DrawTexturedRect(5,5,width-5,height-5)
					end
				end

				local Image=vgui.Create("DImage",Panel)
				Image:Dock(LEFT)
				Image:DockMargin(25,0,0,0)
				Image:SetImage(v[2])

				local Label=vgui.Create("DLabel",Panel)
				Label:SetColor(Panel:GetBackgroundColor())
				Label:SetText(v[1])
				Label:SetFont("extdev_header")
				Label:SetSize(Frame:GetWide(),Label:GetTall())
				Label:SetPos(Panel:GetWide()*0.25,Panel:GetTall()/3)

				local Button=vgui.Create("DButton",Panel)
				Button:SetText("")
				Button:Dock(FILL)
				Button.Paint=nil
				Button.DoClick=function()net.Start("EXTDEV_F3MENU",false)net.WriteVector(v[3])net.SendToServer()end
			end
		end
	end
	local function preparePanel(tbl)
		local data={}
		table.Empty(data)
		if table.IsEmpty(tbl)then
			chat.AddText(Color(255,255,255),"[",Color(255,255,255),"QTP Menu",Color(255,255,255),"] ",Color(200,55,55),"This map doesn't have any destinations.")
			sound.Play("buttons/button10.wav",LocalPlayer():GetPos())
		else
			data=extdev.LoadCFG(LocalPlayer())
			if table.IsEmpty(data)then
				chat.AddText(Color(255,255,255),"[",Color(255,255,255),"QTP Menu",Color(255,255,255),"] ",Color(200,55,55),"Failed to get player settings.")
				sound.Play("buttons/button2.wav",LocalPlayer():GetPos())
			else
				makePanel(data,tbl)
				sound.Play("buttons/button9.wav",LocalPlayer():GetPos())
			end
		end
	end

	net.Receive("EXTDEV_F3MENU",function(length,ply)
		local tbl=net.ReadTable()
		preparePanel(tbl)
	end)
end