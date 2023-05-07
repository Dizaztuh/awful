local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

local Spell = awful.Spell
awful.Populate({
    tigerPalm = Spell(100780, { damage = "physical" }),
    blackoutKick = Spell(118166, { damage = "physical" }),
    risingSunKick = Spell(107428, { damage = "physical" }),
    spinningCraneKick = Spell(101546, { damage = "physical" }),
    touchOfDeath =   Spell(322109),
    envelopingMist = Spell(124682, { heal = true, ranged = true, targeted = true }),
    renewingMist = Spell(119611, { heal = true, ranged = true, targeted = true }),
    soothingMist = Spell(115175, { heal = true }),
    essenceFont = Spell(191837, { heal = true }),
    chiWave = Spell(115098, { heal = true, ranged = true }),
    lifeCocoon = Spell(116849, { heal = true, ranged = true, targeted = true, range = 40 }),
    sphereofDespair = Spell(410777, { targeted = true }),
    roll = Spell(109132),
    chiTorpedo = Spell(119582),
    faelineStomp = Spell(388193, {heal = true, ranged = true}),
    paralyze = Spell(115078, { stun = true, targeted = true, range = 25 }),
    legSweep = Spell(119381, { stun = true, range = 6 }),
    ringOfPeace = Spell(116844, { cc = true }),
    flyingSerpentKick = Spell(101545),
    fortifyingBrew = Spell(115203, { heal = true }),
    dampenHarm = Spell(122278),
    revival = Spell(115310, { heal = true, ranged = true }),
    diffuseMagic = Spell(122783),
    detox = Spell(115450, { dispel = true }),
    spearHandStrike = Spell(116705, { interrupt = true }),
    healingElixir = Spell(122281, { heal = true }),
    sphereofHope = Spell (410777, { targeted = true }),
    thunderFocusTea = Spell(116680),
    restoral = Spell(388615, { heal = true, ranged = true }),
    tigersLust = Spell(116841, { targeted = true, ranged = true, range = 30 }),
    invokeChiJi = Spell(325197)
}, mistweaver, getfenv(1))

local kickAllTable = {
    "Cyclone",
    "Chaos Bolt",
    "Ring of Frost",
    "Revive Pet",
    "Mass Dispel",
    "Summon Water Elemental",
    "Glacial Spike",
    "Greater Pyroblast",
    "Ray of Frost",
    "Shadowfury",
    "Schism",
    "Lightning Lasso",
    "Cyclotronic Blast",
    "Focused Energy",
    "Convoke the Spirits",
    "Deathborne",
    "Mindgames",
    "Repentance",
    "Summon Demonic Tyrant",
    "Banish",
    "Eternity Surge",
    "Demonfire",
}

local kickHealsTable = {
    "Regrowth",
    "Wild Growth",
    "Nourish",
    "Flash of Light",
    "Holy Light",
    "Flash Heal",
    "Heal",
    "Prayer of Healing",
    "Prayer of Mending",
    "Clarity of Will",
    "Divine Hymn",
    "Greater Heal",
    "Penance",
    "Soothing Mist",
    "Enveloping Mist",
    "Vivify",
    "Chain Heal",
    "Healing Wave",
    "Healing Surge",
    "Healing Rain",
    "Drain Life",
    "Dream Breath",
    "Spiritbloom",
    "Living Flame",
}

local cleanseTable = {
    "Hex",
    "Mirrors of Torment",
    "Mindgames",
    "Sepsis",
    "Fire Breath",
    "Curse of Exhaustion",
    "Landslide",
    "Curse of Weakness",
    "Polymorph",
}

-- Callback for Detox ability
detox:Callback(function(spell)
    -- Loop through all friendly units
    awful.fgroup.loop(function(friend)
        -- Check if the friendly unit has a debuff from the cleanseTable
        for _, debuffName in ipairs(cleanseSpells) do
            if friend.debuff(debuffName) then
                -- If so, cast Detox on the friendly unit to cleanse the debuff
                detox:Cast(friend)
                return true -- exit the loop
            end
        end
    end)
end)

-- Callback for Spear Hand Strike ability
spearHandStrike:Callback(function(spell)
    local targetCastingSpell = target.spellName -- Get the name of the spell being cast by the target

    -- Check if the target is casting a spell from the kickAllTable or kickHealsTable
    if targetCastingSpell and (kickAllTable[targetCastingSpell] or kickHealsTable[targetCastingSpell]) then
        -- If so, cast Spear Hand Strike on the target to interrupt it
        spearHandStrike:Cast(target)
    end
end)

-- Callback for Tiger's Lust ability
tigersLust:Callback(function(spell)
    -- Check if the player is rooted for more than 3 seconds and their health is below 50%
    if player.rootRemains > 3 and player.hp < 50 then
        return tigersLust:Cast(player)
    end

    -- Loop through all friendly units
    awful.fgroup.loop(function(friend)
        -- Check if the friend is rooted for more than 3 seconds and their health is below 50%
        if friend.rootRemains > 3 and friend.hp < 50 then
            return tigersLust:Cast(friend)
        end
    end)

    -- Loop through all enemy units
    awful.fgroup.loop(function(friend)
        -- Check if the enemy is rooted for more than 3 seconds and their health is below 50%
        if friend.rootRemains > 3 and enemy.hp < 50 then
            return tigersLust:Cast(friend)
        end
    end)
end)

-- Callback for Invoke Chi-Ji, the Red Crane ability
invokeChiJi:Callback(function(spell)
    -- Check if the player is rooted for more than 3 seconds and their health is below 50%
    if player.rootRemains > 3 and player.hp < 50 then
        return invokeChiJi:Cast(player)
    end

    -- Loop through all friendly units
    awful.fgroup.loop(function(friend)
        -- Check if the friend is rooted for more than 3 seconds and their health is below 50%
        if friend.rootRemains > 3 and friend.hp < 50 then
            return invokeChiJi:Cast(friend)
        end
    end)

    -- Loop through all enemy units
    awful.enemies.loop(function(friend)
        -- Check if the enemy is rooted for more than 3 seconds and their health is below 50%
        if friend.rootRemains > 3 and enemy.hp < 50 then
            return invokeChiJi:Cast(friend)
        end
    end)
end)


-- Create a callback for Thunder Focus Tea
thunderFocusTea:Callback(function(spell)
    -- Check if the player's hp is at or below 75% and the spell is castable
    if player.hp <= 75 and thunderFocusTea:Castable() then
        -- If the player's hp is at or below 75%, cast Thunder Focus Tea on the player
        return thunderFocusTea:Cast(player)
    else
        -- Loop through all friendly units to check their hp
        awful.fgroup.loop(function(friend)
            -- Check if the friendly unit's hp is at or below 75% and the spell is castable
            if friend.hp <= 75 and thunderFocusTea:Castable() then
                -- If the friendly unit's hp is at or below 75%, cast Thunder Focus Tea on the player
                return thunderFocusTea:Cast(player)
            end
        end)
    end
end)


revival:Callback(function(spell)
    -- Loop through all friendly units
        awful.fgroup.loop(function(friend)
        -- Check if the friend's health is below 30%
        if friend.hp < 33 then
            -- Cast Revival
            return revival:Cast(friend)
        end
    end)
end)

restoral:Callback(function(spell)
    -- Loop through all friendly units
        awful.fgroup.loop(function(friend)
        -- Check if the friend's health is below 30%
        if friend.hp < 33 then
            -- Cast Revival
            return restoral:Cast(friend)
        end
    end)
end)

local lastCastTime = 0

sphereofHope:Callback(function(spell)
    -- Check if 30 seconds have passed since the last cast
    if GetTime() - lastCastTime >= 30 then
        -- Loop through all friendly units
        awful.fgroup.loop(function(friend)
            if not friend.combat or friend.hp > 90 or friend.buff(411036) then
                return
            end
            -- If the friend meets the conditions (in combat, hp < 75%, and within range), cast Sphere of Hope on them
            sphereofHope:Cast(friend)

            -- Update the lastCastTime variable
            lastCastTime = GetTime()

            -- Exit the loop
            return true
        end)
    end
end)


local lastCastTimeDespair = 0

sphereofDespair:Callback(function (spell)
    -- Check if 30 seconds have passed since the last cast
    if GetTime() - lastCastTimeDespair >= 30 then
        -- Check if the target doesn't have the debuff (411038) and the spell is castable on the target
        if not target.debuff(411038) and spell:Castable(target) then
            sphereofDespair:Cast(target)

            -- Update the lastCastTimeDespair variable
            lastCastTimeDespair = GetTime()
        end
    end
end)


envelopingMist:Callback("prio", function(spell)
    -- Loop through all friendly units
    awful.fgroup.loop(function(friend)
        -- Check if the friendly unit is not in combat, has more than 75% HP
        if not friend.combat then
            -- If any of the conditions are met, skip this friendly unit
            return
        end
        -- Check if Enveloping Mist's cast time is 0
        if envelopingMist.castTime == 0 then
            -- If the cooldown is 0, cast Enveloping Mist on the friendly unit
            envelopingMist:Cast(friend)
            return true -- exit the loop
        end
    end)
end)


faelineStomp:Callback(function (spell)
    if not player.buff (389387) then
        faelineStomp:Cast(target)
    end
end)

fortifyingBrew:Callback(function(spell)
    if player.hp <= 40 then
        fortifyingBrew:Cast(player)
    end
end)

healingElixir:Callback(function(spell)
    if player.hp <= 55 then
        healingElixir:Cast(player)
    end
end)

-- Define an array of debuffs that we want to check for
local badStuff = {"Mindgames"}

diffuseMagic:Callback(function(spell)
    -- Check if the player has any of the debuffs listed in the "badStuff" array
    if player.debuffFrom(badStuff) or player.hp <= 34 then
        -- If the player has the bad debuff, cast Diffuse Magic on the player
        diffuseMagic:Cast(player)
    end
end)


-- Create a callback for the Leg Sweep ability
legSweep:Callback(function(spell)
    -- Check if the target's hp percentage is at or below 70%, the spell is castable on the target, and the target is in range
    if target.hp <= 70 and legSweep:Castable(target) then
        -- If the target's hp is at or below 70%, cast Leg Sweep on the target
        return legSweep:Cast(target)
    elseif enemies.around(player, 6) >= 2 then
        -- If there are 2 or more enemies around the player within a range of 6 yards, cast Leg Sweep on the target
        return legSweep:Cast(target)
    end
end)


dampenHarm:Callback(function(spell)
    if player.hp <= 65 then -- check if the player's hp is at or below 60%
        dampenHarm:Cast(player) -- cast Dampen Harm on the player
    end
end)

-- Create a callback for the Life Cocoon ability
lifeCocoon:Callback("prio", function(spell)
    -- Loop through all friendly units
    awful.fgroup.loop(function(friend)
        -- If the friend is not in combat, their hp is above 50%, or they are out of the range of Life Cocoon, we skip them
        -- This ensures that we only try to cast Life Cocoon on friends who are in combat, have less than 50% hp, and are within the range of Life Cocoon
        -- friend.dist provides the distance to the friend
        -- lifeCocoon.range provides the range of the Life Cocoon spell
        -- Comparing these values, we can determine if the friend is within range for the Life Cocoon spell
        if not friend.combat or friend.hp > 50 or friend.distance > lifeCocoon.range then return end
        -- If the friend meets the conditions (in combat, hp < 50%, and within range), cast Life Cocoon on them
        return lifeCocoon:Cast(friend)
    end)
end)

-- Create a callback for the Paralyze ability
paralyze:Callback(function(spell)
    -- Check if the enemy healer is valid, within paralyze.range, the target's hp is below 40%, and the spell is castable on the enemy healer
    if enemyHealer.distance <= paralyze.range and target.hp < 70 and paralyze:Castable(enemyHealer) then
        -- If the conditions are met, cast Paralyze on the enemy healer
        paralyze:Cast(enemyHealer)
    end
end)

-- Callback for Tiger Palm
tigerPalm:Callback(function(spell)
    if tigerPalm:Castable(target) and player.lastCast ~= tigerPalm.id then
        -- Cast Tiger Palm on the target.
        tigerPalm:Cast(target)
        return
    end
end)

-- Callback for Blackout Kick
blackoutKick:Callback(function(spell)
    if blackoutKick:Castable(target) and player.lastCast == tigerPalm.id then
        -- Cast Blackout Kick on the target.
        blackoutKick:Cast(target)
        return
    end
end)

-- Callback for Rising Sun Kick
risingSunKick:Callback("prio", function(spell)
    if risingSunKick:Castable(target) then
        -- If so, cast Rising Sun Kick on the target.
        risingSunKick:Cast(target)
    end
end)

touchOfDeath:Callback(function(spell)
    -- Loop through all enemies within range, something arbitrary like 10 yards
    awful.enemies.within(5).loop(function(enemy)
        -- Check if spell is Castable and enemy hp is less than 15%  - LESS THAN due to the spell tooltip being "under 15% health"
        if enemy.hp < 15 then
            -- Cast Touch of Death on the enemy
            touchOfDeath:Cast(enemy)
            return true -- exit the loop after casting the spell
        end
    end)
end)