AddCSLuaFile()
if CLIENT then
	local Frame
	local Lang={}
	local data=extdev.LoadCFG(LocalPlayer())

	//	Hiding Original/Other Scoreboards
	//	Loading Player Data
	//	Adding hook for Showing Scoreboard
	//	Adding hook for Hiding Scoreboard

	net.Start("EXTDEV_LANG",false)
		net.WriteString(util.Base64Encode("send.player.lang",false))
		net.WriteString(data["Language"])
	net.SendToServer()

	net.Receive("EXTDEV_LANG",function(len,ply)
		print("Lang MSG Received")
		if util.Base64Decode(net.ReadString(),false)=="there.lang"then
			print("Lang accepted")
			local bytes=net.ReadUInt(16)
			Lang=util.JSONToTable(util.Decompress(net.ReadData(bytes),nil))
		end
	end)

	local function removeOldSB()
		for name,identifier in pairs(hook.GetTable())do
			if name=="ScoreboardShow"then
				for id,func in pairs(identifier)do
					if id!="ExtDev Scoreboard Show"then
						print(string.format("Removing SB_Show Hook: %s | %s",name,id))
						hook.Remove(name,id)
					end
				end
			elseif name=="ScoreboardHide"then
				for id,func in pairs(identifier)do
					if id!="ExtDev Scoreboard Hide"then
						print(string.format("Removing SB_Hide Hook: %s | %s",name,id))
						hook.Remove(name,id)
					end
				end
			end
		end
	end

	PrintTable(Lang)

	local function makePanel()
		Frame=vgui.Create("extdev_frame")
			Frame:SetSize(ScrW()/2,ScrH()/2)
			Frame:Center()
			Frame:SetTitle("ExtDev:/modules/ScoreBoard.rap3")
			Frame:SetDraggable(false)
			Frame:SetSizable(false)
			Frame:ShowCloseButton(false)
			Frame:SetIcon("icon16/application_xp_terminal.png")

		local P=vgui.Create("DScrollPanel",Frame)
			P:SetSize(Frame:GetWide()*0.9,Frame:GetTall()*0.9)
			P:Dock(FILL)
			P:DockMargin(Frame:GetWide()*0.035,Frame:GetTall()*0.05,Frame:GetWide()*0.035,Frame:GetTall()*0.05)//	Left | Top | Right | Bottom
			P.Paint=nil
			P.VBar.Paint=nil
			P.VBar.btnGrip.Paint=nil
			P.VBar.btnUp.Paint=nil
			P.VBar.btnDown.Paint=nil

		for number,ply in ipairs(player.GetAll())do
			local Panel=P:Add("DPanel")
				Panel:SetSize(P:GetWide()*1.02,P:GetTall()*0.15)
				Panel:AlignTop(-80+(number*Frame:GetWide()*0.5)/5)
				local A=nil
				Panel.Paint=function(s,w,h)
					draw.RoundedBox(10,0,0,w,h,ply:GetPlayerColor():ToColor())
					if not IsValid(A) then
						A=vgui.Create("AvatarImage",Panel)
						A:SetSize(Panel:GetTall()*0.9,Panel:GetTall()*0.9)
						A:Dock(LEFT)
						A:DockMargin(5,5,0,5)
						A:SetPlayer(ply,184)
					end
					
					local X=(Panel:GetTall()*0.9)*1.125
					local Y=(Panel:GetTall()*0.9)*0.1
					
					//	ExtDev Fonts:
					//	extdev_hp | extdev_time | extdev_rank | extdev_nick | extdev_header | extdev_misc
					local inv_ply=Color(255-ply:GetPlayerColor()[1]*255,255-ply:GetPlayerColor()[2]*255,255-ply:GetPlayerColor()[3]*255)

					draw.DrawText(""..ply:GetName(),"extdev_nick",X,Y,inv_ply,TEXT_ALIGN_LEFT)
					draw.DrawText(""..Lang[team.GetName(ply:Team())],"extdev_rank",X,Y*4,team.GetColor(ply:Team()),TEXT_ALIGN_LEFT)
					draw.DrawText(""..Lang["Ping"]..": "..ply:Ping(),"extdev_misc",X,Y*7,inv_ply,TEXT_ALIGN_LEFT)

				end//Panel.Paint
			local Mute=vgui.Create("DImageButton",Panel)
				Mute:SetSize(Panel:GetTall()*0.5,Panel:GetTall()*0.5)
				Mute:Dock(RIGHT)
				Mute:DockMargin(5,5,5,5)
				Mute:SetImage("icon32/unmuted.png")
				Mute.Paint=function(s,w,h)draw.RoundedBox(5,0,0,w,h,Color(50,50,50,100))end
				Mute.DoClick=function(s)ply:SetMuted(!ply:IsMuted())end
				Mute.Think=function()if ply:IsMuted()then Mute:SetImage("icon32/muted.png")else Mute:SetImage("icon32/unmuted.png") end end

			if ply==LocalPlayer()then Mute:Remove()end
		end//for num,ply
		
		gui.EnableScreenClicker(true)
	end

	hook.Add("ScoreboardShow","ExtDev Scoreboard Show",function()
		if not Frame then
			if not table.IsEmpty(Lang)then
				makePanel()
			else
				IncludeCS("extdev/modules/cl_scoreboard.lua")
				return true
			end
		end 
		return true
	end)
	hook.Add("ScoreboardHide","ExtDev Scoreboard Hide",function()
		if Frame then
			Frame:Remove()
			Frame=nil
			gui.EnableScreenClicker(false)
			IncludeCS("extdev/modules/cl_scoreboard.lua")
		end 
	end)

	timer.Simple(0,function()removeOldSB()end)
end-- if CLIENT