AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/cpthazama/halo3/flood_human.mdl" -- Leave empty if using more than one model
ENT.StartHealth = 125

ENT.HullType = HULL_HUMAN
ENT.EntitiesToNoCollide = {"npc_vj_flood_infection"}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_FLOOD","CLASS_PARASITE"}

ENT.BloodColor = "Yellow"
ENT.CustomBlood_Particle = {"cpt_blood_flood","cpt_blood_flood","cpt_blood_flood","vj_impact1_red"} -- Particle that the SNPC spawns when it's damaged

ENT.HasMeleeAttack = true
ENT.MeleeAttackDistance = 105
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1,ACT_MELEE_ATTACK2}
ENT.TimeUntilMeleeAttackDamage = false
ENT.MeleeAttackDamageType = DMG_SLASH
ENT.MeleeAttackAnimationFaceEnemy = false

ENT.HasMeleeAttackKnockBack = false
ENT.MeleeAttackKnockBack_Forward1 = 350
ENT.MeleeAttackKnockBack_Forward2 = 450
ENT.MeleeAttackKnockBack_Up1 = 220
ENT.MeleeAttackKnockBack_Up2 = 220
ENT.MeleeAttackKnockBack_Right1 = 0
ENT.MeleeAttackKnockBack_Right2 = 0

ENT.VJC_Data = {
    CameraMode = 2, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
    ThirdP_Offset = Vector(0, 0, 0), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(2, 0, 5), -- The offset for the controller when the camera is in first person
}

local jUp = 1200
local jDown = 2000
ENT.MaxJumpLegalDistance = VJ_Set(jUp,jDown)

ENT.HasFootStepSound = false

ENT.HasLeapAttack = true
ENT.AnimTbl_LeapAttack = {ACT_GLIDE}
ENT.LeapAttackAnimationFaceEnemy = true
ENT.LeapDistance = 600
ENT.LeapToMeleeDistance = 400
ENT.TimeUntilLeapAttackDamage = 0.1
ENT.NextLeapAttackTime_DoRand = 10
ENT.NextLeapAttackTime = 5
ENT.NextAnyAttackTime_Leap = 0.1
ENT.LeapAttackVelocityForward = 15
ENT.LeapAttackVelocityUp = 400
ENT.LeapAttackDamage = 65
ENT.LeapAttackDamageDistance = 50

ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = {ACT_DIESIMPLE,ACT_DIE_LEFTSIDE,ACT_DIE_RIGHTSIDE}
ENT.DeathAnimationChance = 5

ENT.SoundTbl_MeleeAttackMiss = {
	"vj_halo3flood/shared/melee_swish1.wav",
	"vj_halo3flood/shared/melee_swish3.wav",
	"vj_halo3flood/shared/melee_swish5.wav",
	"vj_halo3flood/shared/melee_swish6.wav",
	"vj_halo3flood/shared/melee_swish7.wav",
	"vj_halo3flood/shared/melee_swish8.wav",
}
ENT.SoundTbl_Impact = {
	"vj_halo3flood/damage01.mp3",
	"vj_halo3flood/damage02.mp3",
	"vj_halo3flood/damage03.mp3",
}
ENT.SoundTbl_Assimilation = {"vj_halo3flood/combatform/reanimation_ground_human.wav","vj_halo3flood/combatform/reanimation_human.wav"}

ENT.Not_Finished = true
ENT.NextAllyKilledT = 0
ENT.CanSpawnWithWeapon = tobool(GetConVarNumber("vj_halo_useweps"))
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
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
	if key == "event_mattack" then
		self.HasMeleeAttackKnockBack = false
		self.MeleeAttackDamage = 19
		self.MeleeAttackDamageDistance = 120
		self:MeleeAttackCode()
		
	end
	if key == "event_pattack" then
		self.HasMeleeAttackKnockBack = true
		self.MeleeAttackDamage = 12
		self.MeleeAttackDamageDistance = 120
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInitialize()
	self:SetCollisionBounds(Vector(15,15,60),Vector(-15,-15,0))
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_JUMP))
	
	if #self.SoundTbl_Idle <= 0 then -- Fix stupid GMod shit
		self:HumanSounds()
	end

	self:SpawnWithWeapons()

	self.CanChaseWeapon = false
	self.ChaseWeapon = NULL
	self.DidWeaponAttackAimParameter = false
	self.NextCanWalkT = CurTime() +math.Rand(5,8)
	self.ResetWalkT = CurTime()
	self.tbl_Muffins = {}

	if self.CustomInit then self:CustomInit() end

	timer.Simple(GetConVarNumber("vj_halo_developmenttime"),function()
		if IsValid(self) then
			local flood = ents.Create("npc_vj_flood_carrier")
			flood:SetPos(self:GetPos())
			flood:SetAngles(self:GetAngles())
			flood:Spawn()
			flood:Activate()
			undo.ReplaceEntity(self,flood)
			for i = 0, self:GetBoneCount() -1 do
				ParticleEffect("cpt_blood_flood",self:GetBonePosition(i),Angle(0,0,0),nil)
				sound.Play(VJ_PICKRANDOMTABLE({"vj_gib/gibbing1.wav","vj_gib/gibbing2.wav","vj_gib/gibbing3.wav"}),self:GetBonePosition(i),50,100 *GetConVarNumber("host_timescale"))
			end
			self:Remove()
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SpawnWithWeapons()
	if self.CanSpawnWithWeapon then
		timer.Simple(0.001,function()
			if IsValid(self) then
				if !IsValid(self:GetActiveWeapon()) && math.random(1,3) == 1 then
					self:Give(VJ_PICKRANDOMTABLE(self.SpawnableWeapons))
				end
				if IsValid(self:GetActiveWeapon()) && GetConVarNumber("vj_halo_unlimitedammo") == 1 then
					self:GetActiveWeapon().Primary.TakeAmmo = 0
					self.MaxAmmo = true
				end
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HumanSounds()
	self.SpawnableWeapons = {
		"weapon_vj_halo_br",
		"weapon_vj_halo_br",
		"weapon_vj_halo_br",
		"weapon_vj_halo_br",
		"weapon_vj_halo_shotgun",
		"weapon_vj_halo_shotgun",
		"weapon_vj_halo_shotgun",
		"weapon_vj_halo_smg",
		"weapon_vj_halo_smg",
		"weapon_vj_halo_rpg"
	}

	self.SoundTbl_Idle = {"vj_halo3flood/vo/invsgt10.mp3","vj_halo3flood/vo/invsgt1.mp3","vj_halo3flood/vo/invsgt2.mp3","vj_halo3flood/vo/invsgt5.mp3","vj_halo3flood/vo/invsgt6.mp3","vj_halo3flood/vo/invsgt8.mp3","vj_halo3flood/vo/invsgt9.mp3","vj_halo3flood/vo/invsgt_fail1.mp3","vj_halo3flood/vo/invsgt_fail10.mp3","vj_halo3flood/vo/invsgt_fail2.mp3","vj_halo3flood/vo/invsgt_fail3.mp3","vj_halo3flood/vo/invsgt_fail5.mp3","vj_halo3flood/vo/invsgt_fail7.mp3","vj_halo3flood/vo/invsgt_fail8.mp3","vj_halo3flood/vo/invsgt_fail9.mp3","vj_halo3flood/combatform/pain1.wav","vj_halo3flood/combatform/pain2.wav","vj_halo3flood/combatform/pain3.wav","vj_halo3flood/combatform/pain4.wav","vj_halo3flood/combatform/pain5.wav","vj_halo3flood/combatform/pain6.wav","vj_halo3flood/combatform/pain7.wav","vj_halo3flood/combatform/pain8.wav","vj_halo3flood/combatform/pain9.wav","vj_halo3flood/combatform/pain10.wav","vj_halo3flood/combatform/pain11.wav","vj_halo3flood/combatform/pain12.wav","vj_halo3flood/combatform/pain13.wav","vj_halo3flood/combatform/pain14.wav","vj_halo3flood/combatform/pain15.wav","vj_halo3flood/combatform/pain16.wav","vj_halo3flood/combatform/pain17.wav"}
	self.SoundTbl_FootStep = {
		"vj_halo3flood/combatform/humanform_longmove1.wav",
		"vj_halo3flood/combatform/humanform_longmove2.wav",
		"vj_halo3flood/combatform/humanform_longmove3.wav",
		"vj_halo3flood/combatform/humanform_longmove4.wav",
		"vj_halo3flood/combatform/humanform_longmove5.wav",
		"vj_halo3flood/combatform/humanform_longmove6.wav",
		"vj_halo3flood/combatform/humanform_longmove7.wav",
		"vj_halo3flood/combatform/humanform_longmove8.wav",
		"vj_halo3flood/combatform/humanform_longmove9.wav",
		"vj_halo3flood/combatform/humanform_longmove10.wav",
		"vj_halo3flood/combatform/humanform_longmove11.wav",
		"vj_halo3flood/combatform/humanform_longmove12.wav",
		"vj_halo3flood/combatform/humanform_longmove13.wav",
		"vj_halo3flood/combatform/humanform_longmove14.wav",
		"vj_halo3flood/combatform/humanform_longmove15.wav",
	}
	self.SoundTbl_Alert = {
		"vj_halo3flood/combatform/spot1.wav",
		"vj_halo3flood/combatform/scream1.wav",
		"vj_halo3flood/combatform/scream2.wav",
		"vj_halo3flood/combatform/scream3.wav",
		"vj_halo3flood/combatform/scream4.wav",
		"vj_halo3flood/combatform/scream5.wav",
		"vj_halo3flood/combatform/scream6.wav",
		"vj_halo3flood/combatform/scream7.wav",
		"vj_halo3flood/combatform/scream8.wav",
		"vj_halo3flood/combatform/scream9.wav",
		"vj_halo3flood/vo/foundfoe10.mp3",
		"vj_halo3flood/vo/foundfoe11.mp3",
		"vj_halo3flood/vo/foundfoe12.mp3",
		"vj_halo3flood/vo/foundfoe1.mp3",
		"vj_halo3flood/vo/foundfoe2.mp3",
		"vj_halo3flood/vo/foundfoe3.mp3",
		"vj_halo3flood/vo/foundfoe4.mp3",
		"vj_halo3flood/vo/foundfoe5.mp3",
		"vj_halo3flood/vo/foundfoe6.mp3",
		"vj_halo3flood/vo/foundfoe7.mp3",
		"vj_halo3flood/vo/foundfoe8.mp3",
		"vj_halo3flood/vo/foundfoe9.mp3",
	}
	self.SoundTbl_CombatIdle = {
		"vj_halo3flood/vo/thrtn1.mp3",
		"vj_halo3flood/vo/thrtn2.mp3",
		"vj_halo3flood/vo/thrtn3.mp3",
		"vj_halo3flood/vo/thrtn4.mp3",
		"vj_halo3flood/vo/thrtn5.mp3",
		"vj_halo3flood/vo/thrtn6.mp3",
		"vj_halo3flood/vo/thrtn7.mp3",
		"vj_halo3flood/vo/thrtn8.mp3",
		"vj_halo3flood/vo/thrtn9.mp3",
		"vj_halo3flood/vo/thrtn10.mp3",
		"vj_halo3flood/vo/thrtn11.mp3",
		"vj_halo3flood/vo/crs1.mp3",
		"vj_halo3flood/vo/crs2.mp3",
		"vj_halo3flood/vo/crs3.mp3",
		"vj_halo3flood/vo/crs4.mp3",
		"vj_halo3flood/vo/crs5.mp3",
		"vj_halo3flood/vo/crs6.mp3",
		"vj_halo3flood/vo/crs7.mp3",
		"vj_halo3flood/vo/strk11.mp3",
		"vj_halo3flood/vo/strk10.mp3",
		"vj_halo3flood/vo/strk1.mp3",
		"vj_halo3flood/vo/strk2.mp3",
		"vj_halo3flood/vo/strk3.mp3",
		"vj_halo3flood/vo/strk4.mp3",
		"vj_halo3flood/vo/strk5.mp3",
		"vj_halo3flood/vo/strk6.mp3",
		"vj_halo3flood/vo/strk7.mp3",
		"vj_halo3flood/vo/strk8.mp3",
		"vj_halo3flood/vo/strk9.mp3",
		"vj_halo3flood/vo/seefoe1.mp3",
		"vj_halo3flood/vo/seefoe2.mp3",
		"vj_halo3flood/vo/seefoe3.mp3",
		"vj_halo3flood/vo/seefoe4.mp3",
		"vj_halo3flood/vo/seefoe5.mp3",
		"vj_halo3flood/vo/seefoe6.mp3",
		"vj_halo3flood/vo/seefoe7.mp3",
		"vj_halo3flood/vo/seefoe8.mp3",
	}
	self.SoundTbl_CallForHelp = {
		"vj_halo3flood/vo/newordr_charge1.mp3",
		"vj_halo3flood/vo/newordr_charge2.mp3",
		"vj_halo3flood/vo/newordr_charge3.mp3",
		"vj_halo3flood/vo/newordr_charge4.mp3",
	}
	self.SoundTbl_OnKilledEnemy = {
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
	self.SoundTbl_AllyDeath = {
		"vj_halo3flood/vo/lmnt_deadally1.mp3",
		"vj_halo3flood/vo/lmnt_deadally3.mp3",
		"vj_halo3flood/vo/lmnt_deadally4.mp3",
		"vj_halo3flood/vo/lmnt_deadally5.mp3",
		"vj_halo3flood/vo/lmnt_deadally6.mp3",
		"vj_halo3flood/vo/lmnt_deadally7.mp3",
	}
	self.SoundTbl_BeforeMeleeAttack = {"vj_halo3flood/combatform/attack1.wav","vj_halo3flood/combatform/attack2.wav","vj_halo3flood/combatform/attack3.wav","vj_halo3flood/combatform/attack4.wav","vj_halo3flood/combatform/attack5.wav","vj_halo3flood/combatform/attack6.wav"}
	self.SoundTbl_Pain = {"vj_halo3flood/vo/dth_hdsht2.mp3","vj_halo3flood/vo/dth_hdsht3.mp3","vj_halo3flood/vo/dth_hdsht4.mp3","vj_halo3flood/vo/dth_hdsth1.mp3","vj_halo3flood/combatform/pain1.wav","vj_halo3flood/combatform/pain2.wav","vj_halo3flood/combatform/pain3.wav","vj_halo3flood/combatform/pain4.wav","vj_halo3flood/combatform/pain5.wav","vj_halo3flood/combatform/pain6.wav","vj_halo3flood/combatform/pain7.wav","vj_halo3flood/combatform/pain8.wav","vj_halo3flood/combatform/pain9.wav","vj_halo3flood/combatform/pain10.wav","vj_halo3flood/combatform/pain11.wav","vj_halo3flood/combatform/pain12.wav","vj_halo3flood/combatform/pain13.wav","vj_halo3flood/combatform/pain14.wav","vj_halo3flood/combatform/pain15.wav","vj_halo3flood/combatform/pain16.wav","vj_halo3flood/combatform/pain17.wav"}
	self.SoundTbl_Death = {"vj_halo3flood/combatform/death1.wav","vj_halo3flood/combatform/death2.wav","vj_halo3flood/combatform/death3.wav","vj_halo3flood/combatform/death4wav","vj_halo3flood/combatform/death5.wav","vj_halo3flood/combatform/death6.wav","vj_halo3flood/combatform/death7.wav","vj_halo3flood/combatform/death8.wav","vj_halo3flood/combatform/death9.wav","vj_halo3flood/combatform/death10.wav","vj_halo3flood/combatform/death11.wav","vj_halo3flood/combatform/death12.wav"}
end
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
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	
	VJ_EmitSound(self,"vj_halo3flood/explode0" .. math.random(1,2) .. ".mp3",85)
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.AdjustedValues = false
function ENT:BonemergeEditor()
	if IsValid(self.Bonemerge) && !self.AdjustedValues then
		self.HasDeathRagdoll = false
		self.GibOnDeathDamagesTable = {"All"}
		local mdl = self.Bonemerge
		self:ManipulateBoneAngles(15,Angle(0,-50,180)) -- Neck
		self:ManipulateBoneAngles(32,Angle(0,0,90)) -- Right Hand
		self:ManipulateBoneAngles(1,Angle(0,0,0)) -- Left Thigh
		self:ManipulateBoneAngles(2,Angle(0,0,0)) -- Left Calf
		self:ManipulateBoneAngles(3,Angle(10,50,180)) -- Left Foot
		self:ManipulateBoneAngles(7,Angle(0,0,0)) -- Right Thigh
		self:ManipulateBoneAngles(8,Angle(0,0,0)) -- Right Calf
		self:ManipulateBoneAngles(9,Angle(10,50,180)) -- Right Foot

		local clav = 0
		self:ManipulateBonePosition(15,Vector(-2,0,0)) -- Neck
		self:ManipulateBonePosition(44,Vector(-2,-1,0)) -- Spine2
		self:ManipulateBonePosition(45,Vector(-4,0,0)) -- Spine1
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CreateMuffins()
	if GetConVarNumber("vj_halo_muffins") == 0 then return end
	for i = 1,self:GetBoneCount() -1 do
		local tbl = {
			"models/cpthazama/halo3fl/flood_muffin_large.mdl",
			"models/cpthazama/halo3fl/flood_muffin_medium.mdl",
			"models/cpthazama/halo3fl/flood_muffin_small.mdl",
		}
		if math.random(1,8) == 1 then
			if SERVER then
				local mmdl = VJ_PICKRANDOMTABLE(tbl)
				local muf = ents.Create("prop_vj_animatable")
				local bonepos,boneang = self:GetBonePosition(i)
				muf:SetModel(mmdl)
				muf:SetPos(bonepos)
				muf:SetAngles(boneang)
				muf:Spawn()
				muf:SetOwner(self)
				muf:SetModelScale(0,0)
				muf:SetModelScale(math.Rand(0.7,1),math.random(1,3))
				self:DeleteOnRemove(muf)
				ParticleEffect("cpt_blood_flood",self:GetBonePosition(i),Angle(0,0,0),nil)
				self.tbl_Muffins[i] = muf
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local function CreateEnemyMuffins(ent,npc,ragdoll)
	if GetConVarNumber("vj_halo_muffins") == 0 then return end
	for i = 1,ent:GetBoneCount() -1 do
		local tbl = {
			"models/cpthazama/halo3fl/flood_muffin_large.mdl",
			"models/cpthazama/halo3fl/flood_muffin_medium.mdl",
			"models/cpthazama/halo3fl/flood_muffin_small.mdl",
		}
		if math.random(1,8) == 1 then
			if SERVER then
				if !ragdoll then
					local mmdl = VJ_PICKRANDOMTABLE(tbl)
					local muf = ents.Create("prop_vj_animatable")
					local bonepos,boneang = ent:GetBonePosition(i)
					muf:SetModel(mmdl)
					muf:SetPos(bonepos)
					muf:SetAngles(boneang)
					muf:Spawn()
					muf:SetModelScale(0,0)
					muf:SetModelScale(math.Rand(0.9,1.5),math.random(20,40))
					ent:DeleteOnRemove(muf)
				end
				ParticleEffect("cpt_blood_flood",ent:GetBonePosition(i),Angle(0,0,0),nil)
				if !ragdoll then
					if ent.tbl_EnemyMuffins == nil then
						ent.tbl_EnemyMuffins = {}
					end
					ent.tbl_EnemyMuffins[i] = muf
				end
			end
		end
	end
	npc:MuffinFollowCode(ent)
	local deaths
	if ent:IsPlayer() then
		deaths = ent:Deaths()
	end
	timer.Simple(math.random(30,60),function()
		if IsValid(ent) then
			if ent:IsPlayer() then
				if ent:Deaths() > deaths then
					return
				end
			end
			if ent:GetClass() == "prop_ragdoll" then
				local form = "Soldier"
				if ent:GetModel() == "models/cpthazama/halo3/flood_brute.mdl" then
					form = "Brute"
				elseif ent:GetModel() == "models/cpthazama/halo3/flood_elite.mdl" then
					form = "Elite"
				end
				VJ_FloodInfectCorpse(form,ent,nil,ent)
				return
			end
			if ent:IsPlayer() then
				ent:Kill()
			else
				ent:SetHealth(0)
				ent:TakeDamage(999999999,ent,ent)
			end
			VJ_CreateFloodForm(ent,ent)
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_Muffins()
	if table.Count(self.tbl_Muffins) > 0 then
		if SERVER then
			self:MuffinFollowCode(self)
			for bone,muf in pairs(self.tbl_Muffins) do
				if IsValid(muf) && math.random(1,900) == 1 then
					ParticleEffect("cpt_blood_flood_dust",muf:GetPos(),muf:GetAngles(),nil)
					if math.random(1,4) == 1 then
						self:MuffinInfection(muf)
					end
				end
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.InfectableHL2Models = {"alyx.mdl","combine_super_soldier.mdl","poison.mdl","classic.mdl","police.mdl","combine_soldier_prisonguard.mdl","combine_soldier.mdl","barney.mdl","breen.mdl","eli.mdl","gman.mdl","gman_high.mdl","kleiner.mdl","odessa.mdl","monk.mdl","female_01.mdl","female_01_bloody.mdl","female_02.mdl","female_02_bloody.mdl","female_03.mdl","female_03_bloody.mdl","female_04.mdl","female_04_bloody.mdl","female_06.mdl","female_06_bloody.mdl","female_07.mdl","female_07_bloody.mdl","male_01.mdl","male_01_bloody.mdl","male_02.mdl","male_02_bloody.mdl","male_03.mdl","male_03_bloody.mdl","male_04.mdl","male_04_bloody.mdl","male_05.mdl","male_05_bloody.mdl","male_06.mdl","male_06_bloody.mdl","male_07.mdl","male_07_bloody.mdl","male_08.mdl","male_08_bloody.mdl","male_09.mdl","male_09_bloody.mdl","male_cheaple.mdl","mossman.mdl"}
function ENT:MuffinInfection(muf)
	if GetConVarNumber("vj_halo_muffins") == 0 then return end
	for _,v in ipairs(ents.FindInSphere(muf:GetPos(),500)) do
		if IsValid(v) && self:Visible(v) then
			if v:IsNPC() && v != self && self:Disposition(v) != D_LI && v.VJ_IsMuffinInfected != true then
				if v.VJ_NPC_Class && table.HasValue(v.VJ_NPC_Class,"CLASS_FLOOD") then return end
				if v.VJ_IsMuffinInfected == true then return end
				v.VJ_IsMuffinInfected = true
				CreateEnemyMuffins(v,self)
			end
			if v:IsPlayer() && GetConVarNumber("ai_ignoreplayers") == 0 && v:Armor() < 25 && self:Disposition(v) != D_LI && v.VJ_IsMuffinInfected != true then
				if v.VJ_NoTarget == true then return end
				if v.VJ_IsMuffinInfected == true then return end
				v.VJ_IsMuffinInfected = true
				CreateEnemyMuffins(v,self)
			end
			if (v:GetClass() == "prop_ragdoll" && v.IsVJBaseCorpse == true) or (v:GetClass() == "prop_physics" && v.IsVJBaseCorpse == true) || (v:GetClass() == "prop_ragdoll" && table.HasValue(self.InfectableHL2Models,string.GetFileFromFilename(v:GetModel()))) then
				if v.VJ_IsMuffinInfected == true then return end
				v.VJ_IsMuffinInfected = true
				CreateEnemyMuffins(v,self,true)
			end
		end
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
function ENT:ForceMeleeAttack()
	if !self:CanDoCertainAttack("MeleeAttack") then return end
	self.MeleeAttacking = true
	self.RangeAttacking = false
	self.AlreadyDoneMeleeAttackFirstHit = false
	self.IsAbleToMeleeAttack = false
	self.AlreadyDoneFirstMeleeAttack = false
	self:CustomOnMeleeAttack_BeforeStartTimer()
	timer.Simple(self.BeforeMeleeAttackSounds_WaitTime,function() if IsValid(self) then self:PlaySoundSystem("BeforeMeleeAttack") end end)
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
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if self.VJ_EnhancedFlood then
		dmginfo:ScaleDamage(self.VJ_Flood_DamageResistance)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Weapon_ShotsSinceLastReload = 0
ENT.AllowWeaponReloading = false
ENT.NextWepCheckT = 1
ENT.WeaponSpread = 1
function ENT:CustomOnThink()
	if self.Dead then return end
	self:GravemindSpeak()
	if self.FloodControl then self:FloodControl() end
	self:CustomOnThink_Muffins()
	self:BonemergeEditor()

	if self.LeapAttacking && !self.MeleeAttacking && !self:IsOnGround() && self:GetActivity() != ACT_GLIDE then
		self:StartEngineTask(GetTaskList("TASK_SET_ACTIVITY"),ACT_GLIDE)
		self:MaintainActivity()
	end
	if self:GetActivity() == ACT_GLIDE && !self.LeapAttacking && !self.MeleeAttacking && self:IsOnGround() then
		self:StartEngineTask(GetTaskList("TASK_SET_ACTIVITY"),ACT_LAND)
	end
	self.HasPoseParameterLooking = IsValid(self:GetActiveWeapon())
	if !self.HasPoseParameterLooking then -- Mkay
		self:SetPoseParameter("aim_pitch",0)
		self:SetPoseParameter("aim_yaw",0)
	end

	if self.VJ_EnhancedFlood then
		if self.MeleeAttacking then
			self:SetPlaybackRate(self.VJ_Flood_SpeedBoost)
		else
			self:SetPlaybackRate(1)
		end
	end

	local idle = ACT_IDLE
	local walk = ACT_WALK
	local run = ACT_RUN
	local wep = self:GetActiveWeapon()
	if IsValid(wep) then
		if self.MaxAmmo then
			wep:SetClip1(wep:GetMaxClip1())
		end
		idle = ACT_IDLE_STIMULATED
		walk = ACT_WALK_STIMULATED
		run = ACT_RUN_STIMULATED
		if !self.VJ_IsBeingControlled then
			self.ConstantlyFaceEnemy = true
			self.ConstantlyFaceEnemy_IfVisible = true
			self.ConstantlyFaceEnemy_Postures = "Moving"
			self.ConstantlyFaceEnemyDistance = 3000
		end
	else
		if !self.VJ_IsBeingControlled then
			self.ConstantlyFaceEnemy = false
			if IsValid(self:GetEnemy()) && !self:IsUnreachable(self:GetEnemy()) then
				self.ConstantlyFaceEnemy = true
				self.ConstantlyFaceEnemy_IfVisible = true
				self.ConstantlyFaceEnemy_Postures = "Both"
				self.ConstantlyFaceEnemyDistance = 8000
			end
		end
	end
	if self.CurrentAttackAnimation == ACT_MELEE_ATTACK1 || self.CurrentAttackAnimation == ACT_MELEE_ATTACK2 then
		self.MeleeAttackDamageAngleRadius = 100
	elseif self.CurrentAttackAnimation == ACT_GESTURE_MELEE_ATTACK1 then
		self.MeleeAttackDamageAngleRadius = -100
	end
	if self.OnThink then self:OnThink(self:GetEnemy(),wep) end
	if IsValid(self:GetEnemy()) then
		local enemy = self:GetEnemy()
		local dist = self:VJ_GetNearestPointToEntityDistance(enemy)
		if !self.VJ_IsBeingControlled && IsValid(self:GetActiveWeapon()) && self:Visible(enemy) then
			if dist <= 1200 && dist > 400 then
				run = ACT_WALK_STIMULATED
			else
				run = ACT_RUN_STIMULATED
			end
		end
		if !self:IsBehindMe(enemy,self.MeleeAttackAngleRadius) then
			self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1,ACT_MELEE_ATTACK2}
		elseif self:IsBehindMe(enemy,self.MeleeAttackAngleRadius) && dist <= self.MeleeAttackDamageDistance then
			self.AnimTbl_MeleeAttack = {ACT_GESTURE_MELEE_ATTACK1}
			-- if !self.VJ_IsBeingControlled then
				self:ForceMeleeAttack()
			-- end
		end
	end
	if !self.VJ_IsBeingControlled then
		self.HasLeapAttack = !(CurTime() < self.ResetWalkT)
	else
		self.HasLeapAttack = true
	end
	if CurTime() < self.ResetWalkT && !self.VJ_IsBeingControlled then
		self.NextCanWalkT = CurTime() +math.Rand(5,16)
		run = walk
	end
	if CurTime() > self.NextCanWalkT && math.random(1,100) == 1 then
		self.ResetWalkT = CurTime() +math.Rand(6,20)
	end
	self.AnimTbl_IdleStand = {idle}
	self.AnimTbl_Walk = {walk}
	self.AnimTbl_Run = {run}
	if GetConVarNumber("vj_halo_useweps") == 1 then
		if IsValid(self:GetActiveWeapon()) then
			self.CanChaseWeapon = false
			local wep = self:GetActiveWeapon()
			if GetConVarNumber("vj_halo_unlimitedammo") == 0 && wep:Clip1() <= 0 then
				if SERVER then
					local fakewep = ents.Create("prop_physics")
					fakewep:SetModel(wep:GetModel())
					fakewep:SetPos(wep:GetPos())
					fakewep:SetAngles(wep:GetAngles())
					fakewep:Spawn()
					fakewep:SetCollisionGroup(1)
					local phys = fakewep:GetPhysicsObject()
					if IsValid(phys) then fakewep:SetVelocity(fakewep:GetForward() *150 +fakewep:GetRight() *math.Rand(100,-100) +fakewep:GetUp() *50) end
					timer.Simple(10,function() if IsValid(fakewep) then fakewep:Remove() end end)
				end
				wep:Remove()
				self.Weapon_ShotsSinceLastReload = 0
				self.Weapon_StartingAmmoAmount = 0
			end
			if self.VJ_IsBeingControlled && self.VJ_TheController:KeyDown(IN_ATTACK2) then
				if CurTime() > wep.NPC_NextPrimaryFireT then
					wep:PrimaryAttack()
					wep.NPC_NextPrimaryFireT = CurTime() + wep.NPC_NextPrimaryFire
					for tk, tv in ipairs(wep.NPC_TimeUntilFireExtraTimers) do
						timer.Simple(tv, function() if IsValid(self) && IsValid(wep) then wep:PrimaryAttack() end end)
					end
				end
			end
			if !self.VJ_IsBeingControlled && IsValid(self:GetEnemy()) then
				if self.MeleeAttacking then return end
				local enemy = self:GetEnemy()
				local dist = self:GetPos():Distance(enemy:GetPos())
				if dist <= 3000 && enemy:Visible(self) && (self:GetForward():Dot((self:GetEnemy():GetPos() -self:GetPos()):GetNormalized()) > math.cos(math.rad(self.MeleeAttackAngleRadius -15))) then
					if CurTime() > wep.NPC_NextPrimaryFireT then
						wep:PrimaryAttack()
						wep.NPC_NextPrimaryFireT = CurTime() + wep.NPC_NextPrimaryFire
						for tk, tv in ipairs(wep.NPC_TimeUntilFireExtraTimers) do
							timer.Simple(tv, function() if IsValid(self) && IsValid(wep) && IsValid(enemy) && dist <= 3000 && enemy:Visible(self) && (self:GetForward():Dot((enemy:GetPos() -self:GetPos()):GetNormalized()) > math.cos(math.rad(self.MeleeAttackAngleRadius -15))) then wep:PrimaryAttack() end end)
						end
					end
				end
			end
			return
		else
			if !self.CanChaseWeapon && CurTime() > self.NextWepCheckT then
				/*if IsValid(self:GetEnemy()) && self:GetPos():Distance(self:GetEnemy():GetPos()) >= 500 then*/
					for _,v in ipairs(ents.FindInSphere(self:GetPos(),450)) do
						if IsValid(v) && v.IsVJBaseWeapon && !IsValid(v:GetOwner()) then
							self.CanChaseWeapon = true
							self.ChaseWeapon = v
							break
						end
					end
				/*end*/
				self.NextWepCheckT = CurTime() +5
			end
			if self.CanChaseWeapon then
				if !IsValid(self.ChaseWeapon) then self.CanChaseWeapon = false; self.ChaseWeapon = NULL return end
				self:SetLastPosition(self.ChaseWeapon:GetPos())
				self:VJ_TASK_GOTO_LASTPOS("TASK_RUN_PATH")
				if self:GetPos():Distance(self.ChaseWeapon:GetPos()) <= 70 then
					self:Give(self.ChaseWeapon:GetClass())
					self.ChaseWeapon:Remove()
					self.CanChaseWeapon = false
				end
			end
		end
	end
	-- if IsValid(self:GetEnemy()) then
		-- local enemy = self:GetEnemy()
		-- local dist = self:GetPos():Distance(enemy:GetPos())
		-- if dist >= 1000 && enemy:Visible(self) then
			-- self.AnimTbl_Run = {ACT_WALK}
		-- elseif dist >= 1000 && !enemy:Visible(self) then
			-- self.AnimTbl_Run = {ACT_RUN}
		-- elseif dist < 1000 then
			-- self.AnimTbl_Run = {ACT_RUN}
		-- end
	-- end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
	-- if IsValid(self.Bonemerge) then
		-- GetCorpse:VJ_CreateBoneMerge(GetCorpse,self.Bonemerge:GetModel(),self.Bonemerge:GetSkin())
	-- end
	GetCorpse.IsFloodModel = true
	if IsValid(self:GetActiveWeapon()) then
		local wep = ents.Create(self:GetActiveWeapon():GetClass())
		wep:SetPos(self:GetActiveWeapon():GetPos())
		wep:SetAngles(self:GetActiveWeapon():GetAngles())
		wep:Spawn()
		wep:SetClip1(self:GetActiveWeapon():Clip1())
		self:GetActiveWeapon():Remove()
	end
	if self.Not_Finished == false then return end
	if math.random(1,4) == 1 then
		local class = self:GetClass()
		timer.Simple(math.random(5,25),function()
			if IsValid(GetCorpse) then
				local flood = ents.Create(class)
				flood:SetPos(GetCorpse:GetPos())
				flood:SetAngles(GetCorpse:GetAngles())
				flood:Spawn()
				flood:Activate()
				undo.ReplaceEntity(self,flood)
				flood:SetHealth(math.random(12,37))
				if GetCorpse:IsOnFire() then flood:Ignite(5,0) end
				flood:SetNoDraw(true)
				flood:VJ_ACT_PLAYACTIVITY(ACT_ROLL_LEFT,true,1.2,false)
				timer.Simple(0.33,function()
					if IsValid(flood) then
						flood.Not_Finished = false
						flood:SetNoDraw(false)
						if GetCorpse:IsValid() then
							GetCorpse:Remove()
						end
					end
				end)
			end
		end)
	end
	GetCorpse.BloodEffect = self.CustomBlood_Particle
	local hookName = "VJ_Halo3Flood_CorpseBlood_" .. GetCorpse:EntIndex()
	hook.Add("EntityTakeDamage",hookName,function(ent,dmginfo)
		if !IsValid(GetCorpse) then
			hook.Remove("EntityTakeDamage",hookName)
		end
		if ent == GetCorpse then
			local attacker = dmginfo:GetAttacker()
			if GetCorpse.BloodEffect then
				for _,i in ipairs(GetCorpse.BloodEffect) do
					sound.Play("physics/flesh/flesh_impact_bullet"..math.random(1,3)..".wav",dmginfo:GetDamagePosition(),60,100)
					ParticleEffect(i,dmginfo:GetDamagePosition(),Angle(math.random(0,360),math.random(0,360),math.random(0,360)),nil)
				end
			end
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Camo(set)
	if set then
		self:SetMaterial("models/cpthazama/halo3/cloak")
		self.VJ_NoTarget = true
		self:DrawShadow(false)
		if IsValid(self:GetActiveWeapon()) then
			self:GetActiveWeapon():DrawShadow(false)
			self:GetActiveWeapon():SetMaterial("models/cpthazama/halo3/cloak")
		end
		for _, x in ipairs(ents.GetAll()) do
			if (x:GetClass() != self:GetClass() && x:GetClass() != "npc_grenade_frag") && x:IsNPC() && self:Visible(x) then
				x:AddEntityRelationship(self,D_NU,99)
				if x.IsVJBaseSNPC == true then
					x.MyEnemy = NULL
					x:SetEnemy(NULL)
					x:ClearEnemyMemory()
				end
				if VJ_HasValue(self.NPCTbl_Combine,x:GetClass()) or VJ_HasValue(self.NPCTbl_Resistance,x:GetClass()) then
					x:VJ_SetSchedule(SCHED_RUN_RANDOM)
					x:SetEnemy(NULL)
					x:ClearEnemyMemory()
				end
			end
		end
	else
		self:SetMaterial(" ")
		self.VJ_NoTarget = false
		self:DrawShadow(true)
		if IsValid(self:GetActiveWeapon()) then
			self:GetActiveWeapon():DrawShadow(true)
			self:GetActiveWeapon():SetMaterial(" ")
		end
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/