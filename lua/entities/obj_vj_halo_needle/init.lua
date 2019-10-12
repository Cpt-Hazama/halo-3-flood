AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/weapons/w_missile_launch.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.DoesDirectDamage = true -- Should it do a direct damage when it hits something?
ENT.DirectDamage = 6 -- How much damage should it do when it hits something
ENT.DirectDamageType = DMG_SLASH -- Damage type
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetMaterial("models/effects/vol_light001.mdl")
	self:DrawShadow(false)
	self:SetColor(Color(220,0,255,255))
	
	util.SpriteTrail(self,6,Color(220,0,255,255),true,2,2,0.1,1/(6+6)*0.8,"VJ_Base/sprites/vj_trial1.vmt")
	
	local eyeglow2 = ents.Create("env_sprite")
	eyeglow2:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
	eyeglow2:SetKeyValue("scale","0.09")
	eyeglow2:SetKeyValue("rendermode","5")
	eyeglow2:SetKeyValue("rendercolor","220 0 255 255")
	eyeglow2:SetKeyValue("spawnflags","1") -- If animated
	eyeglow2:SetPos(self:GetPos())
	eyeglow2:SetParent(self)
	eyeglow2:Spawn()
	eyeglow2:Activate()
	self:DeleteOnRemove(eyeglow2)

	self.StartLight1 = ents.Create("light_dynamic")
	self.StartLight1:SetKeyValue("brightness", "0.08")
	self.StartLight1:SetKeyValue("distance", "20")
	self.StartLight1:SetLocalPos(self:GetPos())
	self.StartLight1:SetLocalAngles( self:GetAngles() )
	self.StartLight1:Fire("Color", "220 0 255 255")
	self.StartLight1:SetParent(self)
	self.StartLight1:Spawn()
	self.StartLight1:Activate()
	self.StartLight1:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.StartLight1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CheckCanSee(ent,cone)
	if ent == nil then return end
	if self:Visible(ent) && (self:GetForward():Dot(((ent:GetPos() +ent:OBBCenter()) -self:GetPos()):GetNormalized()) > math.cos(math.rad(cone))) then
		return true
	else
		return false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if IsValid(self.ParentsEnemy) && self:GetPos():Distance(self.ParentsEnemy:GetPos()) < 1000 && self:CheckCanSee(self.ParentsEnemy,30) then
		self:SetAngles(self:GetVelocity():GetNormal():Angle())
		local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			local gain = 1
			if self:GetPos():Distance(self.ParentsEnemy:GetPos()) < 350 && self:GetPos():Distance(self.ParentsEnemy:GetPos()) > 125 then
				gain = 5
			elseif self:GetPos():Distance(self.ParentsEnemy:GetPos()) <= 125 then
				gain = 8
			else
				gain = 2
			end
			local force = ((self.ParentsEnemy:GetPos() +self.ParentsEnemy:OBBCenter()) -self:GetPos()) *gain
			phys:ApplyForceCenter(force)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(data,phys)
	local effectdata = EffectData()
	effectdata:SetOrigin(data.HitPos)
	util.Effect("AR2Impact", effectdata)
	util.Effect("StunstickImpact", effectdata)
	local pos = data.HitPos
	local normal = data.HitNormal
	local owner = self:GetOwner()
	local ent = data.HitEntity
	if math.random(1,2) == 1 then
		if SERVER then
			local needle = ents.Create("obj_vj_halo_needle_dead")
			needle:SetPos(pos)
			needle:SetAngles((pos +normal):Angle())
			needle.AttachEnt = false
			needle:SetOwner(self:GetOwner())
			needle:Spawn()
			needle:SetOwner(self:GetOwner())
			if IsValid(ent) then
				needle.AttachEnt = ent
				needle:DoBoneAttach(ent)
			end
		end
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/