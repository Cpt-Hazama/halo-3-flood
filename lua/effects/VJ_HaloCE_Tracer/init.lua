if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
/*--------------------------------------------------
	*** Copyright (c) 2012-2020 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
-- Based off of the GMod lasertracer
EFFECT.MainMat = Material("effects/hce_tracer")
EFFECT.FrontMat = Material("effects/hce_tracer_cap")

function EFFECT:Init(data)
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

	self.DieTime = CurTime() +self.TracerTime
end
---------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Think()
	if (CurTime() > self.DieTime) then
		local tr = util.TraceLine({
			start = self.StartPos,
			endpos = self.EndPos
		})
		if tr.Hit && tr.MatType then
			local mat = tr.MatType
			local metalMat = {[MAT_VENT]=true,[MAT_METAL]=true,[MAT_GRATE]=true,[MAT_GLASS]=true,[MAT_COMPUTER]=true}
			if metalMat[mat] then
				sound.Play("vj_impact_metal/bullet_metal/metalsolid" .. math.random(1,10) .. ".wav",self.EndPos,80,100)

				local Emitter = ParticleEmitter(self.EndPos)
				for i = 1,math.random(5,15) do
					local particle = Emitter:Add("effects/hce_tracer",self.EndPos)
					particle:SetVelocity(VectorRand() *math.Rand(100,350))
					particle:SetDieTime(math.Rand(0.1,1))
					particle:SetStartAlpha(200)
					particle:SetEndAlpha(0)
					particle:SetStartSize(1)
					particle:SetEndSize(3)
					particle:SetRoll(math.random(0,360))
					particle:SetGravity(Vector(math.random(-300,300),math.random(-300,300),math.random(-300,-700)))
					particle:SetCollide(true)
					particle:SetBounce(0.9)
					particle:SetAirResistance(120)
					particle:SetStartLength(0)
					particle:SetEndLength(0.1)
					particle:SetVelocityScale(true)
					particle:SetCollide(true)
					particle:SetColor(255,231,166)
				end
			end
		end
		return false
	end
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Render()
	local fDelta = (self.DieTime -CurTime()) /self.TracerTime
	fDelta = math.Clamp(fDelta,0,1) ^0.5
	render.SetMaterial(self.MainMat)
	local sinWave = math.sin(fDelta *math.pi)
	local pos = self.EndPos -self.Dir *(fDelta -sinWave *self.Length)
	local endPos = self.EndPos -self.Dir *(fDelta +sinWave *self.Length)
	local width = 1 +sinWave *3
	local startCord = 1
	local endCord = 0
	local col = Color(215, 200, 165, 25)
	render.DrawBeam(pos,endPos,width,startCord,endCord,col)

	render.SetMaterial(self.FrontMat)
	local EyeNormal = (EyePos() -pos):GetNormal()
	EyeNormal:Mul(self.Length /2)
	EyeNormal.z = 0
	render.DrawQuadEasy(pos,EyeNormal,width /2,width /2,col,(CurTime() *50) %360)
end
/*--------------------------------------------------
	*** Copyright (c) 2012-2020 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
