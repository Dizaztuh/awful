-- Import the necessary modules and get the mistweaver monk profile
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

print("Sisterfister Loaded and ready to fist!")

-- Initialize the mistweaver monk profile
mistweaver:Init(function()
    -- Check if there is an enemy target
    if target.enemy then
        risingSunKick("prio")
        tigerPalm()
        blackoutKick()
        touchOfDeath("prio")
        envelopingMist("prio")
        sphereofDespair("prio")
        sphereofHope()
        faelineStomp()
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