AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.MaxLeaveDistance = 300
ENT.tbl_SquadSpawn = {
	[1] = {class="npc_vj_flood_stalker",forward=0,right=0,up=0},
	[2] = {class="npc_vj_flood_infection",forward=math.Rand(-150,150),right=math.Rand(-150,150),up=0},
	[3] = {class="npc_vj_flood_infection",forward=math.Rand(-150,150),right=math.Rand(-150,150),up=0},
	[4] = {class="npc_vj_flood_infection",forward=math.Rand(-150,150),right=math.Rand(-150,150),up=0},
	[5] = {class="npc_vj_flood_infection",forward=math.Rand(-150,150),right=math.Rand(-150,150),up=0},
	[6] = {class="npc_vj_flood_infection",forward=math.Rand(-150,150),right=math.Rand(-150,150),up=0},
	[7] = {class="npc_vj_flood_infection",forward=math.Rand(-150,150),right=math.Rand(-150,150),up=0},
	[8] = {class="npc_vj_flood_infection",forward=math.Rand(-150,150),right=math.Rand(-150,150),up=0},
	[9] = {class="npc_vj_flood_infection",forward=math.Rand(-150,150),right=math.Rand(-150,150),up=0},
}
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/