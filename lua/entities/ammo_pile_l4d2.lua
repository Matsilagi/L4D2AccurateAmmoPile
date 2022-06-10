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

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "UseCount", { KeyName = "Use Count",	Edit = { type = "Int",	order = 1, min = -1, max = 9999 } } )
	self:SetNWInt("UsedCount",0)
	
	if SERVER then
		self:SetUseCount( -1 )
	end
	
end

if SERVER then
	function ENT:Think()
		local UseCounter = self:GetNWInt("UsedCount",0)
		if UseCounter >= self:GetUseCount() and self:GetUseCount() != 0 and self:GetUseCount() != -1 then self:Remove() end
	end
	
	function ENT:Initialize()
		self:SetModel( "models/props/arccw_uc/ammo_stack.mdl" )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		self:DrawShadow( true )
	end

	function ENT:Use( activator, caller )
		local curweap = activator:GetActiveWeapon()
		local wepammo = curweap:GetPrimaryAmmoType() or nil
		local wepammo2 = curweap:GetSecondaryAmmoType() or false
		local usecounter = self:GetNWInt("UsedCount")
		
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
				elseif mag1 >= 0 and maxclip != nil and wepammo == 9 then
					ammotogive = (maxclip*31) - mag1
				elseif mag1 < 0 and wepammo >= 0 and activator:GetAmmoCount(wepammo) >= 0 then
					if activator:GetActiveWeapon().Primary == nil then
						ammotogive = 10
					else
						ammotogive = (activator:GetActiveWeapon().Primary.DefaultClip * 10)
					end
				else
					ammotogive = 10
				end
				
				if activator:GetActiveWeapon().BottomlessClip == true and activator:GetActiveWeapon().Primary.ClipSize != 0 then --special case for ArcCW Bottomless Clip guns
					ammotogive = (activator:GetActiveWeapon().Primary.ClipSize * 10)
				end
				
				if activator:GetActiveWeapon():GetClass() == "arccw_apex_bocek" then --Bocek workaround
					ammotogive = 100
				end
				
				if wepammo == 8 or wepammo == 9 and mag1 >= 0 and maxclip >= 1 then --Explosive launchers workaround
					ammotogive = (maxclip*31) - mag1
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
			usecounter = usecounter + 1
			self:SetNWInt("UsedCount", usecounter)
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
		local halo_cvar = GetConVar("cl_ammopile_halo") or CreateClientConVar("cl_ammopile_halo", 1, true, false)
		if !IsValid(ply) then return false end
		local closedist = 5000
		local pos = ply:GetPos()
		
		if pos:DistToSqr(self:GetPos()) <= closedist then
			halocolor = Color(0.7*255, 0.7*255, 1.0*255)
		else
			halocolor = Color(0.3*255, 0.4*255, 1.0*255)
		end
		
		if self:BeingLookedAtByLocalPlayer() and halo_cvar:GetBool() then
			halo.Add({self}, halocolor, 2, 2, 6, true, true)
		end
	end

	function ENT:PhysicsCollide( data, phys )
	end
end