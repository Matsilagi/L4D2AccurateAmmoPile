AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_lambda_entity" --I borrowed this from Lambda, no way im spending hours trying to get KeyValues to work.
ENT.PrintName = "Weapon Spawner"
ENT.Category = "Left 4 Dead 2"
ENT.Author = "Matsilagi"
ENT.Editable = false
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.UseTimer = CurTime()
ENT.Count = -1
ENT.TableChoice = 0
ENT.ChosenWeapon = nil
ENT.RandomGun = nil

DEFINE_BASECLASS("base_lambda_entity")

--[[]
--PISTOLS (Magnum and Normal Pistols)
local m1911_replacements = {["arccw_go_usp"] = true, ["arccw_go_p2000"] = true, ["arccw_go_p250"] = true, ["arccw_go_tec9"] = true, ["arccw_go_m9"] = true, ["arccw_go_glock"] = true, ["arccw_apex_re45"] = true, ["arccw_apex_p2020"] = true, ["arccw_matsi_alyxgun"] = true, ["arccw_ud_glock"] = true, ["arccw_uc_usp"] = true, ["arccw_ur_pm"] = true, ["arccw_ur_m1911"] = true, ["arccw_ud_g24"] = true, ["arccw_ud_g26"] = true, ["arccw_ud_g18"] = true }
local deagle_replacements = {["arccw_go_sw29"] = true, ["arccw_go_deagle"] = true, ["arccw_go_r8"] = true, ["arccw_go_cz75"] = true, ["arccw_go_fiveseven"] = true, ["arccw_apex_wingman"] = true, ["arccw_apex_mozambique"] = true, ["arccw_ur_deagle"] = true, ["arccw_ur_annihilator"] = true, ["arccw_ur_deag357"] = true, ["arccw_ud_gnb"] = true }
--SMGs (SMG, Silenced SMG and CS:S MP5)
local uzi_replacements = {["arccw_go_mp7"] = true, ["arccw_go_mp9"] = true, ["arccw_go_bizon"] = true, ["arccw_go_p90"] = true, ["arccw_go_ump"] = true, ["arccw_apex_alternator"] = true, ["arccw_apex_r99"] = true, ["arccw_apex_car"] = true, ["arccw_ud_uzi"] = true, ["arccw_ud_miniuzi"] = true, ["arccw_ud_uzicarbine"] = true }
local tmp_replacements = {["arccw_go_mac10"] = true, ["arccw_go_ump"] = true, ["arccw_go_mp7"] = true, ["arccw_go_bizon"] = true, ["arccw_go_p90"] = true, ["arccw_apex_volt"] = true, ["arccw_ud_microuzi"] = true, ["arccw_apex_prowler"] = true }
local mp5_replacements = {["arccw_go_mp5"] = true, ["arccw_apex_alternator"] = true, ["arccw_apex_r99"] = true, ["arccw_apex_volt"] = true, ["arccw_ur_mp5"] = true, ["arccw_ur_mp510"] = true, ["arccw_ur_mp5k"] = true, ["arccw_ur_mp5kpdw"] = true, ["arccw_ur_mp5sd3"] = true, ["arccw_ur_hk94a3"] = true }
--Tier 1 Shotguns (Pump Shotgun and Chrome Shotgun)
local pumpshotgun_replacements = {["arccw_go_870"] = true, ["arccw_apex_mozambique"] = true, ["arccw_apex_peacekeeper"] = true, ["arccw_ud_870"] = true, ["arccw_ud_r870sawn"] = true, ["arccw_eft_mp155"] = true }
local chromeshotgun_replacements = {["arccw_go_nova"] = true, ["arccw_go_mag7"] = true, ["arccw_apex_mozambique"] = true, ["arccw_apex_peacekeeper"] = true, ["arccw_ud_870"] = true, ["arccw_ud_tac14"] = true, ["arccw_ud_r870poly"] = true, ["arccw_eft_mp153"] = true }
--Tier 2 Shotguns (SPAS-12 and AutoShotgun)
local autoshotgun_replacements = {["arccw_go_m1014"] = true, ["arccw_apex_eva"] = true, ["arccw_ud_m1014"] = true, ["arccw_ud_m1014sport"] = true }
local spas_replacements = {["arccw_apex_mastiff"] = true, ["arccw_ur_spas12"] = true, ["arccw_ur_spas12hl"] = true }
--Tier 2 Rifles (M16,Desert Rifle, AK-47 and CS:S SG-552)
local m16_replacements = {["arccw_go_ar15"] = true, ["arccw_go_m4"] = true, ["arccw_go_m16a2"] = true, ["arccw_apex_r301"] = true, ["arccw_apex_spitfire"] = true, ["arccw_uc_lynx"] = true, ["arccw_ud_m16"] = true, ["arccw_ud_m16a1"] = true, ["arccw_ud_fpw"] = true, ["arccw_ud_m4a1"] = true, ["arccw_ud_m4a1300"] = true, ["arccw_ud_car15"] = true, ["arccw_ud_coltlmg"] = true, ["arccw_ud_mk18"] = true, ["arccw_ud_servicerifle"] = true, ["arccw_ud_r0635"] = true, ["arccw_ud_adar"] = true }
local scar_replacements = {["arccw_go_scar"] = true, ["arccw_go_famas"] = true, ["arccw_apex_hemlok"] = true, ["arccw_apex_havoc"] = true }
local ak_replacements = {["arccw_go_ak47"] = true, ["arccw_go_ace"] = true, ["arccw_go_galil_ar"] = true, ["arccw_go_fnfal"] = true, ["arccw_apex_flatline"] = true, ["arccw_ur_ak"] = true, ["arccw_ur_ak101"] = true, ["arccw_ur_ak105"] = true, ["arccw_ur_ak12"] = true, ["arccw_ur_ak74"] = true, ["arccw_ur_akmn"] = true, ["arccw_ur_akms"] = true, ["arccw_ur_aks74u"] = true, ["arccw_ur_rpk"] = true, ["arccw_ur_rpk74m"] = true, ["arccw_ur_t56"] = true, ["arccw_ur_vpo209"] = true }
local sg552_replacements = {["arccw_go_sg556"] = true, ["arccw_go_aug"] = true, ["arccw_apex_r301"] = true, ["arccw_apex_havoc"] = true }
--Tier 1 Snipers (Hunting Rifle and CS:S Scout)
local m14_replacements = {["arccw_apex_3030"] = true, ["arccw_apex_bocek"] = true, ["arccw_apex_g7"] = true, ["arccw_ud_m14"] = true, ["arccw_ud_ac556"] = true, ["arccw_ud_mini30"] = true }
local scout_replacements = {["arccw_go_ssg08"] = true, ["arccw_apex_g7"] = true, ["arccw_apex_3030"] = true, ["arccw_apex_bocek"] = true }
--Tier 2 Snipers (Military Rifle and CS:S AWP)
local g3sg1_replacements = {["arccw_go_g3"] = true, ["arccw_apex_sentinel"] = true, ["arccw_apex_tripletake"] = true, ["arccw_apex_longbow"] = true }
local awp_replacements = {["arccw_go_awp"] = true, ["arccw_apex_sentinel"] = true, ["arccw_apex_tripletake"] = true, ["arccw_apex_longbow"] = true }
--Any tables (for all guns in X occasion)
local any_replacements = {} --Any Gun
local any_pistol_replacements = {} --Only Pistols
local any_primary_replacements = {} --Except Pistols
local any_smg_replacements = {} --Only SMGs
local any_rifle_replacements = {} --Only Rifles
local any_shotgun_replacements = {} --Only Shotguns
local any_sniper_rifle_replacements = {} --Only Snipers
--Tier tables (for all guns of X tier)
local tier1_replacements = {} --Any Tier 1 Gun (Pistols, SMGs,Pump-Shotguns)
local tier1_shotgun_replacements = {} --Any Tier 1 Shotgun (Pump and Chrome)
local tier2_replacements = {} --Any Tier 2 Gun (Rifles, Sniper Rifles, Auto-Shotguns)
local tier2_shotgun_replacements = {} --Any Tier 2 Shotgun (Auto and SPAS)
]]

--PISTOLS (Magnum and Normal Pistols)
local m1911_replacements = {"arccw_go_usp","arccw_go_p2000","arccw_go_p250","arccw_go_tec9","arccw_go_m9","arccw_go_glock","arccw_apex_re45","arccw_apex_p2020","arccw_matsi_alyxgun","arccw_ud_glock","arccw_uc_usp","arccw_ur_pm","arccw_ur_m1911","arccw_ud_g24","arccw_ud_g26","arccw_ud_g18"}
local deagle_replacements = {"arccw_go_sw29","arccw_go_deagle","arccw_go_r8","arccw_go_cz75","arccw_go_fiveseven","arccw_apex_wingman","arccw_apex_mozambique","arccw_ur_deagle","arccw_ur_annihilator","arccw_ur_deag357","arccw_ud_gnb"}
--SMGs (SMG, Silenced SMG and CS:S MP5)
local uzi_replacements = {"arccw_go_mp7","arccw_go_mp9","arccw_go_bizon","arccw_go_p90","arccw_go_ump","arccw_apex_alternator","arccw_apex_r99","arccw_apex_car","arccw_ud_uzi","arccw_ud_miniuzi","arccw_ud_uzicarbine"}
local tmp_replacements = {"arccw_go_mac10","arccw_go_ump","arccw_go_mp7","arccw_go_bizon","arccw_go_p90","arccw_apex_volt","arccw_ud_microuzi","arccw_apex_prowler"}
local mp5_replacements = {"arccw_go_mp5","arccw_apex_alternator","arccw_apex_r99","arccw_apex_volt","arccw_ur_mp5","arccw_ur_mp510","arccw_ur_mp5k","arccw_ur_mp5kpdw","arccw_ur_mp5sd3","arccw_ur_hk94a3"}
--Tier 1 Shotguns (Pump Shotgun and Chrome Shotgun)
local pumpshotgun_replacements = {"arccw_go_870","arccw_apex_mozambique","arccw_apex_peacekeeper","arccw_ud_870","arccw_ud_r870sawn","arccw_eft_mp155"}
local chromeshotgun_replacements = {"arccw_go_nova","arccw_go_mag7","arccw_apex_mozambique","arccw_apex_peacekeeper","arccw_ud_870","arccw_ud_tac14","arccw_ud_r870poly","arccw_eft_mp153"}
--Tier 2 Shotguns (SPAS-12 and AutoShotgun)
local autoshotgun_replacements = {"arccw_go_m1014","arccw_apex_eva","arccw_ud_m1014","arccw_ud_m1014sport"}
local spas_replacements = {"arccw_apex_mastiff","arccw_ur_spas12","arccw_ur_spas12hl"}
--Tier 2 Rifles (M16,Desert Rifle, AK-47 and CS:S SG-552)
local m16_replacements = {"arccw_go_ar15","arccw_go_m4","arccw_go_m16a2","arccw_apex_r301","arccw_apex_spitfire","arccw_uc_lynx","arccw_ud_m16","arccw_ud_m16a1","arccw_ud_fpw","arccw_ud_m4a1","arccw_ud_m4a1300","arccw_ud_car15","arccw_ud_coltlmg","arccw_ud_mk18","arccw_ud_servicerifle","arccw_ud_r0635","arccw_ud_adar"}
local scar_replacements = {"arccw_go_scar","arccw_go_famas","arccw_apex_hemlok","arccw_apex_havoc"}
local ak_replacements = {"arccw_go_ak47","arccw_go_ace","arccw_go_galil_ar","arccw_go_fnfal","arccw_apex_flatline","arccw_ur_ak","arccw_ur_ak101","arccw_ur_ak105","arccw_ur_ak12","arccw_ur_ak74","arccw_ur_akmn","arccw_ur_akms","arccw_ur_aks74u","arccw_ur_rpk","arccw_ur_rpk74m","arccw_ur_t56","arccw_ur_vpo209"}
local sg552_replacements = {"arccw_go_sg556","arccw_go_aug","arccw_apex_r301","arccw_apex_havoc"}
--Tier 1 Snipers (Hunting Rifle and CS:S Scout)
local m14_replacements = {"arccw_apex_3030","arccw_apex_bocek","arccw_apex_g7","arccw_ud_m14","arccw_ud_ac556","arccw_ud_mini30"}
local scout_replacements = {"arccw_go_ssg08","arccw_apex_g7","arccw_apex_3030","arccw_apex_bocek"}
--Tier 2 Snipers (Military Rifle and CS:S AWP)
local g3sg1_replacements = {"arccw_go_g3","arccw_apex_sentinel","arccw_apex_tripletake","arccw_apex_longbow"}
local awp_replacements = {"arccw_go_awp","arccw_apex_sentinel","arccw_apex_tripletake","arccw_apex_longbow"}
--Any tables (for all guns in X occasion)
local any_replacements = {} --Any Gun
local any_pistol_replacements = {} --Only Pistols
local any_primary_replacements = {} --Except Pistols
local any_smg_replacements = {} --Only SMGs
local any_rifle_replacements = {} --Only Rifles
local any_shotgun_replacements = {} --Only Shotguns
local any_sniper_rifle_replacements = {} --Only Snipers
--Tier tables (for all guns of X tier)
local tier1_replacements = {} --Any Tier 1 Gun (Pistols, SMGs,Pump-Shotguns)
local tier1_shotgun_replacements = {} --Any Tier 1 Shotgun (Pump and Chrome)
local tier2_replacements = {} --Any Tier 2 Gun (Rifles, Sniper Rifles, Auto-Shotguns)
local tier2_shotgun_replacements = {} --Any Tier 2 Shotgun (Auto and SPAS)

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

function ENT:SetupWeaponTables()
	--Any
	table.Add(any_replacements, m1911_replacements)
	table.Add(any_replacements, deagle_replacements)
	table.Add(any_replacements, uzi_replacements)
	table.Add(any_replacements, tmp_replacements)
	table.Add(any_replacements, mp5_replacements)
	table.Add(any_replacements, pumpshotgun_replacements)
	table.Add(any_replacements, chromeshotgun_replacements)
	table.Add(any_replacements, autoshotgun_replacements)
	table.Add(any_replacements, spas_replacements)
	table.Add(any_replacements, m16_replacements)
	table.Add(any_replacements, ak_replacements)
	table.Add(any_replacements, scar_replacements)
	table.Add(any_replacements, sg552_replacements)
	table.Add(any_replacements, m14_replacements)
	table.Add(any_replacements, scout_replacements)
	table.Add(any_replacements, g3sg1_replacements)
	table.Add(any_replacements, awp_replacements)
	
	--Tier1
	table.Add(tier1_replacements, m1911_replacements)
	table.Add(tier1_replacements, deagle_replacements)
	table.Add(tier1_replacements, uzi_replacements)
	table.Add(tier1_replacements, tmp_replacements)
	table.Add(tier1_replacements, mp5_replacements)
	table.Add(tier1_replacements, pumpshotgun_replacements)
	table.Add(tier1_replacements, chromeshotgun_replacements)
	
	--Tier2
	table.Add(tier2_replacements, autoshotgun_replacements)
	table.Add(tier2_replacements, spas_replacements)
	table.Add(tier2_replacements, m16_replacements)
	table.Add(tier2_replacements, ak_replacements)
	table.Add(tier2_replacements, scar_replacements)
	table.Add(tier2_replacements, sg552_replacements)
	table.Add(tier2_replacements, m14_replacements)
	table.Add(tier2_replacements, scout_replacements)
	table.Add(tier2_replacements, g3sg1_replacements)
	table.Add(tier2_replacements, awp_replacements)
	
	--Tier1 Shotguns
	table.Add(tier1_shotgun_replacements, pumpshotgun_replacements)
	table.Add(tier1_shotgun_replacements, chromeshotgun_replacements)

	--Tier2 Shotguns
	table.Add(tier2_shotgun_replacements, autoshotgun_replacements)
	table.Add(tier2_shotgun_replacements, spas_replacements)	
	
	--Primaries
	table.Add(any_primary_replacements, uzi_replacements)
	table.Add(any_primary_replacements, tmp_replacements)
	table.Add(any_primary_replacements, mp5_replacements)
	table.Add(any_primary_replacements, pumpshotgun_replacements)
	table.Add(any_primary_replacements, chromeshotgun_replacements)
	table.Add(any_primary_replacements, autoshotgun_replacements)
	table.Add(any_primary_replacements, spas_replacements)
	table.Add(any_primary_replacements, m16_replacements)
	table.Add(any_primary_replacements, ak_replacements)
	table.Add(any_primary_replacements, scar_replacements)
	table.Add(any_primary_replacements, sg552_replacements)
	table.Add(any_primary_replacements, m14_replacements)
	table.Add(any_primary_replacements, scout_replacements)
	table.Add(any_primary_replacements, g3sg1_replacements)
	table.Add(any_primary_replacements, awp_replacements)
	
	--Pistols
	table.Add(any_pistol_replacements, m1911_replacements)
	table.Add(any_pistol_replacements, deagle_replacements)
	
	--SMGs
	table.Add(any_smg_replacements, uzi_replacements)
	table.Add(any_smg_replacements, tmp_replacements)
	table.Add(any_smg_replacements, mp5_replacements)
	
	--Rifles
	table.Add(any_rifle_replacements, m16_replacements)
	table.Add(any_rifle_replacements, ak_replacements)
	table.Add(any_rifle_replacements, scar_replacements)
	table.Add(any_rifle_replacements, sg552_replacements)
	
	--Shotguns
	table.Add(any_shotgun_replacements, pumpshotgun_replacements)
	table.Add(any_shotgun_replacements, chromeshotgun_replacements)
	table.Add(any_shotgun_replacements, autoshotgun_replacements)
	table.Add(any_shotgun_replacements, spas_replacements)	
	
	--SniperRifles
	table.Add(any_sniper_rifle_replacements, m14_replacements)
	table.Add(any_sniper_rifle_replacements, scout_replacements)
	table.Add(any_sniper_rifle_replacements, g3sg1_replacements)
	table.Add(any_sniper_rifle_replacements, awp_replacements)
	
	if self.TableChoice == 0 then
		self.TableChoice = any_replacements
	end
	
end

function ENT:KeyValue( key, val )

    BaseClass.KeyValue(self, key, val)

	if key:iequals("count") then
		self.Count = val
		self:SetUseCount(val)
    elseif key:iequals("weapon_selection") then
		if tostring(val) == "any" or val == nil then
			self.TableChoice = any_replacements
		elseif tostring(val) == "any_pistol" then
			self.TableChoice = any_pistol_replacements
		elseif tostring(val) == "weapon_pistol" then
			self.TableChoice = m1911_replacements
		elseif tostring(val) == "weapon_pistol_magnum" then
			self.TableChoice = deagle_replacements
		elseif tostring(val) == "any_primary" then
			self.TableChoice = any_primary_replacements
		elseif tostring(val) == "tier1_any" then
			self.TableChoice = tier1_replacements
		elseif tostring(val) == "tier2_any" then
			self.TableChoice = tier2_replacements
		elseif tostring(val) == "any_smg" then
			self.TableChoice = any_smg_replacements
		elseif tostring(val) == "any_rifle" then
			self.TableChoice = any_rifle_replacements
		elseif tostring(val) == "any_sniper_rifle" then
			self.TableChoice = any_sniper_rifle_replacements
		elseif tostring(val) == "any_shotgun" then
			self.TableChoice = any_shotgun_replacements
		elseif tostring(val) == "tier1_shotgun" then
			self.TableChoice = tier1_shotgun_replacements
		elseif tostring(val) == "tier2_shotgun" then
			self.TableChoice = tier2_shotgun_replacements
		elseif tostring(val) == "weapon_smg" then
			self.TableChoice = uzi_replacements
		elseif tostring(val) == "weapon_smg_silenced" then
			self.TableChoice = tmp_replacements
		elseif tostring(val) == "weapon_pumpshotgun" then
			self.TableChoice = pumpshotgun_replacements
		elseif tostring(val) == "weapon_shotgun_chrome" then
			self.TableChoice = chromeshotgun_replacements
		elseif tostring(val) == "weapon_autoshotgun" then
			self.TableChoice = autoshotgun_replacements
		elseif tostring(val) == "weapon_shotgun_spas" then
			self.TableChoice = spas_replacements
		elseif tostring(val) == "weapon_rifle" then
			self.TableChoice = m16_replacements
		elseif tostring(val) == "weapon_rifle_desert" then
			self.TableChoice = scar_replacements
		elseif tostring(val) == "weapon_rifle_ak47" then
			self.TableChoice = ak_replacements
		elseif tostring(val) == "weapon_hunting_rifle	" then
			self.TableChoice = m14_replacements
		elseif tostring(val) == "weapon_sniper_military" then
			self.TableChoice = g3sg1_replacements
		elseif tostring(val) == "weapon_smg_mp5" then
			self.TableChoice = mp5_replacements
		elseif tostring(val) == "weapon_rifle_sg552" then
			self.TableChoice = sg552_replacements
		elseif tostring(val) == "weapon_sniper_awp" then
			self.TableChoice = awp_replacements
		elseif tostring(val) == "weapon_sniper_scout" then
			self.TableChoice = scout_replacements
		else
			self.TableChoice = any_replacements
		end
    end
end

if SERVER then

	function ENT:Think()
		local UseCounter = self:GetNWInt("UsedCount",0)
		if UseCounter >= self:GetUseCount() and self:GetUseCount() != 0 and self:GetUseCount() != -1 then self:Remove() end
	end

	function ENT:Initialize()
		self:SetupWeaponTables()
		
		self.RandomGun = math.random(1,table.Count(self.TableChoice))
		self.ChosenWeapon = self.TableChoice[self.RandomGun]
		local weaponclass = weapons.Get(self.ChosenWeapon)
		
		if SERVER then
			self:SetModel( weaponclass.WorldModel )
			self:SetSkin (self.Skin or 0)
			self:SetUseCount(self.Count or 0)
			self:SetMoveType( MOVETYPE_NONE )
			self:SetSolid( SOLID_VPHYSICS )
			self:PhysicsInit( SOLID_VPHYSICS )
			self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
			self:DrawShadow( true )
		end
	end

	function ENT:Use( activator, caller )
		local curweap = activator:GetActiveWeapon()
		local weaponclass = weapons.Get(self.ChosenWeapon)
		local wepammo = weaponclass.Primary.Ammo or 0
		local wepammo2 = weaponclass.Secondary.Ammo or 0
		local usecounter = self:GetNWInt("UsedCount")
		
		if self.UseTimer <= CurTime() and activator:IsPlayer() and curweap != tostring(self.ChosenWeapon) then
			local maxclip = weaponclass.Primary.ClipSize
			local maxclip2 = weaponclass.Secondary.ClipSize
			local ammotogive = 0
			local ammotogive2 = 0
			local mag1 = 0
			
			if wepammo != false or wepammo != nil then
			
				if curweap:Clip1() > 0 then
					mag1 = curweap:Clip1()
				end
				
				if maxclip != nil then 
					ammotogive = (maxclip*10) - mag1
				elseif weaponclass.ClipSize == 0 and weaponclass.DefaultClip != 0 then
					ammotogive = (weaponclass.DefaultClip * 10)
				elseif weaponclass.BottomlessClip == true and weaponclass.Primary.ClipSize != 0 then --Bottomless clips case
					ammotogive = (weaponclass.Primary.ClipSize * 10)
				elseif self.ChosenWeapon == "arccw_apex_bocek" then --Bocek Case
					ammotogive = 100
				elseif wepammo == 8 or wepammo == 9 then --Launchers case
					ammotogive = (maxclip*31) - mag1
				else --Generic
					ammotogive = 10
				end
				
				if !activator:HasWeapon(self.ChosenWeapon) then
					activator:Give(tostring(self.ChosenWeapon),true)
				end
				
				activator:SetAmmo(ammotogive, wepammo)
			end
			
			if wepammo2 != false or wepammo2 != nil then
				if weaponclass.Secondary.ClipSize != nil then
					ammotogive2 = weaponclass.Secondary.ClipSize*10
				elseif weaponclass.Secondary.DefaultClip != nil then
					ammotogive2 = (weaponclass.Secondary.DefaultClip * 10)
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