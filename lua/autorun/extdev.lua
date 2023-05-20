AddCSLuaFile()
if not EXTDEV then

end

concommand.Add("extdev",
	function(ply,cmd,args,argStr)//	All sub commands
		PrintTable(args)
	end,
	function(cmd,args)//	Auto-Completion
		PrintTable(args)
	end,
	"Base ExtDev command.",0)

if CLIENT then
	//
elseif SERVER then
	//
else
	ErrorNoHalt("[ExtDev] Something went horribly wrong.\n")
	ErrorNoHalt("[ExtDev] This was not supposed to happen.\n")
end

function EXTDEV.Load()
	if not EXTDEV then
		EXTDEV={}
		EXTDEV.Base="extdev"
		EXTDEV.LongName="Extreme Developement"
		EXTDEV.Version="ED-Rusty 1.0"
		
		EXTDEV.Modules={}
		EXTDEV.Modules.Check=10
		EXTDEV.Modules.Dir="modules"
	end
end

function EXTDEV.LoadPhysics()
	if istable(physenv.GetPerformanceSettings())then
		local tbl = physenv.GetPerformanceSettings()
		tbl.MaxAngularVelocity = 50000
		tbl.MaxVelocity = 750000
		physenv.SetPerformanceSettings(tbl)
	end
end

net.Receive("EXTDEV_LANG",function(len,ply)
	if util.Base64Decode(net.ReadString(),false)=="send.player.lang"then
		local name=net.ReadString()
		local lang=file.Read("extdev/lang/"..name..".lua","LSV")
		net.Start("EXTDEV_LANG",false)
			net.WriteString(util.Base64Encode("there.lang",false))
			net.WriteUInt(#lang,16)
			net.WriteData(util.Compress(lang))
		net.Send(ply)
	end
end)

hook.Add("PostGamemodeLoaded","ExtDev PGML",function()
	if engine.ActiveGamemode()=="sandbox"then
		if not EXTDEV then EXTDEV.Load()end
	else
		ErrorNoHalt("[ExtDev] Support for this gamemode was not added nor implemented.\n")
		if not table.IsEmpty(EXTDEV)then table.Empty(EXTDEV)end
	end
end)