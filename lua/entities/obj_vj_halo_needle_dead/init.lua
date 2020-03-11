AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
function ENT:Initialize()
	self:SetModel("models/gibs/furniture_gibs/furnituretable002a_shard01.mdl")
	-- self:SetMaterial("models/effects/vol_light001.mdl")
	self:DrawShadow(false)
	self:SetColor(Color(220,0,255,255))
	util.SpriteTrail(self,6,Color(220,0,255,255),true,2,2,0.1,1/(6+6)*0.8,"VJ_Base/sprites/vj_trial1.vmt")
	
	local eyeglow2 = ents.Create("env_sprite")
	eyeglow2:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
	eyeglow2:SetKeyValue("scale","0.12")
	eyeglow2:SetKeyValue("rendermode","5")
	eyeglow2:SetKeyValue("rendercolor","220 0 255 255")
	eyeglow2:SetKeyValue("spawnflags","1") -- If animated
	eyeglow2:SetPos(self:GetPos())
	eyeglow2:SetParent(self)
	eyeglow2:Spawn()
	eyeglow2:Activate()
	self:DeleteOnRemove(eyeglow2)

	self.StartLight1 = ents.Create("light_dynamic")
	self.StartLight1:SetKeyValue("brightness", "0.1")
	self.StartLight1:SetKeyValue("distance", "30")
	self.StartLight1:SetLocalPos(self:GetPos())
	self.StartLight1:SetLocalAngles( self:GetAngles() )
	self.StartLight1:Fire("Color", "220 0 255 255")
	self.StartLight1:SetParent(self)
	self.StartLight1:Spawn()
	self.StartLight1:Activate()
	self.StartLight1:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.StartLight1)
	self.StartPos = self:GetPos()
	self.StartAng = self:GetAngles()
	self.Removed = false
	
	self:SetMoveType(MOVETYPE_NONE)
	timer.Simple(2,function()
		if IsValid(self) then
			self:DeathEffects(self:GetPos(),0)
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoBoneAttach(ent)
	if IsValid(ent) then
		local tb = {}
		for i = 1,ent:GetBoneCount() -1 do
			-- local bPos,bAng = ent:GetBonePosition(i)
			-- tb[i] = {pos=bPos,ang=bAng}
			tb[i] = i
		end
		local bone = tb[math.random(1,#tb)]
		self.StartBone = bone
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
	if self.AttachEnt == false then
		self:SetPos(self.StartPos)
		self:SetAngles(self.StartAng)
	else
		if IsValid(self.AttachEnt) then
			local ent = self.AttachEnt
			if ent:IsNPC() or ent:IsPlayer() then
				local pos,ang = ent:GetBonePosition(self.StartBone)
				self.StartPos = pos
				self.StartAng = ang
				if self.StartPos == nil || self.StartAng == nil then
					self:DeathEffects(self:GetPos(),0)
					return
				end
				self:SetPos(self.StartPos)
				self:SetAngles(self.StartAng)
				if self:GetPos() == ent:GetPos() then
					self:SetPos(ent:GetPos() +ent:OBBCenter())
					self:SetAngles(self.StartAng)
				end
			else
				self:SetPos(self.StartPos)
				self:SetAngles(self.StartAng)
			end
		else
			self:DeathEffects(self:GetPos(),0)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(pos,time)
	if self.Removed then return end
	self.Removed = true
	local owner = self:GetOwner()
	local ent = self.AttachEnt
	timer.Simple(time,function()
		if IsValid(self) then
			if IsValid(ent) then
				pos = ent:GetPos() +ent:OBBCenter()
				for i = 1,6 do
					local effectdata = EffectData()
					effectdata:SetOrigin(pos +Vector(math.Rand(-(4 *i),4 *i),math.Rand(-(4 *i),4 *i),math.Rand(-(4 *i),4 *i)))
					util.Effect("StunstickImpact",effectdata)
				end
				if !IsValid(owner) then
					owner = ent
				end
				local dmginfo = DamageInfo()
				dmginfo:SetDamage(25)
				dmginfo:SetAttacker(ent)
				dmginfo:SetInflictor(ent)
				dmginfo:SetDamageType(DMG_BLAST)
				dmginfo:SetDamagePosition(ent:GetPos() +ent:OBBCenter())
				ent:TakeDamageInfo(dmginfo)
				sound.Play("vj_halo3flood/weapons/needler_explode.wav",pos,70,100)
			else
				for i = 1,6 do
					local effectdata = EffectData()
					effectdata:SetOrigin(pos +Vector(math.Rand(-(4 *i),4 *i),math.Rand(-(4 *i),4 *i),math.Rand(-(4 *i),4 *i)))
					util.Effect("StunstickImpact",effectdata)
				end
				sound.Play("vj_halo3flood/weapons/needler_explode.wav",pos,70,100)
				if !IsValid(owner) then
					for _,v in ipairs(ents.FindInSphere(pos,150)) do
						if v.VJ_NPC_Class && table.HasValue(v.VJ_NPC_Class,"CLASS_FLOOD") then return end
						local dmginfo = DamageInfo()
						dmginfo:SetDamage(25)
						dmginfo:SetAttacker(v)
						dmginfo:SetInflictor(v)
						dmginfo:SetDamageType(DMG_BLAST)
						dmginfo:SetDamagePosition(v:GetPos() +v:OBBCenter())
						v:TakeDamageInfo(dmginfo)
					end
				else
					util.BlastDamage(owner,owner,pos,150,25)
				end
			end
			self:Remove()
		end
	end)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/