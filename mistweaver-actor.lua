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
        sphereofDespair()
        sphereofHope()
        faelineStomp()
        tigerPalm()
        blackoutKick()
        risingSunKick()
        castOnClosestEnemy()
        stompTotems()
        spearHandStrike()
        legSweep()
        paralyze()
        disable()
        invokeChiJi()
        tigersLust()
        envelopingMist()
        renewingMist()
        detox()
        lifeCocoon()
        revival()
        restoral()
        thunderFocusTea()
        healingElixir()
        dampenHarm()
        fortifyingBrew()
        diffuseMagic()
        end
    end
end)
