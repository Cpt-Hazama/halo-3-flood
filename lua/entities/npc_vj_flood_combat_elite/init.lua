AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/cpthazama/halo3/flood_elite.mdl" -- Leave empty if using more than one model
ENT.StartHealth = 200
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
ENT.EntitiesToNoCollide = {"npc_vj_flood_infection"}
ENT.MeleeAttackAnimationFaceEnemy = false
ENT.CanUseCamouflage = true
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_FLOOD","CLASS_PARASITE"}
ENT.BloodColor = "Yellow"
ENT.CustomBlood_Particle = {"cpt_blood_flood","cpt_blood_flood","cpt_blood_flood","vj_impact1_purple"}

ENT.MeleeAttackDistance = 120
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
// I am too lazy to port my own CE voices
ENT.SoundTbl_Assimilation = {"vj_floodce/shared/death8.mp3"}
ENT.Not_Finished = true -- Can it come back to life randomly?
ENT.ArmDestroyed = false
ENT.InfectionDestroyed = false
ENT.CanSpawnWithWeapon = true
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
	return true
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
	timer.Simple(math.Rand(40,60),function()
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
function ENT:CustomInitialize()
	self.tbl_Muffins = {}
	self.bodyparts = {
		-- ["2"] = {Hitgroup = {2}, Health = 50, Bodygroup = 2, Gib = "models/predatorcz/halo/flood/elite.PMD/a_bbody.mdl", IsDead = false}, // Torso
		-- ["5"] = {Hitgroup = {5}, Health = 50, Bodygroup = 8, Gib = "models/predatorcz/halo/flood/shared.PMD/limb1.mdl", IsDead = false}, // Right Arm
		-- ["4"] = {Hitgroup = {4}, Health = 50, Bodygroup = 9, Gib = "models/predatorcz/halo/flood/shared.PMD/limb2.mdl", IsDead = false} // Left Arm
	}
	self:SetCollisionBounds(Vector(24,24,90),Vector(-24,-24,0))
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
	if self.CanSpawnWithWeapon then
		local vCOVWep = {
			"weapon_vj_halo_needler",
			-- "weapon_vj_halo_plasma",
			"weapon_vj_halo_plasmapistol",
			"weapon_vj_halo_plasmarifle"
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
	self.CanChaseWeapon = false
	self.ChaseWeapon = NULL
	self.HasShield = false
	self.ShieldHealth = 50
	if math.random(1,3) == 1 then
		self.HasShield = true
	end
	self.HasCamo = false
	self.NextCamoT = CurTime()
	self.CamoMeter = 100
	self.IsUsingCamo = false
	if self.CanUseCamouflage then
		if math.random(1,9) == 1 then
			self.HasCamo = true
		end
	end
	self:SetSkin(math.random(0,6))
	-- self:SetColor(Color(math.random(0,255),math.random(0,255),math.random(0,255)))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse) GetCorpse.IsFloodModel = true end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "event_mattack" then
		self.MeleeAttackDamage = 26
		self.MeleeAttackDamageDistance = 180
		self:MeleeAttackCode()
		
	end
	if key == "event_pattack" then
		self.HasMeleeAttackKnockBack = true
		self.MeleeAttackDamage = 15
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
	if key == "event_emit step" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if self.HasShield then
		local dmg = dmginfo:GetDamage()
		if SERVER then
			if IsValid(self.esm) then return end
			self.efm = ents.Create("vj_halo_effect_manager")
			self.efm:SetEffectTime(1)
			self.efm:SetEffectedEntity(self)
			self.efm:SetEffectType("effect_tesla")
			self.efm:Spawn()
			self:DeleteOnRemove(self.efm)
		end
		local sdmg = math.Round(dmg -(dmg *0.4))
		if sdmg <= 0 then
			sdmg = 1
		end
		dmginfo:SetDamage(1)
		self.ShieldHealth = self.ShieldHealth -sdmg
		if self.ShieldHealth <= 0 then
			self.HasShield = false
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_OnBleed(dmginfo,hitgroup)
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
function ENT:CustomOnThink()
	self:CustomOnThink_Muffins()
	self:GravemindSpeak()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FloodControl()
	local ply = self.VJ_TheController
	local ent = self.VJ_TheControllerBullseye
	local lmb = cont:KeyDown(IN_ATTACK)
	local rmb = cont:KeyDown(IN_ATTACK2)
	local space = cont:KeyDown(IN_JUMP)
	local alt = cont:KeyDown(IN_WALK)
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
---------------------------------------------------------------------------------------------------------------------------------------------
local iWalk = ACT_WALK
local iRun = ACT_RUN
ENT.NextRunAwayCheckT = 0
ENT.Weapon_ShotsSinceLastReload = 0
ENT.AllowWeaponReloading = false
ENT.NextWepCheckT = 1
ENT.WeaponSpread = 1
function ENT:CustomOnThink_AIEnabled()
	if self:GetSequenceName(self:GetSequence()) == "overlay" && self:GetVelocity().z < 0 then
		self:StartEngineTask(GetTaskID("TASK_SET_ACTIVITY"),ACT_JUMP)
		self:MaintainActivity()
	end
	self.Bleeds = not self.HasShield
	if IsValid(self:GetActiveWeapon()) then
		self.AnimTbl_IdleStand = {ACT_IDLE_STIMULATED}
		self.AnimTbl_Walk = {ACT_WALK_STIMULATED}
		self.AnimTbl_Run = {ACT_RUN_STIMULATED}
		if !self.VJ_IsBeingControlled then
			self.ConstantlyFaceEnemy = true
			self.ConstantlyFaceEnemy_IfVisible = true
			self.ConstantlyFaceEnemy_Postures = "Moving"
			self.ConstantlyFaceEnemyDistance = 3000
		end
	else
		self.AnimTbl_IdleStand = {ACT_IDLE}
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_Run = {ACT_RUN}
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
				end
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
	-- self.NextMeleeAttackTime = VJ_GetSequenceDuration(self,self.CurrentAttackAnimation)
	-- self.NextAnyAttackTime_Melee = VJ_GetSequenceDuration(self,self.CurrentAttackAnimation)
	if GetConVarNumber("vj_halo_useweps") == 1 && !self.RArmDestroyed then
		if IsValid(self:GetActiveWeapon()) then
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
				local flood = ents.Create("npc_vj_flood_combat_elite")
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
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/