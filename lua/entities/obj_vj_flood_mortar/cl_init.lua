include('shared.lua')

local lang = {name="Spore Cloud",class="obj_vj_flood_mortar"}
language.Add(lang.class,lang.name)
killicon.Add(lang.class,"HUD/killicons/default",Color(255,80,0,255))
language.Add("#" .. lang.class,lang.name)
killicon.Add("#" .. lang.class,"HUD/killicons/default",Color(255,80,0,255))

function ENT:Draw()
	-- self.Entity:DrawModel()
end