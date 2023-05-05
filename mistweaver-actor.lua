-- Import the necessary modules and get the mistweaver monk profile
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweavr

-- Print a message to the console to confirm that the addon has been loaded
print("Sisterfister Loaded and ready to fist!")

-- Initialize the mistweaver monk profile
mistweaver:Init(function()
    -- Check if there is an enemy target
    if target.enemy then
        -- Make the player face the target before attacking
        player.face(target)
        StartAttack()
        healingElixir()
        dampenHarm()
        fortifyingBrew()
        tigerPalm()
        blackoutKick()
        risingSunKick()
        legSweep()
        touchOfDeath()
    end
    
    -- This function will be called every frame, meaning that any action that needs to be taken
    -- on a per-frame basis should be done within this function
end)
