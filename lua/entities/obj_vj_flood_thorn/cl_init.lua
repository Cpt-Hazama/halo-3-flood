include('shared.lua')

language.Add("obj_vj_flood_thorn", "Flood Thorn")
killicon.Add("obj_vj_flood_thorn","HUD/killicons/default",Color(255,80,0,255))

language.Add("#obj_vj_flood_thorn", "Flood Thorn")
killicon.Add("#obj_vj_flood_thorn","HUD/killicons/default",Color(255,80,0,255))

function ENT:Draw()
	self.Entity:DrawModel()
end

function ENT:OnRemove()
end
