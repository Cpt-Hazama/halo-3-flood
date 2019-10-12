ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Plasma Fire!"
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= "Projectiles for my bullseye weapon"
ENT.Category		= "Dan's SNPCS"

if (CLIENT) then
	local Name = "Needle"
	local LangName = "obj_vj_halo_needle_dead"
	language.Add(LangName, Name)
	killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
	language.Add("#"..LangName, Name)
	killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end