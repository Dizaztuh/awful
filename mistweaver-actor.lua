-- Import the necessary modules and get the mistweaver monk profile
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

print("Sisterfister Loaded and ready to fist!")

-- Define the list of spells to cast
local spellList = {
    healingElixir,
    dampenHarm,
    fortifyingBrew,
    faelineStomp,
    tigerPalm,
    blackoutKick,
    risingSunKick,
    legSweep,
    touchOfDeath
}

-- Initialize the mistweaver monk profile
mistweaver:Init(function()
    -- Check if there is an enemy target
    if target.enemy then
        player.face(target)
        StartAttack()
        
        -- Loop through the list of spells
        for _, spell in ipairs(spellList) do
            -- Call the spell function
            spell()
        end
    end
end)

