include('shared.lua')

function ENT:Initialize()

end

function ENT:Draw()
	return false
end

function ENT:OnRemove()
	for _,v in pairs(player.GetAll()) do
		if v.VJ_FloodDir_Music then v.VJ_FloodDir_Music:Stop() end
		if v.NextFMusT then v.NextFMusT = 0 end
	end
end

function ENT:Think()
	for _,v in pairs(player.GetAll()) do
		local mus = v:GetNWBool("flooddir_music")
		self:DoMusic(!mus,v)
	end
end

function ENT:DoMusic(stop,v)
	if stop then
		if v.VJ_FloodDir_Music then v.VJ_FloodDir_Music:Stop() end
		if v.NextFMusT then v.NextFMusT = 0 end
	else
		if !v.VJ_FloodDir_Music then
			v.VJ_FloodDir_Music = CreateSound(v,"vj_halo3flood/dir/floodgate.wav")
			v.VJ_FloodDir_Music:SetSoundLevel(50)
		end
		if v.NextFMusT == nil then v.VJ_FloodDir_Music:Play(); v.NextFMusT = CurTime() +SoundDuration("vj_halo3flood/dir/floodgate.wav") end
		if CurTime() > v.NextFMusT then
			v.VJ_FloodDir_Music:Stop()
			v.VJ_FloodDir_Music:Play()
			v.NextFMusT = CurTime() +SoundDuration("vj_halo3flood/dir/floodgate.wav")
		end
	end
end