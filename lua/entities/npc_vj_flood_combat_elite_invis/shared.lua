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

if CLIENT then
	function ENT:Initialize()
		local index = self:EntIndex()
		hook.Add("RenderScreenspaceEffects", "VJ_H3_EliteShieldFX_" .. index, function()
			if !IsValid(self) then
				hook.Remove("RenderScreenspaceEffects", "VJ_H3_EliteShieldFX_" .. index)
				return
			end
			local ent = self
			if !IsValid(ent) then return end
			local shieldT = ent:GetNWFloat("ShieldT")
			if !ent:GetNWBool("HasShield") then return end
			if CurTime() < shieldT then
				cam.Start3D(EyePos(),EyeAngles())
					if util.IsValidModel(ent:GetModel()) then
						render.SetBlend(1)
						render.MaterialOverride(Material("effects/h3_shield"))
						ent:DrawModel()
						render.MaterialOverride(0)
						render.SetBlend(1)
						render.SetBlend(1)
						render.MaterialOverride(Material("effects/h3_shield2"))
						ent:DrawModel()
						render.MaterialOverride(0)
						render.SetBlend(1)
					end
					if IsValid(ent:GetActiveWeapon()) then
						if util.IsValidModel(ent:GetActiveWeapon():GetModel()) then
							render.SetBlend(1)
							render.MaterialOverride(Material("effects/h3_shield"))
							ent:GetActiveWeapon():DrawModel()
							render.MaterialOverride(0)
							render.SetBlend(1)
							render.SetBlend(1)
							render.MaterialOverride(Material("effects/h3_shield2"))
							ent:GetActiveWeapon():DrawModel()
							render.MaterialOverride(0)
							render.SetBlend(1)
						end
					end
				cam.End3D()
			end
		end)
	end
end