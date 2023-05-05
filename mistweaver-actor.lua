lua local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweavr

-- stuff out here only runs once, when the file is first loaded.
print("Sisterfister Loaded and ready to fist!")

mistweaver:Init(function()
    if target.enemy then
        player.face(target) -- Make the player face the target before attacking
        StartAttack()
        tigerPalm()
        blackoutKick()
        risingSunKick()
    end
    -- everything in here is running *on every tick*
    -- its goal is to "act" every frame
    -- that's why you will be spammed with this print when you toggle your routine.
    -- these are comments and you can remove them :
end)