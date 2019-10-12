AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/cpthazama/halo3/flood_ranged.mdl" -- Leave empty if using more than one model
ENT.StartHealth = 250
ENT.MoveType = MOVETYPE_NONE
ENT.HullType = HULL_HUMAN
ENT.GibOnDeathDamagesTable = {"All"}
ENT.EntitiesToNoCollide = {"npc_vj_flood_infection"}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_FLOOD","CLASS_PARASITE"}
ENT.BloodColor = "Yellow"
ENT.CustomBlood_Particle = {"cpt_blood_flood"} -- Particle that the SNPC spawns when it's damaged

ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.HasFootStepSound = false -- Should the SNPC make a footstep sound when it's moving?
-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Idle = {
	"vj_halo3flood/stalker/stayback1.mp3",
	"vj_halo3flood/stalker/stayback2.mp3",
	"vj_halo3flood/stalker/stayback3.mp3",
	"vj_halo3flood/stalker/stayback4.mp3",
	"vj_halo3flood/stalker/stayback5.mp3",
}
ENT.SoundTbl_Alert = {
	"vj_halo3flood/stalker/foundfoe1.mp3",
	"vj_halo3flood/stalker/foundfoe2.mp3",
	"vj_halo3flood/stalker/foundfoe3.mp3",
	"vj_halo3flood/stalker/foundfoe4.mp3",
	"vj_halo3flood/stalker/foundfoe5.mp3",
	"vj_halo3flood/stalker/foundfoe6.mp3",
}
ENT.SoundTbl_CombatIdle = {
	"vj_halo3flood/stalker/foundfoe1.mp3",
	"vj_halo3flood/stalker/foundfoe2.mp3",
	"vj_halo3flood/stalker/foundfoe3.mp3",
	"vj_halo3flood/stalker/foundfoe4.mp3",
	"vj_halo3flood/stalker/foundfoe5.mp3",
	"vj_halo3flood/stalker/foundfoe6.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_halo3flood/stalker/pain1.mp3",
	"vj_halo3flood/stalker/pain2.mp3",
	"vj_halo3flood/stalker/pain3.mp3",
	"vj_halo3flood/stalker/pain4.mp3",
	"vj_halo3flood/stalker/pain5.mp3",
	"vj_halo3flood/stalker/pain6.mp3",
	"vj_halo3flood/stalker/pain7.mp3",
	"vj_halo3flood/stalker/pain8.mp3",
	"vj_halo3flood/stalker/pain9.mp3",
	"vj_halo3flood/stalker/pain10.mp3",
	"vj_halo3flood/stalker/pain11.mp3",
	"vj_halo3flood/stalker/pain12.mp3",
	"vj_halo3flood/stalker/pain13.mp3",
	"vj_halo3flood/stalker/pain14.mp3",
	"vj_halo3flood/stalker/pain15.mp3",
	"vj_halo3flood/stalker/pain16.mp3",
	"vj_halo3flood/stalker/pain17.mp3",
}
ENT.PureType = "ranged"
ENT.Default = VJ_MOVETYPE_STATIONARY
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
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(35,35,100),Vector(-35,-35,0))
	self.MovementType = VJ_MOVETYPE_STATIONARY
	self.NextNeedleAttackT = CurTime() +1.5
	if GetConVarNumber("vj_halo_transform") == 1 then
		self.NextTransformT = CurTime() +math.Rand(15,20)
	else
		self.NextTransformT = CurTime() +999999999
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "event_mattack" then
		self.MeleeAttackDamage = 90
		self.MeleeAttackDamageDistance = 160
		self:MeleeAttackCode()
	end
	if key == "event_pattack" then
		self.HasMeleeAttackKnockBack = true
		self.MeleeAttackDamage = 70
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
	if key == "event_impact" then
		VJ_EmitSound(self,self.SoundTbl_Thud,85,100)
	end
	if key == "event_emit step" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,95,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnTransformed(from,to)
	local anim = from .. "_to_" .. to
	self.MovementType = VJ_MOVETYPE_STATIONARY
	local act,dur = self:LookupSequence(anim)
	self:VJ_ACT_PLAYACTIVITY("vjseq_" .. anim,true,nil,false)
	self:EmitSound("physics/flesh/flesh_bloody_break.wav",math.random(80,95),math.random(85,100))
	VJ_EmitSound(self,"vj_halo3flood/transformation/" .. to .. "_from_" .. from .. math.random(1,3) .. ".wav",90,100)
	for i = 1,self:GetBoneCount() -1 do
		ParticleEffect("cpt_blood_flood",self:GetBonePosition(i),Angle(math.Rand(0,360),math.Rand(0,360),math.Rand(0,360)),nil)
	end
	timer.Simple(0.15,function()
		if IsValid(self) then
			self:SetNoDraw(false)
		end
	end)
	timer.Simple(dur,function()
		if IsValid(self) then
			self.MovementType = self.Default
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Transform(to,ent)
	local anim = self.PureType .. "_to_" .. to
	self.MovementType = VJ_MOVETYPE_STATIONARY
	local act,dur = self:LookupSequence(anim)
	self:VJ_ACT_PLAYACTIVITY("vjseq_" .. anim,true,nil,false)
	VJ_EmitSound(self,"vj_halo3flood/transformation/" .. anim .. math.random(1,3) .. ".wav",90,100)
	timer.Simple(dur,function()
		if IsValid(self) then
			self:EmitSound("physics/flesh/flesh_bloody_break.wav",math.random(80,95),math.random(85,100))
			for i = 1,self:GetBoneCount() -1 do
				ParticleEffect("cpt_blood_flood",self:GetBonePosition(i),Angle(math.Rand(0,360),math.Rand(0,360),math.Rand(0,360)),nil)
			end
			local f = ents.Create(ent)
			f:SetPos(self:GetPos())
			f:SetAngles(self:GetAngles())
			f:Spawn()
			f:SetNoDraw(true)
			f:OnTransformed(self.PureType,to)
			undo.ReplaceEntity(self,f)
			self:VJ_SwitchController(f)
			self:Remove()
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CanShootEnemy(enemy)
	return (self:GetForward():Dot(((enemy:GetPos() +enemy:OBBCenter()) -self:GetPos() +self:GetForward() *15):GetNormalized()) > math.cos(math.rad(80)))
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
	self.NextRMB = self.NextRMB or CurTime() +1
	if CurTime() > self.NextNeedleAttackT && lmb then
		local tb_Pos = {
			Vector(1.6,-10.63,61.68),
			Vector(-0.32,6.22,62.18),
			Vector(7.14,8.55,69.49),
			Vector(5.45,-9.78,71.04),
			Vector(-1.18,8.45,76.67),
			Vector(6.78,-9.44,77.94),
			Vector(-5.91,8.45,88.18),
			Vector(0.23,-7.84,88.15)
		}
		local chance = math.random(6,8)
		local mul = 0.08
		for i = 1,chance do
			local pos = tb_Pos[i]
			timer.Simple(mul *i,function()
				if IsValid(self) && IsValid(ent) then
					self:FireNeedle(ent,pos)
				end
			end)
		end
		self.NextNeedleAttackT = CurTime() +mul *chance +0.5
	end
	if rmb && CurTime() > self.NextTransformT then
		self:Transform("tank","npc_vj_flood_tank")
		self.NextTransformT = CurTime() +15
	end
	if space && CurTime() > self.NextTransformT then
		self:Transform("stalker","npc_vj_flood_stalker")
		self.NextTransformT = CurTime() +15
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
	self:RegenerateHealth()
	self:GravemindSpeak()
	if GetConVarNumber("ai_disabled") == 1 then return end
	if self.VJ_IsBeingControlled then self:FloodControl() return end
	if IsValid(self:GetEnemy()) then
		local enemy = self:GetEnemy()
		local dist = self:VJ_GetNearestPointToEntityDistance(enemy)
		if dist <= 500 && enemy:Visible(self) && CurTime() > self.NextTransformT then
			self:Transform("stalker","npc_vj_flood_stalker")
			self.NextTransformT = CurTime() +5
			return
		end
		if CurTime() > self.NextNeedleAttackT && dist <= 4000 && enemy:Visible(self) && self:CanShootEnemy(enemy) then
			local tb_Pos = {
				Vector(1.6,-10.63,61.68),
				Vector(-0.32,6.22,62.18),
				Vector(7.14,8.55,69.49),
				Vector(5.45,-9.78,71.04),
				Vector(-1.18,8.45,76.67),
				Vector(6.78,-9.44,77.94),
				Vector(-5.91,8.45,88.18),
				Vector(0.23,-7.84,88.15)
			}
			local chance = math.random(6,8)
			local mul = 0.08
			for i = 1,chance do
				local pos = tb_Pos[i]
				timer.Simple(mul *i,function()
					if IsValid(self) && IsValid(enemy) then
						self:FireNeedle(enemy,pos)
					end
				end)
			end
			self.NextNeedleAttackT = CurTime() +mul *chance +0.5
		end
	end
	if IsValid(self:GetEnemy()) && math.random(1,100) == 1 && CurTime() > self.NextTransformT then
		local enemy = self:GetEnemy()
		local dist = self:VJ_GetNearestPointToEntityDistance(enemy)
		if !self:CanShootEnemy(enemy) then
			self:Transform("stalker","npc_vj_flood_stalker")
		else
			if dist <= 850 then
				self:Transform("tank","npc_vj_flood_tank")
			else
				self:Transform("stalker","npc_vj_flood_stalker")
			end
		end
		self.NextTransformT = CurTime() +15
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FireNeedle(enemy,pos)
	local proj = ents.Create("obj_vj_flood_thorn")
	proj:SetPos(self:LocalToWorld(pos))
	proj:SetAngles((enemy:GetPos() -self:GetPos()):Angle())
	proj:Spawn()
	proj:Activate()
	proj:SetOwner(self)
	local phys = proj:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetVelocity(self:ShootPosFlood(enemy,pos))
	end
	local gest = self:AddGestureSequence(self:LookupSequence("fire"))
	self:SetLayerPriority(gest,2)
	self:SetLayerPlaybackRate(gest,0.5)
	VJ_EmitSound(self,"vj_halo3flood/ranged/spike_fire_squeal" .. math.random(1,5) .. ".wav",90,self:VJ_DecideSoundPitch(100,110))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ShootPosFlood(ent,pos)
	return (ent:GetPos() +ent:OBBCenter() -(self:LocalToWorld(pos))):GetNormal() *9500
	-- local endpos = ent:GetPos() + ent:OBBCenter()
	-- local startpos = self:LocalToWorld(pos)
	-- return (endpos-(startpos)):GetNormal()*(1500)
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