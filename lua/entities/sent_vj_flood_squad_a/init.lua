AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.MaxLeaveDistance = 300
ENT.tbl_SquadSpawn = {
	[1] = {class="npc_vj_flood_combat",forward=0,right=0,up=0,entity=NULL},
	[2] = {class="npc_vj_flood_carrier",forward=90,right=0,up=0,entity=NULL},
	[3] = {class="npc_vj_flood_infection",forward=0,right=50,up=0,entity=NULL},
	[4] = {class="npc_vj_flood_infection",forward=0,right=-50,up=0,entity=NULL},
	[5] = {class="npc_vj_flood_infection",forward=-50,right=0,up=0,entity=NULL},
	[6] = {class="npc_vj_flood_infection",forward=-50,right=50,up=0,entity=NULL},
	[7] = {class="npc_vj_flood_infection",forward=50,right=-50,up=0,entity=NULL},
}
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/