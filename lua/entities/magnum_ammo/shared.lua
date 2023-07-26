ENT.Type = "anim"
ENT.Base = "base_entity"

ENT.PrintName		= "Magnum Ammo"
ENT.Author			= "Leeous"
ENT.Contact			= "@LeeTheCoder"
ENT.Category        = "RE4 Ammo Packs"

ENT.Spawnable 		= true
ENT.AdminSpawnable  = true

-- Tell the game client to draw our model
if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end
