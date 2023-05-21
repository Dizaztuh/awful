-- Import the necessary modules and get the mistweaver monk profile
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

print("Sisterfister Loaded!")

-- Initialize the mistweaver monk profile
mistweaver:Init(function()
    if not player.mounted and target.enemy then
        touchOfDeath()
        ringOfPeace()
        castOnClosestEnemy()
        provoke()
        -- Check if there is an enemy target
            if target.enemy then
            sphereofDespair()
            sphereofHope()
            faelineStomp()
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
