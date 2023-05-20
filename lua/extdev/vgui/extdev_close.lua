local small_cross = Material("vgui/glyph_close_x")

local PANEL = {}

function PANEL:Init()
	self._x = 0
	self._y = 0
	self:SetMaterial(small_cross)
end

function PANEL:DoClick()
	local Parent = self:GetParent()
	if Parent then
		if Parent.Close then 
			Parent:Close()
		else 
			Parent:Remove() 
		end 
	end
end

function PANEL:SetOffset(x,y)
	self._x = x 
	self._y = y 
end 

function PANEL:Think()
	
end

vgui.Register("extdev_close",PANEL,"DImageButton")
