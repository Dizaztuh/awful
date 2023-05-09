-- Import the necessary modules and get the mistweaver monk profile
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

print("Sisterfister Loaded and ready to fist!")

-- Initialize the mistweaver monk profile
mistweaver:Init(function()
    -- Check if there is an enemy target
    if target.enemy then
        risingSunKick()
        faelineStomp()
        tigerPalm()
        blackoutKick()
        legSweep()
        paralyze()
        spearHandStrike()
        envelopingMist()
        renewingMist()
        sphereofDespair()
        sphereofHope()
        lifeCocoon()
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
        touchOfDeath()
        stompTotems()
    end
end)