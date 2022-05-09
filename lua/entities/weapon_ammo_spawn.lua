AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Ammunition Pile"
ENT.Author = "Matsilagi"
ENT.Category = "Left 4 Dead 2"
ENT.Editable = true
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.UseTimer = CurTime()

function ENT:Draw()
	self:DrawModel()
end

if SERVER then
	function ENT:Initialize()
		if SERVER then
			self:SetModel( "models/props/arccw_uc/coffeeammo.mdl" )
			self:SetMoveType( MOVETYPE_VPHYSICS )
			self:SetSolid( SOLID_VPHYSICS )
			self:PhysicsInit( SOLID_VPHYSICS )
			self:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE )
			self:DrawShadow( true )
		end
	end

	function ENT:Use( activator, caller )
		local curweap = activator:GetActiveWeapon()
		local wepammo = curweap:GetPrimaryAmmoType() or nil
		local wepammo2 = curweap:GetSecondaryAmmoType() or false
		
		if wepammo == nil or wepammo < 0 then self.UseTimer = CurTime() + 1 return end
		
		if self.UseTimer <= CurTime() and activator:IsPlayer() then
			local maxclip = curweap:GetMaxClip1()
			local maxclip2 = curweap:GetMaxClip2()
			local mag1 = curweap:Clip1()
			local mag2 = curweap:Clip2()
			local ammotogive = 0
			local ammotogive2 = 0
			
			if wepammo1 != false or wepammo1 != nil then
				if mag1 >= 0 and maxclip != nil then
					ammotogive = (maxclip*10) - mag1
				elseif mag1 < 0 and wepammo >= 0 and activator:GetAmmoCount(wepammo) >= 0 then
					if activator:GetActiveWeapon().Primary == nil then
						ammotogive = 10
					else
						ammotogive = (activator:GetActiveWeapon().Primary.DefaultClip * 10)
					end
				else
					ammotogive =10
				end
			
				activator:SetAmmo(ammotogive, wepammo)
			end
			
			if wepammo2 != false or wepammo2 != nil then
				if mag2 >= 0 and maxclip2 != nil then
					ammotogive2 = (maxclip2*10) - mag2
				elseif mag2 < 0 and wepammo2 >= 0 and activator:GetAmmoCount(wepammo2) >= 0 then
					if activator:GetActiveWeapon().Secondary == nil then
						ammotogive2 = 10
					else
						ammotogive2 = (activator:GetActiveWeapon().Secondary.DefaultClip * 10)
					end
				else
					ammotogive2 = 10
				end
			
				activator:SetAmmo(ammotogive2, wepammo2)
			end
			
			self:EmitSound( "BaseCombatCharacter.AmmoPilePickup" )
			self.UseTimer = CurTime() + 1
		end
	end

else

	function ENT:BeingLookedAtByLocalPlayer() --I copied this from Arc9, thanks Darcy!
		local ply = LocalPlayer()
		if !IsValid(ply) then return false end
		local dist = 20000
		local pos = ply:EyePos()

		if pos:DistToSqr(self:GetPos()) <= dist then
			return util.TraceLine({
				start = pos,
				endpos = pos + (ply:GetAngles():Forward() * dist),
				filter = ply
			}).Entity == self
			end
		return false
	end

	function ENT:Think()
		local ply = LocalPlayer()
		if !IsValid(ply) then return false end
		local closedist = 5000
		local pos = ply:GetPos()
		
		if pos:DistToSqr(self:GetPos()) <= closedist then
			halocolor = Color(0.7*255, 0.7*255, 1.0*255)
		else
			halocolor = Color(0.3*255, 0.4*255, 1.0*255)
		end
		
		if self:BeingLookedAtByLocalPlayer() then
			halo.Add({self}, halocolor, 2, 2, 6, true, true)
		end
	end

	function ENT:PhysicsCollide( data, phys )
	end
end