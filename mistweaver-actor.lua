-- Import the necessary modules and get the mistweaver monk profile
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

print("Sisterfister Loaded and ready to fist!")

-- Initialize the mistweaver monk profile
mistweaver:Init(function()
    if not player.mounted then
        touchOfDeath()
    -- Check if there is an enemy target
    if target.enemy then
        faelineStomp()
        tigerPalm()
        blackoutKick()
        castOnClosestEnemy()
        stompTotems()
        spearHandStrike()
        risingSunKick()
        sphereofDespair()
        sphereofHope()
        legSweep()
        paralyze()
        disable()
        envelopingMist()
        renewingMist()
        detox()
        lifeCocoon()
        revival()
        restoral()
        thunderFocusTea()
        invokeChiJi()
        tigersLust()
        healingElixir()
        dampenHarm()
        fortifyingBrew()
        diffuseMagic()
        end
    end
end)
