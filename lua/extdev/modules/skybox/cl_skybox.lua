AddCSLuaFile()
EXTDEV.Skybox=EXTDEV.Skybox or "skybox/paintedbk"

net.Receive("EXTDEV_SKY_CL",function()
	EXTDEV.Skybox=net.ReadString()
	--[[
	for k,v in pairs(Dark)do
		if string.find(EXTDEV.Skybox,v) then
			//util.GetSunInfo()
		end
	end]]--
end)

hook.Add("PostDraw2DSkyBox","EXTDEV_DRAW_SKY",function()
	local Mat={}
	Mat[1]=string.sub(EXTDEV.Skybox,0,string.len(EXTDEV.Skybox)-2).."bk"
	Mat[2]=string.sub(EXTDEV.Skybox,0,string.len(EXTDEV.Skybox)-2).."dn"
	Mat[3]=string.sub(EXTDEV.Skybox,0,string.len(EXTDEV.Skybox)-2).."ft"
	Mat[4]=string.sub(EXTDEV.Skybox,0,string.len(EXTDEV.Skybox)-2).."rt"
	Mat[5]=string.sub(EXTDEV.Skybox,0,string.len(EXTDEV.Skybox)-2).."lf"
	Mat[6]=string.sub(EXTDEV.Skybox,0,string.len(EXTDEV.Skybox)-2).."up"

	render.OverrideDepthEnable(true,false)
	cam.Start3D(Vector(0,0,0),EyeAngles())
		render.SetMaterial(Material(Mat[1]))-- Back
		render.DrawQuadEasy(Vector(1,0,0)*32,Vector(-1,0,0),-64,-64,Color(255,255,255),0)

		render.SetMaterial(Material(Mat[2]))-- Down
		render.DrawQuadEasy(Vector(0,0,-1)*32,Vector(0,0,1),-64,-64,Color(255,255,255),90)

		render.SetMaterial(Material(Mat[3]))-- Front
		render.DrawQuadEasy(Vector(-1,0,0)*32,Vector(1,0,0),-64,-64,Color(255,255,255),0)

		render.SetMaterial(Material(Mat[4]))-- Left
		render.DrawQuadEasy(Vector(0,-1,0)*32,Vector(0,1,0),-64,-64,Color(255,255,255),0)

		render.SetMaterial(Material(Mat[5]))-- Right
		render.DrawQuadEasy((Vector(0,1,0)*32),Vector(0,-1,0),-64,-64,Color(255,255,255),0)

		render.SetMaterial(Material(Mat[6]))-- Up
		render.DrawQuadEasy((Vector(0,0,1)*32),Vector(0,0,-1),-64,-64,Color(255,255,255),-90)

	cam.End3D()
	render.OverrideDepthEnable(false,false)
end)