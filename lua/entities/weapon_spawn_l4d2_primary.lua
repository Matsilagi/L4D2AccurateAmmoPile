AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "weapon_spawn" --I borrowed this from Lambda, no way im spending hours trying to get KeyValues to work.
ENT.PrintName = "Weapon Spawner (Primary)"
ENT.Category = "Left 4 Dead 2"
ENT.Author = "Matsilagi"
ENT.Editable = true
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.UseTimer = CurTime()
ENT.Count = -1
ENT.TableChoice = any_primary_replacements
ENT.ChosenWeapon = nil
ENT.RandomGun = nil

DEFINE_BASECLASS("weapon_spawn")