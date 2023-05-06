-- Import the necessary modules and get the mistweaver monk profile
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

print("Sisterfister Loaded and ready to fist!")

-- Initialize the mistweaver monk profile
mistweaver:Init(function()
    -- Check if there is an enemy target
    if target.enemy then
        StartAttack()
        sphereofDespair()
        faelineStomp()
        risingSunKick("prio")
        tigerPalm()
        blackoutKick()
        healingElixir()
        lifeCocoon()
        dampenHarm()
        legSweep()
        paralyze()
        touchOfDeath()
        sphereofHope()
        fortifyingBrew()
        diffuseMagic()
        revival()
        envelopingMist()
    end
end)