AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/cpthazama/halo3/flood_human.mdl" -- Leave empty if using more than one model
ENT.StartHealth = 125
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
ENT.CanSpawnWithWeapon = tobool(GetConVarNumber("vj_halo_useweps"))
ENT.EntitiesToNoCollide = {"npc_vj_flood_infection"}
ENT.MeleeAttackAnimationFaceEnemy = false
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_FLOOD","CLASS_PARASITE"}
ENT.BloodColor = "Yellow"
ENT.CustomBlood_Particle = {"cpt_blood_flood","cpt_blood_flood","cpt_blood_flood","vj_impact1_red"} -- Particle that the SNPC spawns when it's damaged

ENT.MeleeAttackDistance = 105
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1,ACT_MELEE_ATTACK2} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage

ENT.HasMeleeAttackKnockBack = false -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 350 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 450 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackKnockBack_Up1 = 220 -- How far it will push you up | First in math.random
ENT.MeleeAttackKnockBack_Up2 = 220 -- How far it will push you up | Second in math.random
ENT.MeleeAttackKnockBack_Right1 = 0 -- How far it will push you right | First in math.random
ENT.MeleeAttackKnockBack_Right2 = 0 -- How far it will push you right | Second in math.random

local jUp = 1200
local jDown = 2000
ENT.MaxJumpLegalDistance = VJ_Set(jUp,jDown)

ENT.HasFootStepSound = false -- Should the SNPC make a footstep sound when it's moving?

ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.AnimTbl_LeapAttack = {ACT_GLIDE} -- Melee Attack Animations
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

ENT.UsesBoneAngle = true
ENT.UsesDamageForceOnDeath = true
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {ACT_DIESIMPLE,ACT_DIE_LEFTSIDE,ACT_DIE_RIGHTSIDE} -- Death Animations
ENT.DeathAnimationChance = 5 -- Put 1 if you want it to play the animation all the time
-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Idle = {"vj_halo3flood/vo/invsgt10.mp3","vj_halo3flood/vo/invsgt1.mp3","vj_halo3flood/vo/invsgt2.mp3","vj_halo3flood/vo/invsgt5.mp3","vj_halo3flood/vo/invsgt6.mp3","vj_halo3flood/vo/invsgt8.mp3","vj_halo3flood/vo/invsgt9.mp3","vj_halo3flood/vo/invsgt_fail1.mp3","vj_halo3flood/vo/invsgt_fail10.mp3","vj_halo3flood/vo/invsgt_fail2.mp3","vj_halo3flood/vo/invsgt_fail3.mp3","vj_halo3flood/vo/invsgt_fail5.mp3","vj_halo3flood/vo/invsgt_fail7.mp3","vj_halo3flood/vo/invsgt_fail8.mp3","vj_halo3flood/vo/invsgt_fail9.mp3","vj_halo3flood/combatform/pain1.wav","vj_halo3flood/combatform/pain2.wav","vj_halo3flood/combatform/pain3.wav","vj_halo3flood/combatform/pain4.wav","vj_halo3flood/combatform/pain5.wav","vj_halo3flood/combatform/pain6.wav","vj_halo3flood/combatform/pain7.wav","vj_halo3flood/combatform/pain8.wav","vj_halo3flood/combatform/pain9.wav","vj_halo3flood/combatform/pain10.wav","vj_halo3flood/combatform/pain11.wav","vj_halo3flood/combatform/pain12.wav","vj_halo3flood/combatform/pain13.wav","vj_halo3flood/combatform/pain14.wav","vj_halo3flood/combatform/pain15.wav","vj_halo3flood/combatform/pain16.wav","vj_halo3flood/combatform/pain17.wav"}
ENT.SoundTbl_FootStep = {
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
ENT.SoundTbl_Alert = {
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
ENT.SoundTbl_CombatIdle = {
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
ENT.SoundTbl_OnAllyDeath = {
	"vj_halo3flood/vo/lmnt_deadally1.mp3",
	"vj_halo3flood/vo/lmnt_deadally3.mp3",
	"vj_halo3flood/vo/lmnt_deadally4.mp3",
	"vj_halo3flood/vo/lmnt_deadally5.mp3",
	"vj_halo3flood/vo/lmnt_deadally6.mp3",
	"vj_halo3flood/vo/lmnt_deadally7.mp3",
}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_halo3flood/combatform/attack1.wav","vj_halo3flood/combatform/attack2.wav","vj_halo3flood/combatform/attack3.wav","vj_halo3flood/combatform/attack4.wav","vj_halo3flood/combatform/attack5.wav","vj_halo3flood/combatform/attack6.wav"}
ENT.SoundTbl_Pain = {"vj_halo3flood/vo/dth_hdsht2.mp3","vj_halo3flood/vo/dth_hdsht3.mp3","vj_halo3flood/vo/dth_hdsht4.mp3","vj_halo3flood/vo/dth_hdsth1.mp3","vj_halo3flood/combatform/pain1.wav","vj_halo3flood/combatform/pain2.wav","vj_halo3flood/combatform/pain3.wav","vj_halo3flood/combatform/pain4.wav","vj_halo3flood/combatform/pain5.wav","vj_halo3flood/combatform/pain6.wav","vj_halo3flood/combatform/pain7.wav","vj_halo3flood/combatform/pain8.wav","vj_halo3flood/combatform/pain9.wav","vj_halo3flood/combatform/pain10.wav","vj_halo3flood/combatform/pain11.wav","vj_halo3flood/combatform/pain12.wav","vj_halo3flood/combatform/pain13.wav","vj_halo3flood/combatform/pain14.wav","vj_halo3flood/combatform/pain15.wav","vj_halo3flood/combatform/pain16.wav","vj_halo3flood/combatform/pain17.wav"}
ENT.SoundTbl_Death = {"vj_halo3flood/combatform/death1.wav","vj_halo3flood/combatform/death2.wav","vj_halo3flood/combatform/death3.wav","vj_halo3flood/combatform/death4wav","vj_halo3flood/combatform/death5.wav","vj_halo3flood/combatform/death6.wav","vj_halo3flood/combatform/death7.wav","vj_halo3flood/combatform/death8.wav","vj_halo3flood/combatform/death9.wav","vj_halo3flood/combatform/death10.wav","vj_halo3flood/combatform/death11.wav","vj_halo3flood/combatform/death12.wav"}
ENT.SoundTbl_Assimilation = {"vj_halo3flood/combatform/reanimation_ground_human.wav","vj_halo3flood/combatform/reanimation_human.wav"}
ENT.Not_Finished = true -- Can it come back to life randomly?
ENT.ArmDestroyed = false
ENT.InfectionDestroyed = false
ENT.NextAllyKilledT = 0
ENT.IsOverlayed = false
ENT.Overlay = NULL
ENT.OverlayModel = "models/player/kleiner.mdl"
ENT.tbl_FloodBones = {
	["ValveBiped.Bip01_Pelvis"] = "frame pelvis",
	["ValveBiped.Bip01_L_Thigh"] = "frame l_thigh",
	["ValveBiped.Bip01_L_Calf"] = "frame l_calf",
	["ValveBiped.Bip01_L_Foot"] = "frame l_foot",
	["ValveBiped.Bip01_R_Thigh"] = "frame r_thigh",
	["ValveBiped.Bip01_R_Calf"] = "frame r_calf",
	["ValveBiped.Bip01_R_Foot"] = "frame r_foot",
	["ValveBiped.Bip01_Spine"] = "frame spine",
	["ValveBiped.Bip01_Spine1"] = "frame spine1",
	["ValveBiped.Bip01_Head1"] = "frame corpse_head",
	["ValveBiped.forward"] = "frame corpse_jaw",
	["ValveBiped.Bip01_L_Clavicle"] = "frame l_clavicle",
	["ValveBiped.Bip01_L_UpperArm"] = "frame l_upperarm",
	["ValveBiped.Bip01_R_Clavicle"] = "frame r_clavicle",
	["ValveBiped.Bip01_R_UpperArm"] = "frame r_upperarm",
	["ValveBiped.Bip01_R_Forearm"] = "frame r_forearm",
	["ValveBiped.Bip01_R_Hand"] = "ValveBiped.Bip01_R_Hand",
	["ValveBiped.Bip01_R_Finger1"] = "frame r_index1",
	["ValveBiped.Bip01_R_Finger3"] = "frame r_ring1",
	["ValveBiped.Bip01_R_Finger0"] = "frame r_thumb1",
	["ValveBiped.Bip01_L_Forearm"] = "frame l_forearm",
	["ValveBiped.Bip01_L_Hand"] = "ValveBiped.Bip01_L_Hand",
}
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
	return true
end
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
		self.MeleeAttackDamageDistance = 160
		self:MeleeAttackCode()
		
	end
	if key == "event_pattack" then
		self.HasMeleeAttackKnockBack = true
		self.MeleeAttackDamage = 12
		self.MeleeAttackDamageDistance = 160
		self:MeleeAttackCode()
		
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.AdjustedValues = false
function ENT:BonemergeEditor()
	if IsValid(self.Bonemerge) && !self.AdjustedValues then
		self.HasDeathRagdoll = false
		self.GibOnDeathDamagesTable = {"All"}
		-- if tobool(GetConVarNumber("vj_halo_modeladjust")) then
			local mdl = self.Bonemerge
			self:ManipulateBoneAngles(15,Angle(0,-50,180)) -- Neck
			self:ManipulateBoneAngles(32,Angle(0,0,90)) -- Right Hand
			-- self:ManipulateBonePosition(0,Vector(0,0,GetConVarNumber("vj_halo_modeladjustz"))) -- Pelvis
			self:ManipulateBoneAngles(1,Angle(0,0,0)) -- Left Thigh
			self:ManipulateBoneAngles(2,Angle(0,0,0)) -- Left Calf
			self:ManipulateBoneAngles(3,Angle(10,50,180)) -- Left Foot
			self:ManipulateBoneAngles(7,Angle(0,0,0)) -- Right Thigh
			self:ManipulateBoneAngles(8,Angle(0,0,0)) -- Right Calf
			self:ManipulateBoneAngles(9,Angle(10,50,180)) -- Right Foot

			local clav = 0
			self:ManipulateBonePosition(15,Vector(-2,0,0)) -- Neck
			-- self:ManipulateBonePosition(22,Vector(clav,0,0)) -- LClav
			-- self:ManipulateBonePosition(34,Vector(clav,0,0)) -- RClav
			-- self:ManipulateBonePosition(13,Vector(1,-4,0)) -- Spine4
			-- self:ManipulateBonePosition(14,Vector(5,0,0)) -- Spine
			self:ManipulateBonePosition(44,Vector(-2,-1,0)) -- Spine2
			self:ManipulateBonePosition(45,Vector(-4,0,0)) -- Spine1
		-- end
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
				local muf = ents.Create("prop_dynamic")
				local bonepos,boneang = self:GetBonePosition(i)
				muf:SetModel(mmdl)
				muf:SetPos(bonepos)
				muf:SetAngles(boneang)
				muf:Spawn()
				muf:SetOwner(self)
				muf:SetModelScale(0,0)
				muf:SetModelScale(math.Rand(0.9,1.2),math.random(3,6))
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
					local muf = ents.Create("prop_dynamic")
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
	timer.Simple(math.random(40,60),function()
		if IsValid(ent) then
			if ent:IsPlayer() then
				if ent:Deaths() > deaths then
					return
				end
			end
			local flood = ents.Create("npc_vj_flood_combat")
			flood:SetPos(ent:GetPos())
			flood:SetAngles(ent:GetAngles())
			flood.CanSpawnWithWeapon = false
			flood:Spawn()
			flood:Activate()
			flood.CanSpawnWithWeapon = false
			if flood.SoundTbl_BeforeMeleeAttack && type(flood.SoundTbl_BeforeMeleeAttack) == "table" then
				if type(VJ_PICKRANDOMTABLE(flood.SoundTbl_BeforeMeleeAttack)) != "boolean" then
					sound.Play(VJ_PICKRANDOMTABLE(flood.SoundTbl_BeforeMeleeAttack),flood:GetPos(),90,100 *GetConVarNumber("host_timescale"))
				end
			end
			undo.ReplaceEntity(ent,flood)
			for i = 0, ent:GetBoneCount() -1 do
				ParticleEffect("cpt_blood_flood",ent:GetBonePosition(i),Angle(0,0,0),nil)
			end
			if ent.IsVJBaseSNPC == true then
				ent.HasDeathRagdoll = false
			end
			if ent.IsVJBaseSNPC_Human then
				if IsValid(ent:GetActiveWeapon()) then
					flood:Give(ent:GetActiveWeapon():GetClass())
					ent:GetActiveWeapon():Remove()
				end
			end
			if ent && !ent:IsPlayer() then
				ent:Remove()
			elseif ent && ent:IsPlayer() then
				-- ent:Kill()
				-- if IsValid(ent:GetRagdollEntity()) then
					-- ent:GetRagdollEntity():Remove()
				-- end
				for _,v in pairs(ent.tbl_EnemyMuffins) do
					if IsValid(v) then
						v:Remove()
					end
				end
				ent.VJ_IsMuffinInfected = false
				ent.tbl_EnemyMuffins = {}
				npc:VJ_PlayerInfection(flood,ent)
			end
			flood:SetNoDraw(true)
			local time = flood:SequenceDuration(flood:LookupSequence(ACT_GET_UP_STAND))
			timer.Simple(0.02,function()
				if IsValid(flood) then
					flood:SetNoDraw(false)
					flood:CreateMuffins()
					flood:PlayVJFloodAnimation(ACT_GET_UP_STAND,false)
				end
			end)
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_Muffins()
	if table.Count(self.tbl_Muffins) > 0 then
		if SERVER then
			-- for bone,muf in pairs(self.tbl_Muffins) do
				-- if IsValid(muf) then
					-- if muf:GetPos() == self:GetPos() then SafeRemoveEntity(muf) end
					-- local bonepos,boneang = self:GetBonePosition(bone)
					-- muf:SetPos(bonepos)
					-- muf:SetAngles(boneang)
					-- if math.random(1,900) == 1 then
						-- ParticleEffect("cpt_blood_flood_dust",muf:GetPos(),muf:GetAngles(),nil)
						-- if math.random(1,4) == 1 then
							-- self:MuffinInfection(muf)
						-- end
					-- end
				-- end
			-- end
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
local function VJ_FLOOD_ALLY_DEATH(npc,attacker,inflictor)
	if npc.IsVJBaseSNPC == true && npc:GetClass() == "npc_vj_flood_combat" then
		for _,v in ipairs(ents.FindInSphere(npc:GetPos(),1000)) do
			if IsValid(v) && v:IsNPC() && v != npc && v:GetClass() == "npc_vj_flood_combat" then
				v:OnAllyDeathSoundCode()
			end
		end
	end
end
hook.Add("OnNPCKilled","VJ_FLOODALLYDEATH_"..math.Rand(1,9999999),VJ_FLOOD_ALLY_DEATH)
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnAllyDeathSoundCode()
	if self.HasSounds == false then return end
		if CurTime() > self.NextAllyKilledT then
		local randomalertsound = math.random(1,3)
		local soundtbl = self.SoundTbl_OnAllyDeath
		if CustomTbl != nil && #CustomTbl != 0 then soundtbl = CustomTbl end
		if randomalertsound == 1 && VJ_PICKRANDOMTABLE(soundtbl) != false then
			VJ_STOPSOUND(self.CurrentIdleSound)
			self.NextIdleSoundT = self.NextIdleSoundT +7
			self.CurrentAllyKilledSound = VJ_CreateSound(self,soundtbl,78,self:VJ_DecideSoundPitch(90,100))
		end
		self.NextAllyKilledT = CurTime() +math.Rand(6,12)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove() VJ_STOPSOUND(self.CurrentAllyKilledSound) end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInitialize()
	self.tbl_Muffins = {}
	-- self:CreateMuffins()
	self.DidWeaponAttackAimParameter = false
	self.RArmDestroyed = false
	self.bodyparts = {
		["1"] = {Hitgroup = {1}, Health = 1, Bodygroup = 0, Gib = "models/predatorcz/halo/flood/human.PMD/head.mdl", IsDead = false}, // Head
		["2"] = {Hitgroup = {2}, Health = 30, Bodygroup = 2, Gib = "models/predatorcz/halo/flood/shared.PMD/innards2.mdl", IsDead = false}, // Torso
		["5"] = {Hitgroup = {5}, Health = 30, Bodygroup = 3, Gib = "models/predatorcz/halo/flood/humanh3.PMD/rarm.mdl", IsDead = false}, // Right Arm
		["4"] = {Hitgroup = {4}, Health = 30, Bodygroup = 4, Gib = "models/predatorcz/halo/flood/humanh3.PMD/larm.mdl", IsDead = false} // Left Arm
	}
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_JUMP)) // No animations for this but these guys jump all over so this will allow them to get out of those positions
	timer.Simple(GetConVarNumber("vj_halo_developmenttime"),function()
		if self:IsValid() then
			local flood = ents.Create("npc_vj_flood_carrier")
			flood:SetPos(self:GetPos())
			flood:SetAngles(self:GetAngles())
			flood:Spawn()
			flood:Activate()
			undo.ReplaceEntity(self,flood)
			for i = 0, self:GetBoneCount() -1 do
				ParticleEffect("GrubSquashBlood",self:GetBonePosition(i),Angle(0,0,0),nil)
				sound.Play(VJ_PICKRANDOMTABLE({"vj_gib/gibbing1.wav","vj_gib/gibbing2.wav","vj_gib/gibbing3.wav"}),self:GetBonePosition(i),50,100 *GetConVarNumber("host_timescale"))
			end
			for i = 0, flood:GetBoneCount() -1 do
				ParticleEffect("GrubSquashBlood",flood:GetBonePosition(i),Angle(0,0,0),nil)
			end
			self:Remove()
		end
	end)
	if self.CanSpawnWithWeapon then
		local vUNSCWep = {
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
		timer.Simple(0.001,function()
			if IsValid(self) then
				if !IsValid(self:GetActiveWeapon()) && math.random(1,3) == 1 then
					self:Give(VJ_PICKRANDOMTABLE(vUNSCWep))
				end
				if IsValid(self:GetActiveWeapon()) && GetConVarNumber("vj_halo_unlimitedammo") == 1 then
					self:GetActiveWeapon().Primary.TakeAmmo = 0
				end
			end
		end)
	end
	self.CanChaseWeapon = false
	self.ChaseWeapon = NULL
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
	GetCorpse.IsFloodModel = true
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
function ENT:CustomOnThink_Flood()
	if self.IsOverlayed && IsValid(self.Overlay) then
		-- self:SetNoDraw(true)
		local ent = self.Overlay
		ent:SetPos(self:GetPos())
		ent:SetAngles(self:GetAngles())
		for i = 0,ent:GetBoneCount() do
			-- print(ent:GetBoneName(i))
			for bone,fbone in pairs(self.tbl_FloodBones) do
				if ent:GetBoneName(i) == fbone then
					local bonepos,boneang = self:GetBonePosition(i)
					ent:SetBonePosition(i,bonepos,boneang)
				end
			end
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
ENT.Weapon_ShotsSinceLastReload = 0
ENT.AllowWeaponReloading = false
ENT.NextWepCheckT = 1
ENT.WeaponSpread = 1
-- local HASRAN = false
function ENT:CustomOnThink()
	self:GravemindSpeak()
	self:CustomOnThink_Muffins()
	self:CustomOnThink_Flood()
	self:BonemergeEditor()

	if self.Dead then return end
	if self.LeapAttacking && !self.MeleeAttacking && !self:IsOnGround() && self:GetActivity() != ACT_GLIDE then
		self:StartEngineTask(GetTaskList("TASK_SET_ACTIVITY"),ACT_GLIDE)
		self:MaintainActivity()
	end
	if self:GetActivity() == ACT_GLIDE && !self.LeapAttacking && !self.MeleeAttacking && self:IsOnGround() then
		self:StartEngineTask(GetTaskList("TASK_SET_ACTIVITY"),ACT_LAND)
	end
	self.HasPoseParameterLooking = IsValid(self:GetActiveWeapon())
	-- self.NextMeleeAttackTime = VJ_GetSequenceDuration(self,self.CurrentAttackAnimation)
	-- self.NextAnyAttackTime_Melee = VJ_GetSequenceDuration(self,self.CurrentAttackAnimation)
	local idle = ACT_IDLE
	local walk = ACT_WALK
	local run = ACT_RUN
	if IsValid(self:GetActiveWeapon()) then
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
		end
	end
	if self.CurrentAttackAnimation == ACT_MELEE_ATTACK1 || self.CurrentAttackAnimation == ACT_MELEE_ATTACK2 then
		self.MeleeAttackDamageAngleRadius = 100
	elseif self.CurrentAttackAnimation == ACT_GESTURE_MELEE_ATTACK1 then
		self.MeleeAttackDamageAngleRadius = -100
	end
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
	self.AnimTbl_IdleStand = {idle}
	self.AnimTbl_Walk = {walk}
	self.AnimTbl_Run = {run}
	if GetConVarNumber("vj_halo_useweps") == 1 then
		if IsValid(self:GetActiveWeapon()) then
			self.CanChaseWeapon = false
			local wep = self:GetActiveWeapon()
			if GetConVarNumber("vj_halo_unlimitedammo") == 0 && self.Weapon_ShotsSinceLastReload >= self.Weapon_StartingAmmoAmount then
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
--------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CanDoWeaponAttack()
	if self:VJ_HasActiveWeapon() == false then return false end
	if self.AllowWeaponReloading == true && self.Weapon_ShotsSinceLastReload >= self.Weapon_StartingAmmoAmount then
		return false,"NoAmmo"
	end
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:WeaponAimPoseParameters(ResetPoses)
	if (self.HasPoseParameterLooking == false) or (self.VJ_IsBeingControlled == false && self.DoingWeaponAttack == false) then return end
	ResetPoses = ResetPoses or false
	//self:VJ_GetAllPoseParameters(true)
	local ent = NULL
	if self.VJ_IsBeingControlled == true then ent = self.VJ_TheController else ent = self:GetEnemy() end
	local p_enemy = 0 -- Pitch
	local y_enemy = 0 -- Yaw
	local r_enemy = 0 -- Roll
	local ang_dif = math.AngleDifference
	local ang_app = math.ApproachAngle
	if IsValid(ent) && ResetPoses == false then
		local self_pos = self:GetPos() + self:OBBCenter()
		local enemy_pos = false //Vector(0,0,0)
		if self.VJ_IsBeingControlled == true then enemy_pos = self.VJ_TheController:GetEyeTrace().HitPos else enemy_pos = ent:GetPos() + ent:OBBCenter() end
		if enemy_pos == false then return end
		local self_ang = self:GetAngles()
		local enemy_ang = (enemy_pos - self_pos):Angle()
		p_enemy = ang_dif(enemy_ang.p,self_ang.p)
		if self.PoseParameterLooking_InvertPitch == true then p_enemy = -p_enemy end
		y_enemy = ang_dif(enemy_ang.y,self_ang.y)
		if self.PoseParameterLooking_InvertYaw == true then y_enemy = -y_enemy end
		r_enemy = ang_dif(enemy_ang.z,self_ang.z)
		if self.PoseParameterLooking_InvertRoll == true then r_enemy = -r_enemy end
	end
	local names = self.PoseParameterLooking_Names
	for x=1, #names.pitch do
		self:SetPoseParameter(names.pitch[x],ang_app(self:GetPoseParameter(names.pitch[x]),p_enemy,self.PoseParameterLooking_TurningSpeed))
	end
	for x=1, #names.yaw do
		self:SetPoseParameter(names.yaw[x],ang_app(self:GetPoseParameter(names.yaw[x]),y_enemy,self.PoseParameterLooking_TurningSpeed))
	end
	for x=1, #names.roll do
		self:SetPoseParameter(names.roll[x],ang_app(self:GetPoseParameter(names.roll[x]),r_enemy,self.PoseParameterLooking_TurningSpeed))
	end
	self:SetPoseParameter("aim_pitch",ang_app(self:GetPoseParameter("aim_pitch"),p_enemy,self.PoseParameterLooking_TurningSpeed))
	self:SetPoseParameter("head_pitch",ang_app(self:GetPoseParameter("head_pitch"),p_enemy,self.PoseParameterLooking_TurningSpeed))
	self:SetPoseParameter("aim_yaw",ang_app(self:GetPoseParameter("aim_yaw"),y_enemy,self.PoseParameterLooking_TurningSpeed))
	self:SetPoseParameter("head_yaw",ang_app(self:GetPoseParameter("head_yaw"),y_enemy,self.PoseParameterLooking_TurningSpeed))
	self:SetPoseParameter("aim_roll",ang_app(self:GetPoseParameter("aim_roll"),r_enemy,self.PoseParameterLooking_TurningSpeed))
	self:SetPoseParameter("head_roll",ang_app(self:GetPoseParameter("head_roll"),r_enemy,self.PoseParameterLooking_TurningSpeed))
	self.DidWeaponAttackAimParameter = true
end
---------------------------------------------------------------------------------------------------------------------------------------------
-- function ENT:LeapAttackDamageSoundCode(CustomTbl)
	-- self:VJ_ACT_PLAYACTIVITY("vjseq_attack2",false,0,false)
	-- if self.HasSounds == false or self.HasLeapAttackDamageSound == false then return end
	-- local randomleapsound = math.random(1,self.LeapAttackDamageSoundChance)
	-- local soundtbl = self.SoundTbl_LeapAttackDamage
	-- if CustomTbl != nil && #CustomTbl != 0 then soundtbl = CustomTbl end
	-- if randomleapsound == 1 && VJ_PICKRANDOMTABLE(soundtbl) != false then
		-- if self.IdleSounds_PlayOnAttacks == false then VJ_STOPSOUND(self.CurrentIdleSound) end
		-- self.NextIdleSoundT_RegularChange = CurTime() + 1
		-- self.CurrentLeapAttackDamageSound = VJ_CreateSound(self,soundtbl,self.LeapAttackDamageSoundLevel,self:VJ_DecideSoundPitch(self.LeapAttackDamageSoundPitch1,self.LeapAttackDamageSoundPitch2))
	-- end
-- end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
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
		timer.Simple(math.random(5,25),function()
			if IsValid(GetCorpse) then
				local flood = ents.Create("npc_vj_flood_combat")
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
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/