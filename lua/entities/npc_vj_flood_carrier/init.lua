AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/cpthazama/halo3/flood_carrier.mdl" -- Leave empty if using more than one model
ENT.StartHealth = 150
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
ENT.EntitiesToNoCollide = {"npc_vj_flood_infection"}
ENT.MeleeAttackAnimationFaceEnemy = false
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_FLOOD","CLASS_PARASITE"}
ENT.CustomBlood_Particle = {"cpt_blood_flood"} -- Particle that the SNPC spawns when it's damaged

ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 125 -- How close does it have to be until it attacks?
ENT.AttackProps = false -- Should it attack props when trying to move?
ENT.HasFootStepSound = false -- Should the SNPC make a footstep sound when it's moving?
ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.DisableDefaultMeleeAttackDamageCode = true -- Disables the default melee attack damage code
ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.AnimTbl_LeapAttack = {ACT_JUMP} -- Melee Attack Animations
ENT.LeapAttackAnimationFaceEnemy = true
ENT.LeapDistance = 600 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 400 -- How close does it have to be until it uses melee?
ENT.TimeUntilLeapAttackDamage = 0.1 -- How much time until it runs the leap damage code?
ENT.NextLeapAttackTime_DoRand = 10
ENT.NextLeapAttackTime = 5 -- How much time until it can use a leap attack?
ENT.NextAnyAttackTime_Leap = 0.1 -- How much time until it can use a attack again? | Counted in Seconds
ENT.LeapAttackVelocityForward = 15 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 400 -- How much upward force should it apply?
ENT.LeapAttackDamage = 65
ENT.LeapAttackDamageDistance = 50 -- How far does the damage go?
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_halo3flood/carrier/shared/carrier_walk1.mp3",}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_halo3flood/carrier/h3/unarmed_melee_suicide1.mp3","vj_halo3flood/carrier/h3/unarmed_melee_suicide2.mp3","vj_halo3flood/carrier/h3/unarmed_melee_suicide3.mp3"}
ENT.SoundTbl_LeapAttack = {}
ENT.SoundTbl_Pain = {"vj_halo3flood/carrier/h3/carswell2.mp3"}
ENT.SoundTbl_Death = {"vj_halo3flood/carrier/hce/die1.mp3","vj_halo3flood/carrier/hce/die2.mp3"}
ENT.GibOnDeathDamagesTable = {"All"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInitialize()
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_JUMP))
	self.Explode = CurTime()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	self:CarrierGibs()
	self:SpawnFlood(math.random(3,11))
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CarrierGibs()
	local bloodeffect = EffectData()
	bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodeffect:SetColor(VJ_Color2Byte(Color(255,221,35)))
	bloodeffect:SetScale(300)
	util.Effect("VJ_Blood1",bloodeffect)
	
	local bloodspray = EffectData()
	bloodspray:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodspray:SetScale(75)
	bloodspray:SetFlags(3)
	bloodspray:SetColor(1)
	util.Effect("bloodspray",bloodspray)
	util.Effect("bloodspray",bloodspray)
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
	VJ_EmitSound(self,"vj_halo3flood/carrier/h3/pop" .. math.random(1,6) .. ".mp3",120,100)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SpawnFlood(count)
	for i = 1,count do
		local pos = self:GetPos() +self:OBBCenter()
		local flood = ents.Create("npc_vj_flood_infection")
		flood:SetPos(pos +self:GetForward() *math.Rand(-(4 *i),4 *i) +self:GetRight() *math.Rand(-(4 *i),4 *i))
		flood:SetAngles(Angle(self:GetAngles().x,math.Rand(0,360),self:GetAngles().z))
		flood:Spawn()
		flood:SetGroundEntity(NULL)
		local rand = 350
		flood:SetVelocity(self:GetForward() *math.random(-rand,rand) +self:GetUp() *math.random(rand -50,rand) +self:GetRight() *math.random(-rand,rand))
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
function ENT:CarrierExplode()
	self:CarrierGibs()
	util.VJ_SphereDamage(self,self,self:GetPos(),150,45,DMG_POISON,false,true)
	self:SpawnFlood(math.random(6,14))
	self:Remove()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self:GravemindSpeak()
	if GetConVarNumber("ai_disabled") == 1 then return end
	if self.CanScale then
		local scale = math.Rand(1,math.Rand(1,2.5))
		local targetVec = Vector(scale,scale,scale)
		self:ManipulateBoneScale(9,LerpVector(0.2,self:GetManipulateBoneScale(9),targetVec))
	end
	if self:GetActivity() == ACT_JUMP && !self.LeapAttacking && self:IsOnGround() then
		self:StartEngineTask(GetTaskList("TASK_SET_ACTIVITY"),ACT_LAND)
	end
	-- self.NextMeleeAttackTime = VJ_GetSequenceDuration(self,self.CurrentAttackAnimation)
	-- self.NextAnyAttackTime_Melee = VJ_GetSequenceDuration(self,self.CurrentAttackAnimation)
	if self.VJ_IsBeingControlled then self:FloodControl() return end
	if IsValid(self:GetEnemy()) then
		local enemy = self:GetEnemy()
		local dist = self:VJ_GetNearestPointToEntityDistance(enemy)
		if dist <= 120 && CurTime() > self.Explode then
			self.HasLeapAttack = false
			local anim = "vjseq_suicide" .. math.random(1,2)
			self:VJ_ACT_PLAYACTIVITY(anim,true,nil,false)
			self.CanScale = true
			VJ_EmitSound(self,"vj_halo3flood/carrier/h3/unarmed_melee_suicide" .. math.random(1,3) .. ".mp3",85,100)
			self.Explode = CurTime() +15
		end
	end
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
	if lmb && CurTime() > self.NextLMB then
		self.HasLeapAttack = false
		self.MovementType = VJ_MOVETYPE_STATIONARY
		local anim = "vjseq_suicide" .. math.random(1,2)
		self:VJ_ACT_PLAYACTIVITY(anim,true,nil,false)
		self.CanScale = true
		VJ_EmitSound(self,"vj_halo3flood/carrier/h3/unarmed_melee_suicide" .. math.random(1,3) .. ".mp3",85,100)
		self.NextLMB = CurTime() +8
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "event_mattack" then
		self:CarrierExplode()
	end
	if key == "event_emit step" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/