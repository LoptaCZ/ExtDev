E2Lib.RegisterExtension("misc_funcs", false)

local SunDirection = Vector(0,0,0)
net.Receive("Expression2_OnlyClient",function()
	local SunInfo=net.ReadTable()
	SunDirection=SunInfo.direction
	SunObstruct=SunInfo.obstruct
end)

__e2setcost( 1 )

e2function vector entity:getHoloScale()
	if !IsValid(this) then return end
	if !this:GetClass()=="gmod_wire_hologram" then return end
	local scale = Vector(1,1,1)

	if scale_buffer[this:EntIndex()] ~= nil then
		scale = scale_buffer[this:EntIndex()]
	end

	return {math.floor(scale[1]),math.floor(scale[2]),math.floor(scale[3])}
end

e2function void rtCreate(name,pos,ang)
	print("Empty Function")
end

e2function void rtCreate(name,pos)
	print("Empty Function")
end

e2function void rtCreate(name,ang)
	print("Empty Function")
end

e2function void rtCreate(name)
	print("Empty Function")
end

e2function void rtSetPos(name,pos)
	print("Empty Function")
end

e2function void rtSetAng(name,ang)
	print("Empty Function")
end

e2function string rtGetTexture(name,width,height,additive)
	local ITexture=GetRenderTarget(tostring(name),width,height,addictive)
	local IMaterial=CreateMaterial("E2RenderTarget_"..name,"UnlitGeneric",{["$basetexture"]=ITexture:GetName()})
	local MatName=(ITexture or IMaterial):GetName()
	return MatName
end

e2function string rtGetTexture(name,width,height)
	local ITexture=GetRenderTarget(tostring(name),width,height)
	local IMaterial=CreateMaterial("E2RenderTarget_"..name,"UnlitGeneric",{["$basetexture"]=ITexture:GetName()})
	local MatName=(ITexture or IMaterial):GetName()
	return MatName
end

e2function string rtGetTexture(name)
	local ITexture=GetRenderTarget(tostring(name),512,512,false)
	local IMaterial=CreateMaterial("E2RenderTarget_"..name,"UnlitGeneric",{["$basetexture"]=ITexture:GetName()})
	local MatName=(ITexture or IMaterial):GetName()
	return MatName
end

e2function vector sunDirection()
	net.Start("Expression2_OnlyClient")
		net.WriteString("string str")
	net.Send(this:GetOwner())
	return SunDirection
end


function createRT(name,pos,ang)
	if(isstring(name) && isvector(pos) && isangle(ang) )then
		render.SetRenderTarget(RenT)
 		render.SetViewPort(0,0,256,256)
 		cam.Start3D2D(pos,ang,256)
 			
 		cam.End3D2D()
	end
end