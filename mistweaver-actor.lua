-- Import the necessary modules and get the mistweaver monk profile
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

print("Sisterfister Loaded and ready to fist!")

-- Initialize the mistweaver monk profile
mistweaver:Init(function()
    -- Check if there is an enemy target
    if target.enemy then
        faelineStomp()
        tigerPalm()
        blackoutKick()
        risingSunKick()
        legSweep()
        paralyze()
        touchOfDeath()
        spearHandStrike()
        envelopingMist()
        sphereofDespair()
        sphereofHope()
        lifeCocoon("prio")
        revival()
        restoral()
        thunderFocusTea()
        detox()
        invokeChiJi()
        tigersLust()
        healingElixir()
        dampenHarm()
        fortifyingBrew()
        diffuseMagic()
    end
end, 0.1)