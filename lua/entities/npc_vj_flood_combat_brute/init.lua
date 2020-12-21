AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/cpthazama/halo3/flood_brute.mdl" -- Leave empty if using more than one model
ENT.StartHealth = 275

ENT.CustomBlood_Particle = {"cpt_blood_flood","cpt_blood_flood","cpt_blood_flood","vj_impact1_purple"}

ENT.VJC_Data = {
    CameraMode = 2, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
    ThirdP_Offset = Vector(0, 0, 0), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "corpse_head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(2, 0, 4), -- The offset for the controller when the camera is in first person
}

ENT.MeleeAttackDistance = 105

ENT.SoundTbl_FootStep = {
	"vj_halo3flood/brute/brutecombatform_longmove1.wav",
	"vj_halo3flood/brute/brutecombatform_longmove2.wav",
	"vj_halo3flood/brute/brutecombatform_longmove3.wav",
	"vj_halo3flood/brute/brutecombatform_longmove4.wav",
	"vj_halo3flood/brute/brutecombatform_longmove5.wav",
	"vj_halo3flood/brute/brutecombatform_longmove6.wav",
	"vj_halo3flood/brute/brutecombatform_longmove7.wav",
	"vj_halo3flood/brute/brutecombatform_longmove8.wav",
	"vj_halo3flood/brute/brutecombatform_longmove9.wav",
	"vj_halo3flood/brute/brutecombatform_longmove10.wav",
	"vj_halo3flood/brute/brutecombatform_longmove12.wav",
	"vj_halo3flood/brute/brutecombatform_longmove13.wav",
	"vj_halo3flood/brute/brutecombatform_longmove14.wav",
	"vj_halo3flood/brute/brutecombatform_longmove15.wav",
	"vj_halo3flood/brute/brutecombatform_longmove16.wav",
	"vj_halo3flood/brute/brutecombatform_longmove17.wav",
	"vj_halo3flood/brute/brutecombatform_longmove18.wav",
}
ENT.SoundTbl_Idle = {
	"vj_halo3flood/brute/bruteform_idle1.wav",
	"vj_halo3flood/brute/bruteform_idle2.wav",
	"vj_halo3flood/brute/bruteform_idle3.wav",
	"vj_halo3flood/brute/bruteform_idle4.wav",
	"vj_halo3flood/brute/bruteform_idle5.wav",
	"vj_halo3flood/brute/bruteform_idle6.wav",
	"vj_halo3flood/brute/bruteform_idle7.wav",
	"vj_halo3flood/brute/bruteform_idle8.wav",
	"vj_halo3flood/brute/bruteform_idle9.wav",
	"vj_halo3flood/brute/bruteform_idle10.wav",
	"vj_halo3flood/brute/bruteform_idle11.wav",
	"vj_halo3flood/brute/bruteform_idle12.wav",
	"vj_halo3flood/brute/bruteform_idle13.wav",
	"vj_halo3flood/brute/bruteform_idle14.wav",
	"vj_halo3flood/brute/bruteform_idle15.wav",
	"vj_halo3flood/brute/bruteform_idle16.wav",
	"vj_halo3flood/brute/bruteform_idle17.wav",
}

ENT.SoundTbl_CombatIdle = {
	"vj_halo3flood/brute/combat/125.wav",
	"vj_halo3flood/brute/combat/126.wav",
	"vj_halo3flood/brute/combat/127.wav",
	"vj_halo3flood/brute/combat/130.wav",
	"vj_halo3flood/brute/combat/131.wav",
	"vj_halo3flood/brute/combat/132.wav",
	"vj_halo3flood/brute/combat/135.wav",
	"vj_halo3flood/brute/combat/145.wav",
	"vj_halo3flood/brute/combat/146.wav",
	"vj_halo3flood/brute/combat/147.wav",
	"vj_halo3flood/brute/combat/148.wav",
	"vj_halo3flood/brute/combat/15.wav",
	"vj_halo3flood/brute/combat/19.wav",
	"vj_halo3flood/brute/combat/21.wav",
	"vj_halo3flood/brute/combat/30.wav",
	"vj_halo3flood/brute/combat/38.wav",
	"vj_halo3flood/brute/combat/59.wav",
	"vj_halo3flood/brute/combat/60.wav",
	"vj_halo3flood/brute/combat/93.wav",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_halo3flood/brute/melee/137.wav",
	"vj_halo3flood/brute/melee/138.wav",
	"vj_halo3flood/brute/melee/139.wav",
	"vj_halo3flood/brute/melee/26.wav",
	"vj_halo3flood/brute/melee/27.wav",
	"vj_halo3flood/brute/melee/41.wav",
	"vj_halo3flood/brute/melee/42.wav",
	"vj_halo3flood/brute/melee/43.wav",
}
ENT.SoundTbl_Pain = {
	"vj_halo3flood/brute/pain/111.wav",
	"vj_halo3flood/brute/pain/113.wav",
	"vj_halo3flood/brute/pain/115.wav",
	"vj_halo3flood/brute/pain/140.wav",
	"vj_halo3flood/brute/pain/141.wav",
	"vj_halo3flood/brute/pain/142.wav",
	"vj_halo3flood/brute/pain/188.wav",
	"vj_halo3flood/brute/pain/189.wav",
	"vj_halo3flood/brute/pain/194.wav",
	"vj_halo3flood/brute/pain/195.wav",
	"vj_halo3flood/brute/pain/196.wav",
	"vj_halo3flood/brute/pain/197.wav",
}
ENT.SoundTbl_Death = {
	"vj_halo3flood/brute/bruteform_body_destroyed1.wav",
	"vj_halo3flood/brute/bruteform_body_destroyed2.wav",
	"vj_halo3flood/brute/bruteform_body_destroyed3.wav",
	"vj_halo3flood/brute/bruteform_body_destroyed4.wav",
	"vj_halo3flood/brute/bruteform_body_destroyed5.wav",
	"vj_halo3flood/brute/bruteform_body_destroyed6.wav",
	"vj_halo3flood/brute/bruteform_body_destroyed7.wav",
	"vj_halo3flood/brute/bruteform_body_destroyed8.wav",
	"vj_halo3flood/brute/bruteform_body_destroyed9.wav",
	"vj_halo3flood/brute/bruteform_body_destroyed10.wav",
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
ENT.SoundTbl_Assimilation = {
	"vj_halo3flood/brute/brutefloodmorph_arrival1.wav",
	"vj_halo3flood/brute/brutefloodmorph_arrival2.wav",
	"vj_halo3flood/brute/brutefloodmorph_arrival3.wav"
}

ENT.SpawnableWeapons = {
	"weapon_vj_halo_plasmapistol",
	"weapon_vj_halo_plasmarifle",
	"weapon_vj_halo_spiker",
	"weapon_vj_halo_spiker",
	"weapon_vj_halo_spiker"
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "event_mattack" then
		self.HasMeleeAttackKnockBack = false
		self.MeleeAttackDamage = 41
		self.MeleeAttackDamageDistance = 130
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
function ENT:CustomInit()
	self:SetCollisionBounds(Vector(21,21,75),Vector(-21,-21,0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if self.VJ_EnhancedFlood then
		dmginfo:ScaleDamage(self.VJ_Flood_DamageResistance)
	else
		dmginfo:ScaleDamage(0.75)
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/