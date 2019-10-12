ENT.Base 			= "npc_vj_flood_combat_elite"
ENT.Type 			= "ai"
ENT.PrintName 		= "Flood Combat Sangheili Form"
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= "Halo Flood"

if (CLIENT) then
local Name = "Flood Combat Sangheili Form"
local LangName = "npc_vj_flood_combat_elite_invis"
language.Add(LangName, Name)
killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
language.Add("#"..LangName, Name)
killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end