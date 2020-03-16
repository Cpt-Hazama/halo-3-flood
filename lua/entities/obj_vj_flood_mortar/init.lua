if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
/*--------------------------------------------------
	=============== Projectile Base ===============
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
INFO: Used to make projectiles.
--------------------------------------------------*/
	-- General ---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Model = {"models/hunter/misc/sphere1x1.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 150 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 75 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamageType = DMG_POISON -- Damage type
ENT.DecalTbl_DeathDecals = {"BeerSplash"}
ENT.SoundTbl_Idle = {"vj_acid/acid_idle1.wav"}
ENT.SoundTbl_OnCollide = {"vj_gib/gibbing1.wav","vj_gib/gibbing2.wav","vj_gib/gibbing3.wav"}

ENT.IdleSoundLevel = 75
ENT.IdleSoundPitch1 = 50
ENT.IdleSoundPitch2 = 60

ENT.Speed = 1750
ENT.IsHalo3Infection = true
ENT.IsHalo3Projectile = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:SetMass(1)
	phys:SetBuoyancyRatio(0)
	phys:EnableDrag(false)
	phys:EnableGravity(false)
	self:SetNoDraw(true)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	ParticleEffectAttach("flood_mortar",PATTACH_ABSORIGIN_FOLLOW,self,0)
	ParticleEffectAttach("cpt_flood_sporeparticles",PATTACH_ABSORIGIN_FOLLOW,self,0)
	self.Activated = true
	-- timer.Simple(0.5,function()
		-- if IsValid(self) then
			-- self.Activated = true
			-- self.Speed = 1750
		-- end
	-- end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:ApplyForceCenter(self:GetForward() *self.Speed)
	end
	if self.Activated then
		if IsValid(self.ParentsEnemy) then
			local targetAng = ((self.ParentsEnemy:GetPos() +self.ParentsEnemy:OBBCenter()) -self:GetPos()):Angle()
			local ang = self:GetAngles()
			self:SetAngles(targetAng)
		else
			self:SetAngles(self:GetAngles())
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDoDamage(data,phys,hitents)
	for _,v in pairs(hitents) do
		if IsValid(v) then
			if v:IsNPC() or v:IsPlayer() then
				if v:Health() < self.RadiusDamage && v:Health() > 0 then
					if v:IsPlayer() then
						v:Kill()
					else
						v:TakeDamage(999999999,self,self)
					end
					VJ_FloodInfect(v,self,self,v:IsPlayer())
				end
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(data,phys)
	ParticleEffect("flood_mortar_explode",data.HitPos,Angle(0,0,0),nil)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/