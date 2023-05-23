if SERVER then
	local data=util.TableToJSON({ {"achiev.name","achiev.desc","icon16/bug.png","function(ply)if IsValid(ply)then print('Kreténe') end"} },true)
	util.AddNetworkString("EXTDEV_F4MENU")

	local function manageFile(fileName)
		local returner={}
		table.Empty(returner)
		if file.IsDir("extdev","DATA")then
			if file.IsDir("extdev/achievements","DATA")then
				if file.Exists("extdev/achievements/"..fileName..".txt","DATA")then
					local tbl=util.JSONToTable(file.Read("extdev/achievements/"..fileName..".txt","DATA"))
					returner=tbl
				else
					PrintMessage(HUD_PRINTCONSOLE,"file '"..fileName.."' doesn't exist. Trying to create a new one.")
					file.Write("extdev/achievements/"..fileName..".txt",data)
				end
			else
				file.CreateDir("extdev/achievements")
				PrintMessage(HUD_PRINTCONSOLE,"Directory 'extdev/achievements' doesn't exist. Trying to create a new one.")
				manageFile(fileName)
			end
		else
			file.CreateDir("extdev")
			PrintMessage(HUD_PRINTCONSOLE,"Directory 'extdev' doesn't exist. Trying to create a new one.")
			manageFile(fileName)
		end
		return returner
	end// manageFile()

	local function loadAchievements()
		local achievs={}

		if file.Exists("extdev/achievements.txt","DATA")then
		else
		end

		return achievs
	end
	
	hook.Add("PlayerButtonDown","EXTDEV_F4_MENU",function(ply,bttn)
		if bttn==KEY_F4 then
			if IsValid(ply)then
				net.Start("EXTDEV_F4MENU",false)
					net.WriteTable(manageFile(ply:SteamID64()))
				net.Send(ply)
			end
		end
	end)
else

	net.Receive("EXTDEV_F4MENU",function(len,ply)
		PrintTable(net.ReadTable())
		if not IsValid(Frame)then
			Frame=vgui.Create("extdev_frame")
			Frame:SetSize(ScrW()*0.75,ScrH()*0.75)
			Frame:Center()
			Frame:MakePopup()
			Frame:SetTitle("ExtDev:/modules/Achievements.rap3")
			Frame:SetIcon("")
		end

	end)//	net.Receive()
end