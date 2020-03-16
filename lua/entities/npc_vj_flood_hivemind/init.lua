AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/cpthazama/halowars/flood_hivemind.mdl" -- Leave empty if using more than one model
ENT.StartHealth = 15000
ENT.SightAngle = 180
ENT.GibOnDeathDamagesTable = {"All"}
ENT.MovementType = VJ_MOVETYPE_STATIONARY
ENT.CanTurnWhileStationary = false
ENT.VJ_IsHugeMonster = true
---------------------------------------------------------------------------------------------------------------------------------------------
PROTO_RANGE = 15000
PROTO_BOOST_HEALTH = 3
PROTO_BOOST_RES = 0.5
PROTO_BOOST_COM = 2.5
PROTO_BOOST_DMG = 2
PROTO_BOOST_SPEED = 1.5
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_FLOOD","CLASS_PARASITE"}
ENT.BloodColor = "Yellow"
ENT.CustomBlood_Particle = {"cpt_blood_flood"} -- Particle that the SNPC spawns when it's damaged

ENT.CallForHelpDistance = PROTO_RANGE
ENT.CallForBackUpOnDamageDistance = PROTO_RANGE
ENT.CallForBackUpOnDamageLimit = 0

ENT.Immune_AcidPoisonRadiation = true
ENT.Immune_Dissolve = true
ENT.Immune_Physics = true
ENT.Immune_Sonic = true
ENT.AllowIgnition = false
ENT.HasDeathAnimation = true
ENT.HasGibOnDeath = false
ENT.AnimTbl_Death = {"death"}

ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.HasFootStepSound = false -- Should the SNPC make a footstep sound when it's moving?
-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Idle = {
	"vj_halo3flood/proto/horror_wailing1.wav",
	"vj_halo3flood/proto/horror_wailing2.wav",
	"vj_halo3flood/proto/horror_wailing3.wav",
	"vj_halo3flood/proto/horror_wailing4.wav",
	"vj_halo3flood/proto/horror_wailing5.wav",
	"vj_halo3flood/proto/horror_wailing6.wav",
	"vj_halo3flood/proto/howly_spook10.wav",
	"vj_halo3flood/proto/howly_spook5.wav",
	"vj_halo3flood/proto/howly_spook6.wav",
	"vj_halo3flood/proto/howly_spook7.wav",
	"vj_halo3flood/proto/howly_spook8.wav",
	"vj_halo3flood/proto/howly_spook9.wav",
	"vj_halo3flood/proto/scary_whail1.wav",
	"vj_halo3flood/proto/scary_whail2.wav",
	"vj_halo3flood/proto/scary_whail3.wav",
	"vj_halo3flood/proto/scary_whail4.wav",
}
ENT.IdleSoundLevel = 110

ENT.BioMass = 50
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo,hitgroup)
	for i = 1,15 do
		timer.Simple(0.15 *i,function()
			if IsValid(self) then
				for i = 1,self:GetBoneCount() -1 do
					if math.random(1,15) == 1 then util.ScreenShake(self:GetPos(),12,100,5,3000); sound.Play("vj_halo3flood/carrier/h3/pop" .. math.random(1,6) .. ".mp3",self:GetBonePosition(i),100,100) end
					ParticleEffect("flood_mortar_explode",self:GetBonePosition(i),Angle(math.Rand(0,360),math.Rand(0,360),math.Rand(0,360)),nil)
					ParticleEffect("flood_mortar_explode",self:GetBonePosition(i) +VectorRand() *15,Angle(math.Rand(0,360),math.Rand(0,360),math.Rand(0,360)),nil)
				end
			end
		end)
	end
	timer.Simple(2.45,function()
		if IsValid(self) then
			self:SetUpGibesOnDeath(dmginfo,hitgroup)
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	local bloodeffect = EffectData()
	bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodeffect:SetColor(VJ_Color2Byte(Color(255,221,35)))
	bloodeffect:SetScale(150)
	util.Effect("VJ_Blood1",bloodeffect)
	util.Effect("VJ_Blood1",bloodeffect)
	util.Effect("VJ_Blood1",bloodeffect)
	
	local bloodspray = EffectData()
	bloodspray:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodspray:SetScale(20)
	bloodspray:SetFlags(3)
	bloodspray:SetColor(1)
	util.Effect("bloodspray",bloodspray)
	util.Effect("bloodspray",bloodspray)
	util.Effect("bloodspray",bloodspray)
	util.Effect("bloodspray",bloodspray)
	util.Effect("bloodspray",bloodspray)
	util.Effect("bloodspray",bloodspray)
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
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(950,950,1000),Vector(-950,-950,0))
	self.Enhanced = {}
	self.NextSlitherT = CurTime()
	self.NextEnhanceCheckT = CurTime() +5
	self.NextAttemptToSpawnT = CurTime() +15
	for _,v in pairs(ents.GetAll()) do
		if v:GetClass() == self:GetClass() && v != self then
			if IsValid(self:GetCreator()) then
				self:GetCreator():ChatPrint("Only one proto-gravemind can exist at a time!")
			end
			self:Remove()
		end
	end
	-- ParticleEffectAttach("cpt_flood_spore",PATTACH_ABSORIGIN_FOLLOW,self,0) -- Weird particle error
	self.SpawnedFlood = {}
	self.SpawnPosition = self:GetPos() +self:GetUp() *25 +self:GetForward() *1500
	self.MortarPositions = {}
	self.MortarPositions[1] = {ent=NULL,pos=self:GetPos() +self:GetForward() *2300}
	self.MortarPositions[2] = {ent=NULL,pos=self:GetPos() +self:GetForward() *-2300}
	self.MortarPositions[3] = {ent=NULL,pos=self:GetPos() +self:GetRight() *2300}
	self.MortarPositions[4] = {ent=NULL,pos=self:GetPos() +self:GetRight() *-2300}
	timer.Simple(1,function()
		if IsValid(self) then
			self:SpawnFlood("npc_vj_flood_infection")
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FindMortarSpot()
	for i = 1,4 do
		local attempt = self.MortarPositions[i]
		if !IsValid(attempt.ent) then
			return attempt.pos
		end
	end
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AttemptSpawn()
	-- Entity(1):ChatPrint("Attempting...")
	for class,cost in pairs(VJ_FLOOD_BIOCOST) do
		-- Entity(1):ChatPrint("Comparing " .. tostring(self.BioMass) .. " - " .. tostring(cost) .. " for " .. class)
		if self.BioMass >= cost then
			-- Entity(1):ChatPrint("Spawning " .. class)
			if class == "npc_vj_flood_mortar" then
				self:SpawnFlood(class,self:FindMortarSpot())
				break
			end
			self:SpawnFlood(class)
			break
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AmountCheck()
	local tbl = {}
	for _,v in pairs(self.SpawnedFlood) do
		if IsValid(v) then
			table.insert(tbl,v)
		end
	end
	return #tbl >= VJ_FLOOD_MAXPROTOFLOOD
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SpawnFlood(ent,pos)
	if pos == false then return end
	if self:AmountCheck() then return end
	if VJ_FLOOD_BIOCOST[ent] then
		if self.BioMass >= VJ_FLOOD_BIOCOST[ent] then
			local flood = ents.Create(ent)
			flood:VJ_SetClearPos(pos or self.SpawnPosition)
			flood:SetAngles(pos && Angle(0,(flood:GetPos() -self:GetPos()):Angle().y,0) or self:GetAngles())
			flood:Spawn()
			if pos then
				for i = 1,4 do
					if pos == self.MortarPositions[i].pos then
						self.MortarPositions[i].ent = flood
						break
					end
				end
			end
			for i = 0,flood:GetBoneCount() -1 do
				ParticleEffect("cpt_blood_flood",flood:GetBonePosition(i),Angle(0,0,0),nil)
				sound.Play(VJ_PICKRANDOMTABLE({"vj_gib/gibbing1.wav","vj_gib/gibbing2.wav","vj_gib/gibbing3.wav"}),flood:GetPos(),50,100 *GetConVarNumber("host_timescale"))
			end
			table.insert(self.SpawnedFlood,flood)
			self.BioMass = self.BioMass -VJ_FLOOD_BIOCOST[ent]
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.NextRegen = CurTime()
function ENT:RegenerateHealth()
	if CurTime() > self.NextRegen then
		local setHealth = math.Clamp(self:Health() +10,0,self:GetMaxHealth())
		if setHealth > self:Health() then
			self:SetHealth(setHealth)
			self.NextRegen = CurTime() +5
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:EnhanceFlood(v,enhance)
	if v:LookupAttachment("tendril1") then
		VJ_FloodEnhanceFX(v,enhance)
	end
	if enhance then
		v.VJ_Old_CallForHelpDistance = v.CallForHelpDistance
		v.VJ_Old_CallForBackUpOnDamageDistance = v.CallForBackUpOnDamageDistance
		v.CallForHelpDistance = v.CallForHelpDistance *PROTO_BOOST_COM
		v.CallForBackUpOnDamageDistance = v.CallForBackUpOnDamageDistance *PROTO_BOOST_COM

		v.VJ_Old_MeleeAttackDamage = v.MeleeAttackDamage
		v.MeleeAttackDamage = v.MeleeAttackDamage *PROTO_BOOST_DMG
		v.VJ_Old_LeapAttackDamage = v.LeapAttackDamage
		v.LeapAttackDamage = v.LeapAttackDamage *PROTO_BOOST_DMG
		
		v:SetHealth(v:Health() *PROTO_BOOST_HEALTH)
		v:SetMaxHealth(v:GetMaxHealth() *PROTO_BOOST_HEALTH)
		
		v.VJ_Flood_DamageResistance = PROTO_BOOST_RES
		v.VJ_Flood_SpeedBoost = PROTO_BOOST_SPEED
	else
		v.CallForHelpDistance = v.VJ_Old_CallForHelpDistance
		v.CallForBackUpOnDamageDistance = v.VJ_Old_CallForBackUpOnDamageDistance

		v.MeleeAttackDamage = v.VJ_Old_MeleeAttackDamage
		v.LeapAttackDamage = v.VJ_Old_LeapAttackDamage
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if CurTime() > self.NextSlitherT then
		local snd = "vj_halo3flood/proto/slither" .. math.random(1,5) .. ".wav"
		VJ_CreateSound(self,snd,90,100)
		self.NextSlitherT = CurTime() +math.Rand(1,2)
	end
	if CurTime() > self.NextAttemptToSpawnT && math.random(1,10) == 1 then
		self:AttemptSpawn()
		self.NextAttemptToSpawnT = CurTime() +math.Rand(15,30)
	end
	if CurTime() > self.NextEnhanceCheckT then
		for _,v in pairs(ents.FindInSphere(self:GetPos(),PROTO_RANGE)) do
			if v:IsNPC() && v != self then
				if VJ_HasValue(v.VJ_NPC_Class,"CLASS_FLOOD") && !v.VJ_EnhancedFlood then
					v.VJ_EnhancedFlood = true
					table.insert(self.Enhanced,v)
					self:EnhanceFlood(v,true)
				end
			end
		end
		self.NextEnhanceCheckT = CurTime() +10
	end
	self:RegenerateHealth()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled(dmginfo,hitgroup)
	self:EmitSound("physics/flesh/flesh_bloody_break.wav",110,90)
	for i = 1,self:GetBoneCount() -1 do
		ParticleEffect("flood_mortar_explode",self:GetBonePosition(i),Angle(math.Rand(0,360),math.Rand(0,360),math.Rand(0,360)),nil)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	if self:Health() > 0 then
		if #self.SpawnedFlood > 0 then
			for _,v in pairs(self.SpawnedFlood) do
				if IsValid(v) then
					v:Remove()
				end
			end
		end
	end
	if #self.Enhanced > 0 then
		for _,v in pairs(self.Enhanced) do
			if IsValid(v) then
				v.VJ_EnhancedFlood = false
				self:EnhanceFlood(v,false)
			end
		end
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/