include("shared.lua")
ENT.RenderGroup = RENDERGROUP_BOTH

ENT.Scale = 8
ENT.IsLoading = false
ENT.FFT = {}
ENT.CurrentSong = ""
ENT.LastH = 0
ENT.Beam = nil
ENT.BeamEnd = {}
ENT.BigCol = Color(255, 255, 255)
ENT.LastSong = ""
ENT.SongLength = 0
ENT.CurLength = 0
ENT.Queue={}

function ENT:Initialize()
	for i=1, 1028 do
		self.FFT[i] = 0
	end
	self:SetSong("")
end

function ENT:OnRemove()
	if IsValid( self.Song ) then
		self.Song:Stop()
		self.Song = nil
	end
	hook.Remove("Think","ARCHOS_RaveCube_Lights")
end

function ENT:DrawParticles( )
	local pos = self:GetPos()

	if !self.Emitter then
		self.Emitter = ParticleEmitter( pos )
	end

	for i=0, 4 do
		local smoke = self.Emitter:Add( "particle/particle_noisesphere", pos )
		if smoke then
			local fftAverage = self:GetAverage( self.Song, 1, 5 )
			local vel = VectorRand():GetNormal() * math.Rand( 150, 300 ) * (fftAverage * 3)
			smoke:SetVelocity( vel )
			smoke:SetLifeTime( 0 )
			smoke:SetDieTime( 2 )
			smoke:SetStartAlpha( 10 )
			smoke:SetEndAlpha( 0 )

			smoke:SetRoll( 0, 360 )
			smoke:SetRollDelta( math.Rand( -1, 1 ) )

			local Size = math.Rand( 5, 10 )
			smoke:SetStartSize( Size * (fftAverage * 5) )
			smoke:SetEndSize( Size * math.Rand( 2, 5 ) )

			smoke:SetAirResistance( 100 )
			smoke:SetGravity( Vector( 0, 0, 0 ) )

			local RandDarkness = math.Rand( 0.25, 1 )
			smoke:SetColor( 255 * RandDarkness, 255 * RandDarkness, 255 * RandDarkness )
		end
	end
end

function ENT:Think()
	self.LastSong = self:GetSong()
	if(!self.Beam) then
		self:SetupBeams()
	end
	net.Receive("ARCHOS_RaveCube_SetSong",function()
		print("Got link")
		self.LastAng = Angle(0,0,0)
		//table.insert(self.Queue,net.ReadString())
		self.Song=net.ReadString()
		self.IsLoading = true
		if IsValid( self.Song ) then
			self.Song:Stop()
			self.Song = nil
			self.CurLength = 0
			self.SongLength = 0
		end
		sound.PlayURL(self.Song, "noplay 2d", function(channel)
			self.CurrentSong = self.Queue[1]
			self.IsLoading = false
			if IsValid( channel ) then
				channel:SetPos( self:GetPos() )
				channel:Play()
				self.Song = channel
				self.SongLength = channel:GetLength()
				self.CurLength = channel:GetTime()

				if self.CurLength>=self.SongLength then
					if (self.CurLength and self.SongLength)==0 then return else
						self.CurLength=0
						self.SongLength=0
						table.remove(self.Queue,1)
					end
				end
				hook.Add("Think","ARCHOS_RaveCube_Lights",function()
					for i=1, 9 do
						self.BeamEnd[i] = self.BeamEnd[i] or {Pos = self:GetPos(), Col = Color(0,0,0,0)}
						local dlight = DynamicLight( self:EntIndex() + i )
						if ( dlight ) then
							dlight.Pos = self.BeamEnd[i].Pos or self:GetPos()
							dlight.r = self.BeamEnd[i].Col.r
							dlight.g = self.BeamEnd[i].Col.g
							dlight.b = self.BeamEnd[i].Col.b
							dlight.Brightness = 0.5
							dlight.Size = self:GetAverage( self.Song, 1, 5 ) * 2024
							dlight.Decay = (self:GetAverage( self.Song, 1, 5 ) * 2024) * 2
							dlight.DieTime = CurTime() + 1
							dlight.Style = 0
						end
					end
					local dlight = DynamicLight( self:EntIndex() + 10)
					if ( dlight ) then
						local r, g, b, a = col
						dlight.Pos = self:GetPos()
						dlight.r = self.BigCol.r
						dlight.g = self.BigCol.g
						dlight.b = self.BigCol.b
						dlight.Brightness = 1
						dlight.Size = self.Scale * 12
						dlight.Decay = (self.Scale * 12) * 2
						dlight.DieTime = CurTime() + 1
						dlight.Style = 0
					end
					if self.Scale > 18 then
						self:DrawParticles()
					end
				end)
			end
		end )
	end)
	
	if( IsValid( self.Song ) ) then
		self.Song:FFT( self.FFT, FFT_2048 )
		self.Song:SetPos( self:GetPos() )
		self.Scale = 16 + self:GetAverage( self.Song, 1, 3 ) * 32
		
		if(LocalPlayer():GetPos():Distance(self:GetPos()) > 1500) then
			self.Song:SetVolume(0)
		end
		
		if(LocalPlayer():GetPos():Distance(self:GetPos()) < 1500) then
			self.Song:SetVolume(1)
		end
	end

	self.LastH = self.LastH + 0.2
	self.LastH = math.fmod( self.LastH, 360 )


	local a,b = Vector(-1, -1, -1) * 2048, Vector(1,1,1) * 2048 
	
	OrderVectors( a,b )
					
	self:SetRenderBounds( a, b )

end

function ENT:GetAverage( stream, lower, upper )

	lower = math.Round( math.Clamp( lower, 1, 2048 ) )
	upper = math.Round( math.Clamp( upper, 1, 2048 ) )

	local n = 0
	for i = lower, upper do
		n = n + (self.FFT[i] or 0)
	end

	local div = ( upper - lower )
	return div == 0 && 0 || n / div

end

function ENT:Draw()
	if( !IsValid(self.Song) ) then
		self.LastAng = self:GetAngles()
		--self:DrawModel() -- Draw the Model()
	end
end

function ENT:SetupBeams()
	self.Beam = {}
	for i=1, 9 do
		self.Beam[i] = RealTime()
	end
end

local boxMaterial = Material( "hlmv/floor" )
local lasermat = Material("effects/laser1.vmt")
local matLight = CreateMaterial("boxvisLight", "UnLitGeneric", {
	["$basetexture"] = "sprites/light_glow01",
	["$nocull"] = 1,
	["$additive"] = 1,
	["$vertexalpha"] = 1,
	["$vertexcolor"] = 1,
	["$ignorez"] = 0,
}) //Material( "sprites/glow_test02" )

function ENT:DrawTranslucent()
	if !self.LastAng then
		self.LastAng = self:GetAngles()
	end
	local fftAverage = self:GetAverage( self.Song, 1, 5 )
	local Ang = self:GetAngles()
	local col = HSVToColor(self.LastH, 1, 0.8)
	render.SetMaterial( boxMaterial )

	boxMaterial:SetFloat( "$alpha", 0.8 )

	boxMaterial:SetVector( "$color", Vector(col.r / 255, col.g / 255, col.b / 255) )
	render.DrawBox( self:GetPos(), self.LastAng - Angle(self.LastAng.p*2, self.LastAng.p*-2, 0), Vector(-1, -1, -1) * self.Scale, Vector(1, 1, 1) * self.Scale, col, false )

	self.BigCol = col
	col = HSVToColor(self.LastH + 128, 1, 1)
	boxMaterial:SetVector( "$color", Vector(1, 1, 1) )
	self.LastAng.p = self.LastAng.p + fftAverage * 2
	render.DrawBox( self:GetPos(), self.LastAng - Angle(0, 0, self.LastAng.p*3), Vector(-1, -1, -1) * self.Scale * 0.5, Vector(1, 1, 1) * self.Scale * 0.5, Color(255, 255, 255, 255), false )
	

	if( IsValid(self.Song) ) then
		col = HSVToColor(self.LastH + 256, 1, 1)
		boxMaterial:SetVector( "$color", Vector(col.r / 255, col.g / 255, col.b / 255) )

		for i=1, 25 do
			local lscale = 1.6 + (self.FFT[i] + self.FFT[i + 1]) * (8 + i)
			local base = self:GetPos()
			local basepos1 = base + Vector(math.sin(RealTime() + i) * 18, math.cos(RealTime() + i) * 18, math.cos(RealTime()*2 + i) * 18) * self.Scale * 0.1
			local basepos2 = base + Vector(math.sin(RealTime() + i) * 18, math.cos(RealTime() + i) * 18, math.sin(RealTime()*2 + i) * 18) * self.Scale * 0.1
			
			render.DrawBox( basepos1, (base - basepos1):Angle(), Vector(-1, -1, -1) * lscale, Vector(1, 1, 1) * lscale, col, false )
			lscale = 1.6 + math.pow(self.FFT[i], 2) * (8*i)//(math.abs(math.log(2048)/math.log(self.FFT[i])))// * (8 + i)
			render.DrawBox( basepos2, (base - basepos2):Angle(), Vector(-1, -1, -1) * lscale, Vector(1, 1, 1) * lscale, col, false )
		end

		col = HSVToColor(self.LastH + 300, 1, 1)

		for i=1, 9 do
			local add = fftAverage * 2
			local tr = util.TraceLine( {
				start = self:GetPos(),
				endpos = self:GetPos() + Vector(math.sin(RealTime() + i*2 + add * 0.5)*2048 + (i*16),math.cos(RealTime() + i*2 + add * 0.5)*2048 + (i*16),math.cos(self.Beam[i]) - math.sin(self.Beam[i]) * 2048 + (i*64)),
				filter = {self},
			})

			self.Beam[i] = self.Beam[i]+(self.FFT[i] * 0.1)

			if tr.Hit then
				render.SetMaterial( lasermat )
				render.StartBeam( 2 )
				render.AddBeam(
					self:GetPos(),
					30,
					CurTime(),
					col		// Color
				)
				render.AddBeam(
					tr.HitPos,
					30,
					CurTime() + 1,
					Color( 0, 0, 0, 255 )
				)
				render.EndBeam()
				render.SetMaterial( matLight )
				render.DrawSprite( tr.HitPos, 32, 32, col )
				self.BeamEnd[i] = {Pos = tr.HitPos, Col = col}
			end
		end
	end

end

hook.Add( "RenderScreenspaceEffects", "ARCHOS_RaveCube_RenderScreenspaceEffects", function()
	local w, h = ScrW(), ScrH()
	local eyepos, eyeangles = EyePos(), EyeAngles()
	for _, boxvisStream in ipairs( ents.FindByClass("ravecube") or {} ) do
		if IsValid( boxvisStream ) then
			local pos = boxvisStream:GetPos()

			local tr = util.TraceLine( {
				start = EyePos(),
				endpos = pos,
				filter = {LocalPlayer()}
			} )
			if tr.HitWorld then continue end

			local screenPos = pos:ToScreen()
			local distance = eyepos:Distance( pos )
			local multi = math.max( eyeangles:Forward():DotProduct( ( pos - eyepos ):GetNormal() ), 0 ) ^ 3
			multi = multi * math.Clamp( ( -distance / 6000 ) + 1, 0, 1 )
			if multi < 0.001 then return end
			multi = math.Clamp( multi, 0, 1 )
			local r = 1 - math.Clamp( pos:Distance(eyepos) / 2048, 0, 1 )
			local volume = (boxvisStream:GetAverage( boxvisStream.Song, 1, 15 )) * -1
			local blur = math.Clamp( ( volume * -10 ) + 1, 0.3, 1 )
			local invert = volume * -10 + 1
			local darkness = -multi + 1
			DrawSunbeams( math.Clamp( 1 * volume, .9, 1 ), math.Clamp( .8 * volume, .1, .8 ), math.Clamp( 3 * boxvisStream:GetAverage( boxvisStream.Song, 1, 5 ), 2.5, 3 ), screenPos.x / w, screenPos.y / h )
			DrawSunbeams( darkness, math.max( volume * 0.8, 0.1 ), math.max( volume * 0.5, 0.3 ), screenPos.x / w, screenPos.y / h )
			DrawBloom( darkness, invert * ( multi / 10 ), math.max( invert * 40 + 2, 5 ), math.max( invert * 40 + 2, 5 ), 4, 8, 1, 1, 1 )
			DrawMotionBlur( blur, 0, 0.01 )
			//DrawBloom( 0.34, 0.12, 5, 5, 14, 1, 1, 1, 1 ) -- Is it really worth it?!
		end
	end
end )