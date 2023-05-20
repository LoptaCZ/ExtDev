AddCSLuaFile()

if SERVER then
	util.AddNetworkString("EXTDEV_SIMFPHYS_MENU")

	hook.Add("PlayerButtonDown","EXTDEV_SIMFPHYS_BIND",function(ply,key)
		if ply:IsSuperAdmin()then
			if key==KEY_F5 then
				net.Start("EXTDEV_SIMFPHYS_MENU")
				net.WriteString("open")
				net.Send(ply)
			end
		end
	end)
	net.Receive("EXTDEV_SIMFPHYS_MENU",function()
		local Func=string.lower(net.ReadString())

		if Func=="spawn"then
			local String     = net.ReadString()
			local Decompiled = util.Decompress(String)
			local JSON       = util.JSONToTable(Decompiled)

		end
	end)
else
	local ED_Model = "models/blu/gtav/dukes/dukes.mdl"
	surface.CreateFont("simfphys_label",{font="Impact",weight=500,size=36})
	net.Receive("EXTDEV_SIMFPHYS_MENU",function()
		local Func=string.lower(net.ReadString())
		if Func=="open"then
			if !Frame then
				local Mode="chassis"
				local Frame=vgui.Create("DFrame")
					Frame:SetSize(ScrW()/1.5,ScrH()/2)
					Frame:Center()
					Frame:MakePopup()
					Frame:SetTitle("[Simfphys] Simfphys Vehicle Editor")
					Frame.Paint=function(s,w,h)
						draw.RoundedBox(5,0,0,Frame:GetWide()/4.5,h,Color(75,75,75,255))
						draw.RoundedBox(5,Frame:GetWide()/1.45,0,w,h,Color(75,75,75,255))
						draw.RoundedBox(5,0,0,w,h,Color(0,0,0,200))
						draw.RoundedBox(5,0,0,w,Frame:GetTall()*0.04,Color(0,0,200,255))
					end
					Frame.OnClose=function()
						hook.Remove("Think","Thonkang")
					end
				local Model=vgui.Create("DModelPanel",Frame)
					Model:SetSize(ScrW()/3.5,ScrH()/2.5)
					Model:SetModel(ED_Model)
					local Pos=Model.Entity:GetBonePosition(Model.Entity:LookupBone("root"))
					local min,max=Model.Entity:GetRenderBounds()
					Model:SetFOV(90)
					Model:SetLookAt(Pos)
					Model:SetCamPos(Pos+Vector(max.x,max.y,max.z))
					Model:DrawModel()
					Model:SetPos(Frame:GetWide()/4.1,Frame:GetTall()/12)
					//Model.Paint=function(s,w,h)draw.RoundedBox(0,0,0,w,h,Color(255,255,255))end

				local B_Names={"Chassis","Driver Seat","Passenger","Fuel","Engine","Exhaust","Wheels"}
				local B_Icons={"car.png","steerwheel.png","seat.png","fuel.png","dashboard/engine","exhaust.png","wheel.png"}
				for number,text in pairs(B_Names)do
					local Labe=vgui.Create("DLabel",Frame,text)
						Labe:SetPos(96,-24+number*64)
						Labe:SetText(text)
						Labe:SetFont("simfphys_label")
						Labe:SizeToContents()
						Labe.Paint=function(s,w,h)
							if Mode==string.lower(Labe:GetName())then
								Labe:SetColor(Color(255+math.sin(CurTime()*5)*25,125+math.sin(CurTime()*5)*25,0))
							else
								Labe:SetColor(Color(50,50,50))
							end

						end
					local Img=vgui.Create("DImage",Frame,text)
						Img:SetPos(8,-32+number*64)
						Img:SetSize(64,64)
						Img:SetImage("vcmod/gui/icons/"..B_Icons[number])
						Img.Think=function(s,w,h)
							if Mode==string.lower(Img:GetName())then
								Img:SetImageColor(Color(75,75,75))
							else
								Img:SetImageColor(Color(50,50,50))
							end
						end
				end

				for k,v in pairs(B_Names)do
					local Bttn=vgui.Create("DButton",Frame,v)
					Bttn:SetText(" ")
					Bttn:SetPos(0,-40+k*64)
					Bttn:SetSize(Frame:GetWide()/4.5,64)
					Bttn.Paint=function(s,w,h)
						draw.RoundedBox(5,0,0,w,h,Color(255,255,255,0))
					end
					Bttn.DoClick=function()
						if Bttn:GetName()!=Mode then
							Mode=string.lower(Bttn:GetName())
						end
					end
				end
				Frame.Think=function()
					if string.lower(Mode)==string.lower("Chassis")then
						if !IsValid(VehicleModel) and IsValid(Frame) then
							VehicleModel=Frame:Add("DTextEntry")
								VehicleModel:SetSize(300,25)
								VehicleModel:SetPos(Frame:GetWide()-315,50)
								VehicleModel:SetPlaceholderText("models/blu/gtav/dukes/dukes.mdl")
								VehicleModel.OnEnter=function(val)
									Model:SetModel(tostring(val:GetValue()))
								end
							VehicleModel_Label=Frame:Add("DLabel")
								VehicleModel_Label:SetText("Vehicle Model")
								VehicleModel_Label:SetPos(Frame:GetWide()-315,30)
								VehicleModel_Label:SizeToContents()
						end
					elseif string.lower(Mode)==string.lower("Driver Seat")then
						VehicleModel:Remove()
						VehicleModel_Label:Remove()
					elseif string.lower(Mode)==string.lower("Passenger")then
						VehicleModel:Remove()
						VehicleModel_Label:Remove()
					elseif string.lower(Mode)==string.lower("Fuel")then
						VehicleModel:Remove()
						VehicleModel_Label:Remove()
					elseif string.lower(Mode)==string.lower("Engine")then
						VehicleModel:Remove()
						VehicleModel_Label:Remove()
					elseif string.lower(Mode)==string.lower("Exhaust")then
						VehicleModel:Remove()
						VehicleModel_Label:Remove()
					elseif string.lower(Mode)==string.lower("Wheels")then
						VehicleModel:Remove()
						VehicleModel_Label:Remove()
					else
						Mode=string.lower("Chassis")
					end
				end
			end
		end
	end)
end