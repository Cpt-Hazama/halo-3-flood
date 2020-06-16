/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Halo 3 Flood SNPCs"
local AddonName = "Halo 3 Flood"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_halo3flood_spawn.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')
	
	-- lua_run local tbl = {} local dir = "vj_halo3flood/floodegg/idle1/" for _,file in pairs(file.Find("sound/" .. dir .. "*","GAME")) do table.insert(tbl,dir .. file) end for _,v in pairs(tbl) do print('"' .. v .. '",') end
	-- lua_run local tbl = {} local dir = "vj_halo3flood/brute/combat/" local keyword = "angry" for _,file in pairs(file.Find("sound/" .. dir .. "*","GAME")) do if string.find(file,keyword) then table.insert(tbl,dir .. file) end end for _,v in pairs(tbl) do print('"' .. v .. '",') end

	VJ_FLOOD_NODEPOS = {}
	
	VJ.AddNPCWeapon("VJ_H3F_BattleRifle","weapon_vj_halo_br")
	VJ.AddNPCWeapon("VJ_H3F_MA5B-CE","weapon_vj_halo_ma5b")
	VJ.AddNPCWeapon("VJ_H3F_Needler-Reach","weapon_vj_halo_needler")
	VJ.AddNPCWeapon("VJ_H3F_PlasmaRifle-CE","weapon_vj_halo_plasma")
	VJ.AddNPCWeapon("VJ_H3F_PlasmaPistol-3","weapon_vj_halo_plasmapistol")
	VJ.AddNPCWeapon("VJ_H3F_PlasmaRifle-3","weapon_vj_halo_plasmarifle")
	VJ.AddNPCWeapon("VJ_H3F_M90-3","weapon_vj_halo_shotgun")
	VJ.AddNPCWeapon("VJ_H3F_SMG-3","weapon_vj_halo_smg")
	VJ.AddNPCWeapon("VJ_H3F_Type25-3","weapon_vj_halo_spiker")
	VJ.AddNPCWeapon("VJ_H3F_M41-SPNKR","weapon_vj_halo_rpg")
	
	local vCat = "Halo 3 Flood"
	VJ.AddCategoryInfo(vCat,{Icon = "vj_icons/halo3_flood.png"})
	VJ.AddNPC("Flood Combat Form","npc_vj_flood_combat",vCat)
	VJ.AddNPC("Flood Carrier Form","npc_vj_flood_carrier",vCat)
	VJ.AddNPC("Flood Infection Form","npc_vj_flood_infection",vCat)
	VJ.AddNPC("Flood Stalker Form","npc_vj_flood_stalker",vCat)
	VJ.AddNPC("Flood Tank Form","npc_vj_flood_tank",vCat)
	VJ.AddNPC("Flood Ranged Form","npc_vj_flood_ranged",vCat)
	VJ.AddNPC("Flood Combat Jiralhanae Form","npc_vj_flood_combat_brute",vCat)
	VJ.AddNPC("Flood Combat Sangheili Form","npc_vj_flood_combat_elite",vCat)
	VJ.AddNPC("Flood Combat Sangheili Form (Camo)","npc_vj_flood_combat_elite_invis",vCat)
	VJ.AddNPC("Flood Spawner","sent_vj_flood_randflood",vCat)
	VJ.AddNPC("Flood Combat Spawner","sent_vj_flood_randcombat",vCat)
	VJ.AddNPC("Pure Flood Spawner","sent_vj_flood_randpureflood",vCat)
	VJ.AddNPC("Flood Infection Spawner","sent_vj_flood_randinfection",vCat)
	VJ.AddNPC("Map Flood Spawner","sent_vj_flood_director",vCat)
	VJ.AddNPC("Flood Egg Sack","npc_vj_flood_egg",vCat)

	// Halo Wars
	VJ.AddNPC("Flood Hive Mind","npc_vj_flood_hivemind",vCat)
	VJ.AddNPC("Flood Mortar","npc_vj_flood_mortar",vCat)

	// Groups
	VJ.AddNPC("Flood Squad Type A","sent_vj_flood_squad_a",vCat)
	VJ.AddNPC("Flood Squad Type B","sent_vj_flood_squad_b",vCat)
	VJ.AddNPC("Flood Squad Type C","sent_vj_flood_squad_c",vCat)
	
	hook.Add("EntityRemoved","VJ_AddNodes_FLOOD",function(ent)
		if ent:GetClass() == "info_node" then
			table.insert(VJ_FLOOD_NODEPOS,ent:GetPos())
		end
	end)

	if SERVER then	
		hook.Add("PlayerDeath","VJ_Halo3Flood_MuffinRemove",function(ply)
			if ply.tbl_EnemyMuffins && #ply.tbl_EnemyMuffins > 0 then
				for _,v in pairs(ply.tbl_EnemyMuffins) do
					if IsValid(v) then
						v:Remove()
					end
				end
			end
			ply.VJ_IsMuffinInfected = false
			ply.VJ_NextPushInfectionOffT = CurTime() +1
			ply.tbl_EnemyMuffins = {}
		end)

		hook.Add("PlayerSpawn","VJ_Halo3Flood_MuffinValues",function(ply)
			if ply.tbl_EnemyMuffins && #ply.tbl_EnemyMuffins > 0 then
				for _,v in pairs(ply.tbl_EnemyMuffins) do
					if IsValid(v) then
						v:Remove()
					end
				end
			end
			ply.VJ_IsMuffinInfected = false
			ply.VJ_NextPushInfectionOffT = CurTime() +1
			ply.tbl_EnemyMuffins = {}
		end)
	end
	
	local NPC = FindMetaTable("NPC")
	local ENT = FindMetaTable("Entity")
	local Phys = FindMetaTable("PhysObj")

	if SERVER then
		hook.Add("OnNPCKilled","VJ_Halo3_BioMass",function(victim,inflictor,attacker)
			if VJ_HasValue(attacker.VJ_NPC_Class,"CLASS_FLOOD") then
				if victim != attacker then
					VJ_AddBioMass()
				end
			end
		end)

		hook.Add("PlayerDeath","VJ_Halo3_BioMass_Player",function(victim,inflictor,attacker)
			if VJ_HasValue(attacker.VJ_NPC_Class,"CLASS_FLOOD") then
				if victim != attacker then
					VJ_AddBioMass()
				end
			end
		end)
	
		function VJ_AddBioMass()
			for _,v in pairs(ents.FindByClass("npc_vj_flood_hivemind")) do
				local amount = math.random(GetConVarNumber("vj_flood_biocost_add_min"),GetConVarNumber("vj_flood_biocost_add_max"))
				v.BioMass = v.BioMass +amount
			end
		end
	
		function VJ_TestYouDied(pos,spawner)
			local struggle = ents.Create("prop_vj_flood_youdied")
			struggle:SetPos(pos)
			struggle:Spawn()
			struggle:VJ_CreateBoneMerge(struggle,spawner:GetModel(),spawner:GetSkin())
		end

		function VJ_FloodEnhanceFX(ent,bEnhance)
			if bEnhance then
				ent.tbl_EnhanceFX = ent.tbl_EnhanceFX or {}
				for i = 1,3 do
					local tendrilGlow = ents.Create("env_sprite")
					tendrilGlow:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
					tendrilGlow:SetKeyValue("scale","0.135")
					tendrilGlow:SetKeyValue("rendermode","5")
					tendrilGlow:SetKeyValue("rendercolor","255 89.25 76.5")
					tendrilGlow:SetKeyValue("spawnflags","1")
					tendrilGlow:SetParent(ent)
					tendrilGlow:Fire("SetParentAttachment","tendril" .. tostring(i),0)
					tendrilGlow:Spawn()
					tendrilGlow:Activate()
					ent:DeleteOnRemove(tendrilGlow)
					table.insert(ent.tbl_EnhanceFX,tendrilGlow)
				end
			else
				if ent.tbl_EnhanceFX then
					for _,v in pairs(ent.tbl_EnhanceFX) do
						v:Remove()
					end
				end
			end
		end

		function VJ_FloodInfectCorpse(form,corpse,animation,infection)
			local flood
			if form == "Soldier" then
				flood = ents.Create("npc_vj_flood_combat")
			elseif form == "Elite" then
				flood = ents.Create("npc_vj_flood_combat_elite")
			elseif form == "Brute" then
				flood = ents.Create("npc_vj_flood_combat_brute")
			end
			local oldModel = corpse:GetModel()
			local oldSkin = corpse:GetSkin()
			local bg = {}
			for i = 0,18 do
				bg[i] = corpse:GetBodygroup(i)
			end
			local shouldKeepSkin = true
			local foundBone = (corpse:LookupBone("ValveBiped.Bip01_Pelvis") != nil)
			ParticleEffect("GrubSquashBlood",infection:GetPos(),Angle(0,0,0),nil)
			ParticleEffect("blood_impact_green_01_chunk",infection:GetPos(),Angle(0,0,0),nil)
			ParticleEffect("cpt_blood_flood",infection:GetPos(),Angle(0,0,0),nil)
			sound.Play("vj_gib/default_gib_splat.wav",infection:GetPos(),70,100 *GetConVarNumber("host_timescale"))
			corpse:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
			infection:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)

			local color = corpse:GetColor()
			flood:VJ_SetClearPos(corpse:GetPos() +corpse:OBBCenter() +Vector(0,0,8))
			flood:SetAngles(corpse:GetAngles())
			flood.CanSpawnWithWeapon = false
			flood:Spawn()
			VJ_AddBioMass()
			undo.ReplaceEntity(infection,flood)
			infection:Remove()
			flood.CanSpawnWithWeapon = false
			flood:CreateMuffins()
			flood:DoChangeMovementType(VJ_MOVETYPE_STATIONARY)
			flood.DisableFindEnemy = true
			flood.DisableSelectSchedule = true
			local cvar = tobool(GetConVarNumber("vj_halo_keepmodel"))
			if form == "Soldier" && cvar && foundBone then
				flood:VJ_CreateBoneMerge(flood,oldModel,oldSkin,bg)
				shouldKeepSkin = false
			end
			sound.Play(VJ_PICKRANDOMTABLE(flood.SoundTbl_Assimilation),flood:GetPos(),90,100 *GetConVarNumber("host_timescale"))
			for i = 0, corpse:GetBoneCount() -1 do
				ParticleEffect("cpt_blood_flood",corpse:GetBonePosition(i),Angle(0,0,0),nil)
			end
			for i = 0, flood:GetBoneCount() -1 do
				ParticleEffect("cpt_blood_flood",flood:GetBonePosition(i),Angle(0,0,0),nil)
			end
			corpse:Remove()
			if shouldKeepSkin then
				flood:SetSkin(oldSkin)
			end
			timer.Simple(0.02,function()
				if IsValid(flood) then
					for i = 1,8 do
						timer.Simple(i *0.2,function()
							if IsValid(flood) then
								for i = 1, flood:GetBoneCount() -1 do
									if math.random(1,7) == 1 then
										ParticleEffect("cpt_blood_flood",flood:GetBonePosition(i),Angle(0,0,0),nil)
										sound.Play(VJ_PICKRANDOMTABLE({"vj_gib/gibbing1.wav","vj_gib/gibbing2.wav","vj_gib/gibbing3.wav"}),flood:GetPos(),50,100 *GetConVarNumber("host_timescale"))
									end
								end
							end
						end)
					end
					local animTime = flood:SequenceDuration(flood:SelectWeightedSequence(ACT_ROLL_RIGHT))
					local animTimeB = flood:SequenceDuration(flood:SelectWeightedSequence(ACT_ROLL_LEFT))
					flood:VJ_ACT_PLAYACTIVITY(ACT_ROLL_RIGHT,true,animTime,false)
					timer.Simple(animTime,function()
						if IsValid(flood) then
							flood:VJ_ACT_PLAYACTIVITY(ACT_ROLL_LEFT,true,animTimeB,false)
						end
					end)
					timer.Simple(animTime +animTimeB,function()
						if IsValid(flood) then
							flood:DoChangeMovementType(VJ_MOVETYPE_GROUND)
							flood.DisableFindEnemy = false
							flood.DisableSelectSchedule = false
						end
					end)
				end
			end)
		end

		function VJ_CreateFloodForm(victim,inflictor)
			VJ_AddBioMass()
			if victim:IsNPC() then
				if victim.GetRagdollEntity && IsValid(victim:GetRagdollEntity()) then
					victim:GetRagdollEntity():Remove()
				end
				victim.VJ_Halo3_IsAlreadyInfected = true
				victim.VJ_IgnoreFloodInfection = true
				-- if GetConVarNumber("ai_serverragdolls") > 0 then
					local findPos = victim:GetPos()
					local findMDL = victim:GetModel()
					timer.Simple(0.01,function()
						for _,v in pairs(ents.FindInSphere(findPos,75)) do
							if v:GetClass() == "prop_ragdoll" && v:GetModel() == findMDL then
								v:Remove()
							end
						end
					end)
				-- end
				local weapon = nil
				if IsValid(victim:GetActiveWeapon()) && victim:GetActiveWeapon().IsVJBaseWeapon then
					weapon = victim:GetActiveWeapon():GetClass()
				end
				local class = "npc_vj_flood_combat"
				local checkForFlood = true
				local time = 0
				local sndTbl = nil
				if victim.InfectionClass then
					class = victim.InfectionClass
				end
				if victim.IsVJBaseSNPC == true then
					victim.HasDeathRagdoll = false
				end
				if victim.SoundTbl_FootStep && #victim.SoundTbl_FootStep > 0 then
					sndTbl = victim.SoundTbl_FootStep
				else
					if victim.DefaultSoundTbl_FootStep then
						sndTbl = victim.DefaultSoundTbl_FootStep
					end
				end
				local oldModel = victim:GetModel()
				local oldSkin = victim:GetSkin()
				local bg = {}
				for i = 0,18 do
					bg[i] = victim:GetBodygroup(i)
				end
				local foundBone = (victim:LookupBone("ValveBiped.Bip01_Pelvis") != nil)
				local switchEnt = inflictor
				local projFix = inflictor.IsHalo3Projectile
				local fixPos = victim:GetPos()
				local fixAng = victim:GetAngles()
				if foundBone then
					local struggle = ents.Create("prop_vj_flood_youdied")
					struggle:SetPos(victim:GetPos())
					struggle:SetAngles(victim:GetAngles())
					struggle:Spawn()
					struggle:VJ_CreateBoneMerge(struggle,oldModel,oldSkin,bg)
					struggle:SetCollisionGroup(1)
					time = struggle.RemoveTime
					undo.ReplaceEntity(inflictor,struggle)
					SafeRemoveEntity(inflictor)
					projFix = false
					switchEnt = struggle
				end
				if victim.MorphAnimation then
					time = victim:DecideAnimationLength(victim.AnimTbl_Death[1],false)
					if switchEnt == inflictor then
						switchEnt = victim
						SafeRemoveEntity(inflictor)
						projFix = false
					end
				end
				timer.Simple(time,function()
					if IsValid(switchEnt) then
						local flood = ents.Create(class)
						flood:SetPos(projFix && fixPos or switchEnt:GetPos())
						flood:SetAngles(projFix && fixAng or switchEnt:GetAngles())
						flood:Spawn()
						flood:SetNoDraw(true)
						if weapon then flood:Give(weapon) end
						undo.ReplaceEntity(switchEnt,flood)
						SafeRemoveEntity(switchEnt)
						local cvar = tobool(GetConVarNumber("vj_halo_keepmodel"))
						if class == "npc_vj_flood_combat" && cvar && foundBone then
							flood:VJ_CreateBoneMerge(flood,oldModel,oldSkin,bg)
							flood.Bonemerge:SetNoDraw(true)
							if sndTbl then
								flood.SoundTbl_FootStep = sndTbl
							end
						end
						timer.Simple(0.1,function()
							if IsValid(flood) then
								flood:SetNoDraw(false)
								if flood.Bonemerge then flood.Bonemerge:SetNoDraw(false) end
							end
						end)
						for i = 0, flood:GetBoneCount() -1 do
							ParticleEffect("cpt_blood_flood",flood:GetBonePosition(i),Angle(0,0,0),nil)
						end
						flood:CreateMuffins()
						flood:DoChangeMovementType(VJ_MOVETYPE_STATIONARY)
						flood.DisableFindEnemy = true
						flood.DisableSelectSchedule = true
						local animTime = flood:SequenceDuration(flood:SelectWeightedSequence(ACT_GET_UP_STAND))
						-- timer.Simple(0.02,function()
							-- if IsValid(flood) then
								flood:VJ_ACT_PLAYACTIVITY(ACT_GET_UP_STAND,true,animTime,false)
								VJ_EmitSound(flood,"vj_halo3flood/combatform/reanimation_ground_human.wav",80,100)
							-- end
						-- end)
						timer.Simple(animTime,function()
							if IsValid(flood) then
								flood:DoChangeMovementType(VJ_MOVETYPE_GROUND)
								flood.DisableFindEnemy = false
								flood.DisableSelectSchedule = false
							end
						end)
					end
				end)
			elseif victim:IsPlayer() then
				if IsValid(victim:GetRagdollEntity()) then
					victim:GetRagdollEntity():Remove()
				end
				local weapon = nil
				if IsValid(victim:GetActiveWeapon()) && victim:GetActiveWeapon().IsVJBaseWeapon then
					weapon = victim:GetActiveWeapon():GetClass()
				end
				local oldModel = victim:GetModel()
				local oldSkin = victim:GetSkin()
				local bg = {}
				for i = 0,18 do
					bg[i] = victim:GetBodygroup(i)
				end
				local foundBone = (victim:LookupBone("ValveBiped.Bip01_Pelvis") != nil)

				local struggle = ents.Create("prop_vj_flood_youdied")
				struggle:SetPos(victim:GetPos())
				struggle:SetAngles(victim:GetAngles())
				struggle:Spawn()
				struggle:VJ_CreateBoneMerge(struggle,oldModel,oldSkin,bg)
				undo.ReplaceEntity(inflictor,struggle)
				SafeRemoveEntity(inflictor)
				timer.Simple(struggle.RemoveTime,function()
					if IsValid(struggle) then
						local flood = ents.Create("npc_vj_flood_combat")
						flood:SetPos(struggle:GetPos())
						flood:SetAngles(struggle:GetAngles())
						flood:Spawn()
						flood:SetNoDraw(true)
						if weapon then flood:Give(weapon) end
						undo.ReplaceEntity(struggle,flood)
						SafeRemoveEntity(struggle)
						local cvar = tobool(GetConVarNumber("vj_halo_keepmodel"))
						if cvar && foundBone then
							flood:VJ_CreateBoneMerge(flood,oldModel,oldSkin,bg)
							flood.Bonemerge:SetNoDraw(true)
						end
						timer.Simple(0.1,function()
							if IsValid(flood) then
								flood:SetNoDraw(false)
								if flood.Bonemerge then flood.Bonemerge:SetNoDraw(false) end
							end
						end)
						for i = 0, flood:GetBoneCount() -1 do
							ParticleEffect("cpt_blood_flood",flood:GetBonePosition(i),Angle(0,0,0),nil)
						end
						flood:CreateMuffins()
						flood:DoChangeMovementType(VJ_MOVETYPE_STATIONARY)
						flood.DisableFindEnemy = true
						flood.DisableSelectSchedule = true
						local animTime = flood:SequenceDuration(flood:SelectWeightedSequence(ACT_GET_UP_STAND))
						timer.Simple(0.02,function()
							if IsValid(flood) then
								flood:VJ_ACT_PLAYACTIVITY(ACT_GET_UP_STAND,true,animTime,false)
								VJ_EmitSound(flood,"vj_halo3flood/combatform/reanimation_ground_human.wav",80,100)
							end
						end)
						timer.Simple(animTime,function()
							if IsValid(flood) then
								flood:DoChangeMovementType(VJ_MOVETYPE_GROUND)
								flood.DisableFindEnemy = false
								flood.DisableSelectSchedule = false
							end
						end)
					end
				end)
			end
		end

		function VJ_FloodInfect(victim,inflictor,attacker,isPlayer)
			if !isPlayer then
				if inflictor.IsHalo3Infection then
					if inflictor == attacker && victim != inflictor then
						if victim.VJ_Halo3_IsAlreadyInfected then return end
						if victim.VJ_IgnoreFloodInfection then return end
						VJ_CreateFloodForm(victim,inflictor)
					end
				end
			else
				if inflictor.IsHalo3Infection then
					if inflictor == attacker && victim != inflictor then
						VJ_CreateFloodForm(victim,inflictor)
					end
				end
			end
		end

		function ENT:VJ_CreateBoneMerge(targEnt,oldModel,oldSkin,bg)
			if targEnt:IsNPC() then
				targEnt:SetModel("models/cpthazama/halo3/flood_human_valve.mdl")
				targEnt:SetCollisionBounds(Vector(15,15,60),Vector(-15,-15,0))
			end
			local body = ents.Create("prop_vj_animatable")
			body:SetModel(oldModel)
			body:SetPos(targEnt:GetPos())
			body:SetAngles(targEnt:GetAngles())
			body.VJ_Owner = targEnt
			function body:Initialize()
				self:AddEffects(EF_BONEMERGE)
				self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
				self:SetOwner(self.VJ_Owner)
			end
			body:Spawn()
			body:SetParent(targEnt)
			body:SetSkin(oldSkin)
			if bg then
				for i = 0,18 do
					body:SetBodygroup(i,bg[i])
				end
			end
			targEnt.Bonemerge = body
		end

		function ENT:MuffinFollowCode(targetEntity)
			local index = "VJ_Halo3Flood_Muffins_" .. self:EntIndex()
			if !IsValid(targetEntity) then
				hook.Remove("Think",index)
				return
			end
			-- if targetEntity:GetClass() == "prop_ragdoll" then
				-- targetEntity = targetEntity:GetPhysicsObject()
			-- end
			local muffins = targetEntity.tbl_EnemyMuffins
			if targetEntity == self then
				muffins = self.tbl_Muffins
			end
			if !muffins then
				hook.Remove("Think",index)
				return
			end
			hook.Add("Think",index,function()
				if !targetEntity:IsValid() then
					hook.Remove("Think",index)
				else
					if muffins then
						for bone,muf in pairs(muffins) do
							if IsValid(muf) then
								if muf:GetPos() == targetEntity:GetPos() then SafeRemoveEntity(muf) end
								local bonepos,boneang = targetEntity:GetBonePosition(bone)
								muf:SetPos(bonepos)
								muf:SetAngles(boneang)
								muf:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
							end
						end
					end
				end
			end)
		end

		function NPC:FloodFollowBone(targetEntity,boneID) -- Credits to Silverlan as I used some of his bone code
			local index = "VJ_Halo3Flood_Bone_" .. self:EntIndex()
			if !targetEntity then
				hook.Remove("Think",index)
				return
			end
			local bonepos,boneang = targetEntity:GetBonePosition(boneID)
			if !bonepos then
				hook.Remove("Think",index)
				return
			end
			local posOffset = (self:GetPos() -bonepos)
			local angOffset = (self:GetAngles() -targetEntity:GetAngles())
			hook.Add("Think",index,function()
				if !targetEntity:IsValid() || !self:IsValid() || IsValid(targetEntity) && targetEntity:Health() <= 0 then
					hook.Remove("Think",index)
				else
					local bonepos,boneang = targetEntity:GetBonePosition(boneID)
					if(bonepos) then
						boneang = targetEntity:GetAngles()
						bonepos = bonepos +posOffset
						boneang = boneang +angOffset
						self:SetPos(bonepos)
						self:SetAngles(boneang)
					end
				end
			end)
		end
	end
	
	function NPC:VJ_BioMass(i)
		for _,v in pairs(ents.GetAll()) do
			if v:GetClass() == "npc_vj_flood_hivemind" then
				v.BioMass = v.BioMass +i
				break
			end
		end
	end
	
	function NPC:PlayVJFloodAnimation(act,face)
		self:VJ_ACT_PLAYACTIVITY(act,true,false,face,0)
	end

	function NPC:GravemindSpeak()
		if !self.VJ_IsBeingControlled then return end
		if self.VJ_Halo_Gravemind == nil then
			self.VJ_Halo_Gravemind = CurTime() -1
		end
		if CurTime() > self.VJ_Halo_Gravemind then
			local lines = {
				"vj_halo3flood/gravemind/050mf_060_grv.wav",
				"vj_halo3flood/gravemind/050mf_070_grv.wav",
				"vj_halo3flood/gravemind/050mf_080_grv.wav",
				"vj_halo3flood/gravemind/050mg_010_grv.wav",
				"vj_halo3flood/gravemind/050mg_020_grv.wav",
				"vj_halo3flood/gravemind/050mg_030_grv.wav",
				"vj_halo3flood/gravemind/050mg_040_grv.wav"
			}
			VJ_EmitSound(self.VJ_TheController,lines,0.1,100)
			self.VJ_Halo_Gravemind = CurTime() +math.Rand(90,150)
		end
	end

	function NPC:VJ_SetClearPos(origin)
		local mins = self:OBBMins()
		local maxs = self:OBBMaxs()
		local pos = origin || self:GetPos()
		local nearents = ents.FindInBox(pos +mins,pos +maxs)
		maxs.x = maxs.x *2
		maxs.y = maxs.y *2
		local zMax = 0
		local entTgt

		for _,ent in ipairs(nearents) do
			if(ent != self && ent:GetSolid() != SOLID_NONE && ent:GetSolid() != SOLID_BSP && gamemode.Call("ShouldCollide",self,ent) != false) then
				local obbMaxs = ent:OBBMaxs()
				if(obbMaxs.z > zMax) then
					zMax = obbMaxs.z
					entTgt = ent
				end
			end
		end

		local tbl_filter = {self,entTgt}
		local stayaway = zMax > 0

		if(!stayaway) then
			pos.z = pos.z +10
		else
			zMax = zMax +10
		end

		local left = Vector(0,1,0)
		local right = left *-1
		local forward = Vector(1,0,0)
		local back = forward *-1

		local trace_left = util.TraceLine({
			start = pos,
			endpos = pos +left *maxs.y,
			filter = tbl_filter
		})

		local trace_right = util.TraceLine({
			start = pos,
			endpos = pos +right *maxs.y,
			filter = tbl_filter
		})

		if(trace_left.Hit || trace_right.Hit) then
			if(trace_left.Fraction < trace_right.Fraction) then
				pos = pos +right *((trace_right.Fraction -trace_left.Fraction) *maxs.y)
			elseif(trace_right.Fraction < trace_left.Fraction) then
				pos = pos +left *((trace_left.Fraction -trace_right.Fraction) *maxs.y)
			end
		elseif(stayaway) then
			pos = pos +(math.random(1,2) == 1 && left || right) *maxs.y *1.8
			stayaway = false
		end

		local trace_forward = util.TraceLine({
			start = pos,
			endpos = pos +forward *maxs.x,
			filter = tbl_filter
		})

		local trace_backward = util.TraceLine({
			start = pos,
			endpos = pos +back *maxs.x,
			filter = tbl_filter
		})

		if(trace_forward.Hit || trace_backward.Hit) then
			if(trace_forward.Fraction < trace_backward.Fraction) then
				pos = pos +back *((trace_backward.Fraction -trace_forward.Fraction) *maxs.x)
			elseif(trace_backward.Fraction < trace_forward.Fraction) then
				pos = pos +forward *((trace_forward.Fraction -trace_backward.Fraction) *maxs.x)
			end
		elseif(stayaway) then
			pos = pos +(math.random(1,2) == 1 && forward || back) *maxs.x *1.8
			stayaway = false
		end

		if(stayaway) then -- We can't avoid whatever it is we're stuck in, let's try to spawn on top of it
			local start = entTgt:GetPos()
			start.z = start.z +zMax
			local endpos = start
			endpos.z = endpos.z +maxs.z

			local tr = util.TraceLine({
				start = start,
				endpos = endpos,
				filter = tbl_filter
			})
		
			if(!tr.Hit || (!tr.HitWorld && gamemode.Call("ShouldCollide",self,tr.Entity) == false)) then
				pos.z = start.z
				stayaway = false
			else -- Just try to move to whatever direction seems best
				local trTgt = trace_left
				if(trace_right.Fraction < trTgt.Fraction) then trTgt = trace_right end
				if(trace_forward.Fraction < trTgt.Fraction) then trTgt = trace_forward end
				if(trace_backward.Fraction < trTgt.Fraction) then trTgt = trace_backward end
				pos = pos +trTgt.Normal *maxs.x
			end
		end
		self:SetPos(pos)
		self:DropToFloor()
	end

	function NPC:VJ_SwitchController(newent,ply)
		if !self.VJ_IsBeingControlled then return end
		local ply = ply or self.VJ_TheController
		self.VJ_TheControllerEntity:StopControlling()
		local SpawnControllerObject = ents.Create("obj_vj_npccontroller")
		SpawnControllerObject.TheController = ply
		SpawnControllerObject:SetControlledNPC(newent)
		SpawnControllerObject:Spawn()
		SpawnControllerObject:StartControlling()
	end
	
	function NPC:VJ_PlayerInfection(newent,ply)
		local SpawnControllerObject = ents.Create("obj_vj_npccontroller")
		SpawnControllerObject.TheController = ply
		SpawnControllerObject:SetControlledNPC(newent)
		SpawnControllerObject:Spawn()
		SpawnControllerObject:StartControlling()
	end

	-- Precache Particles -------------------------------------------------------------------------------------------------------------------------
	game.AddParticles("particles/flood.pcf")
	game.AddParticles("particles/cpt_flood_blood_impact.pcf")
	game.AddParticles("particles/cpt_flood_effects.pcf")
	game.AddParticles("particles/cpt_flood_infection.pcf")
	game.AddParticles("particles/cpt_flood_spores.pcf")
	game.AddParticles("particles/cpt_flood_mortar1.pcf")
	game.AddParticles("particles/cpt_flood_mortar2.pcf")
	game.AddParticles("particles/cpt_flood_shield.pcf") -- Credits to Darken for making, Mayhem for permission to use
	-- f_car_explosion
	-- f_hdyn_chest
	-- f_hydn_chest_chunks
	-- f_inf_chunks
	
	-- Director --
	VJ.AddConVar("vj_flood_director_enabled",1)
	VJ.AddConVar("vj_flood_director_maxci",80)
	VJ.AddConVar("vj_flood_director_mobcount",35)
	VJ.AddConVar("vj_flood_director_spawnmax",2000)
	VJ.AddConVar("vj_flood_director_spawnmin",650)
	VJ.AddConVar("vj_flood_director_mobchance",100)
	VJ.AddConVar("vj_flood_director_mobcooldownmin",120)
	VJ.AddConVar("vj_flood_director_mobcooldownmax",180)
	VJ.AddConVar("vj_flood_director_delaymin",0.85)
	VJ.AddConVar("vj_flood_director_delaymax",3)
	VJ.AddConVar("vj_flood_director_pureonly",0)
	VJ.AddClientConVar("vj_flood_director_music",1)

	if CLIENT then
		hook.Add("PopulateToolMenu", "VJ_ADDTOMENU_FLOODDIR", function()
			spawnmenu.AddToolMenuOption("DrVrej", "SNPC Configures", "Halo 3 Flood - Director", "Halo 3 Flood - Director", "", "", function(Panel)
				if !game.SinglePlayer() then
				if !LocalPlayer():IsAdmin() or !LocalPlayer():IsSuperAdmin() then
					Panel:AddControl( "Label", {Text = "You are not an admin!"})
					Panel:AddControl("Checkbox", {Label = "Enable Music?", Command = "vj_flood_director_music"})
					Panel:ControlHelp("Notice: Only admins can change this settings")
					return
					end
				end
				Panel:AddControl("Label", {Text = "Notice: Only admins can change this settings."})
				Panel:AddControl("Checkbox", {Label = "Enable AI Director processing?", Command = "vj_flood_director_enabled"})
				Panel:AddControl("Checkbox", {Label = "Enable Music?", Command = "vj_flood_director_music"})
				Panel:AddControl("Checkbox", {Label = "Pure Flood Only", Command = "vj_flood_director_pureonly"})
				Panel:AddControl("Slider", { Label 	= "Max Flood", Command = "vj_flood_director_maxci", Type = "Float", Min = "5", Max = "400"})
				Panel:AddControl("Slider", { Label 	= "Min Distance they can spawn from players", Command = "vj_flood_director_spawnmin", Type = "Float", Min = "150", Max = "30000"})
				Panel:AddControl("Slider", { Label 	= "Max Distance they can spawn from players", Command = "vj_flood_director_spawnmax", Type = "Float", Min = "150", Max = "30000"})
				Panel:AddControl("Slider", { Label 	= "Min time between spawns", Command = "vj_flood_director_delaymin", Type = "Float", Min = "0.1", Max = "15"})
				Panel:AddControl("Slider", { Label 	= "Max time between spawns", Command = "vj_flood_director_delaymax", Type = "Float", Min = "0.2", Max = "15"})
				Panel:AddControl("Slider", { Label 	= "Max Mob Flood", Command = "vj_flood_director_mobcount", Type = "Float", Min = "5", Max = "400"})
				Panel:ControlHelp("Must be greater than Max Flood option, otherwise nothing will spawn!")
				Panel:AddControl("Slider", { Label 	= "Chance that a mob will appear", Command = "vj_flood_director_mobchance", Type = "Float", Min = "1", Max = "500"})
				Panel:AddControl("Slider", { Label 	= "Min cooldown time for mob spawns", Command = "vj_flood_director_mobcooldownmin", Type = "Float", Min = "1", Max = "800"})
				Panel:AddControl("Slider", { Label 	= "Max cooldown time for mob spawns", Command = "vj_flood_director_mobcooldownmax", Type = "Float", Min = "1", Max = "800"})
			end, {})
		end)
	end

	-- Menu -------------------------------------------------------------------------------------------------------------------------
	local AddConvars = {}
	AddConvars["vj_halo_infectexplode"] = 0 -- Infection Forms explode?
	AddConvars["vj_halo_developmenttime"] = 500
	AddConvars["vj_halo_useweps"] = 1
	AddConvars["vj_halo_muffins"] = 0
	AddConvars["vj_halo_transform"] = 1
	AddConvars["vj_halo_unlimitedammo"] = 0
	AddConvars["vj_halo_keepmodel"] = 0
	AddConvars["vj_halo_modeladjust"] = 1
	-- AddConvars["vj_halo_modeladjustz"] = 0
	for k, v in pairs(AddConvars) do
		if !ConVarExists( k ) then CreateConVar( k, v, {FCVAR_ARCHIVE} ) end
	end
	
	VJ.AddConVar("vj_flood_biocost_infection",15)
	VJ.AddConVar("vj_flood_biocost_carrier",150)
	VJ.AddConVar("vj_flood_biocost_stalker",200)
	VJ.AddConVar("vj_flood_biocost_ranged",250)
	VJ.AddConVar("vj_flood_biocost_tank",800)
	VJ.AddConVar("vj_flood_biocost_mortar",1000)
	VJ.AddConVar("vj_flood_biocost_add_min",8)
	VJ.AddConVar("vj_flood_biocost_add_max",18)
	VJ.AddConVar("vj_flood_biocost_start",50)
	if (CLIENT) then
		local function VJ_HALOFLOOD_MAIN(Panel)
			if !game.SinglePlayer() then
			if !LocalPlayer():IsAdmin() or !LocalPlayer():IsSuperAdmin() then
				Panel:AddControl( "Label", {Text = "You are not an admin!"})
				Panel:ControlHelp("Notice: Only admins can change this settings.")
				return
				end
			end
			Panel:AddControl( "Label", {Text = "Notice: Only admins can change this settings."})
			local vj_h3freset = {Options = {}, CVars = {}, Label = "Reset Everything:", MenuButton = "0"}
			vj_h3freset.Options["#vjbase.menugeneral.default"] = { 
				vj_halo_infectexplode = "0",
				vj_halo_useweps = "1",
				vj_halo_muffins = "0",
				vj_halo_transform = "1",
				vj_halo_unlimitedammo = "0",
				vj_halo_keepmodel = "0",
				vj_halo_modeladjust = "1",
				vj_halo_modeladjustz = "0",
				vj_flood_biocost_infection = "15",
				vj_flood_biocost_carrier = "150",
				vj_flood_biocost_stalker = "200",
				vj_flood_biocost_ranged = "250",
				vj_flood_biocost_tank = "800",
				vj_flood_biocost_mortar = "1000",
				vj_flood_biocost_add_min = "8",
				vj_flood_biocost_add_max = "18",
				vj_flood_biocost_start = "50",
			}
			Panel:AddControl("ComboBox", vj_h3freset)
			Panel:AddControl("Checkbox", {Label = "Infection Forms explode on attack?", Command = "vj_halo_infectexplode"})
			Panel:ControlHelp("Note: They only explode if the player's armor is greater than 0")
			Panel:AddControl("Checkbox", {Label = "Flood Combat Forms can use weapons?", Command = "vj_halo_useweps"})
			Panel:AddControl("Checkbox", {Label = "Flood Combat Forms can grow muffins?", Command = "vj_halo_muffins"})
			Panel:AddControl("Checkbox", {Label = "Flood Pure Forms can transform?", Command = "vj_halo_transform"})
			Panel:AddControl("Checkbox", {Label = "Flood Combat Forms have unlimited ammo?", Command = "vj_halo_unlimitedammo"})
			Panel:AddControl("Checkbox", {Label = "Infected NPCs/Players keep model?", Command = "vj_halo_keepmodel"})
			Panel:ControlHelp("Note: THIS MAY LOOK WEIRD DUE TO SKELETON DIFFERENCES!")
			Panel:ControlHelp("Note: Will only work on Valve Biped models (I.E. Rebels, Combine, etc. based models)")
			Panel:AddControl("Label",{Text = " "})
			Panel:AddControl("Label",{Text = "Hive Mind Settings:"})
			Panel:AddControl("Slider",{Label="Starting Bio-Mass",Command = "vj_flood_biocost_start",Min = "15",Max = "10000"})
			Panel:AddControl("Slider",{Label="Min. Gain Bio-Mass",Command = "vj_flood_biocost_add_min",Min = "1",Max = "75"})
			Panel:AddControl("Slider",{Label="Max. Gain Bio-Mass",Command = "vj_flood_biocost_add_max",Min = "1",Max = "100"})
			Panel:AddControl("Label",{Text = "Hive Mind Bio-Mass Requirement Settings:"})
			Panel:AddControl("Slider",{Label="Infection Form",Command = "vj_flood_biocost_infection",Min = "0",Max = "5000"})
			Panel:AddControl("Slider",{Label="Carrier Form",Command = "vj_flood_biocost_carrier",Min = "0",Max = "5000"})
			Panel:AddControl("Slider",{Label="Stalker Form",Command = "vj_flood_biocost_stalker",Min = "0",Max = "5000"})
			Panel:AddControl("Slider",{Label="Ranged Form",Command = "vj_flood_biocost_ranged",Min = "0",Max = "5000"})
			Panel:AddControl("Slider",{Label="Tank Form",Command = "vj_flood_biocost_tank",Min = "0",Max = "5000"})
			Panel:AddControl("Slider",{Label="Mortar Form",Command = "vj_flood_biocost_mortar",Min = "0",Max = "5000"})
		end
		local function VJ_HALOFLOOD_ALL(Panel)
			if !game.SinglePlayer() then
			if !LocalPlayer():IsAdmin() or !LocalPlayer():IsSuperAdmin() then
				Panel:AddControl( "Label", {Text = "You are not an admin!"})
				Panel:ControlHelp("Notice: Only admins can change this settings.")
				return
				end
			end
			Panel:AddControl( "Label", {Text = "Notice: Only admins can change this settings."})
			local vj_hflfreset = {Options = {}, CVars = {}, Label = "Reset Everything:", MenuButton = "0"}
			vj_hflfreset.Options["#vjbase.menugeneral.default"] = { 
			vj_halo_developmenttime = "500"
			}
			Panel:AddControl("ComboBox", vj_hflfreset)
			Panel:AddControl("Slider", { Label 	= "Flood Development Time", Command = "vj_halo_developmenttime", Type = "Float", Min = "10", Max = "3000"})
		end
		function VJ_ADDTOMENU_HALOFLOOD()
			spawnmenu.AddToolMenuOption( "DrVrej", "SNPC Configures", "Halo 3 Flood", "Halo 3 Flood", "", "", VJ_HALOFLOOD_MAIN, {} )
			spawnmenu.AddToolMenuOption( "DrVrej", "SNPC Configures", "Global Flood Control", "Global Flood Control", "", "", VJ_HALOFLOOD_ALL, {} )
		end
		hook.Add( "PopulateToolMenu", "VJ_ADDTOMENU_HALOFLOOD", VJ_ADDTOMENU_HALOFLOOD )
	end
-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end