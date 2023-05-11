-- Import the necessary modules and get the mistweaver monk profile
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

print("Sisterfister Loaded and ready to fist!")

-- Initialize the mistweaver monk profile
mistweaver:Init(function()
    if not player.mounted then
        touchOfDeath()
        risingSunKick()
        ringOfPeace()
        ringOfPeacez()
        -- Check if there is an enemy target
        if target.enemy then
            sphereofDespair()
            sphereofHope()
            faelineStomp()
            tigerPalm()
            blackoutKick()
            castOnClosestEnemy()
            stompTotems()
            spearHandStrike()
            legSweep()
            paralyze()
            disable()
            invokeChiJi()
            tigersLust()
            detox()
            lifeCocoon()
            revival()
            restoral()
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
