if CLIENT then
	//
else
	if EXTDEV then
		util.AddNetworkString("EXTDEV_REQUEST_LANG")
		EXTDEV.Language={}
		local path="extdev/lang/"
		function EXTDEV.Language.Load(s_filename)
			if file.Exists(path..s_filename,"LSV") then
				local s_lang=file.Read(path..s_filename,"LSV")
				local out=util.JSONToTable(s_lang)
				if istable(out)then
					table.insert(EXTDEV.Language,{out[Lang_Details_Name],out})
				else
					print("Not a valid JSON")
					file.Write(path..s_filename,util.TableToJSON({EXTDEV_SMenu_TAB1="Upadla",EXTDEV_SMenu_TAB2="Noha"},true))
				end
				
				MsgC(Color(0,0,0),"[",Color(255,255,255),"ExtDev",Color(0,0,0),"] ",Color(0,200,0),string.format("Loading language %s file.\n",s_filename))
			else
				MsgC(Color(0,0,0),"[",Color(255,255,255),"ExtDev",Color(0,0,0),"] ",Color(200,0,0),string.format("Language file failed to load, probably doesn't exist. (%s)\n",s_filename))
			end
			return out
		end

		EXTDEV.Language.Load("en.lua")

		hook.Add("Initialize","EXTEDV_LANG_INIT",function()
			local Files=file.Find(path.."*.lua","LSV")
			for k,v in pairs(Files)do
				//EXTDEV.Language.Load(""..v)
			end
		end)
		--[[
		net.Receive("EXTDEV_REQUEST_LANG",function()
			local Target=net.ReadEntity()
			net.Start("EXTDEV_REQUEST_LANG")
				net.WriteString(util.TableToJSON(EXTDEV.Language.Load("en.lua"),true))
			net.Send(Target)
		end)]]
	end
end