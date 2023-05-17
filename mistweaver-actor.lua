-- Import the necessary modules and get the mistweaver monk profile
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver
local healthstone = awful.Item(5512)
print("Sisterfister Loaded and ready to fist!")

-- Initialize the mistweaver monk profile
mistweaver:Init(function()
    if not player.mounted then
        touchOfDeath()
        risingSunKick()
        ringOfPeace()
        castOnClosestEnemy()
        -- Check if there is an enemy target
        if target.enemy then
            sphereofDespair()
            sphereofHope()
            faelineStomp()
            tigerPalm()
            blackoutKick()
            stompTotems()
            spearHandStrike()
            grappleWeapon()
            legSweep()
            paralyze()
            disable()
            revival()
            restoral()
            essenceFont()
            invokeChiJi()
            tigersLust()
            detox()
            lifeCocoon()
            healthstone()
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
