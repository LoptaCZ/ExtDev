if CLIENT then
	local Path=""
	concommand.Add("extdev_view",function()
		local ply = LocalPlayer()
		local Data={}
		Data.BGColor=Color(0,0,0,150)
		Data.FGColor=Color(35,35,35,150)
		Data.Language="en"

		Data=extdev.LoadCFG(ply)
		Data=extdev.ReloadCFG(ply)

		local mimetypes = {}
		mimetypes["mp3"] = "icon16/sound.png"
		mimetypes["s3m"] = "icon16/sound.png"
		mimetypes["xm"] = "icon16/sound.png"
		mimetypes["mod"] = "icon16/sound.png"
		mimetypes["it"] = "icon16/sound.png"
		mimetypes["mid"] = "icon16/sound.png"
		mimetypes["midi"] = "icon16/sound.png"

		mimetypes["zip"] = "icon16/page_white_zip.png"
		mimetypes["rar"] = "icon16/page_white_zip.png"
		mimetypes["7z"] = "icon16/page_white_zip.png"
		mimetypes["ztmp"] = "icon16/page_white_zip.png"

		mimetypes["gma"] = "icon16/compress.png"
		mimetypes["vpk"] = "icon16/package.png"
		mimetypes["db"] = "icon16/database.png"

		mimetypes["txt"] = "icon16/page_white_text.png"
		mimetypes["dat"] = "icon16/page_white_gear.png"
		mimetypes["lua"] = "icon16/page_white_code.png"
		mimetypes["vmt"] = "icon16/page_white_edit.png"

		mimetypes["vtf"] = "icon16/picture.png"
		mimetypes["png"] = "icon16/picture.png"
		mimetypes["jpg"] = "icon16/picture.png"
		mimetypes["bmp"] = "icon16/picture.png"
		mimetypes["tga"] = "icon16/picture.png"

		mimetypes["bsp"] = "icon16/map.png"
		mimetypes["exe"] = "icon16/application.png"
		mimetypes["so"] = "icon16/cog.png"
		mimetypes["cfg"] = "icon16/cog.png"
		mimetypes["dll"] = "icon16/cog.png"
		mimetypes["ver"] = "icon16/information.png"
		mimetypes["nil"] = "icon16/folder.png"
		mimetypes["html"] = "icon16/html.png"
		mimetypes["css"] = "icon16/css.png"

		local Frame=vgui.Create("DFrame")
		Frame:SetSize(ScrW()/2,ScrH()/2)
		Frame:Center()
		Frame:MakePopup()
		Frame:SetTitle("")
		Frame.Paint=function(s,w,h)
			draw.RoundedBox(5,0,0,w,h,Data.BGColor)
			draw.RoundedBox(5,10,40,w-20,h-50,Data.FGColor)
			draw.RoundedBox(5,0,0,w,h/20,Color(0,0,150,255))

			draw.SimpleText("[ExtDev]:/File Browser.rap3","extdev_header",24,5,Color(255,255,255))
		end

		local Viewer=vgui.Create("DPanel",Frame)
		Viewer:SetSize(Frame:GetWide()/2,Frame:GetTall()-70)
		Viewer:SetPos(380,50)
		Viewer.Paint=function(s,w,h)
			draw.RoundedBox(5,0,0,w,h,Data.BGColor)
		end

		local Text=vgui.Create("RichText",Viewer)
		Text:Dock(FILL)
		Text:InsertColorChange(255,255,255,255)
		Text:SetText("ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789")
		Text.Paint=function(s,w,h)
			draw.RoundedBox(0,0,0,w,h,Data.BGColor)
		end

		local Decode=false
		local Decoder=vgui.Create("DCheckBoxLabel",Frame)
		Decoder:SetPos((Frame:GetWide()/2)-112.5,Frame:GetTall()/2)
		Decoder:SetText("Decode")
		Decoder:SetFont("extdev_misc")
		Decoder:SetTextColor(Color(255,255,255,255))
		Decoder.OnChange=function(val)
			Decode=val
		end

		local List=vgui.Create("DPanel",Frame)
		List:SetSize(Frame:GetWide()/3,Frame:GetTall()-70)
		List:SetPos(20,50)
		List.Paint=function(s,w,h)
			draw.RoundedBox(5,0,0,w,h,Data.FGColor)
		end

		local dtree=vgui.Create("DTree",List)
		dtree:Dock(FILL)
		dtree:Clear()
		dtree:SetShowIcons(true)
		dtree.Paint=function(s,w,h)
			draw.RoundedBox(5,0,0,w,h,Color(Data.BGColor.r,Data.BGColor.g,Data.BGColor.b,150))
		end
		dtree.OnNodeSelected=function(pnl)
			for _,v in pairs(pnl:GetChildren())do
				if v:GetName()=="Panel"then
					ColorIt(v)
				end
			end
		end

		local base=dtree:AddNode("Garrysmod/garrysmod/")
		base:SetExpanded(true)
		base:SetIcon("icon16/folder_page_white.png")
		base.Paint=function(s,w,h)
			draw.RoundedBox(0,0,0,w,h,Color(Data.FGColor.r,Data.FGColor.g,Data.FGColor.b))
		end
		base.Label:SetColor(Color(255,255,255))
		base:SetDrawLines(true)

		local files,dirs=file.Find("*","MOD")

		function ColorIt(node)
			local t = node:GetChildren()
			for k,v in pairs(t)do
				local Name="icon16/application_xp.png"
				//print(v)
				if v:GetName()=="DLabel"then
					v:SetColor(Color(255,255,255))
					Name=v:GetText()
				elseif v:GetName()=="DImage"then
					v:SetImage(mimetypes[string.GetExtensionFromFilename(Name)])
				end
				if v:HasChildren() then ColorIt(v) end
			end
		end
		for k,v in pairs(dirs)do
			local x=base:AddFolder(v,v,"MOD",true)
			if x:HasChildren() then
				ColorIt(x)
			end
			x.Label:SetColor(Color(255,255,255))
			ColorIt(x)
			x.DoClick=function()
				print(x)
				print(x.Panel)
				print(x.Label:GetText())
			end
		end
		for k,v in pairs(files)do
			local x=base:AddNode(v,mimetypes[string.GetExtensionFromFilename(v)])
			if x:HasChildren() then
				ColorIt(x)
			end
			x.Label:SetColor(Color(255,255,255))
			ColorIt(x)
			x.DoClick=function()
				print(x)
				print(x.Panel)
				print(x.Label:GetText())
			end
		end
	end)
end