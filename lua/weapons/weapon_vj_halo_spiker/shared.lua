if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "Spiker Rifle"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base"
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.MadeForNPCsOnly 			= true -- Is tihs weapon meant to be for NPCs only?
SWEP.WorldModel					= "models/cpthazama/halo3/weapons/spiker.mdl"
SWEP.HoldType 					= "ar2"
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_NextPrimaryFire 		= 0.16 -- Next time it can use primary fire
SWEP.NPC_CustomSpread	 		= 1
SWEP.NPC_TimeUntilFire	 		= 0.01 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {0.08} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
	-- World Model ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel_UseCustomPosition = true -- Should the gun use custom position? This can be used to fix guns that are in the crotch
SWEP.WorldModel_CustomPositionAngle = Vector(3,0,-5)
SWEP.WorldModel_CustomPositionOrigin = Vector(-1,12,-1)
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= 3 -- Damage
SWEP.Primary.Force				= 1 -- Force applied on the object the bullet hits
SWEP.Primary.ClipSize			= 160 -- Max amount of bullets per clip
SWEP.Primary.Ammo				= "AR2" -- Ammo type
SWEP.Primary.Sound				= {
	"vj_halo3flood/spike_rifle1.wav",
	"vj_halo3flood/spike_rifle2.wav",
	"vj_halo3flood/spike_rifle3.wav",
	"vj_halo3flood/spike_rifle4.wav",
	"vj_halo3flood/spike_rifle5.wav",
	"vj_halo3flood/spike_rifle6.wav",
}
SWEP.Primary.DistantSound		= {
	"vj_halo3flood/spike_rifle_lod_far2.wav",
	"vj_halo3flood/spike_rifle_lod_far3.wav",
	"vj_halo3flood/spike_rifle_lod_far4.wav",
	"vj_halo3flood/spike_rifle_lod_far6.wav",
}
SWEP.Primary.TracerType			= "VJ_HaloCE_Spiker"
SWEP.PrimaryEffects_MuzzleAttachment = "muzzle"
SWEP.PrimaryEffects_MuzzleFlash = false
SWEP.PrimaryEffects_SpawnShells = false
SWEP.PrimaryEffects_DynamicLightColor = Color(255,63,0)