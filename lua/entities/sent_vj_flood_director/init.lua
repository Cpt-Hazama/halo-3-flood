AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.FloodClasses = {
	"npc_vj_flood_combat",
	"npc_vj_flood_combat",
	"npc_vj_flood_combat",
	"npc_vj_flood_combat",
	"npc_vj_flood_combat",
	"npc_vj_flood_combat",
	"npc_vj_flood_carrier",
	"npc_vj_flood_carrier",
	"npc_vj_flood_carrier",
	"npc_vj_flood_carrier",
	"npc_vj_flood_infection",
	"npc_vj_flood_infection",
	"npc_vj_flood_infection",
	"npc_vj_flood_infection",
	"npc_vj_flood_infection",
	"npc_vj_flood_infection",
	"npc_vj_flood_infection",
	"npc_vj_flood_infection",
	"npc_vj_flood_infection",
	"npc_vj_flood_infection",
	"npc_vj_flood_stalker",
	"npc_vj_flood_stalker",
	"npc_vj_flood_stalker",
	"npc_vj_flood_stalker",
	"npc_vj_flood_tank",
	"npc_vj_flood_tank",
	"npc_vj_flood_ranged",
	"npc_vj_flood_combat_brute",
	"npc_vj_flood_combat_brute",
	"npc_vj_flood_combat_brute",
	"npc_vj_flood_combat_brute",
	"npc_vj_flood_combat_brute",
	"npc_vj_flood_combat_elite",
	"npc_vj_flood_combat_elite",
	"npc_vj_flood_combat_elite",
	"npc_vj_flood_combat_elite",
	"npc_vj_flood_combat_elite_invis",
	"npc_vj_flood_combat_elite_invis",
}
ENT.previousNodes = {}
ENT.MobSpawnRate = 0.19 -- The difference in time between each spawned NPC

function ENT:Initialize()
	if table.Count(VJ_FLOOD_NODEPOS) <= 0 then
		error("No nodegraph detected! Play on a noded map to use the director. Nodes made using the nodegraph editor are undetectable as they're not actually nodes")
		self:Remove()
		return
	end
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetPos(Vector(0,0,0))
	self:SetNoDraw(true)
	self:DrawShadow(false)

	self:GraveMind()
	
	self.IsActivated = tobool(GetConVarNumber("vj_flood_director_enabled"))
	self.CI_SpawnDistance = GetConVarNumber("vj_flood_director_spawnmax")
	self.CI_SpawnDistanceClose = GetConVarNumber("vj_flood_director_spawnmin")
	self.CI_MobChance = GetConVarNumber("vj_flood_director_mobchance")
	self.CI_MobCooldownMin = GetConVarNumber("vj_flood_director_mobcooldownmin")
	self.CI_MobCooldownMax = GetConVarNumber("vj_flood_director_mobcooldownmax")
	self.CI_MaxInfected = GetConVarNumber("vj_flood_director_maxci")
	self.CI_MaxMobSpawn = GetConVarNumber("vj_flood_director_mobcount")
	self.SpawnableNPCs = {}
	self.tbl_SpawnedNPCs = {}
	self.tbl_NPCsWithEnemies = {}
	self.NextAICheckTime = CurTime() +5
	self.NextInfectedSpawnTime = CurTime() +1
	self.NextMobSpawnTime = CurTime() +math.Rand(self.CI_MobCooldownMin,self.CI_MobCooldownMax)
end

function ENT:GraveMind()
	for _,v in pairs(player.GetAll()) do
		local tbl = {
			"vj_halo3flood/gravemind/050mf_060_grv.wav",
			"vj_halo3flood/gravemind/050mf_070_grv.wav",
			"vj_halo3flood/gravemind/050mf_080_grv.wav",
			"vj_halo3flood/gravemind/050mg_010_grv.wav",
			"vj_halo3flood/gravemind/050mg_020_grv.wav",
			"vj_halo3flood/gravemind/050mg_030_grv.wav",
			"vj_halo3flood/gravemind/050mg_040_grv.wav"
		}
		v:EmitSound(tbl[math.random(1,#tbl)],50,100)
	end
end

function ENT:OnRemove()
	self:DoMusic(true)
	for index,object in ipairs(self.tbl_SpawnedNPCs) do
		if IsValid(object) then
			object:Remove()
		end
	end
end

function ENT:Think()
	self.IsActivated = tobool(GetConVarNumber("vj_flood_director_enabled"))
	if self.IsActivated then
		self:ManageVars()
		self:ManageAI()
	end
end

function ENT:ManageVars()
	self.CI_SpawnDistance = GetConVarNumber("vj_flood_director_spawnmax")
	self.CI_SpawnDistanceClose = GetConVarNumber("vj_flood_director_spawnmin")
	self.CI_MobChance = GetConVarNumber("vj_flood_director_mobchance")
	self.CI_MobCooldownMin = GetConVarNumber("vj_flood_director_mobcooldownmin")
	self.CI_MobCooldownMax = GetConVarNumber("vj_flood_director_mobcooldownmax")
	self.CI_MaxInfected = GetConVarNumber("vj_flood_director_maxci")
	self.CI_MaxMobSpawn = GetConVarNumber("vj_flood_director_mobcount")
	self.AI_RefreshTime = GetConVarNumber("vj_flood_director_refreshrate")
	self.Flood_Pure = GetConVarNumber("vj_flood_director_pureonly")
end

function ENT:CheckSurvivorDistance(ent)
	local survivors = self:FindSurvivors(ent:GetPos())
	local farthestSurvivor = survivors[table.Count(survivors)]
	if ent:GetPos():Distance(farthestSurvivor:GetPos()) >= GetConVarNumber("vj_flood_director_spawnmax") +750 && !ent:Visible(farthestSurvivor) then
		ent:Remove()
	end
end

function ENT:ManageAI()
	if self.Flood_Pure == 1 then
		self.SpawnableNPCs = {
			"npc_vj_flood_infection",
			"npc_vj_flood_infection",
			"npc_vj_flood_infection",
			"npc_vj_flood_infection",
			"npc_vj_flood_infection",
			"npc_vj_flood_infection",
			"npc_vj_flood_infection",
			"npc_vj_flood_infection",
			"npc_vj_flood_infection",
			"npc_vj_flood_carrier",
			"npc_vj_flood_carrier",
			"npc_vj_flood_carrier",
			"npc_vj_flood_carrier",
			"npc_vj_flood_carrier",
			"npc_vj_flood_stalker",
			"npc_vj_flood_stalker",
			"npc_vj_flood_stalker",
			"npc_vj_flood_tank",
		}
	else
		self.SpawnableNPCs = self.FloodClasses
	end

	-- Checks for inactive AI
	if CurTime() > self.NextAICheckTime then
		if table.Count(self.tbl_SpawnedNPCs) <= 0 then return end
		for _,v in ipairs(self.tbl_SpawnedNPCs) do
			if IsValid(v) then
				self:CheckSurvivorDistance(v)
				if IsValid(v:GetEnemy()) && !table.HasValue(self.tbl_NPCsWithEnemies,v) then
					table.insert(self.tbl_NPCsWithEnemies,v)
				elseif !IsValid(v:GetEnemy()) then
					if table.HasValue(self.tbl_NPCsWithEnemies,v) then
						table.remove(self.tbl_NPCsWithEnemies,self.tbl_NPCsWithEnemies[v])
					end
				end
			end
		end
		table.Empty(self.previousNodes) -- Reset the previously spawned-on nodes to refresh spawn positions
		self.previousNodes = {}
		self.NextAICheckTime = CurTime() +5
	end
	
	-- Manages Music
	if #self.tbl_NPCsWithEnemies > 0 then
		self:DoMusic(true)
	end

	-- Spawns AI
	if CurTime() > self.NextInfectedSpawnTime then
		if #self.tbl_SpawnedNPCs >= self.CI_MaxInfected -self.CI_MaxMobSpawn then return end -- Makes sure that we can at least spawn a mob when it's time
		self:SpawnInfected(VJ_PICKRANDOMTABLE(self.SpawnableNPCs),self:FindClearArea(false))
		self.NextInfectedSpawnTime = CurTime() +math.Rand(GetConVarNumber("vj_flood_director_delaymin"),GetConVarNumber("vj_flood_director_delaymax"))
	end

	-- Spawns Mobs
	if CurTime() > self.NextMobSpawnTime && math.random(1,self.CI_MobChance) == 1 then
		for i = 1,self.CI_MaxMobSpawn do
			timer.Simple(self.MobSpawnRate *i,function() -- Help with lag when spawning
				if IsValid(self) then
					self:SpawnInfected(VJ_PICKRANDOMTABLE(self.SpawnableNPCs),self:FindClearArea(true),true)
				end
			end)
		end
		self:GraveMind()
		self.NextMobSpawnTime = CurTime() +math.Rand(self.CI_MobCooldownMin,self.CI_MobCooldownMax)
	end
end

function ENT:DoMusic(stop)
	for _,v in ipairs(player.GetAll()) do
		v:SetNWBool("flooddir_music",stop)
	end
end

function ENT:CheckNodeVisibility(pos,survivor)
	local nodeCheck = ents.Create("prop_vj_animatable")
	nodeCheck:SetModel("models/Alyx.mdl")
	nodeCheck:SetPos(pos)
	nodeCheck:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	nodeCheck:Spawn()
	nodeCheck:Activate()
	nodeCheck:SetNoDraw(true)
	nodeCheck:DrawShadow(false)
	timer.Simple(0.02,function()
		if IsValid(nodeCheck) then
			nodeCheck:Remove()
		end
	end)
	return nodeCheck:Visible(survivor)
end

function ENT:ConfigureNodeTable(tbl)
	local newTable = {}
	local ply = self:PickRandomSurvivor()
	for _,v in pairs(tbl) do
		newTable[v] = v:Distance(ply:GetPos())
	end
	return table.SortByKey(newTable,true)
end

function ENT:FindClearArea(getClosest)
	if table.Count(self.tbl_SpawnedNPCs) >= self.CI_MaxInfected then return end
	if getClosest then
		if table.Count(VJ_FLOOD_NODEPOS) > 0 then
			for _,i in ipairs(self:ConfigureNodeTable(VJ_FLOOD_NODEPOS)) do
				local nodePos = i
				local survivor = self:FindSurvivors(nodePos)[1]
				if nodePos:Distance(survivor:GetPos()) <= self.CI_SpawnDistance && nodePos:Distance(survivor:GetPos()) > self.CI_SpawnDistanceClose then
					if !self:CheckNodeVisibility(nodePos,survivor) then
						table.insert(self.previousNodes,nodePos)
						return nodePos
					end
				end
			end
		end
	else
		if table.Count(VJ_FLOOD_NODEPOS) > 0 then
			for _,i in ipairs(self:ConfigureNodeTable(VJ_FLOOD_NODEPOS)) do
				local nodePos = i
				local survivor = self:FindSurvivors(nodePos)[1]
				if self.previousNodes[nodePos] then return end
				if nodePos:Distance(survivor:GetPos()) <= self.CI_SpawnDistance && nodePos:Distance(survivor:GetPos()) > self.CI_SpawnDistanceClose then
					-- if !survivor:VisibleVec(nodePos) then
					if !self:CheckNodeVisibility(nodePos,survivor) then
						if table.HasValue(self.previousNodes,nodePos) then return end
						table.insert(self.previousNodes,nodePos)
						return nodePos
					end
				end
			end
		end
	end
end

function ENT:PickRandomSurvivor()
	local tbl = {}
	for _,v in ipairs(player.GetAll()) do
		table.insert(tbl,v)
	end
	return VJ_PICKRANDOMTABLE(tbl)
end

function ENT:FindSurvivors(vec)
	local tb = {}
	if vec then
		for _,v in pairs(player.GetAll()) do
			tb[v] = v:GetPos():Distance(vec)
		end
		return table.SortByKey(tb,true)
	else
		for _,v in pairs(player.GetAll()) do
			table.insert(tb,v)
		end
		return tb
	end
end

function ENT:SpawnInfected(ent,pos,isMob)
	if pos == nil then /*MsgN("AI Director: Could not spawn SpawnableNPCs, no position specified!")*/ return end
	if table.Count(self.tbl_SpawnedNPCs) >= self.CI_MaxInfected then return end
	local infected = ents.Create(ent)
	infected:SetPos(pos)
	infected:Spawn()
	infected:Activate()
	table.insert(self.tbl_SpawnedNPCs,infected)
	if isMob then
		infected.FindEnemy_UseSphere = true
		infected.FindEnemy_CanSeeThroughWalls = true
		infected:DrawShadow(false)
		timer.Simple(0.02,function()
			if IsValid(infected) then
				infected:DrawShadow(false)
			end
		end)
	end
	infected.AI_Director = self
	function infected:CustomOnRemove()
		if IsValid(self.AI_Director) then
			table.remove(self.AI_Director.tbl_SpawnedNPCs,self.AI_Director.tbl_SpawnedNPCs[infected])
			if table.HasValue(self.AI_Director.tbl_NPCsWithEnemies,infected) then table.remove(self.AI_Director.tbl_NPCsWithEnemies,self.AI_Director.tbl_NPCsWithEnemies[tbl_SpawnedNPCs]) end
		end
	end
	infected.EntitiesToNoCollide = {
		"npc_vj_flood_combat",
		"npc_vj_flood_carrier",
		"npc_vj_flood_infection",
		"npc_vj_flood_stalker",
		"npc_vj_flood_tank",
		"npc_vj_flood_combat_brute",
		"npc_vj_flood_combat_elite",
		"npc_vj_flood_combat_elite_invis"
	}
end