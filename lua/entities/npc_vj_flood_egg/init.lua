AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/cpthazama/halo3/flood_egg.mdl" -- Leave empty if using more than one model
ENT.StartHealth = 40
ENT.MovementType = VJ_MOVETYPE_STATIONARY
ENT.CanTurnWhileStationary = false
ENT.Behavior = VJ_BEHAVIOR_PASSIVE_NATURE
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = "Yellow"
ENT.CustomBlood_Particle = {"cpt_blood_flood"} -- Particle that the SNPC spawns when it's damaged

ENT.HasDeathRagdoll = false
ENT.WaitBeforeDeathTime = 30

ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.HasFootStepSound = false -- Should the SNPC make a footstep sound when it's moving?
-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_SackIdle = {
	["idle1"] = {
		"vj_halo3flood/floodegg/idle1/floodball_idle_var0_1.wav",
		"vj_halo3flood/floodegg/idle1/floodball_idle_var0_2.wav",
		"vj_halo3flood/floodegg/idle1/floodball_idle_var0_3.wav",
		"vj_halo3flood/floodegg/idle1/floodball_idle_var0_4.wav",
		"vj_halo3flood/floodegg/idle1/floodball_idle_var0_5.wav",
		"vj_halo3flood/floodegg/idle1/floodball_idle_var0_6.wav",
	},
	["idle2"] = {
		"vj_halo3flood/floodegg/idle2/floodball_idle_var1_1.wav",
		"vj_halo3flood/floodegg/idle2/floodball_idle_var1_2.wav",
		"vj_halo3flood/floodegg/idle2/floodball_idle_var1_3.wav",
		"vj_halo3flood/floodegg/idle2/floodball_idle_var1_4.wav",
		"vj_halo3flood/floodegg/idle2/floodball_idle_var1_5.wav",
		"vj_halo3flood/floodegg/idle2/floodball_idle_var1_6.wav",
	},
	["idle3"] = {
		"vj_halo3flood/floodegg/idle3/floodball_idle_var2_1.wav",
		"vj_halo3flood/floodegg/idle3/floodball_idle_var2_2.wav",
		"vj_halo3flood/floodegg/idle3/floodball_idle_var2_3.wav",
		"vj_halo3flood/floodegg/idle3/floodball_idle_var2_4.wav",
		"vj_halo3flood/floodegg/idle3/floodball_idle_var2_5.wav",
		"vj_halo3flood/floodegg/idle3/floodball_idle_var2_6.wav",
	},
	["idle4"] = {
		"vj_halo3flood/floodegg/idle4/floodball_idle_var3_1.wav",
		"vj_halo3flood/floodegg/idle4/floodball_idle_var3_2.wav",
		"vj_halo3flood/floodegg/idle4/floodball_idle_var3_3.wav",
		"vj_halo3flood/floodegg/idle4/floodball_idle_var3_4.wav",
		"vj_halo3flood/floodegg/idle4/floodball_idle_var3_5.wav",
		"vj_halo3flood/floodegg/idle4/floodball_idle_var3_6.wav",
	},
}
ENT.SoundTbl_Breath = {
	"vj_halo3flood/floodegg/infections_inside1.wav",
	"vj_halo3flood/floodegg/infections_inside2.wav",
	"vj_halo3flood/floodegg/infections_inside3.wav",
	"vj_halo3flood/floodegg/infections_inside4.wav",
	"vj_halo3flood/floodegg/infections_inside5.wav",
	"vj_halo3flood/floodegg/infections_inside6.wav",
}
ENT.BreathSoundLevel = 60
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(65,65,65),Vector(-65,-65,0))
	-- timer.Simple(0,function() self:SpawnFunction(self:GetCreator()) end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SpawnFunction(ply)
	local tr = util.TraceLine({
		start = ply:EyePos(),
		endpos = ply:EyePos() +ply:EyePos():Angle():Forward() *10000,
		filter = function(ent) if ent == ply or ent == self then return false end end
	})
	if (!tr.Hit) then return end
	self:SetAngles((tr.HitNormal):Angle())
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if string.find(key,"idle") then
		if self.CurrentSound then
			self.CurrentSound:Stop()
		end
		self.CurrentSound = CreateSound(self,VJ_PICK(self.SoundTbl_SackIdle[key]))
		self.CurrentSound:SetSoundLevel(75)
		self.CurrentSound:Play()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SpawnFlood(count)
	local sCount = self.VJ_EnhancedFlood && count *2 or count
	for i = 1,sCount do
		local pos = self:GetPos() +self:OBBCenter()
		local flood = ents.Create("npc_vj_flood_infection")
		flood:SetPos(pos +self:GetForward() *math.Rand(-(4 *i),4 *i) +self:GetRight() *math.Rand(-(4 *i),4 *i))
		flood:SetAngles(Angle(self:GetAngles().x,math.Rand(0,360),self:GetAngles().z))
		flood:Spawn()
		flood:SetGroundEntity(NULL)
		local rand = 350
		flood:SetVelocity(self:GetForward() *math.random(-rand,rand) +self:GetUp() *math.random(rand -50,rand) +self:GetRight() *math.random(-rand,rand))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if self:Health() <= 0 then
		VJ_STOPSOUND(self.CurrentSound)
		VJ_STOPSOUND(self.CurrentBreathSound)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo,hitgroup)
	self:SetBodygroup(0,1)
	self:SpawnFlood(math.random(7,15))
	VJ_EmitSound(self,"vj_halo3flood/floodegg/floodball_expl" .. math.random(1,6) .. ".wav",85,100)

	local bloodeffect = EffectData()
	bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodeffect:SetColor(VJ_Color2Byte(Color(255,221,35)))
	bloodeffect:SetScale(300)
	util.Effect("VJ_Blood1",bloodeffect)
	
	local bloodspray = EffectData()
	bloodspray:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodspray:SetScale(75)
	bloodspray:SetFlags(3)
	bloodspray:SetColor(1)
	util.Effect("bloodspray",bloodspray)
	util.Effect("bloodspray",bloodspray)
	ParticleEffect("flood_hive_explode",self:GetPos() +self:OBBCenter(),Angle(0,0,0),nil)
	ParticleEffect("flood_hive_explode",self:GetPos() +self:OBBCenter() +self:GetUp() *80,Angle(0,0,0),nil)
	ParticleEffect("cpt_blood_flood",self:GetPos() +self:OBBCenter() +self:GetRight() *-45,Angle(0,0,0),nil)
	ParticleEffect("cpt_blood_flood",self:GetPos() +self:OBBCenter() +self:GetRight() *45,Angle(0,0,0),nil)
	ParticleEffect("cpt_blood_flood",self:GetPos() +self:OBBCenter() +self:GetForward() *-45,Angle(0,0,0),nil)
	ParticleEffect("cpt_blood_flood",self:GetPos() +self:OBBCenter() +self:GetForward() *45,Angle(0,0,0),nil)
	ParticleEffect("cpt_blood_flood",self:GetPos() +self:OBBCenter() +self:GetRight() *-45 +self:GetForward() *45,Angle(0,0,0),nil)
	ParticleEffect("cpt_blood_flood",self:GetPos() +self:OBBCenter() +self:GetRight() *45 +self:GetForward() *-45,Angle(0,0,0),nil)
	ParticleEffect("cpt_blood_flood",self:GetPos() +self:OBBCenter() +self:GetRight() *-45 +self:GetForward() *-45,Angle(0,0,0),nil)
	ParticleEffect("cpt_blood_flood",self:GetPos() +self:OBBCenter() +self:GetRight() *45 +self:GetForward() *45,Angle(0,0,0),nil)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	VJ_STOPSOUND(self.CurrentSound)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/