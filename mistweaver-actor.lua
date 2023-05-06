-- Import the necessary modules and get the mistweaver monk profile
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

print("Sisterfister Loaded and ready to fist!")

-- Initialize the mistweaver monk profile
mistweaver:Init(function()
    -- Check if there is an enemy target
    if target.enemy then
        StartAttack()
        envelopingMist("prio")
        sphereofDespair("prio")
        sphereofHope()
        touchOfDeath("prio")
        faelineStomp()
        risingSunKick("prio")
        tigerPalm()
        blackoutKick()
        legSweep("prio")
        paralyze("prio")
        lifeCocoon("prio")
        healingElixir()
        dampenHarm()
        fortifyingBrew()
        diffuseMagic()
        revival("prio")
    end
end)