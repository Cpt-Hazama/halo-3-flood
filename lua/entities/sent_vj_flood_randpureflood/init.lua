AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/props_junk/popcan01a.mdl"} -- The models it should spawn with | Picks a random one from the table
local ent_tbl = {
	"npc_vj_flood_tank",
	"npc_vj_flood_ranged",
	"npc_vj_flood_ranged",
	"npc_vj_flood_stalker",
	"npc_vj_flood_stalker",
	"npc_vj_flood_stalker",
	"npc_vj_flood_stalker",
	"npc_vj_flood_stalker",
	"npc_vj_flood_infection",
	"npc_vj_flood_infection",
	"npc_vj_flood_infection",
	"npc_vj_flood_infection",
	"npc_vj_flood_infection"
}
ENT.EntitiesToSpawn = {
	{EntityName = "NPC1",SpawnPosition = {vForward=50,vRight=0,vUp=0},Entities = ent_tbl},
	{EntityName = "NPC2",SpawnPosition = {vForward=0,vRight=100,vUp=0},Entities = ent_tbl},
	{EntityName = "NPC3",SpawnPosition = {vForward=100,vRight=100,vUp=0},Entities = ent_tbl},
	{EntityName = "NPC4",SpawnPosition = {vForward=100,vRight=-100,vUp=0},Entities = ent_tbl},
	{EntityName = "NPC5",SpawnPosition = {vForward=0,vRight=-100,vUp=0},Entities = ent_tbl},
}
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/