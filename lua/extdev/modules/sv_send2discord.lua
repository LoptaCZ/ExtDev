--[[
Gmod to Discord Chat Relay:
Have your chat display in discord!
You need a Webhook URL to make this work.
Step 1: Go into discord, and hover your mouse over the desired channel you'd like messages to be sent to.
Step 2: Click on Edit Channel, and click on Webhooks.
Step 3: Click on "Create Webohook"
Step 4: Fill in a default username, and give it an avatar of your choosing. Then click save. Edit it again before going onto step 5
Step 5: Copy and paste the webhook URL down below.
You need a SteamWebAPIKey for avatars to be fetched.
Step 1: Goto http://steamcommunity.com/dev/apikey
Step 2: Fill in a domain name, I recommend the IP address of your server.
Step 3: Copy and paste the key down below.
]]--

local WebhookURL = "http://discordapp.com/api/webhooks/532587325838983178/diW38JHdG6N2o_hkTV6n4zfujD5SaAEU4ZI_6l6r2Spo6eobP-iUV6iFmNfN7ifv-V3S"
local SteamWebAPIKey = "71E7905B6D5E7F52DA1530FCD2EE867C"

local function sendChat(p_player,s_string,b_team)
    local function getAvatar(code,body,headers)
        local function getAvatarData(json)
            local out = util.JSONToTable(json)
            if(!istable(out) or !out.response) then return false end
            if(!out.response.players or !out.response.players[1]) then return false end
            return out.response.players[1].avatarfull
        end
        if !body then
            local tbl={
                failed     =function(err) MsgC(Color(200,0,0),"HTTP Error: "..err)end,
                method     ="GET",
                url        ="http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/",
                parameters ={key=SteamWebAPIKey,steamids=code},
                success    =getAvatar
            }
            HTTP(tbl)
        else
            //print("Got Avatar.")
            return getAvatarData(body)
        end
    end
    if !p_player then return end
    if !IsValid(p_player) then return end
    --[[
    local post={
        content=s_string,
        username=p_player or "Unknown",
        avatar_url=getAvatar(p_player:SteamID64())
    }
    local tbl={
        failed     = function(err) MsgC(Color(200,0,0),"HTTP Error: "..err.." =>")end,
        method     = "POST",
        url        = WebhookURL,
        parameters = payload,
        headers    = post1,
        type       = "application/json",
        body       = util.TableToJSON(payload,true),
        success    = function(code,body,headers)MsgC(Color(0,200,200),"HTTP responded with: "..code.."\n")end
    }
    local post1={
        ["Authorization"] = "Maybe you need an Authorization header?",//["Authorization"]
        ["Content-Type"] = "multipart/form-data",//"application/json",//["Content-Type"]
        ["Content-Length"] = string.len(table.ToString(payload,"content",true))//["Content-Length"]
    }
    local payload = {
        content = s_string,
        username = p_player or "Unknown",
        avatar_URL = getAvatar(p_player:SteamID64()),
    }]]--
    local user    = p_player:Name() or "<Unknown>"
    local content = s_string or "nil"
    local avatar  = getAvatar(p_player:SteamID64())or""
    local format="http://gmodshit.fear-some.com/archie/gawniec.php"

    if avatar then 
        format=string.format("http://gmodshit.fear-some.com/archie/gawniec.php?&u=%s&c=%s",user,content)
    else
        format=string.format("http://gmodshit.fear-some.com/archie/gawniec.php?&u=%s&c=%s&a=%s",user,content,avatar)
    end

    local text = string.Replace(format," ","%20")
    //print(text)

    local tbl={
        method="post",
        url=WebhookURL,
        type="application/json",
        parameters={content=s_string or"nothing",username=p_player:Nick() or"Unknown",avatar_URL=getAvatar(p_player:SteamID64())},
        headers={["content-type"]="appliaction/json"},
        success=function(code,body,headers)MsgC(Color(0,255,0),code,"\n")end,
        failed=function(err)MsgC(Color(255,0,0),err,"\n") end
    }
    HTTP(tbl)
end

hook.Add("PlayerSay","Discord_Webhook_Chat", sendChat)