AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.MaxLeaveDistance = 300
ENT.tbl_SquadSpawn = {}

function ENT:Initialize()
	self:SetNoDraw(true)
	self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	self.Squad = {}
	-- self.Leader = false
	for i = 1,#self.tbl_SquadSpawn do
		local tbl = self.tbl_SquadSpawn[i]
		local ent = ents.Create(tbl.class)
		local sPos = self:GetUp() *tbl.up +self:GetRight() *tbl.right +self:GetForward() *tbl.forward
		ent:SetPos(self:GetPos() +sPos)
		ent:Spawn()
		ent:SetOwner(self)
		-- if i == #self.tbl_SquadSpawn then self:Remove() end
		-- if i == 1 then
			-- self:SetParent(ent)
			-- self.Leader = ent
			-- Entity(1):SetPos(ent:GetPos())
		-- end
		-- ent.SquadPosition = sPos
		-- ent.DisableChasingEnemy = true
		-- tbl.entity = ent
		table.insert(self.Squad,ent)
	end
end

function ENT:MoveInGroup(v)
	v:SetLastPosition(self:GetPos() +v.SquadPosition)
	v:VJ_TASK_GOTO_LASTPOS("TASK_RUN_PATH")
	v.DisableChasingEnemy = true
end

function ENT:Think()
	-- if #self.Squad <= 0 then self:Remove() end
	-- for k,v in pairs(self.Squad) do
		-- local tbl = {}
		-- if self.tbl_SquadSpawn[k].entity == v then
			-- tbl = self.tbl_SquadSpawn[k]
		-- end
		-- if !IsValid(v) then
			-- table.remove(self.Squad,k)
			-- return
		-- end
		-- if !IsValid(self.Leader) then
			-- self.Leader = IsValid(self.Squad[k +1]) && self.Squad[k +1]
		-- else
			-- if self.Leader == v then v.DisableWandering = false else v.DisableWandering = true end
		-- end
		-- v.SquadPosition = self.Leader:GetPos() +self.Leader:GetUp() *tbl.up +self.Leader:GetRight() *tbl.right +self.Leader:GetForward() *tbl.forward
		-- if IsValid(v:GetEnemy()) then
			-- local dist = v:GetPos():Distance(v:GetEnemy():GetPos())
			-- if dist <= self.MaxLeaveDistance then
				-- v.DisableChasingEnemy = false
			-- else
				-- v.DisableChasingEnemy = true
			-- end
		-- else
			-- if v != self.Leader then
				-- self:MoveInGroup(v)
			-- end
		-- end
	-- end
end

function ENT:OnRemove()
	for _,v in pairs(self.Squad) do
		if IsValid(v) then
			v:Remove()
		end
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/