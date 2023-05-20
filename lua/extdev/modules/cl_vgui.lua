AddCSLuaFile()
if EXTDEV then
	local VGUILoaded=false
	local function LoadVGUI()
		if not VGUILoaded then
			local guis,_=file.Find("extdev/vgui/*","LSV")
			for k,v in pairs(guis)do
				if file.Size("extdev/vgui/"..v,"LSV")>=1 then
					print("[EXTDEV VGUI] Loading vgui extension "..v)
					//AddCSLuaFile("extdev/vgui/"..v)
					//include("extdev/vgui/"..v)
					AddCSLuaFile(Format("extdev/vgui/%s",v))
					RunString(file.Read("extdev/vgui/"..v,"LSV"),"[ModuleLoader|VGUI]",true)
				else
					print("[EXTDEV VGUI] Failed to load "..v..", becouse file is empty.")
				end
			end
		VGUILoaded=true
		end
	end
	function draw.Circle( x, y, radius, seg )
		local cir = {}
		local seg=math.Round(seg,0)
		table.insert(cir,{x=x,y=y,u=0.5,v=0.5})
		for i = 0, seg do
			local a = math.rad((i/seg)*-360)
			table.insert(cir,{x=x+math.sin(a)*radius,y=y+math.cos(a)*radius,u=math.sin(a)/2+0.5,v=math.cos(a)/2+0.5})
		end
		local a = math.rad(0) -- This is needed for non absolute segment counts
		table.insert(cir,{x=x+math.sin(a)*radius,y=y+math.cos(a)*radius,u=math.sin(a)/2+0.5,v=math.cos(a)/2+0.5})
		surface.DrawPoly(cir)
	end
	LoadVGUI()
end

