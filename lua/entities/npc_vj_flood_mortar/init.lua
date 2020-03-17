AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/cpthazama/halowars/flood_mortar.mdl" -- Leave empty if using more than one model
ENT.StartHealth = 1500
ENT.SightAngle = 180
ENT.GibOnDeathDamagesTable = {"All"}
ENT.HasGibOnDeath = false
ENT.MovementType = VJ_MOVETYPE_STATIONARY
ENT.CanTurnWhileStationary = false
ENT.VJ_IsHugeMonster = true
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_FLOOD","CLASS_PARASITE"}
ENT.BloodColor = "Yellow"
ENT.CustomBlood_Particle = {"cpt_blood_flood"} -- Particle that the SNPC spawns when it's damaged

ENT.Immune_AcidPoisonRadiation = true
ENT.Immune_Dissolve = true
ENT.Immune_Physics = true
ENT.Immune_Sonic = true
ENT.AllowIgnition = false
ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = {"death"}

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_vj_flood_mortar" -- The entity that is spawned when range attacking
ENT.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK1} -- Range Attack Animations
ENT.RangeDistance = 7500 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime_DoRand = false -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "spores"
ENT.RangeAttackAngleRadius = 180

ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.HasFootStepSound = false -- Should the SNPC make a footstep sound when it's moving?
-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Idle = {
	"vj_halo3flood/proto/scary_throat1.wav",
	"vj_halo3flood/proto/scary_throat3.wav",
	"vj_halo3flood/proto/scary_throat4.wav",
	"vj_halo3flood/proto/scary_throat5.wav",
}
ENT.SoundTbl_Alert = {
	"vj_halo3flood/proto/scary_throat6.wav",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
	TheProjectile.ParentsEnemy = self:GetEnemy()
	return self:CalculateProjectile("Curve",self:GetPos(), self:GetEnemy():GetPos(),1000)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo,hitgroup)
	timer.Simple(0.3,function()
		if IsValid(self) then
			self:SetModelScale(0.1,2)
			for i = 1,self:GetBoneCount() -1 do
				ParticleEffect("flood_hive_explode",self:GetBonePosition(i),Angle(math.Rand(0,360),math.Rand(0,360),math.Rand(0,360)),nil)
			end
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(195,195,435),Vector(-195,-195,0))
	self.NextSlitherT = CurTime()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "range" then
		self:RangeAttackCode()
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
function ENT:CustomOnThink()
	if CurTime() > self.NextSlitherT then
		VJ_CreateSound(self,"vj_halo3flood/proto/slither3.wav",80,math.random(85,105))
		self.NextSlitherT = CurTime() +1
	end
	self:RegenerateHealth()
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