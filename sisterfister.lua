local Unlocker, awful, project = ...
local monk = project.monk.mistweaver

print("SisterFister Monk rotation loaded and ready to fist!")

monk:Init(function()
    -- Keep in mind that we only want to execute our rotation if there is an enemy target.
    if target.enemy then
        StartAttack()

        -- Check if we have enough Chi to use Alpha Tiger before our first Blackout Kick.
        if player.chi >= 2 and alphaTiger:Ready() then
            alphaTiger:Cast()
        end

        -- Use Blackout Kick if we have a proc from Rising Sun Kick.
        if player:HasBuff(risingSunKickProc) and blackoutKick:Ready() then
            blackoutKick:Cast(target)
        end

        -- Use Rising Sun Kick on cooldown and refresh its proc buff.
        if risingSunKick:Ready() then
            risingSunKick:Cast(target)
            player:CastBuff(risingSunKickProc)
        end

        -- Use Tiger Palm if we have less than 4 Chi.
        if player.chi < 4 and tigerPalm:Ready() then
            tigerPalm:Cast(target)
        end

        -- Use Spinning Crane Kick if we have more than 2 Chi and there are 3 or more targets.
        if player.chi >= 2 and target:CountNearbyEnemies(8) >= 3 and spinningCraneKick:Ready() then
            spinningCraneKick:Cast()
        end

        -- Use Touch of Death if the target is below 10% health.
        if target.health < 10 and touchOfDeath:Ready() then
            touchOfDeath:Cast(target)
        end

        -- Keep up Renewing Mist on the target.
        if not target:HasBuff(renewingMist) then
            renewingMist:Cast(target)
        end
    end
end)
