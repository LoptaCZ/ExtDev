if SERVER then
	local Grass_Default = {"carconstruct/grass/grass01","carconstruct/grass/grass-sand_blend01"}
	local Grass_Snow    = {"models/props_holidays/snowball/snowball_color"}
	local Concrete_Default={"concrete/concretefloor001a","building_template/roof_template001a"}
	local Concrete_Snow={"concrete/concretefloor001a","building_template/roof_template001a"}
	local Missing_Texture={""}
	//concrete/concwsnow01
	
	local Date=os.date("%m",os.time())

	if tonumber(Date)==12 or tonumber(Date)==1 or tonumber(Date)==2 then
		local X = tonumber(Date)
		print("There should be snow")

		--for k,v in pairs(Concrete_Default)do
		--	Material(v):SetString("$basetexture","")
		--end
		--[[
		for k,v in pairs(Grass_Default)do
			Material(v):SetString("$basetexture",Grass_Snow[1])
			Material(v):SetString("$surfaceprop","snow")
			if string.find(v,"sand_blend")then
				Material(v):SetString("$basetexture2","gm_construct/construct_sand")
			end
			Material(v):Recompute()
		end
		for k,v in pairs(Concrete_Default)do
			Material(v):SetString("$basetexture",Concrete_Snow[k])
			Material(v):SetString("$surfaceprop","snow")
			Material(v):Recompute()
		end]]
	else
		print("There shouldn't be snow")
		--ConCommand("mat_reloadmaterial carconstruct/grass/grass01")
		--Material(v):SetString("$basetexture","carconstruct/grass/grass01")
		--Material(v):SetTexture("$basetexture","materials/carconstruct/grass/grass01")
	end
--[[
	if Something then

		for k,v in pairs(Default)do
			Material(v):SetTexture("$basetexture",Custom[k])
			Material(v):SetUndefined("$surfaceprop")
			--Material(v):SetString("$surfaceprop","gravel")
			Material(v):Recompute()
		end

	else
		for k,v in pairs(Custom)do
			Material(v):SetTexture("$basetexture",Default[k])
			Material(v):SetUndefined("$surfaceprop")
			--Material(v):SetString("$surfaceprop","gravel")
			Material(v):Recompute()
		end
	end
	]]--

else
	return
end
