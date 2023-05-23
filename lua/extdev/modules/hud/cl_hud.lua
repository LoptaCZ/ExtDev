if CLIENT then
	function hudFunc()
		local function ScrRatio()
			local W,H=ScrW(),ScrH()
			local Res = W/H
			return Res
		end

		hook.Add("HUDShouldDraw","ExtDev HUD",function(name)
			local HUD = {"CHudHealth","CHudBattery","CHudHintDisplay","CHudGeiger"}
			for k,element in pairs(HUD)do
				if name==element then return false end
			end
			return true
		end)

		local Data=extdev.LoadCFG(LocalPlayer())//		<========================================================
		local Shapes={}
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

		hook.Add("HUDPaint","ExtDev HUD Custom",function()
			//		<========================================================
		end)
	end
else
	if EXTDEV then
		EXTDEV.Error("Not running on CLIENT.\n Code won't be executed.")
		return
	else
		ErrorNoHalt()
		return
	end
end

