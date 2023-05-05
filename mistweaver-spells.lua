local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

local Spell = awful.Spell

awful.Populate({
    tigerPalm = Spell(100780, { damage = "physical" }),
    blackoutKick = Spell(118166, { damage = "physical" }),
    risingSunKick = Spell(107428, { damage = "physical" }),
    spinningCraneKick = Spell(101546, { damage = "physical" }),
    touchOfDeath = Spell(115080, { damage = "physical", targeted = true }),
    envelopingMist = Spell(124682, { heal = true, targeted = true }),
    renewingMist = Spell(119611, { heal = true, targeted = true }),
    soothingMist = Spell(115175, { heal = true }),
    essenceFont = Spell(191837, { heal = true }),
    chiWave = Spell(115098, { heal = true }),
    lifeCocoon = Spell(116849, { heal = true, targeted = true }),
    zenSpheres = Spell(410777, { heal = true, targeted = true }),
    roll = Spell(109132),
    chiTorpedo = Spell(119582),
    faelineStomp = Spell(388193),
    paralyze = Spell(115078, { stun = true, targeted = true }),
    legSweep = Spell(119381, { stun = true, targeted = true }),
    ringOfPeace = Spell(116844, { cc = true, targeted = false }),
    flyingSerpentKick = Spell(101545),
    fortifyingBrew = Spell(115203, { heal = true }),
    dampenHarm = Spell(122278),
    diffuseMagic = Spell(122783),
    healingElixir = Spell(122281, { heal = true })
}, mistweaver, getfenv(1))

faelineStomp:Callback(function (spell)
    spell:Cast(target)
end)

fortifyingBrew:Callback(function(spell)
    if player.health <= 40 then
        spell:Cast()
    end
end)

healingElixir:Callback(function(spell)
    if player.health <= 75 then
        spell:Cast()
    end
end)

-- Define an array of debuffs that we want to check for
local badStuff = {"Mindgames"}

diffuseMagic:Callback(function(spell)
    -- Check if the player has any of the debuffs listed in the "badStuff" array
    if player.debuffFrom(badStuff) then
        -- If the player has the bad debuff, cast Diffuse Magic on the player
        spell:Cast()
    elseif player.hp <= 35 then
        -- If player hp is 0.35 or less, cast Diffuse Magic on the player
        spell:Cast()
    end
end)

-- Create a callback for the Leg Sweep ability
legSweep:Callback(function(spell)
    -- Check if the target's health percentage is at or below 40%
    if target.hp <= 40 then
        -- If the target's health is at or below 40%, cast Leg Sweep on the target
        spell:Cast(target)
        return
    end
end)

dampenHarm:Callback(function(spell)
    if player.hp <= 60 then -- check if the player's health is at or below 60%
        spell:Cast() -- cast Dampen Harm on the player
    end
end)

-- Create a callback for the Touch of Death ability
touchOfDeath:Callback(function(spell)
    -- Loop through all enemies within range
    awful.enemies.loop(function(enemy)
        -- Check if enemy hp is less than or equal to 15%
        if enemy.hp <= 15 then
            -- Cast Touch of Death on the enemy
            spell:Cast(enemy)
            return true -- exit the loop after casting the spell
        end
    end)
end)

-- Create a callback for the Life Cocoon ability
lifeCocoon:Callback(function(spell)
    -- Loop through all friendly units
    awful.friends.loop(function(friend)
        -- If the friend is not in combat, their health is above 50%, or they are out of the range of Life Cocoon, we skip them
        -- This ensures that we only try to cast Life Cocoon on friends who are in combat, have less than 50% health, and are within the range of Life Cocoon
        -- friend.dist provides the distance to the friend
        -- lifeCocoon.range provides the range of the Life Cocoon spell
        -- Comparing these values, we can determine if the friend is within range for the Life Cocoon spell
        if not friend.combat or friend.hp > 50 or friend.dist > lifeCocoon.range then return end

        -- If the friend meets the conditions (in combat, hp < 50%, and within range), cast Life Cocoon on them
        return lifeCocoon:Cast(friend)
    end)
end)


-- Create a callback for the Paralyze ability
paralyze:Callback(function(spell)
    -- Check if the enemy healer is valid, within 20 yards range, and the target's health is below 40%
    if enemyHealer.exists and enemyHealer.Distance() <= 20 and target.hp < 0.4 then
        -- If the conditions are met, cast Paralyze on the enemy healer
        spell:Cast(enemyHealer)
    end
end)

-- Callback for Tiger Palm
tigerPalm:Callback(function()
    -- If Tiger Palm is castable and both Rising Sun Kick and Blackout Kick are not castable, cast Tiger Palm.
    if  risingSunKick:Castable(target) and not blackoutKick:Castable(target) then
        tigerPalm:Cast(target)
        return
    end
end)

-- Callback for Blackout Kick
blackoutKick:Callback(function()
    -- If Blackout Kick is castable and Rising Sun Kick is on cooldown or not castable, cast Blackout Kick.
    if blackoutKick:Castable(target) and (risingSunKick.cd > 0 or not risingSunKick:Castable(target)) then
        blackoutKick:Cast(target)
        return
    end
end)

-- Callback for Rising Sun Kick
risingSunKick:Callback(function()
    -- If Rising Sun Kick is castable, cast Rising Sun Kick.
    if risingSunKick:Castable(target) then
        risingSunKick:Cast(target)
    elseif
        tigerPalm:Cast(target)
        return
    end
end)



