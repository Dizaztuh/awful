local Unlocker, awful, project = ...
local monk = project.monk.fistweaver

print("SisterFister Monk rotation loaded and ready to fist!")

local function lowestHealthPartyMember()
    local lowestMember = nil
    local lowestHealth = 100
    for i = 1, #group.members do
        local member = group.members[i]
        if member.health < lowestHealth and not member:HasBuff(renewingMist) then
            lowestMember = member
            lowestHealth = member.health
        end
    end
    return lowestMember
end

monk:Init(function()
    if target.enemy then
        StartAttack()
        -- Execute the main rotation.
        mainRotation()
local function mainRotation()
    -- Use Tiger Palm before every Blackout Kick.
    if tigerPalm:Ready() then
        tigerPalm:Cast(target)
    end

    -- Use Blackout Kick if we have a proc from Rising Sun Kick or if it's off cooldown.
    if player:HasBuff(risingSunKickProc) and blackoutKick:Ready() then
        blackoutKick:Cast(target)
    elseif risingSunKick:Cooldown() == 0 and blackoutKick:Ready() then
        blackoutKick:Cast(target)
    end

    -- Use Rising Sun Kick on cooldown and refresh its proc buff.
    if risingSunKick:Ready() then
        risingSunKick:Cast(target)
        player:CastBuff(risingSunKickProc)
    end

    -- Use Touch of Death if the target is below 10% health.
    if target.health < 10 and touchOfDeath:Ready() then
        touchOfDeath:Cast(target)
    end

    -- Keep up Renewing Mist on the lowest health party member who doesn't have the buff.
    local lowestMember = lowestHealthPartyMember()
    if lowestMember and not lowestMember:HasBuff(renewingMist) then
        renewingMist:Cast(lowestMember)
    end
end
    end
end)
