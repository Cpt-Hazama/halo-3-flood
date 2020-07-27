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
-- ENT.Model = {"models/cpthazama/halowars/flood_thorn.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.Model = {"models/spitball_small.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.DoesDirectDamage = true -- Should it do a direct damage when it hits something?
ENT.DirectDamage = 4 -- How much damage should it do when it hits something
ENT.DirectDamageType = DMG_SLASH -- Damage type
ENT.DecalTbl_DeathDecals = {"BeerSplash"}
ENT.SoundTbl_Idle = {}
ENT.SoundTbl_OnCollide = {
	"vj_halo3flood/ranged/ranged_spike_hit1.wav",
	"vj_halo3flood/ranged/ranged_spike_hit2.wav",
	"vj_halo3flood/ranged/ranged_spike_hit3.wav",
	"vj_halo3flood/ranged/ranged_spike_hit4.wav",
	"vj_halo3flood/ranged/ranged_spike_hit5.wav",
	"vj_halo3flood/ranged/ranged_spike_hit6.wav",
	"vj_halo3flood/ranged/ranged_spike_hit7.wav",
	"vj_halo3flood/ranged/ranged_spike_hit8.wav",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	-- self:SetMaterial("models/cpthazama/halo3/flood_stalker/flood_stalker")
	phys:Wake()
	phys:EnableGravity(false)
	phys:EnableDrag(true)
	phys:SetBuoyancyRatio(0)
	self:SetNoDraw(true)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(data,phys)
	ParticleEffect("cpt_blood_flood",self:GetPos(),Angle(math.random(0,360),math.random(0,360),math.random(0,360)),nil)
	ParticleEffect("cpt_blood_flood",self:GetPos(),Angle(math.random(0,360),math.random(0,360),math.random(0,360)),nil)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	timer.Simple(3,function() if IsValid(self) then self:Remove() end end)
	util.SpriteTrail(self,0, Color(230,255,127,100), false, 45, 45, 0.6, 1/(10+1)*0.5, "VJ_Base/sprites/vj_trial1.vmt")
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/