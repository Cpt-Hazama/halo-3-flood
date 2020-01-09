AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/cpthazama/halo3/flood_tank.mdl" -- Leave empty if using more than one model
ENT.StartHealth = 1000
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
ENT.GibOnDeathDamagesTable = {"All"}
ENT.RandomSpitChance = 8500
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_FLOOD","CLASS_PARASITE"}
ENT.BloodColor = "Yellow"
ENT.CustomBlood_Particle = {"cpt_blood_flood"} -- Particle that the SNPC spawns when it's damaged

ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 350 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 450 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackKnockBack_Up1 = 220 -- How far it will push you up | First in math.random
ENT.MeleeAttackKnockBack_Up2 = 220 -- How far it will push you up | Second in math.random
ENT.MeleeAttackKnockBack_Right1 = 0 -- How far it will push you right | First in math.random
ENT.MeleeAttackKnockBack_Right2 = 0 -- How far it will push you right | Second in math.random

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1,ACT_MELEE_ATTACK2} -- Melee Attack Animations
ENT.MeleeAttackDistance = 120 -- How close does it have to be until it attacks?
-- ENT.NextMeleeAttackTime = 0
ENT.NextAnyAttackTime_Melee = false
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.HasFootStepSound = false -- Should the SNPC make a footstep sound when it's moving?
-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Idle = {
	"vj_halo3flood/tank/hrdfoe11.mp3",
	"vj_halo3flood/tank/hrdfoe13.mp3",
	"vj_halo3flood/tank/hrdfoe15.mp3",
	"vj_halo3flood/tank/hrdfoe7.mp3",
	"vj_halo3flood/tank/hrdfoe9.mp3",
}
ENT.SoundTbl_Spew = {
	"vj_halo3flood/tank/tank_spew_5sec1.wav",
	"vj_halo3flood/tank/tank_spew_5sec2.wav",
	"vj_halo3flood/tank/tank_spew_5sec3.wav",
}
ENT.SoundTbl_MeleeAttackExtra = {
	"vj_halo3flood/tank/tank_melee_hit10.wav",
	"vj_halo3flood/tank/tank_melee_hit11.wav",
	"vj_halo3flood/tank/tank_melee_hit12.wav",
	"vj_halo3flood/tank/tank_melee_hit7.wav",
	"vj_halo3flood/tank/tank_melee_hit8.wav",
	"vj_halo3flood/tank/tank_melee_hit9.wav",
}
ENT.SoundTbl_Alert = {
	"vj_halo3flood/tank/charge1.mp3",
	"vj_halo3flood/tank/charge2.mp3",
	"vj_halo3flood/tank/charge3.mp3",
	"vj_halo3flood/tank/charge4.mp3",
	"vj_halo3flood/tank/charge5.mp3"
}
ENT.SoundTbl_CombatIdle = {
	"vj_halo3flood/tank/foundfoe1.mp3",
	"vj_halo3flood/tank/foundfoe2.mp3",
	"vj_halo3flood/tank/foundfoe3.mp3",
	"vj_halo3flood/tank/foundfoe4.mp3",
	"vj_halo3flood/tank/foundfoe5.mp3",
	"vj_halo3flood/tank/foundfoe6.mp3",
	"vj_halo3flood/tank/foundfoe7.mp3",
	"vj_halo3flood/tank/foundfoe8.mp3",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_halo3flood/tank/melee1.mp3",
	"vj_halo3flood/tank/melee2.mp3",
	"vj_halo3flood/tank/melee3.mp3",
	"vj_halo3flood/tank/melee4.mp3",
	"vj_halo3flood/tank/melee5.mp3",
	"vj_halo3flood/tank/melee6.mp3",
	"vj_halo3flood/tank/melee7.mp3",
	"vj_halo3flood/tank/melee8.mp3",
	"vj_halo3flood/tank/melee9.mp3",
	"vj_halo3flood/tank/melee10.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_halo3flood/tank/pain1.mp3",
	"vj_halo3flood/tank/pain2.mp3",
	"vj_halo3flood/tank/pain3.mp3",
	"vj_halo3flood/tank/pain4.mp3",
	"vj_halo3flood/tank/pain5.mp3",
	"vj_halo3flood/tank/pain6.mp3",
	"vj_halo3flood/tank/pain7.mp3",
	"vj_halo3flood/tank/pain8.mp3",
	"vj_halo3flood/tank/pain9.mp3",
	"vj_halo3flood/tank/pain10.mp3",
	"vj_halo3flood/tank/pain11.mp3",
	"vj_halo3flood/tank/pain12.mp3",
}
ENT.SoundTbl_Death = {
	"vj_halo3flood/tank/dth1.mp3",
	"vj_halo3flood/tank/dth2.mp3",
	"vj_halo3flood/tank/dth3.mp3",
	"vj_halo3flood/tank/dth4.mp3",
	"vj_halo3flood/tank/dth5.mp3",
	"vj_halo3flood/tank/dth6.mp3",
	"vj_halo3flood/tank/dth7.mp3",
	"vj_halo3flood/tank/dth8.mp3",
	"vj_halo3flood/tank/dth9.mp3",
	"vj_halo3flood/tank/dth10.mp3",
	"vj_halo3flood/tank/dth11.mp3",
	"vj_halo3flood/tank/dth12.mp3",
	"vj_halo3flood/tank/dth13.mp3",
}
ENT.SoundTbl_Thud = {
	"vj_halo3flood/tank/tank_melee_hit10.wav",
	"vj_halo3flood/tank/tank_melee_hit11.wav",
	"vj_halo3flood/tank/tank_melee_hit12.wav",
	"vj_halo3flood/tank/tank_melee_hit7.wav",
	"vj_halo3flood/tank/tank_melee_hit8.wav",
	"vj_halo3flood/tank/tank_melee_hit9.wav",
}
ENT.SoundTbl_FootStep = {
	"vj_halo3flood/tank/longmove1.wav",
	"vj_halo3flood/tank/longmove2.wav",
	"vj_halo3flood/tank/longmove3.wav",
	"vj_halo3flood/tank/longmove4.wav",
	"vj_halo3flood/tank/longmove5.wav",
	"vj_halo3flood/tank/longmove6.wav",
	"vj_halo3flood/tank/longmove7.wav",
	"vj_halo3flood/tank/longmove8.wav",
	"vj_halo3flood/tank/longmove9.wav",
	"vj_halo3flood/tank/longmove10.wav",
	"vj_halo3flood/tank/longmove11.wav",
	"vj_halo3flood/tank/longmove12.wav",
	"vj_halo3flood/tank/longmove13.wav",
	"vj_halo3flood/tank/longmove14.wav",
	"vj_halo3flood/tank/longmove15.wav",
}
ENT.PureType = "tank"
ENT.Default = VJ_MOVETYPE_GROUND
ENT.MeleeAttackAnimationFaceEnemy = false
ENT.EntitiesToNoCollide = {"npc_vj_flood_infection"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	local bloodeffect = EffectData()
	bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodeffect:SetColor(VJ_Color2Byte(Color(255,221,35)))
	bloodeffect:SetScale(120)
	util.Effect("VJ_Blood1",bloodeffect)
	
	local bloodspray = EffectData()
	bloodspray:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodspray:SetScale(8)
	bloodspray:SetFlags(3)
	bloodspray:SetColor(1)
	util.Effect("bloodspray",bloodspray)
	util.Effect("bloodspray",bloodspray)
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(26,26,85),Vector(-26,-26,0))
	self.IsBlocking = false
	self.Transforming = false
	self.NextSpitT = CurTime() +math.Rand(8,20)
	if GetConVarNumber("vj_halo_transform") == 1 then
		self.NextTransformT = CurTime() +math.Rand(15,20)
	else
		self.NextTransformT = CurTime() +999999999
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "event_mattack" then
		self.MeleeAttackDamage = 90
		self.MeleeAttackDamageDistance = 160
		if self.CurrentAttackAnimation == ACT_GESTURE_MELEE_ATTACK1 then
			VJ_EmitSound(self,self.SoundTbl_Thud,85,100)
			util.ScreenShake(self:GetPos(),10,100,0.5,400)
		end
		self:MeleeAttackCode()
	end
	if key == "event_pattack" then
		self.MeleeAttackDamage = 70
		self.MeleeAttackDamageDistance = 160
		self:MeleeAttackCode()
	end
	if key == "event_particle small" then
		self:EmitSound("physics/flesh/flesh_bloody_break.wav",math.random(65,75),math.random(85,100))
		for i = 1,math.random(1,3) do
			ParticleEffect("cpt_blood_flood",self:GetPos() +self:OBBCenter() +self:GetRight() *math.Rand(-5 *i,5 *i) +self:GetForward() *math.Rand(-5 *i,5 *i),Angle(math.Rand(0,360),math.Rand(0,360),math.Rand(0,360)),nil)
		end
	end
	if key == "event_particle big" then
		self:EmitSound("physics/flesh/flesh_bloody_break.wav",math.random(80,95),math.random(85,100))
		for i = 1,self:GetBoneCount() -1 do
			ParticleEffect("cpt_blood_flood",self:GetBonePosition(i),Angle(math.Rand(0,360),math.Rand(0,360),math.Rand(0,360)),nil)
		end
	end
	if key == "event_infection" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,85,100)
		self:EmitSound("physics/flesh/flesh_bloody_break.wav",math.random(65,75),math.random(85,100))
		local fMin = 300
		local fMax = 450
		local fTurn = 250
		local flood = ents.Create("npc_vj_flood_infection")
		flood:SetPos(self:GetAttachment(1).Pos)
		flood:SetAngles(self:GetAngles())
		flood:Spawn()
		flood:Activate()
		constraint.NoCollide(flood,self,0,0)
		flood:SetGroundEntity(NULL)
		flood:SetVelocity(((self:GetPos() +self:OBBCenter() +self:GetForward() *300) -(self:GetAttachment(1).Pos)):GetNormal() *math.Rand(fMin,fMax) +self:GetRight() *math.Rand(-fTurn,fTurn))
		ParticleEffect("GrubBlood",self:GetAttachment(1).Pos,self:GetAttachment(1).Ang,nil)
		ParticleEffect("GrubBlood",self:GetAttachment(1).Pos,self:GetAttachment(1).Ang,nil)
		ParticleEffect("cpt_blood_flood",self:GetAttachment(1).Pos,self:GetAttachment(1).Ang,nil)
		ParticleEffect("cpt_blood_flood",self:GetAttachment(1).Pos,self:GetAttachment(1).Ang,nil)
	end
	if key == "event_impact" then
		VJ_EmitSound(self,self.SoundTbl_Thud,85,100)
		util.ScreenShake(self:GetPos(),10,100,0.5,400)
	end
	if key == "event_emit step" then
		util.ScreenShake(self:GetPos(),10,100,0.5,400)
		VJ_EmitSound(self,self.SoundTbl_FootStep,95,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnTransformed(from,to)
	local anim = from .. "_to_" .. to
	self.MovementType = VJ_MOVETYPE_STATIONARY
	local act,dur = self:LookupSequence(anim)
	self:VJ_ACT_PLAYACTIVITY("vjseq_" .. anim,true,nil,false)
	self:EmitSound("physics/flesh/flesh_bloody_break.wav",math.random(80,95),math.random(85,100))
	VJ_EmitSound(self,"vj_halo3flood/transformation/" .. to .. "_from_" .. from .. math.random(1,3) .. ".wav",90,100)
	for i = 1,self:GetBoneCount() -1 do
		ParticleEffect("cpt_blood_flood",self:GetBonePosition(i),Angle(math.Rand(0,360),math.Rand(0,360),math.Rand(0,360)),nil)
	end
	timer.Simple(0.15,function()
		if IsValid(self) then
			self:SetNoDraw(false)
		end
	end)
	timer.Simple(dur,function()
		if IsValid(self) then
			self.MovementType = self.Default
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Transform(to,ent)
	local anim = self.PureType .. "_to_" .. to
	self.MovementType = VJ_MOVETYPE_STATIONARY
	local act,dur = self:LookupSequence(anim)
	self:VJ_ACT_PLAYACTIVITY("vjseq_" .. anim,true,nil,false)
	VJ_EmitSound(self,"vj_halo3flood/transformation/" .. anim .. math.random(1,3) .. ".wav",90,100)
	timer.Simple(dur,function()
		if IsValid(self) then
			self:EmitSound("physics/flesh/flesh_bloody_break.wav",math.random(80,95),math.random(85,100))
			for i = 1,self:GetBoneCount() -1 do
				ParticleEffect("cpt_blood_flood",self:GetBonePosition(i),Angle(math.Rand(0,360),math.Rand(0,360),math.Rand(0,360)),nil)
			end
			local f = ents.Create(ent)
			f:SetPos(self:GetPos())
			f:SetAngles(self:GetAngles())
			f:Spawn()
			f:SetNoDraw(true)
			f:OnTransformed(self.PureType,to)
			undo.ReplaceEntity(self,f)
			self:VJ_SwitchController(f)
			self:Remove()
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FloodControl()
	local ply = self.VJ_TheController
	local ent = self.VJ_TheControllerBullseye
	local dist = self:VJ_GetNearestPointToEntityDistance(ent)
	local lmb = ply:KeyDown(IN_ATTACK)
	local rmb = ply:KeyDown(IN_ATTACK2)
	local space = ply:KeyDown(IN_JUMP)
	local alt = ply:KeyDown(IN_WALK)
	self.NextLMB = self.NextLMB or CurTime() +1
	self.NextRMB = self.NextRMB or CurTime() +1
	if rmb && CurTime() > self.NextTransformT then
		self:Transform("stalker","npc_vj_flood_stalker")
		self.Transforming = true
		self.NextTransformT = CurTime() +15
	end
	if space && CurTime() > self.NextTransformT then
		self:Transform("ranged","npc_vj_flood_ranged")
		self.Transforming = true
		self.NextTransformT = CurTime() +15
	end
	if alt && !self.Transforming && CurTime() > self.NextSpitT then
		self:VJ_ACT_PLAYACTIVITY("vjseq_infection_spew",true,nil,false)
		self.NextSpitT = CurTime() +30
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.NextRegen = CurTime()
function ENT:RegenerateHealth()
	if CurTime() > self.NextRegen then
		local setHealth = math.Clamp(self:Health() +10,0,self:GetMaxHealth())
		if setHealth > self:Health() then
			self:SetHealth(setHealth)
			self.NextRegen = CurTime() +10
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ForceMeleeAttack()
	if !self:CanDoCertainAttack("MeleeAttack") then return end
	self.MeleeAttacking = true
	self.RangeAttacking = false
	self.AlreadyDoneMeleeAttackFirstHit = false
	self.IsAbleToMeleeAttack = false
	self.AlreadyDoneFirstMeleeAttack = false
	self:CustomOnMeleeAttack_BeforeStartTimer()
	timer.Simple(self.BeforeMeleeAttackSounds_WaitTime,function() if IsValid(self) then self:BeforeMeleeAttackSoundCode() end end)
	self.NextAlertSoundT = CurTime() + 0.4
	if self.DisableMeleeAttackAnimation == false then
		self.CurrentAttackAnimation = VJ_PICKRANDOMTABLE(self.AnimTbl_MeleeAttack)
		self.CurrentAttackAnimationDuration = VJ_GetSequenceDuration(self,self.CurrentAttackAnimation) -self.MeleeAttackAnimationDecreaseLengthAmount
		if self.MeleeAttackAnimationAllowOtherTasks == false then
			self.PlayingAttackAnimation = true
			timer.Simple(self.CurrentAttackAnimationDuration,function()
				if IsValid(self) then
					self.PlayingAttackAnimation = false
				end
			end)
		end
		self:VJ_ACT_PLAYACTIVITY(self.CurrentAttackAnimation,false,0,false,self.MeleeAttackAnimationDelay,{SequenceDuration=self.CurrentAttackAnimationDuration})
	end
	self.MeleeAttack_DoingPropAttack = false
	if self.TimeUntilMeleeAttackDamage == false then
		self:MeleeAttackCode_DoFinishTimers()
	else
		timer.Create( "timer_melee_start"..self:EntIndex(), self.TimeUntilMeleeAttackDamage, self.MeleeAttackReps, function() self:MeleeAttackCode() end)
		for tk, tv in ipairs(self.MeleeAttackExtraTimers) do
			self:DoAddExtraAttackTimers("timer_melee_start_"..math.Round(CurTime())+math.random(1,99999999),tv,1,"MeleeAttack")
		end
	end
	self:CustomOnMeleeAttack_AfterStartTimer()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:IsBehindMe(enemy,checkRadius)
    return !(self:GetForward():Dot(((enemy:GetPos() +enemy:OBBCenter()) -self:GetPos()):GetNormalized()) > math.cos(math.rad(checkRadius)))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self:RegenerateHealth()
	self:GravemindSpeak()
	if GetConVarNumber("ai_disabled") == 1 then return end
	if self.IsBlocking then
		self.AnimTbl_IdleStand = {ACT_IDLE_STIMULATED}
		self.AnimTbl_Walk = {ACT_RUN_STIMULATED}
		self.AnimTbl_Run = {ACT_RUN_STIMULATED}
	else
		self.AnimTbl_IdleStand = {ACT_IDLE}
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_Run = {ACT_RUN}
	end
	-- self.NextMeleeAttackTime = VJ_GetSequenceDuration(self,self.CurrentAttackAnimation)
	-- self.NextAnyAttackTime_Melee = VJ_GetSequenceDuration(self,self.CurrentAttackAnimation)
	if self.CurrentAttackAnimation == ACT_MELEE_ATTACK1 || self.CurrentAttackAnimation == ACT_MELEE_ATTACK2 then
		self.MeleeAttackDamageAngleRadius = 100
	elseif self.CurrentAttackAnimation == ACT_GESTURE_MELEE_ATTACK1 then
		self.MeleeAttackDamageAngleRadius = -100
	end
	if IsValid(self:GetEnemy()) then
		local enemy = self:GetEnemy()
		local dist = self:VJ_GetNearestPointToEntityDistance(enemy)
		if !self:IsBehindMe(enemy,self.MeleeAttackAngleRadius) then
			self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1,ACT_MELEE_ATTACK2}
		elseif self:IsBehindMe(enemy,self.MeleeAttackAngleRadius) && dist <= self.MeleeAttackDamageDistance then
			self.AnimTbl_MeleeAttack = {ACT_GESTURE_MELEE_ATTACK1}
			-- if !self.VJ_IsBeingControlled then
				self:ForceMeleeAttack()
			-- end
		end
	end
	if self.VJ_IsBeingControlled then self:FloodControl() return end
	if IsValid(self:GetEnemy()) then
		local enemy = self:GetEnemy()
		local dist = self:VJ_GetNearestPointToEntityDistance(enemy)
		if dist <= 400 then
			self.AnimTbl_Run = {ACT_WALK}
		end
		if dist > 600 && CurTime() > self.NextSpitT && self.Transforming == false then
			self:VJ_ACT_PLAYACTIVITY("vjseq_infection_spew",true,nil,false)
			self.NextSpitT = CurTime() +math.random(20,30)
		end
	else
		local chance = math.random(1,self.RandomSpitChance)
		if chance == 1 && CurTime() > self.NextSpitT && self.Transforming == false then
			self:VJ_ACT_PLAYACTIVITY("vjseq_infection_spew",true,nil,false)
			self.NextSpitT = CurTime() +math.random(20,30)
		end
	end
	if IsValid(self:GetEnemy()) && math.random(1,100) == 1 && CurTime() > self.NextTransformT then
		local enemy = self:GetEnemy()
		local dist = self:VJ_GetNearestPointToEntityDistance(enemy)
		if dist <= 850 then
			self:Transform("stalker","npc_vj_flood_stalker")
		else
			self:SetAngles(Angle(0,(enemy:GetPos() -self:GetPos()):Angle().y,0))
			self:Transform("ranged","npc_vj_flood_ranged")
		end
		self.Transforming = true
		self.NextTransformT = CurTime() +15
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if dmginfo:IsBulletDamage() then
		if self.IsBlocking then
			dmginfo:ScaleDamage(0.5)
		elseif !self.IsBlocking && math.random(1,40) == 1 then
			self.IsBlocking = true
			timer.Simple(10,function()
				if IsValid(self) then
					self.IsBlocking = false
				end
			end)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_OnBleed(dmginfo,hitgroup)
	if math.random(1,5) == 1 then
		local gibs = {"models/predatorcz/halo/flood/shared.PMD/innards1.mdl","models/predatorcz/halo/flood/shared.PMD/innards3.mdl","models/predatorcz/halo/flood/shared.PMD/limb1.mdl","models/predatorcz/halo/flood/shared.PMD/limb2.mdl","models/predatorcz/halo/flood/shared.PMD/limb3.mdl","models/predatorcz/halo/flood/shared.PMD/skin1.mdl","models/predatorcz/halo/flood/shared.PMD/skin2.mdl","models/predatorcz/halo/flood/shared.PMD/skin3.mdl"}
		if dmginfo:IsBulletDamage() then
			self:CreateGibEntity("obj_vj_gib",gibs,{BloodType="Yellow",Pos=dmginfo:GetDamagePosition()})
		else
			self:CreateGibEntity("obj_vj_gib",gibs,{BloodType="Yellow",Pos=self:GetPos() +self:OBBCenter()})
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled(dmginfo,hitgroup)
	self:EmitSound("physics/flesh/flesh_bloody_break.wav",82,90)
	for i = 1,self:GetBoneCount() -1 do
		ParticleEffect("f_hdyn_chest",self:GetBonePosition(i),Angle(math.Rand(0,360),math.Rand(0,360),math.Rand(0,360)),nil)
		ParticleEffect("cpt_blood_flood",self:GetBonePosition(i),Angle(math.Rand(0,360),math.Rand(0,360),math.Rand(0,360)),nil)
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/