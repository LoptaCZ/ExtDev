
local cat = ((ACF.CustomToolCategory and ACF.CustomToolCategory:GetBool()) and "ACF" or "Construction");

TOOL.Category		= cat
TOOL.Name			= "#Tool.acfsafezone.safezonename"
TOOL.Command		= nil
TOOL.ConfigName		= ""

TOOL.ClientConVar[ "name" ] = ""
TOOL.ClientConVar[ "posx1" ] = 0
TOOL.ClientConVar[ "posy1" ] = 0
TOOL.ClientConVar[ "posz1" ] = 0
TOOL.ClientConVar[ "posx2" ] = 0
TOOL.ClientConVar[ "posy2" ] = 0
TOOL.ClientConVar[ "posz2" ] = 0

TOOL.Phase 			= 0

if CLIENT then
	language.Add("Tool.acfsafezone.safezonename","ACF Safezone")
	language.Add("Tool.acfsafezone.name","ACF Safezone")
	language.Add("Tool.acfsafezone.desc","Creates/Removes safezones.")
	language.Add("Tool.acfsafezone.0","Left Click to create 1st point.")
	language.Add("Tool.acfsafezone.1","Left Click to create 2nd point.")
	language.Add("Tool.acfsafezone.2","Right Click to remove.")

	language.Add("Tool.acfsafezone.sfname","Enter Safezone name.")
end

function TOOL:LeftClick(trace)
	if self.Phase==0 then
		
	elseif self.Phase==1 then

	elseif self.Phase==2 then

	end
end

function TOOL:RightClick(trace)

end

function TOOL:Reload(trace)

end

function TOOL.BuildCPanel(panel)
	panel:AddControl("Header", { Text = "#Tool.wire_namer.name", Description = "#Tool.acfsafezone.sfname" })

	panel:AddControl("TextBox", {
		Label = "#Tool.acfsafezone.safezonename",
		OnTextChanged=function(self)
			name=self
		end
	})
end

function TOOL:DrawHUD()
	
end