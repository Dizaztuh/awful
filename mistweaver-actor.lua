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

