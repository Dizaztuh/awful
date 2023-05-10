-- Import the necessary modules and get the mistweaver monk profile
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

print("Sisterfister Loaded and ready to fist!")

-- Initialize the mistweaver monk profile
mistweaver:Init(function()
        touchOfDeath()
        castOnClosestEnemy()
        stompTotems()
        risingSunKick()
    -- Check if there is an enemy target
    if target.enemy then
        sphereofDespair()
        sphereofHope()
        faelineStomp()
        tigerPalm()
        blackoutKick()
        legSweep()
        paralyze()
        spearHandStrike()
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
end)
