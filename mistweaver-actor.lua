-- Import the necessary modules and get the mistweaver monk profile
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver
settings = project.settings
local function updateInstanceType()
    local _, instanceType = IsInInstance()
    PVP = instanceType == "pvp" or instanceType == "arena"
    PVE = instanceType == "party" or instanceType == "raid" or instanceType == "scenario" or instanceType == "none"
    INSTANCE = instanceType == "party" or instanceType == "raid" or instanceType == "scenario"
    BATTLEGROUND = instanceType == "pvp"
    ARENA = instanceType == "arena"
    DUNGEON = instanceType == "party"
    RAID = instanceType == "raid"
    SCENARIO = instanceType == "scenario"
    WORLD = instanceType == "none"
end

awful.onEvent(function(_, event)
    if event == "PLAYER_ENTERING_WORLD" then
        updateInstanceType()
    end
end)

print("Sisterfister Loaded!")

-- Initialize the mistweaver monk profile
mistweaver:Init(function()
    updateInstanceType()
    if player.buff("Arena Preparation") or player.buff("Drink") then return end
    if not player.mounted and (ARENA or BATTLEGROUND or DUNGEON or RAID or player.combat) then
        if player.hasTalent(287503) then
            touchOfDeath()
            if settings.rop then
            ringOfPeace()
            end
            if settings.aa then
            castOnClosestEnemy()
            end
            faelineStomp()
            risingSunKick()
            tigerPalm()
            blackoutKick()
            sphereofDespair()
            sphereofHope()
            if settings.ts then
            stompTotems()
            end
            spearHandStrike()
            grappleWeapon()
            revival()
            restoral()
            legSweep()
            provoke()
            if settings.para then
            paralyze()
            end
            disable()
            essenceFont()
            invokeChiJi()
            tigersLust()
            detox()
            lifeCocoon()
            if settings.em then
            envelopingMist()
            end
            if settings.rm then
            renewingMist()
            end
            thunderFocusTea()
            healingElixir()
            dampenHarm()
            fortifyingBrew()
            diffuseMagic()
        else
            ringOfPeace()
            detox()
            provoke()
            if settings.para then
            paralyze()
            end
            tigersLust()
            grappleWeapon()
            invokeYulon()
            summonJadeSerpent()
            touchOfDeath()
            lifeCocoon()
            sphereofHope()
            renewing()
            soothingMist()
            vivify()
            enveloping()
            vivify()
            sphereofDespair()
            revival()
            restoral()
            legSweep()
            healingElixir()
            if settings.dh then
            dampenHarm()
            end
            fortifyingBrew()
            if settings.dm then
            diffuseMagic()
            end
            if settings.spear then
            spearHandStrike()
            end
            if settings.tft then
            thunderFocusTea()
            end
            manaTea()
        end
    end
end)

