AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName		= "Shotgun Ammo"
ENT.Author			= "Leeous"
ENT.Contact			= "contact@leeous.com"
ENT.Category        = "RE4 Ammo Packs"

ENT.Spawnable 		= true
ENT.AdminSpawnable  = true

-- Tell the game client to draw our model
if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end