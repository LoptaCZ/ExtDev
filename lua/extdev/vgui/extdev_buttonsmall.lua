
local PANEL = {}

AccessorFunc( PANEL, "m_bBorder", "DrawBorder", FORCE_BOOL )

function PANEL:Init()
	self.Color={}
	self.Color.Enabled=Color(255,255,255)
	self.Color.Disabled=Color(150,150,150)
	self.Color.Pressed=Color(200,200,200)
	self.Color.Hovered=Color(225,225,225)
	self:SetContentAlignment( 5 )
	self:SetDrawBorder( true )
	self:SetPaintBackground( true )
	self:SetTall( 22 )
	self:SetMouseInputEnabled( true )
	self:SetKeyboardInputEnabled( true )
	self:SetCursor( "hand" )
	self:SetFont( "DermaDefault" )
	self:SetText("")
	
	self.m_Image=nil
	self.img="null"
end

function PANEL:IsDown()
	return self.Depressed
end

function PANEL:SetColors(tEnabled,tDisabled,tPressed,tHovered)
	self.Color.Disabled=tDisabled or Color(150,150,150)
	self.Color.Enabled=tEnabled or Color(255,255,255)
	self.Color.Pressed=tPressed or Color(200,200,200)
	self.Color.Hovered=tHovered or Color(225,225,225)
end

function PANEL:SetImage(img)
	if (!img) then
		if (IsValid(self.m_Image)) then
			self.m_Image:Remove()
			self.img="null"
		end
		return
	end
	if (!IsValid(self.m_Image)) then
		self.m_Image = vgui.Create("DImage",self)
	end
	self.m_Image:SetImage(img)
	self.img=img
	self.m_Image:SizeToContents()
	self:InvalidateLayout()
end
PANEL.SetIcon = PANEL.SetImage

function PANEL:GetImage()
	local ret = nil
	if IsValid(self.m_Image)then
		ret=self.m_Image:GetImage()
	else
		ret=self.img
	end
	return ret
end

function PANEL:Paint(w,h)
	surface.SetTexture(surface.GetTextureID("color_ignorez"))
	if (!self:IsEnabled())then 
		surface.SetDrawColor(self.Color.Disabled:Unpack())
	elseif(self:IsDown()||self.m_bSelected) then
		surface.SetDrawColor(self.Color.Pressed:Unpack())
	elseif(self.Hovered) then
		surface.SetDrawColor(self.Color.Hovered:Unpack())
	else
		surface.SetDrawColor(self.Color.Enabled:Unpack())
	end
	surface.DrawPoly({{x=0,y=h/2},{x=w/2,y=0},{x=w,y=0},{x=w,y=h},{x=0,y=h}})

	if (IsValid(self.m_Image))then
		surface.SetTexture(surface.GetTextureID(self.m_Image:GetImage()))
		surface.SetDrawColor(255,255,255,255)
		surface.DrawTexturedRect(1,1,w*0.99,h*0.99)
	end
end

function PANEL:UpdateColours(skin)
	if (!self:IsEnabled() )					then return self.Color.Disabled end
	if (self:IsDown()||self.m_bSelected)	then return self.Color.Pressed end
	if (self.Hovered)							then return self.Color.Hovered end
	return self.Color.Enabled
end

function PANEL:PerformLayout()
	if (IsValid(self.m_Image)) then
		self.m_Image:SetPos(4,(self:GetTall()-self.m_Image:GetTall())*0.5)
	end
	DLabel.PerformLayout( self )
end

function PANEL:SetConsoleCommand( strName, strArgs )
	self.DoClick = function( self, val )
		RunConsoleCommand( strName, strArgs )
	end
end

function PANEL:SizeToContents()
	local w, h = self:GetContentSize()
	self:SetSize( w + 8, h + 4 )
end
vgui.Register("extdev_buttonsmall",PANEL,"DLabel")
