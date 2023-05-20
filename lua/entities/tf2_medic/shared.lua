AddCSLuaFile()

ENT.Base 			= "base_nextbot"
ENT.Spawnable		= true

function ENT:Initialize()

	self:SetModel("models/player/hwm/medic.mdl")
	
	sound.Play(Format("vo/medic_battlecry0%i.mp3",math.random(1,6)),self:GetPos(),75,100,1)

	self.LoseTargetDist	= 1000	-- How far the enemy has to be before we lose them
	self.SearchRadius 	= 500	-- How far to search for enemies

	local Cosmetics=math.random(0,1)
	local Hats={
		"models/player/items/medic/as_medic_cloud_hat.mdl","models/player/items/medic/berliners_bucket_helm.mdl","models/player/items/medic/coh_medichat.mdl",
		"models/player/items/medic/fwk_medic_stahlhelm.mdl","models/player/items/medic/hardhat.mdl","models/player/items/medic/hardhat_tower.mdl",
		"models/player/items/medic/hat_first.mdl","models/player/items/medic/hat_first_nr.mdl","models/player/items/medic/hat_second.mdl",
		"models/player/items/medic/hat_second_nr.mdl","models/player/items/medic/hat_third.mdl","models/player/items/medic/hat_third_nr.mdl",
		"models/player/items/medic/hwn_medic_hat.mdl","models/player/items/medic/icepack.mdl","models/player/items/medic/japan_hachimaki.mdl",
		"models/player/items/medic/japan_hat.mdl","models/player/items/medic/japan_hat_monarch.mdl","models/player/items/medic/medic_bill.mdl",
		"models/player/items/medic/medic_cap.mdl","models/player/items/medic/medic_cap_online.mdl","models/player/items/medic/medic_dex.mdl",
		"models/player/items/medic/medic_domination.mdl","models/player/items/medic/medic_ellis.mdl","models/player/items/medic/medic_gatsby.mdl",
		"models/player/items/medic/medic_german_gonzila.mdl","models/player/items/medic/medic_halloween.mdl","models/player/items/medic/medic_helmet.mdl",
		"models/player/items/medic/medic_mnc.mdl","models/player/items/medic/medic_mtg.mdl","models/player/items/medic/medic_officer.mdl",
		"models/player/items/medic/medic_spiral.mdl","models/player/items/medic/medic_ttg_max.mdl","models/player/items/medic/medic_tyrolean.mdl",
		"models/player/items/medic/medic_ushanka.mdl","models/player/items/medic/paper_hat.mdl","models/player/items/medic/shogun_geishahair.mdl",
		"models/player/items/medic/skull_horns_b.mdl","models/player/items/medic/skull_horns_b2.mdl","models/player/items/medic/skull_horns_b3.mdl",
		"models/player/items/medic/summer_hat_medic.mdl","models/player/items/medic/treasure_hat_oct.mdl","models/player/items/medic/veteran_hat.mdl",
		"models/player/items/medic/yeti_hardhat.mdl"
	}
	local Cosmetics={
		"models/player/items/medic/archimedes.mdl","models/player/items/medic/bowtie.mdl","models/player/items/medic/fwk_medic_pocketsquare.mdl",
		"models/player/items/medic/fwk_medic_stethoscope.mdl","models/player/items/medic/hwn_medic_misc1.mdl","models/player/items/medic/hwn_medic_misc2.mdl",
		"models/player/items/medic/medic_earbuds.mdl","models/player/items/medic/medic_mask.mdl","models/player/items/medic/medic_smokingpipe.mdl",
		"models/player/items/medic/medic_smokingpipe2.mdl","models/player/items/medic/professor_speks.mdl","models/player/items/medic/qc_glove.mdl",
		"models/player/items/medic/scarf_soccer.mdl","models/player/items/medic/summer_shades.mdl","models/player/items/medic/tw_coat_medic.mdl",
		"models/player/items/medic/tw_coat_medic_necktie.mdl","models/player/items/medic/medic_blighted_beak.mdl","models/player/items/medic/medic_clipboard.mdl"
	}

	self:SetHealth(175)
	self.MaxHealth=175

	self:SetCollisionGroup(COLLISION_GROUP_NPC)

	//	HALLOWEEN 31.10.
	if SERVER then
		if(Cosmetics)then
			local HasHat=math.random(0,1)
			local HasAcc=math.random(0,1)
			if(HasHat)then
				local Hatt=math.random(1,#Hats)
				local Hat=ents.Create("prop_dynamic")
				Hat:SetModel(Hats[Hatt])
				Hat:SetPos(self:GetPos())
				Hat:Spawn()
				constraint.BoneMerge(self,Hat)
			end
			if(HasAcc)then
				local AccCount=math.random(1,2)
				for k=1,AccCount do
					local Acc=math.random(1,#Cosmetics)
					local Accesory=ents.Create("prop_dynamic")
					Accesory:SetModel(Cosmetics[Acc])
					Accesory:SetPos(self:GetPos())
					Accesory:Spawn()
					constraint.BoneMerge(self,Accesory)
				end
			end
		end
	end
end

function ENT:SetEnemy( ent )
	self.Enemy = ent
end
function ENT:GetEnemy()
	return self.Enemy
end

function ENT:HaveEnemy()
	if ( self:GetEnemy() and IsValid( self:GetEnemy() ) ) then
		if ( self:GetRangeTo( self:GetEnemy():GetPos() ) > self.LoseTargetDist ) then
			return self:FindEnemy()
		elseif ( self:GetEnemy():IsPlayer() and !self:GetEnemy():Alive() ) then
			return self:FindEnemy()
		end
		return true
	else
		return self:FindEnemy()
	end
end

function ENT:FindEnemy()
	if GetConVar("ai_ignoreplayers"):GetBool() then
		self:SetEnemy( nil )
		return false
	else
		local _ents = ents.FindInSphere(self:GetPos(),self.SearchRadius)
		for k, v in pairs(_ents) do
		if (v:IsPlayer()) then
			self:SetEnemy(v)
			return true
		end
	end
	self:SetEnemy( nil )
	return false
	end
end

function ENT:RunBehaviour()
	while (true) do
		if (self:HaveEnemy()) then
			self.loco:FaceTowards(self:GetEnemy():GetPos())
			sound.Play("vo/medic_trade_taunts02.mp3",self:GetPos(),75,100,1)
			self:StartActivity(ACT_RUN)
			self:ResetSequenceInfo()
			self:SetSequence(self:LookupSequence("run_melee_allclass"))
			self:ResetSequence(self:LookupSequence("run_melee_allclass"))
			self.loco:SetDesiredSpeed(450)
			self.loco:SetAcceleration(900)
			self:ChaseEnemy()
			self:ResetSequenceInfo()
			self:PlaySequenceAndWait("taunt_yeti")
			self.loco:SetAcceleration(400)
			sound.Play("vo/taunts/medic/medic_taunt_admire_20.mp3",self:GetPos(),75,100,1)
			self:SetSequence(self:LookupSequence("taunt_yeti"))
			self:StartActivity(ACT_IDLE)
		else
			local TargetPos=self:GetPos()+Vector(math.Rand(-1,1),math.Rand(-1,1),0)*math.random(400,4000)
			self:StartActivity(ACT_WALK)
			self:ResetSequenceInfo()
			self:SetSequence(self:LookupSequence("run_melee_allclass"))
			self:ResetSequence(self:LookupSequence("run_melee_allclass"))
			self.loco:SetDesiredSpeed(250)
			self:MoveToPos(TargetPos)
			
			if math.Distance(self:GetPos().x,self:GetPos().y,TargetPos.x,TargetPos.y)>10 then
				//print("Medic arrived to Target Position. (",TargetPos,")")
				local Taunts={"taunt_xray","taunt_laugh","taunt_replay","taunt09","taunt07","taunt_brutallegend"}
				local ShouldTaunt=math.random(0,1)

				if ShouldTaunt!=0 then
					local Taunt = math.random(1,6)
					local Seq   = tostring(Taunts[Taunt])
					local TauntMisc=nil
					if Seq=="taunt_xray"then
						TauntMisc=ents.Create("prop_dynamic")
						TauntMisc:SetModel("models/player/items/taunts/medic_xray_taunt.mdl")
					elseif Seq=="taunt_brutallegend"then
						TauntMisc=ents.Create("prop_dynamic")
						TauntMisc:SetModel("models/workshop_partner/player/items/taunts/brutal_guitar/brutal_guitar_xl.mdl")
					elseif Seq=="taunt09"then
						TauntMisc=ents.Create("prop_dynamic")
						TauntMisc:SetModel("models/props_forest/dove.mdl")
					end
					if IsValid(TauntMisc)then
						TauntMisc:SetPos(self:GetPos())
						TauntMisc:Spawn()
						constraint.BoneMerge(self,TauntMisc)
					end
					self:StartActivity(ACT_IDLE)
					coroutine.wait(self:SequenceDuration(self:LookupSequence(Seq)/2))
					self:ResetSequenceInfo()
					self:PlaySequenceAndWait(Seq or "stand_melee_allclass")
					if IsValid(TauntMisc)then TauntMisc:Remove() end
					ShouldTaunt=0
				else
					self:ResetSequenceInfo()
					self:StartActivity(ACT_IDLE)
					coroutine.wait(self:SequenceDuration(self:LookupSequence("stand_melee_allclass")))
					self:PlaySequenceAndWait("stand_melee_allclass")
				end
			end
			//coroutine.resume()
		end
		coroutine.wait(2)
	end
end

function ENT:OnInjured(DamageInfo)
	local Dmg=DamageInfo:GetDamage()
	local Att=DamageInfo:GetAttacker()
	if Dmg>100 then
		sound.Play(Format("vo/medic_painsharp0%i.mp3",math.random(1,8)),self:GetPos(),75,100,1)
	else
		sound.Play(Format("vo/medic_painsevere0%i.mp3",math.random(1,4)),self:GetPos(),75,100,1)
	end
	self:SetEnemy(Att)
	self:FindEnemy()
	self:SetEnemy(Att)

	if IsValid(self) then
		if Dmg<self.MaxHealth then
			timer.Create("medic_heal",1,0,function()
				if IsValid(self) then
					if self:Health()<self.MaxHealth then
						self:SetHealth(math.Clamp(self:Health()+5,1,self.MaxHealth))
					else
						timer.Destroy("medic_heal")
					end
				end
				//print(self:Health())
			end)
		end
	else
		sound.Play(Format("vo/medic_paincrticialdeath0%i.mp3",math.random(1,4)),self:GetPos(),75,100,1)
		timer.Destroy("medic_heal")
	end
end

function ENT:ChaseEnemy( options )
	local options = options or {}
	local path = Path("Follow")
	path:SetMinLookAheadDistance( options.lookahead or 300 )
	path:SetGoalTolerance( options.tolerance or 20 )
	path:Compute(self,self:GetEnemy():GetPos())		-- Compute the path towards the enemies position
	if (!path:IsValid()) then return "failed" end
	while (path:IsValid() and self:HaveEnemy()) do
		if (path:GetAge() > 0.1 ) then					-- Since we are following the player we have to constantly remake the path
			path:Compute(self,self:GetEnemy():GetPos())-- Compute the path towards the enemy's position again
		end
		path:Update(self)								-- This function moves the bot along the path
		if (options.draw) then path:Draw() end
		if (self.loco:IsStuck()) then
			self:ResetSequenceInfo()
			self:SetSequence(self:LookupSequence("stand_melee_allclass"))
			self:HandleStuck()
			return "stuck"
		end
		coroutine.yield()
	end
	return "ok"
end

list.Set( "NPC", "tf2_medic", {
	Name = "Red Medic",
	Class = "tf2_medic",
	Category = "Team Fortress 2"
})