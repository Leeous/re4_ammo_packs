include("shared.lua")
AddCSLuaFile("shared.lua")

local pickup_sound = Sound("ammo_pickup.wav")

function ENT:SpawnFunction(ply, trace)
    if ( !trace.Hit ) then return end

    local ent = ents.Create( "shotgun_ammo" )
    ent:SetPos( trace.HitPos + trace.HitNormal )
    ent:Spawn()
    ent:Activate()
    if CLIENT then
        phys:Wake()
    end
    return ent
end

function ENT:Initialize()
    self:SetModel("models/lee/props/re4_props/re4_ammo_pack_shotgun.mdl")
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:DrawShadow(true)
    self:DropToFloor()

    local physObj = self:GetPhysicsObject()
    if not physObj:IsValid() then return end
    physObj:Wake()
end

function ENT:Use( ply, trace )
    if (!ply:IsPlayer()) then
        return end
    self:EmitSound(pickup_sound)
    ply:GiveAmmo(GetConVar("re4_shotgun_ammo_amount"):GetInt(), GetConVar("re4_shotgun_ammo_type"):GetString(), not GetConVar("re4_show_ammo_pickup"):GetBool())
    self:Remove();
end

function ENT:Touch(ply)
    if self.givenAmmo == true then return end
    if not ply:IsPlayer() then return end
    self:EmitSound(pickup_sound)
    ply:GiveAmmo(GetConVar("re4_shotgun_ammo_amount"):GetInt(), GetConVar("re4_shotgun_ammo_type"):GetString(), not GetConVar("re4_show_ammo_pickup"):GetBool())
    self:Remove()
end

-- Hack to force ammo to physwake
function ENT:Think()
    if not self.first_think then
        self:PhysWake()
        self.first_think = true

        -- Immediately unhook the Think, save cycles. The first_think thing is
        -- just there in case it still Thinks somehow in the future.
        self.Think = nil
    end
end