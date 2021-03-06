if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
/*--------------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
-- Based off of the GMod lasertracer
EFFECT.MainMat = Material("effects/spark")

function EFFECT:Init( data )
	self.StartPos = data:GetStart()
	self.EndPos = data:GetOrigin()
	local ent = data:GetEntity()
	local att = data:GetAttachment()

	if ( IsValid( ent ) && att > 0 ) then
		if (ent.Owner == LocalPlayer() && !LocalPlayer():GetViewModel() != LocalPlayer()) then ent = ent.Owner:GetViewModel() end
		att = ent:GetAttachment(att)
		if (att) then
			self.StartPos = att.Pos
		end
	end

	self.Dir = self.EndPos - self.StartPos
	self:SetRenderBoundsWS(self.StartPos, self.EndPos)
	self.TracerTime = math.min(1, self.StartPos:Distance(self.EndPos) / 10000) -- Calculate death time
	self.Length = 0.1

	local Emitter = ParticleEmitter(self.StartPos)
	for i = 1,2 do
		local size = math.random(8,10)
		local particle = Emitter:Add("particle/particle_glow_03",self.StartPos)
		particle:SetVelocity(self.Dir:Angle():Forward() *500)
		particle:SetDieTime(math.Rand(0.045,0.065))
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(size)
		particle:SetEndSize(1)
		if i == 1 then
			particle:SetColor(255,63,0)
		else
			particle:SetColor(127,0,255)
		end
		particle:SetAirResistance(160)
	end
	Emitter:Finish()

	self.DieTime = CurTime() + self.TracerTime
end
---------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Think()
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Render()
	local fDelta = (self.DieTime - CurTime()) / self.TracerTime
	fDelta = math.Clamp(fDelta, 0, 1) ^ 0.5
	render.SetMaterial(self.MainMat)
	local sinWave = math.sin(fDelta * math.pi)
	render.DrawBeam(
		self.EndPos - self.Dir * (fDelta - sinWave * self.Length),
		self.EndPos - self.Dir * (fDelta + sinWave * self.Length),
		1 + sinWave * 5, 1, 0, Color(255,63,0,255)
	)
end
/*--------------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
