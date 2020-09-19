AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/cpthazama/halo3/flood_infection.mdl" -- Leave empty if using more than one model
ENT.StartHealth = 50
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_TINY
ENT.GibOnDeathDamagesTable = {"All"}
ENT.EntitiesToNoCollide = {"npc_vj_flood_infection","prop_vj_flood_youdied"}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_FLOOD","CLASS_PARASITE"}
ENT.CustomBlood_Particle = {"cpt_blood_flood"} -- Particle that the SNPC spawns when it's damaged

ENT.VJC_Data = {
    CameraMode = 2, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
    ThirdP_Offset = Vector(0, 0, 0), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "spine2", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(4, 0, 4), -- The offset for the controller when the camera is in first person
}

ENT.HasMeleeAttack = false
ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.AnimTbl_LeapAttack = {ACT_RANGE_ATTACK1} -- Melee Attack Animations
ENT.LeapDistance = 200 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.TimeUntilLeapAttackDamage = 0.2 -- How much time until it runs the leap damage code?
ENT.NextLeapAttackTime = 1 -- How much time until it can use a leap attack?
ENT.NextAnyAttackTime_Leap = 0.4 -- How much time until it can use a attack again? | Counted in Seconds
ENT.LeapAttackExtraTimers = {0.4,0.6,0.8,1} -- Extra leap attack timers | it will run the damage code after the given amount of seconds
ENT.LeapAttackVelocityForward = 15 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 300 -- How much upward force should it apply?
ENT.LeapAttackDamage = 10
ENT.LeapAttackDamageDistance = 50 -- How far does the damage go?
ENT.AttackProps = false -- Should it attack props when trying to move?
ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
ENT.FootStepTimeRun = 0.2 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.2 -- Next foot step sound when it is walking
ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.HasExtraMeleeAttackSounds = true
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_halo3flood/infection/move1.mp3","vj_halo3flood/infection/move2.mp3","vj_halo3flood/infection/move3.mp3","vj_halo3flood/infection/move4.mp3","vj_halo3flood/infection/move5.mp3","vj_halo3flood/infection/move6.mp3","vj_halo3flood/infection/move7.mp3","vj_halo3flood/infection/move8.mp3","vj_halo3flood/infection/move9.mp3"}
ENT.SoundTbl_Idle = {"vj_halo3flood/infection/infector_idle_1.mp3","vj_halo3flood/infection/infector_idle_2.mp3","vj_halo3flood/infection/infector_idle_3.mp3","vj_halo3flood/infection/infector_idle_4.mp3","vj_halo3flood/infection/infector_idle_5.mp3","vj_halo3flood/infection/infector_idle_6.mp3","vj_halo3flood/infection/infector_idle_7.mp3","vj_halo3flood/infection/infector_idle_8.mp3","vj_halo3flood/infection/infector_idle_9.mp3","vj_halo3flood/infection/infector_idle_10.mp3","vj_halo3flood/infection/infector_idle_11.mp3","vj_halo3flood/infection/infector_idle_12.mp3","vj_halo3flood/infection/infector_idle_13.mp3","vj_halo3flood/infection/infector_idle_14.mp3","vj_halo3flood/infection/infector_idle_15.mp3","vj_halo3flood/infection/infector_idle_16.mp3","vj_halo3flood/infection/infector_idle_17.mp3","vj_halo3flood/infection/infector_idle_18.mp3","vj_halo3flood/infection/infector_idle_19.mp3","vj_halo3flood/infection/infector_idle_20.mp3","vj_halo3flood/infection/infector_idle_21.mp3","vj_halo3flood/infection/infector_idle_22.mp3","vj_halo3flood/infection/infector_idle_23.mp3","vj_halo3flood/infection/infector_idle_24.mp3","vj_halo3flood/infection/infector_idle_25.mp3","vj_halo3flood/infection/infector_idle_26.mp3","vj_halo3flood/infection/infector_idle_27.mp3","vj_halo3flood/infection/infector_idle_28.mp3","vj_halo3flood/infection/infector_idle_29.mp3","vj_halo3flood/infection/infector_idle_30.mp3",}
ENT.SoundTbl_Alert = {"vj_halo3flood/infection/infector_idle_1.mp3"}
ENT.SoundTbl_LeapAttackDamage = {
	"vj_halo3flood/infection/infector_bite1.mp3",
	"vj_halo3flood/infection/infector_bite10.mp3",
	"vj_halo3flood/infection/infector_bite11.mp3",
	"vj_halo3flood/infection/infector_bite2.mp3",
	"vj_halo3flood/infection/infector_bite3.mp3",
	"vj_halo3flood/infection/infector_bite4.mp3",
	"vj_halo3flood/infection/infector_bite5.mp3",
	"vj_halo3flood/infection/infector_bite6.mp3",
	"vj_halo3flood/infection/infector_bite7.mp3",
	"vj_halo3flood/infection/infector_bite8.mp3",
	"vj_halo3flood/infection/infector_bite9.mp3",
}
ENT.SoundTbl_Impact = {
	"vj_halo3flood/damage01.mp3",
	"vj_halo3flood/damage02.mp3",
	"vj_halo3flood/damage03.mp3",
}
ENT.SoundTbl_LeapAttack = {"vj_halo3flood/infection/infector_bite1.mp3","vj_halo3flood/infection/infector_bite2.mp3","vj_halo3flood/infection/infector_bite3.mp3","vj_halo3flood/infection/infector_bite4.mp3","vj_halo3flood/infection/infector_bite5.mp3","vj_halo3flood/infection/infector_bite6.mp3","vj_halo3flood/infection/infector_bite7.mp3","vj_halo3flood/infection/infector_bite8.mp3","vj_halo3flood/infection/infector_bite9.mp3","vj_halo3flood/infection/infector_bite10.mp3","vj_halo3flood/infection/infector_bite11.mp3"}
ENT.SoundTbl_Death = {"vj_halo3flood/infection/pop1.mp3","vj_halo3flood/infection/pop2.mp3","vj_halo3flood/infection/pop3.mp3","vj_halo3flood/infection/pop4.mp3","vj_halo3flood/infection/pop5.mp3"}

ENT.IdleSoundLevel = 60
ENT.NextIdleSound1 = 1
ENT.NextIdleSound2 = 1
ENT.FootStepSoundLevel = 45
ENT.LeapAttackSoundLevel = 50
ENT.MeleeAttackSoundLevel = 50
ENT.DeathSoundLevel = 60

-- ENT.VJ_IgnoreFloodInfection = true -- Add this to your SNPCs as well as their death corpse to prevent infection
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	local bloodeffect = EffectData()
	bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodeffect:SetColor(VJ_Color2Byte(Color(255,221,35)))
	bloodeffect:SetScale(10)
	util.Effect("VJ_Blood1",bloodeffect)
	
	local bloodspray = EffectData()
	bloodspray:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodspray:SetScale(1)
	bloodspray:SetFlags(3)
	bloodspray:SetColor(1)
	util.Effect("bloodspray",bloodspray)
	util.Effect("bloodspray",bloodspray)
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	
	VJ_EmitSound(self,"vj_halo3flood/explode0" .. math.random(1,2) .. ".mp3",85)
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInitialize()
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_JUMP))
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_CLIMB))
	self.IsHalo3Infection = true
	self:ManipulateBoneJiggle(18,1)
	self.NextInfectionThinkT = 0
	self.corpse = NULL
	self.IsLatched = false
	self.LatchedEnt = NULL
	self.LatchBone = nil
	self.LatchT = CurTime()
	self:DrawShadow(false)
end
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.NextRegen = CurTime()
function ENT:RegenerateHealth()
	if CurTime() > self.NextRegen then
		local setHealth = math.Clamp(self:Health() +5,0,self:GetMaxHealth())
		if setHealth > self:Health() then
			self:SetHealth(setHealth)
			self.NextRegen = CurTime() +5
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CanDoInfection()
	if !IsValid(self:GetEnemy()) then
		return true
	elseif IsValid(self:GetEnemy()) && self:GetEnemy():GetPos():Distance(self:GetPos()) > 500 then
		return true
	end
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Latch(ent)
	local tb = {}
	for i = 1,ent:GetBoneCount() -1 do
		tb[i] = i
	end
	local bone = tb[math.random(1,#tb)]
	if !bone then return end
	self.LatchBone = bone
	local pos,ang = ent:GetBonePosition(self.LatchBone)
	-- print(ent:GetBoneName(bone))
	if pos then
		self:SetPos(pos)
		self:SetAngles(ang)
	end
	if ent:IsPlayer() then
		ent.VJ_NextPushInfectionOffT = CurTime() +5
	end
	-- print(bone)
	self:FloodFollowBone(ent,self.LatchBone)
	self.LatchT = CurTime() +1.5
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:LatchAI(ent)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetNotSolid(true)
	if self:GetPos() == ent:GetPos() then
		self:SetPos(ent:GetPos() +ent:OBBCenter())
		self:Unlatch(true)
	end
	if CurTime() > self.LatchT then
		if math.random(1,75) == 1 then
			self:VJ_ACT_PLAYACTIVITY("vjseq_infect",true,nil,false)
			timer.Simple(2,function()
				if IsValid(self) && IsValid(ent) then
					ent:TakeDamage(999999999,self,self)
					ParticleEffect("cpt_blood_flood",self:GetPos(),Angle(0,0,0),nil)
				end
			end)
			self.LatchT = CurTime() +7
		else
			self:VJ_ACT_PLAYACTIVITY("vjseq_attack1",true,nil,false)
			ent:TakeDamage(5,self,self)
			ParticleEffect("cpt_blood_flood",self:GetPos(),Angle(0,0,0),nil)
			if ent:IsPlayer() then
				ent.VJ_NextPushInfectionOffT = CurTime() +5
			end
			self.LatchT = CurTime() +2
		end
		if self:GetPos() == ent:GetPos() || self.LatchBone == 0 then
			self:Unlatch()
		end
		if !IsValid(ent) or ent:Health() <= 0 then
			self:Unlatch()
		end
	end
	self:NextThink(CurTime())
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Unlatch(bThrow)
	if bThrow then
		self:SetGroundEntity(NULL)
		local throw = ((self.LatchedEnt:GetPos() +self.LatchedEnt:OBBCenter()) +self:GetPos())
		self:SetVelocity(throw *0.1)
	end
	self.IsLatched = false
	self.LatchedEnt = NULL
	self.LatchBone = nil
	self.HasLeapAttack = true
	self:SetMoveType(MOVETYPE_STEP)
	self:SetNotSolid(false)
	self:SetAngles(Angle(0,self:GetAngles().y,0))
	self:FloodFollowBone()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_OnBleed(dmginfo,hitgroup)
	-- if dmginfo:GetDamageType() == DMG_BLAST then
		-- self:SetGroundEntity(NULL)
		-- local throw = (dmginfo:GetDamagePosition() +self:GetPos())
		-- self:SetVelocity(throw *0.1)
	-- end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:InfectionAI()
	if self.IsLatched then
		-- print(self.LatchedEnt,self.LatchedEnt:Health())
		self.HasLeapAttack = false
		if IsValid(self.LatchedEnt) then
			local ent = self.LatchedEnt
			if IsValid(ent) then
				if self.LatchBone == nil then
					self:Latch(ent)
				end
				self:LatchAI(ent)
			end
		elseif !IsValid(self.LatchedEnt) or (IsValid(self.LatchedEnt) && self.LatchedEnt:Health() <= 0) then
			self:Unlatch()
		end
		return
	end
	if !self:CanDoInfection() then
		self.corpse = NULL
		self.DisableChasingEnemy = false
		return
	end
	if !IsValid(self.corpse) then
		self.corpse = NULL
		self.DisableChasingEnemy = false
		local tbl = {}
		for _,v in ipairs(ents.FindInSphere(self:GetPos(),500)) do
			if (v:GetClass() == "prop_ragdoll" && v.IsVJBaseCorpse == true) or (v:GetClass() == "prop_physics" && v.IsVJBaseCorpse == true) || (v:GetClass() == "prop_ragdoll" && table.HasValue(self.InfectableHL2Models,string.GetFileFromFilename(v:GetModel()))) then
				if v.IsSetToBeInfected then return end
				if v.VJ_IgnoreFloodInfection then return end
				-- self.corpse = v
				table.insert(tbl,v)
			end
		end
		local attempt = VJ_PICK(tbl)
		if IsValid(attempt) && !attempt.IsSetToBeInfected then
			self.corpse = attempt
		end
	else
		self.DisableChasingEnemy = true
		self:SetLastPosition(self.corpse:GetPos())
		self:VJ_TASK_GOTO_LASTPOS("TASK_RUN_PATH")
		if self.corpse:GetPos():Distance(self:GetPos()) <= 25 then
			-- local time = self:SequenceDuration(self:SelectWeightedSequence(ACT_SPECIAL_ATTACK1))
			self:VJ_ACT_PLAYACTIVITY(ACT_SPECIAL_ATTACK1,true,false,false)
			constraint.NoCollide(self.corpse,self,0,0)
			timer.Simple(1.4,function()
				if IsValid(self) && IsValid(self.corpse) && !self.corpse.IsSetToBeInfected && self.corpse:GetPos():Distance(self:GetPos()) <= 25 then
					self.corpse.IsSetToBeInfected = true
					local form = (self.corpse:GetModel() == "models/cpthazama/halo3/flood_elite.mdl" && "Elite") or (self.corpse:GetModel() == "models/cpthazama/halo3/flood_brute.mdl" && "Brute") or "Soldier"
					self:CreateCombatForm(form,self.corpse,nil,self)
				end
			end)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if self.VJ_EnhancedFlood then
		dmginfo:ScaleDamage(self.VJ_Flood_DamageResistance)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.InfectableHL2Models = {"alyx.mdl","combine_super_soldier.mdl","poison.mdl","classic.mdl","police.mdl","combine_soldier_prisonguard.mdl","combine_soldier.mdl","barney.mdl","breen.mdl","eli.mdl","gman.mdl","gman_high.mdl","kleiner.mdl","odessa.mdl","monk.mdl","female_01.mdl","female_01_bloody.mdl","female_02.mdl","female_02_bloody.mdl","female_03.mdl","female_03_bloody.mdl","female_04.mdl","female_04_bloody.mdl","female_06.mdl","female_06_bloody.mdl","female_07.mdl","female_07_bloody.mdl","male_01.mdl","male_01_bloody.mdl","male_02.mdl","male_02_bloody.mdl","male_03.mdl","male_03_bloody.mdl","male_04.mdl","male_04_bloody.mdl","male_05.mdl","male_05_bloody.mdl","male_06.mdl","male_06_bloody.mdl","male_07.mdl","male_07_bloody.mdl","male_08.mdl","male_08_bloody.mdl","male_09.mdl","male_09_bloody.mdl","male_cheaple.mdl","mossman.mdl"}
function ENT:CustomOnThink()
	if self.VJ_EnhancedFlood then
		self.LeapDistance = 375
		self.LeapAttackVelocityForward = 325
		self.LeapAttackVelocityUp = 275
		if self.MeleeAttacking or self.LeapAttacking then
			self:SetPlaybackRate(self.VJ_Flood_SpeedBoost)
		else
			self:SetPlaybackRate(1)
		end
	else
		self.LeapDistance = 200
		self.LeapAttackVelocityForward = 15
		self.LeapAttackVelocityUp = 300
	end
	local ent = self.LatchedEnt
	if IsValid(ent) then
		if ent:IsPlayer() then
			if ent:KeyReleased(IN_USE) then
				ent.VJ_NextPushInfectionOffT = ent.VJ_NextPushInfectionOffT -2
			end
			if CurTime() > ent.VJ_NextPushInfectionOffT then
				-- if math.random(1,3) == 1 then
					-- self:TakeDamage(self:Health(),ent,ent)
				-- else
					self:Unlatch(true)
				-- end
			end
		end
	end
	self:RegenerateHealth()
	self:GravemindSpeak()
	if CurTime() > self.NextInfectionThinkT then
		self:InfectionAI()
		self.NextInfectionThinkT = CurTime() +1
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CreateCombatForm(form,corpse,animation,infection)
	if !IsValid(corpse) then return end
	VJ_FloodInfectCorpse(form,corpse,animation,infection)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnLeapAttack_AfterChecks(TheHitEntity)
	if IsValid(TheHitEntity) && TheHitEntity:IsNPC() && TheHitEntity.HasShield then
		ParticleEffect("cpt_blood_flood",self:GetPos(),Angle(0,0,0),nil)
		ParticleEffect("cpt_blood_flood",self:GetPos(),Angle(0,0,0),nil)
		ParticleEffect("cpt_blood_flood",self:GetPos(),Angle(0,0,0),nil)
		ParticleEffect("cpt_blood_flood",self:GetPos(),Angle(0,0,0),nil)
		ParticleEffect("cpt_blood_flood",self:GetPos(),Angle(0,0,0),nil)
		self:TakeDamage(self:Health(),TheHitEntity,TheHitEntity)
		return
	end
	if GetConVarNumber("vj_halo_infectexplode") == 1 then
		if (TheHitEntity:IsPlayer()) && TheHitEntity:Health() > 0 && TheHitEntity:Armor() > 0 then
			ParticleEffect("cpt_blood_flood",self:GetPos(),Angle(0,0,0),nil)
			ParticleEffect("cpt_blood_flood",self:GetPos(),Angle(0,0,0),nil)
			ParticleEffect("cpt_blood_flood",self:GetPos(),Angle(0,0,0),nil)
			ParticleEffect("cpt_blood_flood",self:GetPos(),Angle(0,0,0),nil)
			ParticleEffect("cpt_blood_flood",self:GetPos(),Angle(0,0,0),nil)
			self:Remove()
		end
	else
		local ent = TheHitEntity
		local rHP = 60
		if ent:IsNPC() then
			rHP = ent:GetMaxHealth() /2
		end
		if !self.IsLatched && IsValid(ent) && ent:Health() <= rHP && ent:Health() > 0 then
			self.IsLatched = true
			if ent:IsPlayer() then
				ent.VJ_NextPushInfectionOffT = CurTime() +5
			end
			self.LatchedEnt = ent
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
hook.Add("PlayerDeath","VJ_Halo3FloodSNPCs_InfectionPlayer",function(victim,inflictor,attacker)
	VJ_FloodInfect(victim,inflictor,attacker,true)
end)
---------------------------------------------------------------------------------------------------------------------------------------------
hook.Add("OnNPCKilled","VJ_Halo3FloodSNPCs_Infection",function(victim,inflictor,attacker)
	VJ_FloodInfect(victim,inflictor,attacker,false)
end)
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/