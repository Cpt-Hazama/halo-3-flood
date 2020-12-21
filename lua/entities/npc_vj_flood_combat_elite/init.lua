AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/cpthazama/halo3/flood_elite.mdl" -- Leave empty if using more than one model
ENT.StartHealth = 320

ENT.CanRegenCamo = false
ENT.CamoRegenTime = 15
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_FLOOD","CLASS_PARASITE"}

ENT.BloodColor = "Yellow"
ENT.CustomBlood_Particle = {"cpt_blood_flood","cpt_blood_flood","cpt_blood_flood","vj_impact1_purple"}

ENT.VJC_Data = {
    CameraMode = 2, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
    ThirdP_Offset = Vector(0, 0, 0), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(2, 0, 5), -- The offset for the controller when the camera is in first person
}

ENT.MeleeAttackDistance = 120

ENT.SoundTbl_FootStep = {
	"vj_halo3flood/elite/foot/longmove1.wav",
	"vj_halo3flood/elite/foot/longmove2.wav",
	"vj_halo3flood/elite/foot/longmove3.wav",
	"vj_halo3flood/elite/foot/longmove4.wav",
	"vj_halo3flood/elite/foot/longmove5.wav",
	"vj_halo3flood/elite/foot/longmove6.wav",
	"vj_halo3flood/elite/foot/longmove7.wav",
	"vj_halo3flood/elite/foot/longmove8.wav",
	"vj_halo3flood/elite/foot/longmove9.wav",
	"vj_halo3flood/elite/foot/longmove10.wav",
	"vj_halo3flood/elite/foot/longmove12.wav",
}
ENT.SoundTbl_Idle = {
	"vj_halo3flood/elite/layer14.wav",
	"vj_halo3flood/elite/layer16.wav",
	"vj_halo3flood/elite/layer19.wav",
	"vj_halo3flood/elite/layer22.wav",
	"vj_halo3flood/elite/layer24.wav",
	"vj_halo3flood/elite/layer27.wav",
	"vj_halo3flood/elite/layer39.wav",
	"vj_halo3flood/elite/layer43.wav",
	"vj_halo3flood/elite/layer44.wav",
	"vj_halo3flood/elite/layer56.wav",
	"vj_halo3flood/elite/layer61.wav",
	"vj_halo3flood/elite/layer62.wav",
	"vj_halo3flood/elite/layer84.wav",
	"vj_halo3flood/elite/layer89.wav",
}
ENT.SoundTbl_CombatIdle = {
	"vj_halo3flood/elite/2.wav",
	"vj_halo3flood/elite/10.wav",
	"vj_halo3flood/elite/29.wav",
	"vj_halo3flood/elite/45.wav",
	"vj_halo3flood/elite/48.wav",
	"vj_halo3flood/elite/64.wav",
	"vj_halo3flood/elite/105.wav",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_halo3flood/elite/melee1.wav",
	"vj_halo3flood/elite/melee2.wav",
	"vj_halo3flood/elite/melee3.wav",
	"vj_halo3flood/elite/melee4.wav",
}
ENT.SoundTbl_Pain = {
	"vj_halo3flood/elite/pain/layer1.wav",
	"vj_halo3flood/elite/pain/layer4.wav",
	"vj_halo3flood/elite/pain/layer5.wav",
	"vj_halo3flood/elite/pain/layer8.wav",
	"vj_halo3flood/elite/pain/layer10.wav",
	"vj_halo3flood/elite/pain/layer11.wav",
	"vj_halo3flood/elite/pain/layer12.wav",
	"vj_halo3flood/elite/pain/layer36.wav",
	"vj_halo3flood/elite/pain/layer38.wav",
	"vj_halo3flood/elite/pain/layer46.wav",
	"vj_halo3flood/elite/pain/layer73.wav",
	"vj_halo3flood/elite/pain/layer90.wav",
}
ENT.SoundTbl_Death = {
	"vj_halo3flood/elite/out1.wav",
	"vj_halo3flood/elite/out2.wav",
	"vj_halo3flood/elite/out3.wav",
	"vj_halo3flood/elite/out4.wav",
	"vj_halo3flood/elite/out5.wav",
	"vj_halo3flood/elite/out6.wav",
	"vj_halo3flood/elite/out7.wav",
	"vj_halo3flood/elite/out8.wav",
	"vj_halo3flood/elite/out9.wav",
	"vj_halo3flood/elite/out10.wav",
}
ENT.SoundTbl_CallForHelp = {
	"vj_halo3flood/vo/newordr_charge1.mp3",
	"vj_halo3flood/vo/newordr_charge2.mp3",
	"vj_halo3flood/vo/newordr_charge3.mp3",
	"vj_halo3flood/vo/newordr_charge4.mp3",
}
ENT.SoundTbl_OnKilledEnemy = {
	"vj_halo3flood/vo/chr_deadmc1.mp3",
	"vj_halo3flood/vo/chr_deadmc2.mp3",
	"vj_halo3flood/vo/chr_deadmc3.mp3",
	"vj_halo3flood/vo/chr_deadmc4.mp3",
	"vj_halo3flood/vo/chr_deadmc5.mp3",
	"vj_halo3flood/vo/chr_deadmc6.mp3",
	"vj_halo3flood/vo/chr_deadmc7.mp3",
	"vj_halo3flood/vo/chr_deadmc8.mp3",
	"vj_halo3flood/vo/chr_deadmc9.mp3",
	"vj_halo3flood/vo/chr_deadmc10.mp3",
}
ENT.SoundTbl_AllyDeath = {
	"vj_halo3flood/vo/lmnt_deadally1.mp3",
	"vj_halo3flood/vo/lmnt_deadally3.mp3",
	"vj_halo3flood/vo/lmnt_deadally4.mp3",
	"vj_halo3flood/vo/lmnt_deadally5.mp3",
	"vj_halo3flood/vo/lmnt_deadally6.mp3",
	"vj_halo3flood/vo/lmnt_deadally7.mp3",
}

ENT.SoundTbl_Assimilation = {"vj_floodce/shared/death8.mp3"}

ENT.SpawnableWeapons = {
	"weapon_vj_halo_needler",
	"weapon_vj_halo_plasmapistol",
	"weapon_vj_halo_plasmarifle",
	"weapon_vj_halo_plasmarifle"
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInit()
	self:SetCollisionBounds(Vector(21,21,75),Vector(-21,-21,0))

	self:SetNWFloat("ShieldT",0)
	self.HasShield = math.random(1,3) == 1
	self.ShieldHealth = 50

	self.HasCamo = math.random(1,9) == 1
	if self.AlwaysHaveCamo then self.HasCamo = true end
	self.CamoMeter = 100
	self.NextCamoT = CurTime()
	self.IsUsingCamo = false

	self:SetSkin(math.random(0,6))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "event_mattack" then
		self.HasMeleeAttackKnockBack = false
		self.MeleeAttackDamage = 26
		self.MeleeAttackDamageDistance = 125
		self:MeleeAttackCode()
	end
	if key == "event_mattack forward" then
		self.HasMeleeAttackKnockBack = false
		self.MeleeAttackDamage = 30
		self.MeleeAttackDamageDistance = 130
		self:MeleeAttackCode()
	end
	if key == "event_pattack" then
		self.HasMeleeAttackKnockBack = true
		self.MeleeAttackDamage = 15
		self.MeleeAttackDamageDistance = 125
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
	if key == "event_emit step" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FloodControl()
	local ply = self.VJ_TheController
	if !IsValid(ply) then return end
	local ent = self.VJ_TheControllerBullseye
	local lmb = ply:KeyDown(IN_ATTACK)
	local rmb = ply:KeyDown(IN_ATTACK2)
	local space = ply:KeyDown(IN_JUMP)
	local alt = ply:KeyDown(IN_WALK)
	self.Next = self.Next or CurTime()
	if alt && CurTime() > self.Next then
		if self.HasCamo then
			if self.CamoMeter > 0 then
				if !self.IsUsingCamo then
					self:Camo(true)
					self.IsUsingCamo = true
				end
			end
		end
		self.Next = CurTime() +1
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if self.HasShield then
		local dmg = dmginfo:GetDamage()
		self:SetNWFloat("ShieldT",CurTime() +1)
		local sdmg = math.Round(dmg -(dmg *0.4))
		if sdmg <= 0 then
			sdmg = 1
		end
		dmginfo:SetDamage(1)
		ParticleEffect("npcarmor_hit",dmginfo:GetDamagePosition(),Angle(0,0,0),self)
		VJ_EmitSound(self,"ambient/energy/zap" .. math.random(1,3) .. ".wav",65,math.random(90,110))
		self.ShieldHealth = self.ShieldHealth -sdmg
		if self.ShieldHealth <= 0 then
			self.HasShield = false
			ParticleEffectAttach("npcarmor_break",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
			VJ_EmitSound(self,"ambient/energy/weld" .. math.random(1,2) .. ".wav",85,100)
		end
	end
	if self.VJ_EnhancedFlood then
		dmginfo:ScaleDamage(self.VJ_Flood_DamageResistance)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_OnBleed(dmginfo,hitgroup)
	if dmginfo:GetDamageType() == DMG_BLAST then
		self:SetGroundEntity(NULL)
		local dist = dmginfo:GetDamagePosition():Distance((self:GetPos() +self:OBBCenter()))
		local throw = (dmginfo:GetDamagePosition() -(self:GetPos() +self:OBBCenter()))
		local throwAng = throw:Angle()
		local throwAmount = dist *2
		self:SetVelocity(throwAng:Forward() *-throwAmount +throwAng:Up() *300)
		self:StartEngineTask(GetTaskList("TASK_SET_ACTIVITY"),ACT_GLIDE)
		self:MaintainActivity()
	end
	self.ResetWalkT = self.ResetWalkT -1
	if self.HasShield then return end
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
function ENT:OnThink(enemy,wep)
	self.Bleeds = not self.HasShield
	self:SetNWBool("HasShield",self.HasShield)
	if IsValid(enemy) then
		if !self.VJ_IsBeingControlled && self.HasCamo then
			if self.CamoMeter > 0 then
				if !self.IsUsingCamo then
					self:Camo(true)
					self.IsUsingCamo = true
				end
				if self.IsUsingCamo && CurTime() > self.NextCamoT then
					self.CamoMeter = self.CamoMeter -1
					self.NextCamoT = CurTime() +0.3
				end
			else
				if self.IsUsingCamo then
					self:Camo(false)
					self.IsUsingCamo = false
					if self.CanRegenCamo then
						timer.Simple(self.CamoRegenTime,function()
							if IsValid(self) then
								self.CamoMeter = 100
								if self.VJ_IsBeingControlled && IsValid(self.VJ_TheController) then
									self.VJ_TheController:ChatPrint("Camo Available!")
								end
							end
						end)
					end
				end
			end
		end
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/