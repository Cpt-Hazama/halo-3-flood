AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.CanUseCamouflage = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInitialize()
	self.tbl_Muffins = {}
	self.bodyparts = {
		-- ["2"] = {Hitgroup = {2}, Health = 50, Bodygroup = 2, Gib = "models/predatorcz/halo/flood/elite.PMD/a_bbody.mdl", IsDead = false}, // Torso
		-- ["5"] = {Hitgroup = {5}, Health = 50, Bodygroup = 8, Gib = "models/predatorcz/halo/flood/shared.PMD/limb1.mdl", IsDead = false}, // Right Arm
		-- ["4"] = {Hitgroup = {4}, Health = 50, Bodygroup = 9, Gib = "models/predatorcz/halo/flood/shared.PMD/limb2.mdl", IsDead = false} // Left Arm
	}
	self:SetCollisionBounds(Vector(21,21,75),Vector(-21,-21,0))
	self:SetNWFloat("ShieldT",0)
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
		if math.random(1,1) == 1 then
			self.HasCamo = true
		end
	end
	self:SetSkin(math.random(0,6))
	-- self:SetColor(Color(math.random(0,255),math.random(0,255),math.random(0,255)))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FloodControl()
	local ply = self.VJ_TheController
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
function ENT:CustomOnThink_AIEnabled()
	if self:GetSequenceName(self:GetSequence()) == "overlay" && self:GetVelocity().z < 0 then
		self:StartEngineTask(GetTaskID("TASK_SET_ACTIVITY"),ACT_JUMP)
		self:MaintainActivity()
	end
	self.Bleeds = not self.HasShield
	self:SetNWBool("HasShield",self.HasShield)
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
	-- self:PlayerChat(self.CamoMeter)
	if self.IsUsingCamo && CurTime() > self.NextCamoT then
		self.CamoMeter = self.CamoMeter -1
		self.NextCamoT = CurTime() +0.3
	end
	if self.CamoMeter <= 0 then
		if self.IsUsingCamo then
			self:Camo(false)
			self.IsUsingCamo = false
			timer.Simple(10,function()
				if IsValid(self) then
					self.CamoMeter = 100
					if self.VJ_IsBeingControlled && IsValid(self.VJ_TheController) then
						self.VJ_TheController:ChatPrint("Camo Available!")
					end
				end
			end)
		end
	end
	if self.CurrentAttackAnimation == ACT_MELEE_ATTACK1 || self.CurrentAttackAnimation == ACT_MELEE_ATTACK2 then
		self.MeleeAttackDamageAngleRadius = 100
	elseif self.CurrentAttackAnimation == ACT_GESTURE_MELEE_ATTACK1 then
		self.MeleeAttackDamageAngleRadius = -100
	end
	if self.VJ_IsBeingControlled then self:FloodControl() end
	if IsValid(self:GetEnemy()) then
		local enemy = self:GetEnemy()
		local dist = self:VJ_GetNearestPointToEntityDistance(enemy)
		if !self.VJ_IsBeingControlled && self.HasCamo then
			if self.CamoMeter > 0 then
				if !self.IsUsingCamo then
					self:Camo(true)
					self.IsUsingCamo = true
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
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/