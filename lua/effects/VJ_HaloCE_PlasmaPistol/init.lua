if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
/*--------------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
-- Based off of the GMod lasertracer
EFFECT.MainMat 					= Material("effects/stunstick")
EFFECT.TracerColor				= Color(33,255,0,255)
EFFECT.Speed 					= 10000
EFFECT.Length 					= 100

EFFECT.DynamicLightColor		= Color(33,255,0,255)
EFFECT.DynamicLightBrightness	= 2
EFFECT.DynamicLightSize			= 100

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

	self.Dir = self.EndPos -self.StartPos
	self:SetRenderBoundsWS(self.StartPos, self.EndPos)
	
	self.Normal = self.Dir:GetNormal()
	self.StartTime = 0
	self.TracerTime = (self.Dir:Length() +self.Length) / self.Speed -- Calculate death time
	self.Length = 0.1

	self.DieTime = CurTime() +self.TracerTime
end
---------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Think()
	-- self.TracerTime = self.TracerTime -FrameTime()
	self.StartTime = self.StartTime +FrameTime()
	if (CurTime() > self.DieTime) then -- If it's dead then...
		util.Decal("fadingscorch", self.EndPos +self.Dir:GetNormalized(), self.EndPos -self.Dir:GetNormalized())

		local effectdata = EffectData()
		effectdata:SetOrigin(self.EndPos + self.Dir:GetNormalized() * -2)
		effectdata:SetNormal(self.Dir:GetNormalized() * -3)
		effectdata:SetMagnitude(0.1)
		effectdata:SetScale(0.8)
		effectdata:SetRadius(5)
		util.Effect("Sparks", effectdata)
		return false
	end
	
	local dLight = DynamicLight(self:EntIndex())
	local endPos = self.StartPos +self.Normal *(self.Speed *self.StartTime)
	if dLight then
		dLight.r = self.DynamicLightColor.r
		dLight.g = self.DynamicLightColor.g
		dLight.b = self.DynamicLightColor.b
		dLight.Pos = endPos
		dLight.Brightness = self.DynamicLightBrightness
		dLight.Decay = 1000
		dLight.Size = self.DynamicLightSize
		dLight.DieTime = CurTime() +3
		dLight.Style = 6
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
	local width = 5 +sinWave *10
	local startCord = 8
	local endCord = 0
	local col = self.TracerColor
	render.DrawBeam(pos,endPos,width,startCord,endCord,col)

	local EyeNormal = (EyePos() -pos):GetNormal()
	EyeNormal:Mul(self.Length /2)
	EyeNormal.z = 0
	render.DrawQuadEasy(pos,EyeNormal,width,width,col,(CurTime() *50) %360)
end
/*--------------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
