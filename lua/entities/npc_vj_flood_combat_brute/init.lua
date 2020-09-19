AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/cpthazama/halo3/flood_brute.mdl" -- Leave empty if using more than one model
ENT.StartHealth = 275
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
ENT.EntitiesToNoCollide = {"npc_vj_flood_infection"}
ENT.MeleeAttackAnimationFaceEnemy = false
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_FLOOD","CLASS_PARASITE"}
ENT.BloodColor = "Yellow"
ENT.CustomBlood_Particle = {"cpt_blood_flood","cpt_blood_flood","cpt_blood_flood","vj_impact1_purple"}

ENT.VJC_Data = {
    CameraMode = 2, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
    ThirdP_Offset = Vector(0, 0, 0), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "corpse_head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(2, 0, 4), -- The offset for the controller when the camera is in first person
}

ENT.MeleeAttackDistance = 105
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1,ACT_MELEE_ATTACK2} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.HasFootStepSound = false -- Should the SNPC make a footstep sound when it's moving?

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
-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_MeleeAttackMiss = {
	"vj_halo3flood/shared/melee_swish1.wav",
	"vj_halo3flood/shared/melee_swish3.wav",
	"vj_halo3flood/shared/melee_swish5.wav",
	"vj_halo3flood/shared/melee_swish6.wav",
	"vj_halo3flood/shared/melee_swish7.wav",
	"vj_halo3flood/shared/melee_swish8.wav",
}
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
ENT.SoundTbl_OnAllyDeath = {
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
ENT.SoundTbl_Impact = {
	"vj_halo3flood/damage01.mp3",
	"vj_halo3flood/damage02.mp3",
	"vj_halo3flood/damage03.mp3",
}
ENT.Not_Finished = true -- Can it come back to life randomly?
ENT.ArmDestroyed = false
ENT.InfectionDestroyed = false
ENT.CanSpawnWithWeapon = tobool(GetConVarNumber("vj_halo_useweps"))
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
	
	VJ_EmitSound(self,"vj_halo3flood/explode0" .. math.random(1,2) .. ".mp3",85)
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "event_mattack" then
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
function ENT:CustomInitialize()
	self.tbl_Muffins = {}
	self.bodyparts = {
		-- ["2"] = {Hitgroup = {2}, Health = 50, Bodygroup = 2, Gib = "models/predatorcz/halo/flood/elite.PMD/a_bbody.mdl", IsDead = false}, // Torso
		-- ["5"] = {Hitgroup = {5}, Health = 50, Bodygroup = 8, Gib = "models/predatorcz/halo/flood/shared.PMD/limb1.mdl", IsDead = false}, // Right Arm
		-- ["4"] = {Hitgroup = {4}, Health = 50, Bodygroup = 9, Gib = "models/predatorcz/halo/flood/shared.PMD/limb2.mdl", IsDead = false} // Left Arm
	}
	self:SetCollisionBounds(Vector(21,21,75),Vector(-21,-21,0))
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_JUMP)) // No animations for this but these guys jump all over so this will allow them to get out of those positions
	timer.Simple(GetConVarNumber("vj_halo_developmenttime") +50,function()
		if self:IsValid() then
			local flood = ents.Create("npc_vj_flood_carrier")
			flood:SetPos(self:GetPos())
			flood:SetAngles(self:GetAngles())
			flood:Spawn()
			flood:Activate()
			undo.ReplaceEntity(self,flood)
			for i = 0, self:GetBoneCount() -1 do
				ParticleEffect("blood_impact_green_01_chunk",self:GetBonePosition(i),Angle(0,0,0),nil)
				sound.Play(VJ_PICKRANDOMTABLE({"vj_gib/gibbing1.wav","vj_gib/gibbing2.wav","vj_gib/gibbing3.wav"}),self:GetBonePosition(i),50,100 *GetConVarNumber("host_timescale"))
			end
			for i = 0, flood:GetBoneCount() -1 do
				ParticleEffect("GrubSquashBlood",flood:GetBonePosition(i),Angle(0,0,0),nil)
			end
			self:Remove()
		end
	end)
	self.CanChaseWeapon = false
	self.ChaseWeapon = NULL
	if self.CanSpawnWithWeapon then
		local vCOVWep = {
			"weapon_vj_halo_needler",
			-- "weapon_vj_halo_plasma",
			"weapon_vj_halo_plasmapistol",
			"weapon_vj_halo_plasmarifle",
			"weapon_vj_halo_spiker",
			"weapon_vj_halo_spiker",
			"weapon_vj_halo_spiker"
		}
		timer.Simple(0.001,function()
			if IsValid(self) then
				if !IsValid(self:GetActiveWeapon()) && math.random(1,3) == 1 then
					self:Give(VJ_PICKRANDOMTABLE(vCOVWep))
				end
				if IsValid(self:GetActiveWeapon()) && GetConVarNumber("vj_halo_unlimitedammo") == 1 then
					self:GetActiveWeapon().Primary.TakeAmmo = 0
				end
			end
		end)
	end
	self.NextCanWalkT = CurTime() +math.Rand(5,8)
	self.ResetWalkT = CurTime()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if self.VJ_EnhancedFlood then
		dmginfo:ScaleDamage(self.VJ_Flood_DamageResistance)
	else
		dmginfo:ScaleDamage(0.75)
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
function ENT:CustomOnThink()
	self:CustomOnThink_Muffins()
	self:GravemindSpeak()
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
local iWalk = ACT_WALK
local iRun = ACT_RUN
ENT.NextRunAwayCheckT = 0
ENT.Weapon_ShotsSinceLastReload = 0
ENT.AllowWeaponReloading = false
ENT.NextWepCheckT = 1
ENT.WeaponSpread = 1
function ENT:CustomOnThink_AIEnabled()
	if self.LeapAttacking && !self.MeleeAttacking && !self:IsOnGround() && self:GetActivity() != ACT_GLIDE then
		self:StartEngineTask(GetTaskList("TASK_SET_ACTIVITY"),ACT_GLIDE)
		self:MaintainActivity()
	end
	if self:GetActivity() == ACT_GLIDE && !self.LeapAttacking && self:IsOnGround() then
		self:StartEngineTask(GetTaskList("TASK_SET_ACTIVITY"),ACT_LAND)
	end
	if self.VJ_EnhancedFlood then
		if self.MeleeAttacking then
			self:SetPlaybackRate(self.VJ_Flood_SpeedBoost)
		else
			self:SetPlaybackRate(1)
		end
	end

	self.HasPoseParameterLooking = IsValid(self:GetActiveWeapon())

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
			if IsValid(self:GetEnemy()) && !self:IsUnreachable(self:GetEnemy()) then
				self.ConstantlyFaceEnemy = true
				self.ConstantlyFaceEnemy_IfVisible = true
				self.ConstantlyFaceEnemy_Postures = "Both"
				self.ConstantlyFaceEnemyDistance = 8000
			end
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
	-- if self.CurrentAttackAnimation == ACT_MELEE_ATTACK1 || self.CurrentAttackAnimation == ACT_MELEE_ATTACK2 then
		-- self.MeleeAttackDamageAngleRadius = 100
	-- elseif self.CurrentAttackAnimation == ACT_GESTURE_MELEE_ATTACK1 then
		-- self.MeleeAttackDamageAngleRadius = -100
	-- end
	self.AnimTbl_IdleStand = {idle}
	self.AnimTbl_Walk = {walk}
	self.AnimTbl_Run = {run}
	if IsValid(self:GetEnemy()) then
		local enemy = self:GetEnemy()
		local dist = self:VJ_GetNearestPointToEntityDistance(enemy)
		if !self:IsBehindMe(enemy,self.MeleeAttackAngleRadius) then
			if !self:IsMoving() then
				self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
			else
				self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2}
			end
		elseif self:IsBehindMe(enemy,self.MeleeAttackAngleRadius) && dist <= self.MeleeAttackDamageDistance then
			self.AnimTbl_MeleeAttack = {ACT_GESTURE_MELEE_ATTACK1}
			-- if !self.VJ_IsBeingControlled then
				self:ForceMeleeAttack()
			-- end
		end
	end
	-- self.NextMeleeAttackTime = VJ_GetSequenceDuration(self,self.CurrentAttackAnimation)
	-- self.NextAnyAttackTime_Melee = VJ_GetSequenceDuration(self,self.CurrentAttackAnimation)
	if GetConVarNumber("vj_halo_useweps") == 1 && !self.RArmDestroyed then
		if IsValid(self:GetActiveWeapon()) then
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
end
--------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CanDoWeaponAttack()
	if self:VJ_HasActiveWeapon() == false then return false end
	if self.AllowWeaponReloading == true && wep:Clip1() <= 0 then
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
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
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
		timer.Simple(math.random(5,25),function()
			if IsValid(GetCorpse) then
				local flood = ents.Create("npc_vj_flood_combat_brute")
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
						GetCorpse:Remove()
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
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/