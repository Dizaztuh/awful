-- Import the necessary modules and get the mistweaver monk profile
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver
local type = awful.instanceType2
PVP = type == "pvp" or type == "arena"
PVE = type == "party" or type == "raid" or type == "scenario" or type == "none"
INSTANCE = type == "party" or type == "raid" or type == "scenario"
BATTLEGROUND = type == "pvp"
ARENA = type == "arena"
DUNGEON = type == "party"
RAID = type == "raid"
SCENARIO = type == "scenario"
WORLD = type == "none"

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
    end
end)

