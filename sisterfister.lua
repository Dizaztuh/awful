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
        -- Cast Tiger Palm before every Blackout Kick
        if tigerPalm:Ready() then
            tigerPalm:Cast(target)
        end
    
        if blackoutKick:Ready() then
            blackoutKick:Cast(target)
    
            -- Use instant-cast Rising Sun Kick if available
            if risingSunKick:Ready(true) then
                risingSunKick:Cast(target)
            end
        end
    
        -- Use Rising Sun Kick on cooldown
        if risingSunKick:Ready() then
            risingSunKick:Cast(target)
        end
    
        -- Use Touch of Death if the target is below 10% health.
        if target.health < 10 and touchOfDeath:Ready() then
            touchOfDeath:Cast(target)
        end
    
        -- Cast Renewing Mist on the lowest health party member who doesn't have the buff
        local lowestHealth = GetLowestHealthPartyMember()
        if lowestHealth and not lowestHealth:HasBuff(renewingMist) then
            renewingMist:Cast(lowestHealth)
        end
    end
    end)
