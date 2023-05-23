AddCSLuaFile()
edChat={}
edChat.Override=false
edChat.TTS=true
edChat.TTS_focus=true
if SERVER then

else
	concommand.Add("cl_extdev_tts",function()
		edChat.TTS=!edChat.TTS
	end,FCVAR_CLIENTDLL)
	concommand.Add("cl_extdev_tts_focus",function()
		edChat.TTS_focus=!edChat.TTS_focus
	end,FCVAR_CLIENTDLL)
	if edChat.Override then
		edChat.Frame=nil
		edChat.dTextEntry=nil
		edChat.dRichText=nil
		edChat.TTS=edChat.TTS or true
		edChat.TTS_focus=edChat.TTS_focus or true

		edChat.MakeFrame=function(bteam)
			if !edChat.Frame then
				local Frame=vgui.Create("DFrame")
					edChat.Frame=Frame
					Frame:SetSize(ScrW()/4,ScrH()/4)
					Frame:SetPos(15,ScrH()/Frame:GetTall())
					Frame:MakePopup()
					Frame.OnClose=edChat.FrameClose()
				local Entry=vgui.Create("DTextEntry",Frame)
					Entry:SetSize(Frame:GetWide(),25)
					Entry:SetPos(0,Frame:GetTall()-25)
					Entry:RequestFocus()
					Entry.OnKeyCodeTyped=function(self,code)
						if code==KEY_ESCAPE then
							edChat.FrameClose()
							gui.HideGameUI()
						elseif code==KEY_ENTER then
							if string.Trim(self:GetText())!=""then
								if bteam then
									LocalPlayer():ConCommand("sayteam "..self:GetText())
								else
									LocalPlayer():ConCommand("say "..self:GetText())
								end
							end
						end
					end
				edChat.dTextEntry=Entry
				gamemode.Call("StartChat")
			end
		end
		edChat.FrameClose=function()
			edChat.Frame:SetMouseInputEnabled(false)
			edChat.Frame:SetKeyboardInputEnabled(false)
			gui.EnableScreenClicker(false)
			gamemode.Call("FinishChat")
			edChat.dTextEntry:SetText("")
			gamemode.Call("ChatTextChanged","")
			edChat.Frame:Remove()
		end
	
		hook.Add("HUDShouldDraw","EXTDEV_DEFAULT_CHAT_HIDER",function(name)
			if name=="CHudChat"then
				return false
			end
		end)

		hook.Add("PlayerBindPress","EXTDEV_CHAT_OVERRIDE",function(ply,bind,pressed)
			local bteam=false
			if bind=="messagemode"then
				
			elseif bind=="messagemode2"then
				bteam=true
			else
				return
			end
	
			edChat.MakeFrame(bteam)

			return true
		end)
		//hook.Add("ChatText","",function()end)
	end
end