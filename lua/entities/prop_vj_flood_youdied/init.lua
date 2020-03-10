if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
AddCSLuaFile("shared.lua")
include("shared.lua")
/*--------------------------------------------------
	=============== VJ Prop Animatable Entity ===============
	*** Copyright (c) 2012-2020 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
INFO: Used to make simple props and animate them, since prop_dynamic doesn't work properly in Garry's Mod...
--------------------------------------------------*/
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Initialize()
	self:SetModel("models/cpthazama/halo3/valve_morph.mdl")
	self:SetSolid(SOLID_OBB)
	local anim = "infection" .. math.random(1,2)
	local time = self:SequenceDuration(anim)
	self:ResetSequence(anim)
	self:SetPlaybackRate(1)
	self.RemoveTime = time
	if anim == "infection2" then
		timer.Simple(3.7,function()
			if IsValid(self) then
				VJ_EmitSound(self,"vj_gib/bones_snapping" .. math.random(1,3) .. ".wav",78,100)
			end
		end)
	end

	for i = 0,time *2 do
		timer.Simple(math.Clamp(i *math.Rand(0.1,0.5),0,time),function()
			if IsValid(self) then
				for i = 1, self:GetBoneCount() -1 do
					if self:GetBonePosition(i) == self:GetPos() then return end
					if math.random(1,4) == 1 then
						ParticleEffect("cpt_blood_flood",self:GetBonePosition(i),Angle(0,0,0),nil)
						sound.Play(VJ_PICKRANDOMTABLE({"vj_gib/gibbing1.wav","vj_gib/gibbing2.wav","vj_gib/gibbing3.wav"}),self:GetBonePosition(i),50,100 *GetConVarNumber("host_timescale"))
					end
				end
			end
		end)
	end

	self:ManipulateBoneAngles(21,Angle(0,0,180)) -- Neck
	self:ManipulateBoneAngles(14,Angle(0,0,90)) -- Left Hand
	self:ManipulateBoneAngles(47,Angle(0,0,90)) -- Right Hand
	self:ManipulateBoneAngles(1,Angle(0,0,0)) -- Left Thigh
	self:ManipulateBoneAngles(2,Angle(0,0,0)) -- Left Calf
	self:ManipulateBoneAngles(3,Angle(10,50,180)) -- Left Foot
	self:ManipulateBoneAngles(5,Angle(0,0,0)) -- Right Thigh
	self:ManipulateBoneAngles(6,Angle(0,0,0)) -- Right Calf
	self:ManipulateBoneAngles(7,Angle(10,50,180)) -- Right Foot

	self:ManipulateBonePosition(21,Vector(-3,0,0)) -- Neck
	self:ManipulateBonePosition(11,Vector(-3,0,0)) -- LClav
	self:ManipulateBonePosition(44,Vector(-3,0,0)) -- RClav
	self:ManipulateBonePosition(9,Vector(1,-4,0)) -- Spine4
	self:ManipulateBonePosition(10,Vector(5,0,0)) -- Spine4
	self:ManipulateBonePosition(54,Vector(-2,-1,0)) -- Spine2
	self:ManipulateBonePosition(55,Vector(-4,0,0)) -- Spine1
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AcceptInput(event)
	if event == "neck_snap" then
		VJ_EmitSound(self,"vj_gib/bones_snapping" .. math.random(1,3) .. ".wav",78,100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
	self:NextThink(CurTime())
	return true
end
/*--------------------------------------------------
	=============== VJ Prop Animatable Entity ===============
	*** Copyright (c) 2012-2020 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
INFO: Used to make simple props and animate them, since prop_dynamic doesn't work properly in Garry's Mod...
--------------------------------------------------*/
