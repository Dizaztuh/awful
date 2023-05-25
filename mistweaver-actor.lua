-- Import the necessary modules and get the mistweaver monk profile
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver
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
    if player.buff("Arena Preparation") or player.buff ("Drink") then return end
    if not player.mounted and (ARENA or BATTLEGROUND or DUNGEON or RAID) then
            touchOfDeath()
            ringOfPeace()
            castOnClosestEnemy()
            faelineStomp()
            risingSunKick()
            tigerPalm()
            blackoutKick()
            sphereofDespair()
            sphereofHope()
            stompTotems()
            spearHandStrike()
            grappleWeapon()
            revival()
            restoral()
            legSweep()
            provoke()
            paralyze()
            disable()
            essenceFont()
            invokeChiJi()
            tigersLust()
            detox()
            lifeCocoon()
            envelopingMist()
            renewingMist()
            thunderFocusTea()
            healingElixir()
            dampenHarm()
            fortifyingBrew()
            diffuseMagic()

    end
end)

