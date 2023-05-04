monk:Init(function()local Unlocker, awful, project = ...
local monk = project.monk.fistweaver
monk:Init(function()
    local Unlocker, awful, project = ...
    local monk = project.monk.fistweaver
    
    local function cast(spell, target)
        if target and target.enemy and spell:Cast(target) then
            awful.alert(spell.name, spell.id)
            return true
        end
        return false
    end
    
    local function canCast(spell, target)
        return spell:Usable() and spell:InRange(target)
    end
    
    local function hasDebuff(spell, target)
        return target.debuff[spell.name] and target.debuff[spell.name].remaining >= spell.duration * 0.3
    end
    
    local function hasBuff(spell, player)
        return player.buff[spell.name] and player.buff[spell.name].remaining >= spell.duration * 0.3
    end
    
    local function useTouchOfDeath(target)
        return target.hp <= 15 and canCast(touchOfDeath, target)
    end
    
    local function useFaelineStomp(target)
        return target.distance < 8 and canCast(faelineStomp, target)
    end
    
    -- Faeline Stomp on pull
    local target = target
    if useFaelineStomp(target) then
        cast(faelineStomp, target)
    end
    
    while target.enemy do
        -- Tiger Palm
        if canCast(tigerPalm, target) then
            cast(tigerPalm, target)
        end
    
        -- Blackout Kick
        if canCast(blackoutKick, target) then
            if not hasDebuff(risingSunKick, target) then
                cast(blackoutKick, target)
            elseif risingSunKick.cooldown > 2.5 then
                cast(blackoutKick, target)
            end
        end
    
        -- Rising Sun Kick
        if canCast(risingSunKick, target) then
            cast(risingSunKick, target)
        end
    
        -- Alpha Tiger
        if canCast(tigerPalm, target) and hasBuff(tigerPower, player) then
            cast(tigerPalm, target)
        end
    
        -- Touch of Death
        if useTouchOfDeath(target) then
            cast(touchOfDeath, target)
        end
    end
end)

print("Sisterfister Monk PvP rotation loaded!")

monk:Init(function()

local function cast(spell, target)
    if target and target.enemy and spell:Cast(target) then
        awful.alert(spell.name, spell.id)
        return true
    end
    return false
end

local function canCast(spell)
    return spell:Usable() and spell:InRange(target)
end

local function hasDebuff(spell)
    return target.debuff[spell.name] and target.debuff[spell.name].remaining >= spell.duration * 0.3
end

local function hasBuff(spell)
    return player.buff[spell.name] and player.buff[spell.name].remaining >= spell.duration * 0.3
end

local function useTouchOfDeath()
    return target.hp <= 15 and canCast(touchOfDeath)
end

local function useFaelineStomp()
    return target.distance < 8 and canCast(faelineStomp)
end

-- Faeline Stomp on pull
if useFaelineStomp() then
    cast(faelineStomp, target)
end

while target.enemy do
    -- Tiger Palm
    if canCast(tigerPalm) then
        cast(tigerPalm, target)
    end

    -- Blackout Kick
    if canCast(blackoutKick) then
        if not hasDebuff(risingSunKick) then
            cast(blackoutKick, target)
        elseif risingSunKick.cooldown > 2.5 then
            cast(blackoutKick, target)
        end
    end

    -- Rising Sun Kick
    if canCast(risingSunKick) then
        cast(risingSunKick, target)
    end

    -- Alpha Tiger
    if canCast(tigerPalm) and hasBuff(tigerPower) then
        cast(tigerPalm, target)
    end

    -- Touch of Death
    if useTouchOfDeath() then
        cast(touchOfDeath, target)
    end
end
end)


local function cast(spell, target)
    if target and target.enemy and spell:Cast(target) then
        awful.alert(spell.name, spell.id)
        return true
    end
    return false
end

local function canCast(spell)
    return spell:Usable() and spell:InRange(target)
end

local function hasDebuff(spell)
    return target.debuff[spell.name] and target.debuff[spell.name].remaining >= spell.duration * 0.3
end

local function hasBuff(spell)
    return player.buff[spell.name] and player.buff[spell.name].remaining >= spell.duration * 0.3
end

local function isBurst()
    return awful.burst and target.hp <= 50 and target.distance < 8
end

local function useTouchOfDeath()
    return target.hp <= 15 and canCast(touchOfDeath)
end

local function useFaelineStomp()
    return target.distance < 8 and canCast(faelineStomp)
end

-- Faeline Stomp on pull
if useFaelineStomp() then
    cast(faelineStomp, target)
end

while target.enemy do
    -- Tiger Palm
    if canCast(tigerPalm) then
        cast(tigerPalm, target)
    end

    -- Blackout Kick
    if canCast(blackoutKick) then
        if not hasDebuff(risingSunKick) then
            cast(blackoutKick, target)
        elseif risingSunKick.cooldown > 2.5 then
            cast(blackoutKick, target)
        end
    end

    -- Rising Sun Kick
    if canCast(risingSunKick) then
        cast(risingSunKick, target)
    end

    -- Alpha Tiger
    if canCast(tigerPalm) and hasBuff(tigerPower) then
        cast(tigerPalm, target)
    end

    -- Touch of Death
    if useTouchOfDeath() then
        cast(touchOfDeath, target)
    end
end
end)
