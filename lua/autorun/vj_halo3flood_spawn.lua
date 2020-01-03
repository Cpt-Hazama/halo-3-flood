/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Halo 3 Flood SNPCs"
local AddonName = "Halo 3 Flood"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_halo3flood_spawn.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')
	
	VJ_FLOOD_NODEPOS = {}
	
	hook.Add("EntityRemoved","VJ_AddNodes_FLOOD",function(ent)
		if ent:GetClass() == "info_node" then
			table.insert(VJ_FLOOD_NODEPOS,ent:GetPos())
		end
	end)
	
	hook.Add("PlayerDeath","VJ_Halo3Flood_MuffinRemove",function(ply)
		for _,v in pairs(ply.tbl_EnemyMuffins) do
			if IsValid(v) then
				v:Remove()
			end
		end
	end)

	hook.Add("PlayerSpawn","VJ_Halo3Flood_MuffinValues",function(ply)
		ply.VJ_IsMuffinInfected = false
		ply.tbl_EnemyMuffins = {}
	end)
	
	local NPC = FindMetaTable("NPC")
	local ENT = FindMetaTable("Entity")
	local Phys = FindMetaTable("PhysObj")

	function ENT:MuffinFollowCode(targetEntity)
		local index = "VJ_Halo3Flood_Muffins_" .. self:EntIndex()
		if !IsValid(targetEntity) then
			hook.Remove("Think",index)
			return
		end
		-- if targetEntity:GetClass() == "prop_ragdoll" then
			-- targetEntity = targetEntity:GetPhysicsObject()
		-- end
		local muffins = targetEntity.tbl_EnemyMuffins
		if targetEntity == self then
			muffins = self.tbl_Muffins
		end
		if !muffins then
			hook.Remove("Think",index)
			return
		end
		hook.Add("Think",index,function()
			if !targetEntity:IsValid() then
				hook.Remove("Think",index)
			else
				if muffins then
					for bone,muf in pairs(muffins) do
						if IsValid(muf) then
							if muf:GetPos() == targetEntity:GetPos() then SafeRemoveEntity(muf) end
							local bonepos,boneang = targetEntity:GetBonePosition(bone)
							muf:SetPos(bonepos)
							muf:SetAngles(boneang)
						end
					end
				end
			end
		end)
	end

	function NPC:FloodFollowBone(targetEntity,boneID) -- Credits to Silverlan as I used some of his bone code
		local index = "VJ_Halo3Flood_Bone_" .. self:EntIndex()
		if !targetEntity then
			hook.Remove("Think",index)
			return
		end
		local bonepos,boneang = targetEntity:GetBonePosition(boneID)
		if !bonepos then
			hook.Remove("Think",index)
			return
		end
		local posOffset = (self:GetPos() -bonepos)
		local angOffset = (self:GetAngles() -targetEntity:GetAngles())
		hook.Add("Think",index,function()
			if !targetEntity:IsValid() || !self:IsValid() then
				hook.Remove("Think",index)
			else
				local bonepos,boneang = targetEntity:GetBonePosition(boneID)
				if(bonepos) then
					boneang = targetEntity:GetAngles()
					bonepos = bonepos +posOffset
					boneang = boneang +angOffset
					self:SetPos(bonepos)
					self:SetAngles(boneang)
				end
			end
		end)
	end
	
	function NPC:PlayVJFloodAnimation(act,face)
		self:VJ_ACT_PLAYACTIVITY(act,true,false,face,0)
	end

	function NPC:GravemindSpeak()
		if !self.VJ_IsBeingControlled then return end
		if self.VJ_Halo_Gravemind == nil then
			self.VJ_Halo_Gravemind = CurTime() -1
		end
		if CurTime() > self.VJ_Halo_Gravemind then
			local lines = {
				"vj_halo3flood/gravemind/050mf_060_grv.wav",
				"vj_halo3flood/gravemind/050mf_070_grv.wav",
				"vj_halo3flood/gravemind/050mf_080_grv.wav",
				"vj_halo3flood/gravemind/050mg_010_grv.wav",
				"vj_halo3flood/gravemind/050mg_020_grv.wav",
				"vj_halo3flood/gravemind/050mg_030_grv.wav",
				"vj_halo3flood/gravemind/050mg_040_grv.wav"
			}
			VJ_EmitSound(self.VJ_TheController,lines,0.1,100)
			self.VJ_Halo_Gravemind = CurTime() +math.Rand(90,150)
		end
	end

	function NPC:VJ_SwitchController(newent,ply)
		if !self.VJ_IsBeingControlled then return end
		local ply = ply or self.VJ_TheController
		self.VJ_TheControllerEntity:StopControlling()
		local SpawnControllerObject = ents.Create("ob_vj_npccontroller")
		SpawnControllerObject.TheController = ply
		SpawnControllerObject:SetControlledNPC(newent)
		SpawnControllerObject:Spawn()
		SpawnControllerObject:StartControlling()
	end
	
	function NPC:VJ_PlayerInfection(newent,ply)
		local SpawnControllerObject = ents.Create("ob_vj_npccontroller")
		SpawnControllerObject.TheController = ply
		SpawnControllerObject:SetControlledNPC(newent)
		SpawnControllerObject:Spawn()
		SpawnControllerObject:StartControlling()
	end
	
	VJ.AddNPCWeapon("VJ_H3F_BattleRifle","weapon_vj_halo_br")
	VJ.AddNPCWeapon("VJ_H3F_MA5B-CE","weapon_vj_halo_ma5b")
	VJ.AddNPCWeapon("VJ_H3F_Needler-Reach","weapon_vj_halo_needler")
	VJ.AddNPCWeapon("VJ_H3F_PlasmaRifle-CE","weapon_vj_halo_plasma")
	VJ.AddNPCWeapon("VJ_H3F_PlasmaPistol-3","weapon_vj_halo_plasmapistol")
	VJ.AddNPCWeapon("VJ_H3F_PlasmaRifle-3","weapon_vj_halo_plasmarifle")
	VJ.AddNPCWeapon("VJ_H3F_M90-3","weapon_vj_halo_shotgun")
	VJ.AddNPCWeapon("VJ_H3F_SMG-3","weapon_vj_halo_smg")
	VJ.AddNPCWeapon("VJ_H3F_Type25-3","weapon_vj_halo_spiker")

	local vUNSCWep = {
		"weapon_vj_halo_br",
		"weapon_vj_halo_ma5b",
		"weapon_vj_halo_shotgun",
		"weapon_vj_halo_smg"
	}
	local vCOVWep = {
		"weapon_vj_halo_needler",
		"weapon_vj_halo_plasma",
		"weapon_vj_halo_plasmapistol",
		"weapon_vj_halo_plasmarifle",
		"weapon_vj_halo_spiker"
	}
	
	local vCat = "Halo 3 Flood"
	VJ.AddNPC("Flood Combat Form","npc_vj_flood_combat",vCat)
	VJ.AddNPC("Flood Carrier Form","npc_vj_flood_carrier",vCat)
	VJ.AddNPC("Flood Infection Form","npc_vj_flood_infection",vCat)
	VJ.AddNPC("Flood Stalker Form","npc_vj_flood_stalker",vCat)
	VJ.AddNPC("Flood Tank Form","npc_vj_flood_tank",vCat)
	VJ.AddNPC("Flood Ranged Form","npc_vj_flood_ranged",vCat)
	VJ.AddNPC("Flood Combat Jiralhanae Form","npc_vj_flood_combat_brute",vCat)
	VJ.AddNPC("Flood Combat Sangheili Form","npc_vj_flood_combat_elite",vCat)
	VJ.AddNPC("Flood Combat Sangheili Form (Camo)","npc_vj_flood_combat_elite_invis",vCat)
	VJ.AddNPC("Flood Spawner","sent_vj_flood_randflood",vCat)
	VJ.AddNPC("Flood Combat Spawner","sent_vj_flood_randcombat",vCat)
	VJ.AddNPC("Pure Flood Spawner","sent_vj_flood_randpureflood",vCat)
	VJ.AddNPC("Flood Infection Spawner","sent_vj_flood_randinfection",vCat)
	VJ.AddNPC("Map Flood Spawner","sent_vj_flood_director",vCat)

	-- Precache Particles -------------------------------------------------------------------------------------------------------------------------
	game.AddParticles("particles/flood.pcf")
	game.AddParticles("particles/cpt_flood_blood_impact.pcf")
	game.AddParticles("particles/cpt_flood_effects.pcf")
	game.AddParticles("particles/cpt_flood_infection.pcf")
	game.AddParticles("particles/cpt_flood_spores.pcf")
	-- f_car_explosion
	-- f_hdyn_chest
	-- f_hydn_chest_chunks
	-- f_inf_chunks
	
	-- Director --
	VJ.AddConVar("vj_flood_director_enabled",1)
	VJ.AddConVar("vj_flood_director_maxci",80)
	VJ.AddConVar("vj_flood_director_mobcount",35)
	VJ.AddConVar("vj_flood_director_spawnmax",2000)
	VJ.AddConVar("vj_flood_director_spawnmin",650)
	VJ.AddConVar("vj_flood_director_mobchance",100)
	VJ.AddConVar("vj_flood_director_mobcooldownmin",120)
	VJ.AddConVar("vj_flood_director_mobcooldownmax",180)
	VJ.AddConVar("vj_flood_director_delaymin",0.85)
	VJ.AddConVar("vj_flood_director_delaymax",3)
	VJ.AddConVar("vj_flood_director_pureonly",0)
	VJ.AddClientConVar("vj_flood_director_music",1)

	if CLIENT then
		hook.Add("PopulateToolMenu", "VJ_ADDTOMENU_FLOODDIR", function()
			spawnmenu.AddToolMenuOption("DrVrej", "SNPC Configures", "Halo 3 Flood - Director", "Halo 3 Flood - Director", "", "", function(Panel)
				if !game.SinglePlayer() then
				if !LocalPlayer():IsAdmin() or !LocalPlayer():IsSuperAdmin() then
					Panel:AddControl( "Label", {Text = "You are not an admin!"})
					Panel:AddControl("Checkbox", {Label = "Enable Music?", Command = "vj_flood_director_music"})
					Panel:ControlHelp("Notice: Only admins can change this settings")
					return
					end
				end
				Panel:AddControl("Label", {Text = "Notice: Only admins can change this settings."})
				Panel:AddControl("Checkbox", {Label = "Enable AI Director processing?", Command = "vj_flood_director_enabled"})
				Panel:AddControl("Checkbox", {Label = "Enable Music?", Command = "vj_flood_director_music"})
				Panel:AddControl("Checkbox", {Label = "Pure Flood Only", Command = "vj_flood_director_pureonly"})
				Panel:AddControl("Slider", { Label 	= "Max Flood", Command = "vj_flood_director_maxci", Type = "Float", Min = "5", Max = "400"})
				Panel:AddControl("Slider", { Label 	= "Min Distance they can spawn from players", Command = "vj_flood_director_spawnmin", Type = "Float", Min = "150", Max = "30000"})
				Panel:AddControl("Slider", { Label 	= "Max Distance they can spawn from players", Command = "vj_flood_director_spawnmax", Type = "Float", Min = "150", Max = "30000"})
				Panel:AddControl("Slider", { Label 	= "Min time between spawns", Command = "vj_flood_director_delaymin", Type = "Float", Min = "0.1", Max = "15"})
				Panel:AddControl("Slider", { Label 	= "Max time between spawns", Command = "vj_flood_director_delaymax", Type = "Float", Min = "0.2", Max = "15"})
				Panel:AddControl("Slider", { Label 	= "Max Mob Flood", Command = "vj_flood_director_mobcount", Type = "Float", Min = "5", Max = "400"})
				Panel:ControlHelp("Must be greater than Max Flood option, otherwise nothing will spawn!")
				Panel:AddControl("Slider", { Label 	= "Chance that a mob will appear", Command = "vj_flood_director_mobchance", Type = "Float", Min = "1", Max = "500"})
				Panel:AddControl("Slider", { Label 	= "Min cooldown time for mob spawns", Command = "vj_flood_director_mobcooldownmin", Type = "Float", Min = "1", Max = "800"})
				Panel:AddControl("Slider", { Label 	= "Max cooldown time for mob spawns", Command = "vj_flood_director_mobcooldownmax", Type = "Float", Min = "1", Max = "800"})
			end, {})
		end)
	end

	-- Menu -------------------------------------------------------------------------------------------------------------------------
	local AddConvars = {}
	AddConvars["vj_halo_infectexplode"] = 0 -- Infection Forms explode?
	AddConvars["vj_halo_developmenttime"] = 500
	AddConvars["vj_halo_useweps"] = 1
	AddConvars["vj_halo_muffins"] = 0
	AddConvars["vj_halo_transform"] = 1
	AddConvars["vj_halo_unlimitedammo"] = 0
	for k, v in pairs(AddConvars) do
		if !ConVarExists( k ) then CreateConVar( k, v, {FCVAR_ARCHIVE} ) end
	end
	if (CLIENT) then
		local function VJ_HALOFLOOD_MAIN(Panel)
			if !game.SinglePlayer() then
			if !LocalPlayer():IsAdmin() or !LocalPlayer():IsSuperAdmin() then
				Panel:AddControl( "Label", {Text = "You are not an admin!"})
				Panel:ControlHelp("Notice: Only admins can change this settings.")
				return
				end
			end
			Panel:AddControl( "Label", {Text = "Notice: Only admins can change this settings."})
			local vj_h3freset = {Options = {}, CVars = {}, Label = "Reset Everything:", MenuButton = "0"}
			vj_h3freset.Options["#vjbase.menugeneral.default"] = { 
			vj_halo_infectexplode = "0",
			vj_halo_useweps = "1",
			vj_halo_muffins = "0",
			vj_halo_transform = "1",
			vj_halo_unlimitedammo = "0"
			}
			Panel:AddControl("ComboBox", vj_h3freset)
			Panel:AddControl("Checkbox", {Label = "Infection Forms explode on attack?", Command = "vj_halo_infectexplode"})
			Panel:AddControl("Checkbox", {Label = "Flood Combat Forms can use weapons?", Command = "vj_halo_useweps"})
			Panel:AddControl("Checkbox", {Label = "Flood Combat Forms can grow muffins?", Command = "vj_halo_muffins"})
			Panel:AddControl("Checkbox", {Label = "Flood Pure Forms can transform?", Command = "vj_halo_transform"})
			Panel:AddControl("Checkbox", {Label = "Flood Combat Forms have unlimited ammo?", Command = "vj_halo_unlimitedammo"})
		end
		local function VJ_HALOFLOOD_ALL(Panel)
			if !game.SinglePlayer() then
			if !LocalPlayer():IsAdmin() or !LocalPlayer():IsSuperAdmin() then
				Panel:AddControl( "Label", {Text = "You are not an admin!"})
				Panel:ControlHelp("Notice: Only admins can change this settings.")
				return
				end
			end
			Panel:AddControl( "Label", {Text = "Notice: Only admins can change this settings."})
			local vj_hflfreset = {Options = {}, CVars = {}, Label = "Reset Everything:", MenuButton = "0"}
			vj_hflfreset.Options["#vjbase.menugeneral.default"] = { 
			vj_halo_developmenttime = "500"
			}
			Panel:AddControl("ComboBox", vj_hflfreset)
			Panel:AddControl("Slider", { Label 	= "Flood Development Time", Command = "vj_halo_developmenttime", Type = "Float", Min = "10", Max = "3000"})
		end
		function VJ_ADDTOMENU_HALOFLOOD()
			spawnmenu.AddToolMenuOption( "DrVrej", "SNPC Configures", "Halo 3 Flood", "Halo 3 Flood", "", "", VJ_HALOFLOOD_MAIN, {} )
			spawnmenu.AddToolMenuOption( "DrVrej", "SNPC Configures", "Global Flood Control", "Global Flood Control", "", "", VJ_HALOFLOOD_ALL, {} )
		end
		hook.Add( "PopulateToolMenu", "VJ_ADDTOMENU_HALOFLOOD", VJ_ADDTOMENU_HALOFLOOD )
	end
-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end