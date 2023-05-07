local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

local Spell = awful.Spell
awful.Populate({
    tigerPalm = Spell(100780, { damage = "physical" }),
    blackoutKick = Spell(118166, { damage = "physical" }),
    risingSunKick = Spell(107428, { damage = "physical" }),
    spinningCraneKick = Spell(101546, { damage = "physical" }),
    touchOfDeath =   Spell(322109, { damage = "physical", range = 5}),
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
    legSweep = Spell(119381, { stun = true, range = 9 }),
    ringOfPeace = Spell(116844, {cc = true, ranged = true, range = 40 }),
    flyingSerpentKick = Spell(101545),
    fortifyingBrew = Spell(115203, { heal = true }),
    dampenHarm = Spell(122278),
    revival = Spell(115310, { heal = true, ranged = true }),
    diffuseMagic = Spell(122783),
    detox = Spell(115450),
    spearHandStrike = Spell(116705),
    healingElixir = Spell(122281, { heal = true }),
    sphereofHope = Spell (410777, { targeted = true }),
    thunderFocusTea = Spell(116680),
    restoral = Spell(388615, { heal = true, ranged = true }),
    tigersLust = Spell(116841, { targeted = true, ranged = true, range = 30 }),
    invokeChiJi = Spell(325197)
}, mistweaver, getfenv(1))

local kickAllTable = {
    ["Cyclone"] = true,
    ["Chaos Bolt"] = true,
    ["Ring of Frost"] = true,
    ["Revive Pet"] = true,
    ["Mass Dispel"] = true,
    ["Summon Water Elemental"] = true,
    ["Glacial Spike"] = true,
    ["Greater Pyroblast"] = true,
    ["Ray of Frost"] = true,
    ["Shadowfury"] = true,
    ["Schism"] = true,
    ["Lightning Lasso"] = true,
    ["Cyclotronic Blast"] = true,
    ["Focused Energy"] = true,
    ["Convoke the Spirits"] = true,
    ["Deathborne"] = true,
    ["Mindgames"] = true,
    ["Repentance"] = true,
    ["Summon Demonic Tyrant"] = true,
    ["Banish"] = true,
    ["Eternity Surge"] = true,
    ["Demonfire"] = true,
}

local kickHealsTable = {
    ["Regrowth"] = true,
    ["Wild Growth"] = true,
    ["Nourish"] = true,
    ["Flash of Light"] = true,
    ["Holy Light"] = true,
    ["Flash Heal"] = true,
    ["Heal"] = true,
    ["Prayer of Healing"] = true,
    ["Prayer of Mending"] = true,
    ["Clarity of Will"] = true,
    ["Divine Hymn"] = true,
    ["Greater Heal"] = true,
    ["Penance"] = true,
    ["Soothing Mist"] = true,
    ["Enveloping Mist"] = true,
    ["Vivify"] = true,
    ["Chain Heal"] = true,
    ["Healing Wave"] = true,
    ["Healing Surge"] = true,
    ["Healing Rain"] = true,
    ["Drain Life"] = true,
    ["Dream Breath"] = true,
    ["Spiritbloom"] = true,
    ["Living Flame"] = true,
}

local cleanseTable = {
    ["Hex"] = true,
    ["Mirrors of Torment"] = true,
    ["Mindgames"] = true,
    ["Sepsis"] = true,
    ["Fire Breath"] = true,
    ["Curse of Exhaustion"] = true,
    ["Landslide"] = true,
    ["Curse of Weakness"] = true,
    ["Polymorph"] = true,
    ["Fear"] = true,
    ["Psychic Scream"] = true,
}



-- Callback for Spear Hand Strike ability
spearHandStrike:Callback(function(spell)
    local targetCastingSpell = target.casting -- Get the name of the spell being cast by the target
    local randomCastPct = math.random(60, 80) -- Generate a random number between 60 and 80

    -- Check if the target is casting a spell from the kickAllTable or kickHealsTable
    if targetCastingSpell and (kickAllTable[targetCastingSpell] or kickHealsTable[targetCastingSpell]) and target.castPct > randomCastPct then
        -- If so, cast Spear Hand Strike on the target to interrupt it
        spearHandStrike:Cast(target)
    end
end)

-- Callback for Detox ability
detox:Callback(function(spell)
    -- Loop through all friendly units
    awful.fgroup.loop(function(friend)
        -- Check if the friendly unit has a debuff from the cleanseTable
        for _, debuffName in ipairs(cleanseTable) do
            if friend.debuff(debuffName) then
                -- If so, cast Detox on the friendly unit to cleanse the debuff
                detox:Cast(friend)
                return true -- exit the loop
            end
        end
    end)
end)


-- Callback for Tiger's Lust ability
tigersLust:Callback(function(spell)
    -- Check if the player is rooted for more than 3 seconds and their health is below 50%
    if (player.rootRemains > 3 or player.slowed) and player.hp < 60 then
        return tigersLust:Cast(player)
    end

    -- Loop through all friendly units
    awful.friends.loop(function(friend)
        -- Check if the friend is rooted for more than 3 seconds and their health is below 50%
        if (friend.rootRemains > 3 or player.slowed) and friend.hp < 60 then
            return tigersLust:Cast(friend)
        end
    end)

    -- Loop through all enemy units
    awful.friends.loop(function(friend)
        -- Check if the enemy is rooted for more than 3 seconds and their health is below 50%
        if (friend.rootRemains > 3 or player.slowed) and friend.target.hp < 60 then
            return tigersLust:Cast(friend)
        end
    end)
end)

-- Callback for Invoke Chi-Ji, the Red Crane ability
invokeChiJi:Callback(function(spell)
    -- Check if the player is rooted for more than 3 seconds and their health is below 50%
    if (player.rootRemains > 3 or player.slowed) and player.hp < 60 then
        return invokeChiJi:Cast(player)
    end

    -- Loop through all friendly units
    awful.friends.loop(function(friend)
        -- Check if the friend is rooted for more than 3 seconds and their health is below 50%
        if (friend.rootRemains > 3 or player.slowed) and friend.hp < 60 then
            return invokeChiJi:Cast(friend)
        end
    end)

    -- Loop through all enemy units
    awful.friends.loop(function(friend)
        -- Check if the enemy is rooted for more than 3 seconds and their health is below 50%
        if (friend.rootRemains > 3 or player.slowed) and friend.target.hp < 60 then
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
    if GetTime() - lastCastTime >= 5 then
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
    if GetTime() - lastCastTimeDespair >= 5 then
        -- Check if the target doesn't have the debuff (411038) and the spell is castable on the target
        if not target.debuff(411038) then
            sphereofDespair:Cast(target)

            -- Update the lastCastTimeDespair variable
            lastCastTimeDespair = GetTime()
        end
    end
end)


envelopingMist:Callback(function(spell)
    -- Initialize a variable to store the friendly unit with the lowest HP
    local lowestHpFriend = nil
    local lowestHpPercentage = 100

    -- Loop through all friendly units
    awful.fgroup.loop(function(friend)
        -- Check if this friendly unit has a lower HP percentage than the current lowestHpPercentage
        if friend.hp < lowestHpPercentage then
            -- Update lowestHpFriend and lowestHpPercentage
            lowestHpFriend = friend
            lowestHpPercentage = friend.hp
        end
    end)

    -- Check if Enveloping Mist's cast time is 0 and the lowestHpFriend is found
    if envelopingMist.castTime == 0 and lowestHpFriend ~= nil then
        -- If the cooldown is 0, cast Enveloping Mist on the friendly unit with the lowest HP
        envelopingMist:Cast(lowestHpFriend)
    end
end)



faelineStomp:Callback(function (spell)
    if not player.buff (388026) then
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
    -- Get the number of players in range
    local playersInRange = enemies.around(player, 9)
    
    -- Check if the spell is castable on the target
    if legSweep:Castable(target) then
        -- If there are 2 or more enemies around the player within a range of 6 yards, cast Leg Sweep on the target
        if playersInRange > 1 then
            return legSweep:Cast(target)
        -- If the player's HP is below 45%, cast Leg Sweep on the target
        elseif player.hp < 45 then
            return legSweep:Cast(target)
        end
    end
end)


dampenHarm:Callback(function(spell)
    if player.hp <= 65 then -- check if the player's hp is at or below 60%
        dampenHarm:Cast(player) -- cast Dampen Harm on the player
    end
end)

-- Create a callback for the Life Cocoon ability
lifeCocoon:Callback(function(spell)
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
    -- Check if the enemy healer is valid, within paralyze.range, the target's hp is below 40%, the spell is castable on the enemy healer, and the enemy healer is not the player's target
    if enemyHealer.distance <= paralyze.range and target.hp < 70 and paralyze:Castable(enemyHealer) and not (player.target.guid == enemyHealer.guid) then
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
risingSunKick:Callback(function(spell)
    -- Check if Rising Sun Kick is castable on the target and its cooldown is 0
    if  risingSunKick.cd == 0 then
        -- If so, cast Rising Sun Kick on the target.
        risingSunKick:Cast(target)
    end
end)


touchOfDeath:Callback(function(spell)
    -- Get the number of enemies within 8 yards and initialize an empty table to store enemies
    local numOfEnemiesInRange = awful.enemies.around(player, 5)
    local enemiesInRange = {}

    -- Loop through all enemies in the game, add enemies within 8 yards to the enemiesInRange table
    for _, enemy in ipairs(awful.enemies) do
        if awful.distance(player, enemy) <= 10 then
            table.insert(enemiesInRange, enemy)
        end
    end

    -- Check if there are any enemies in range
    if numOfEnemiesInRange > 0 then
        -- Iterate through the enemiesInRange table
        for _, enemy in ipairs(enemiesInRange) do
            -- Check if the spell is castable and the enemy's HP is less than 15%
            if touchOfDeath:Castable(enemy) and enemy.hp < 15 then
                -- Cast Touch of Death on the enemy
                touchOfDeath:Cast(enemy)
                return true -- exit the loop after casting the spell
            end
        end
    end
end)

-- Create a callback for the ringOfPeace ability
ringOfPeace:Callback(function(spell)
    -- Define a table containing the desired spell IDs.
    local spellIds = {62618, 196718, 198838, 98008, 376079}

    -- Define a function to check if a value exists in a table.
    local function valueExists(tbl, val)
        for _, v in ipairs(tbl) do
            if v == val then
                return true
            end
        end
        return false
    end

    -- Define a loop using the Awful framework's "triggers.loop" function to iterate through all active triggers.
    awful.triggers.loop(function(trigger)
        -- If the current trigger's ID is not in the spellIds table, skip to the next trigger.
        if not valueExists(spellIds, trigger.id) then return end
        -- If the trigger's ID is in the spellIds table, continue processing this trigger.
        -- At this point, you can perform any desired actions with the detected trigger.
        -- Retrieve the x, y, and z coordinates of the trigger's position.
        local x, y, z = trigger.position()
        -- Perform desired actions based on the trigger's ID
        if trigger.id == 62618 then
            ringOfPeace:AoECast(x, y, z)
        elseif trigger.id == 196718 then
            ringOfPeace:AoECast(x, y, z)
        elseif trigger.id == 198838 then
            ringOfPeace:AoECast(x, y, z)
        elseif trigger.id == 198838 then
            ringOfPeace:AoECast(x, y, z)
        elseif trigger.id == 376079 then
            ringOfPeace:AoECast(x, y, z)
        end
    end)
end)



