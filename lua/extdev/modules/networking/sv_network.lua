if SERVER then
	util.AddNetworkString("EXTDEV_NETWORK")
	local networks={}
	local lastID=0

	local function loadNetwork(network)
		return util.AddNetworkString(network)
	end

	local function loadWholeNetwork(network)
		for k,v in pairs(network)do
			loadNetwork(v)
		end
	end

	local function respond(ply,b64,msg)
		net.Start("EXTDEV_NETWORK",false)
			net.WriteString(b64)
			if isnumber(msg) then net.WriteInt(lastID,32)else net.WriteString(msg)end
		net.Send(ply)
	end

	if file.IsDir("extdev","DATA")then
		if file.Exists("extdev/network.txt","DATA")then
			networks=util.JSONToTable(file.Read("extdev/network.txt","DATA"))
			loadWholeNetwork(networks)
		else
			table.insert(networks,0,"EXTDEV_NETWORK")
			file.Write("extdev/network.txt",util.TableToJSON(networks,true))
		end
	else
		file.CreateDir("extdev")
	end

	net.Receive("EXTDEV_NETWORK",function(len,ply)
		local func=util.Base64Decode(net.ReadString(),false)
		local name=util.Base64Decode(net.ReadString(),false)
		if func=="load"then
			loadNetwork(name)
		elseif func=="last.id"then
			local b64=util.Base64Encode("send.last.id.respond",false)
			respond(ply,b64,lastID)
		elseif func=="get.names"then
			local b64=util.Base64Encode("send.get.names.respond",false)
			respond(ply,b64,util.TableToJSON(networks,false))
		end
	end)
end
