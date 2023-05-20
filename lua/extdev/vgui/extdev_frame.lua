AddCSLuaFile()

local PANEL = {}

AccessorFunc( PANEL, "m_bIsMenuComponent",	"IsMenu",			FORCE_BOOL )
AccessorFunc( PANEL, "m_bDraggable",		"Draggable",		FORCE_BOOL )
AccessorFunc( PANEL, "m_bSizable",			"Sizable",			FORCE_BOOL )
AccessorFunc( PANEL, "m_bScreenLock",		"ScreenLock",		FORCE_BOOL )
AccessorFunc( PANEL, "m_bDeleteOnClose",	"DeleteOnClose",	FORCE_BOOL )
AccessorFunc( PANEL, "m_bPaintShadow",		"PaintShadow",		FORCE_BOOL )

AccessorFunc( PANEL, "m_iMinWidth",			"MinWidth",			FORCE_NUMBER )
AccessorFunc( PANEL, "m_iMinHeight",		"MinHeight",		FORCE_NUMBER )

AccessorFunc( PANEL, "m_bBackgroundBlur",	"BackgroundBlur",	FORCE_BOOL )

function PANEL:Init()
	//include("extdev/vgui/extdev_button.lua")
	AddCSLuaFile("extdev/vgui/extdev_buttonsmall.lua")
	//include("extdev/vgui/extdev_checkbox.lua")
	AddCSLuaFile("extdev/vgui/extdev_close.lua")
	//include("extdev/vgui/extdev_combobox.lua")
	//include("extdev/vgui/extdev_label.lua")
	//include("extdev/vgui/extdev_list.lua")
	//include("extdev/vgui/extdev_slider.lua")

	self:SetFocusTopLevel( true )

	--self:SetCursor( "sizeall" )

	self:SetPaintShadow( true )

	self.Color={}
	self.Color.r=35
	self.Color.g=35
	self.Color.b=35
	self.Color.a=255

	self.btnClose = vgui.Create("extdev_close",self)
	self.btnClose:SetText( "" )
	self.btnClose.DoClick = function ( button ) self:Close() end
	self.btnClose.Paint = function( panel, w, h ) derma.SkinHook( "Paint", "WindowCloseButton", panel, w, h ) end

	self.lblTitle = vgui.Create( "DLabel", self )
	self.lblTitle:SetFont("extdev_header")
	self.lblTitle.UpdateColours = function( label, skin )

		if ( self:IsActive() ) then return label:SetTextStyleColor( skin.Colours.Window.TitleActive ) end

		return label:SetTextStyleColor( skin.Colours.Window.TitleInactive )

	end

	self:SetDraggable( true )
	self:SetSizable( false )
	self:SetScreenLock( false )
	self:SetDeleteOnClose( true )
	self:SetTitle( "Window" )

	self:SetMinWidth( 50 )
	self:SetMinHeight( 50 )

	-- This turns off the engine drawing
	self:SetPaintBackgroundEnabled( false )
	self:SetPaintBorderEnabled( false )

	self.m_fCreateTime = SysTime()

	self:DockPadding( 5, 24 + 5, 5, 5 )
end

function PANEL:SetColor(tColor)
	self.Color=tColor:ToTable()
end

function PANEL:ShowCloseButton( bShow )

	self.btnClose:SetVisible( bShow )

end

function PANEL:GetTitle()

	return self.lblTitle:GetText()

end

function PANEL:SetTitle( strTitle )

	self.lblTitle:SetText( strTitle )
	self.lblTitle:SetFont("extdev_header")

end

function PANEL:Close()

	self:SetVisible( false )

	if ( self:GetDeleteOnClose() ) then
		self:Remove()
	end

	self:OnClose()

end

function PANEL:OnClose()
end

function PANEL:SetIcon( str )

	if ( !str && IsValid( self.imgIcon ) ) then
		return self.imgIcon:Remove() -- We are instructed to get rid of the icon, do it and bail.
	end

	if ( !IsValid( self.imgIcon ) ) then
		self.imgIcon = vgui.Create( "DImage", self )
	end

	if ( IsValid( self.imgIcon ) ) then
		self.imgIcon:SetMaterial( Material( str ) )
	end

end

function PANEL:Center()

	self:InvalidateLayout( true )
	self:CenterVertical()
	self:CenterHorizontal()

end

function PANEL:IsActive()

	if ( self:HasFocus() ) then return true end
	if ( vgui.FocusedHasParent( self ) ) then return true end

	return false

end

function PANEL:Think()

	local mousex = math.Clamp( gui.MouseX(), 1, ScrW() - 1 )
	local mousey = math.Clamp( gui.MouseY(), 1, ScrH() - 1 )

	if ( self.Dragging ) then

		local x = mousex - self.Dragging[1]
		local y = mousey - self.Dragging[2]

		-- Lock to screen bounds if screenlock is enabled
		if ( self:GetScreenLock() ) then

			x = math.Clamp( x, 0, ScrW() - self:GetWide() )
			y = math.Clamp( y, 0, ScrH() - self:GetTall() )

		end

		self:SetPos( x, y )

	end

	if ( self.Sizing ) then

		local x = mousex - self.Sizing[1]
		local y = mousey - self.Sizing[2]
		local px, py = self:GetPos()

		if ( x < self.m_iMinWidth ) then x = self.m_iMinWidth elseif ( x > ScrW() - px && self:GetScreenLock() ) then x = ScrW() - px end
		if ( y < self.m_iMinHeight ) then y = self.m_iMinHeight elseif ( y > ScrH() - py && self:GetScreenLock() ) then y = ScrH() - py end

		self:SetSize( x, y )
		self:SetCursor( "sizenwse" )
		return

	end

	local screenX, screenY = self:LocalToScreen( 0, 0 )

	if ( self.Hovered && self.m_bSizable && mousex > ( screenX + self:GetWide() - 20 ) && mousey > ( screenY + self:GetTall() - 20 ) ) then

		self:SetCursor( "sizenwse" )
		return

	end

	if ( self.Hovered && self:GetDraggable() && mousey < ( screenY + 24 ) ) then
		self:SetCursor( "sizeall" )
		return
	end

	self:SetCursor( "arrow" )

	-- Don't allow the frame to go higher than 0
	if ( self.y < 0 ) then
		self:SetPos( self.x, 0 )
	end

end

function PANEL:Paint( w, h )

	local frame={
		{x=w/2,y=h/2.5},{x=0,y=h},{x=0,y=h/3},{x=w/32,y=h/3.5},{x=w/32,y=h/5.5},{x=0,y=h/6.5},{x=0,y=h/24},{x=w/26,y=0},{x=w/1.35,y=0},{x=w/1.30,y=h/28},
		{x=w/1.15,y=h/28},{x=w/1.1,y=0},{x=w,y=0},{x=w,y=h/9},{x=w/1.025,y=h/6.5},{x=w/1.025,y=h/3.5},{x=w,y=h/3.25},{x=w,y=h/1.05},
		{x=w/1.05,y=h},{x=w/1.1,y=h},{x=w/1.15,y=h/1.05},{x=w/1.3,y=h/1.05},{x=w/1.35,y=h},{x=0,y=h}
	}

	for k,v in pairs(frame)do
		v.x=frame[k].x*0.999
		v.y=frame[k].y*0.999
	end

	//draw.RoundedBox(5,0,0,w,h,Color(0,0,0,150))

	surface.SetTexture(surface.GetTextureID("color_ignorez"))
	surface.SetDrawColor(self.Color.r,self.Color.g,self.Color.b,self.Color.a)
	surface.DrawPoly(frame)

	if ( self.m_bBackgroundBlur ) then
		Derma_DrawBackgroundBlur( self, self.m_fCreateTime )
	end

end

function PANEL:OnMousePressed()

	local screenX, screenY = self:LocalToScreen( 0, 0 )

	if ( self.m_bSizable && gui.MouseX() > ( screenX + self:GetWide() - 20 ) && gui.MouseY() > ( screenY + self:GetTall() - 20 ) ) then
		self.Sizing = { gui.MouseX() - self:GetWide(), gui.MouseY() - self:GetTall() }
		self:MouseCapture( true )
		return
	end

	if ( self:GetDraggable() && gui.MouseY() < ( screenY + 24 ) ) then
		self.Dragging = { gui.MouseX() - self.x, gui.MouseY() - self.y }
		self:MouseCapture( true )
		return
	end

end

function PANEL:OnMouseReleased()

	self.Dragging = nil
	self.Sizing = nil
	self:MouseCapture( false )

end

function PANEL:PerformLayout()

	local titlePush = 50

	if ( IsValid( self.imgIcon ) ) then

		self.imgIcon:SetPos( 8 + titlePush/2.5, 5 )
		self.imgIcon:SetSize( 32, 32 )
		
	end


	self.btnClose:SetPos( self:GetWide() - 31 - 4, 0 )
	self.btnClose:SetSize( 31, 24 )

	self.lblTitle:SetPos( 16 + titlePush, 10 )
	self.lblTitle:SetSize( self:GetWide() - 25 - titlePush, 20 )

end

vgui.Register("extdev_frame",PANEL,"EditablePanel")
