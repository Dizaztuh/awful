local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

local Spell = awful.Spell
awful.Populate({
    tigerPalm = Spell(100780, { damage = "physical", targeted = true, ranged = true, range = 5 }),
    blackoutKick = Spell(118166, { damage = "physical", targeted = true }),
    risingSunKick = Spell(107428, { damage = "physical", targeted = false, ranged = true, range = 5 }),
    spinningCraneKick = Spell(101546, { damage = "physical" }),
    touchOfDeath =   Spell(322109, { damage = "physical", range = 10, ranged = true}),
    envelopingMist = Spell(124682, { heal = true, targeted = true }),
    renewingMist = Spell(119611, { heal = true, targeted = true }),
    soothingMist = Spell(115175, { heal = true }),
    essenceFont = Spell(191837, { heal = true }),
    chiWave = Spell(115098, { heal = true }),
    lifeCocoon = Spell(116849, { heal = true, targeted = true, range = 40 }),
    sphereofDespair = Spell(410777, { targeted = true }),
    roll = Spell(109132),
    chiTorpedo = Spell(119582),
    faelineStomp = Spell(388193, {heal = true}),
    paralyze = Spell(115078, { stun = true, targeted = true, range = 25 }),
    legSweep = Spell(119381, { effect = "physical", stun = true, range = 10 }),
    ringOfPeace = Spell(116844, { cc = true , ignoreMoving = true, range = 40 }),
    flyingSerpentKick = Spell(101545),
    fortifyingBrew = Spell(115203, { heal = true }),
    dampenHarm = Spell(122278),
    revival = Spell(115310, { heal = true }),
    diffuseMagic = Spell(122783),
    detox = Spell(115450, { targeted = true, range = 40 }),
    spearHandStrike = Spell(116705),
    healingElixir = Spell(122281, { heal = true }),
    sphereofHope = Spell (410777, { targeted = true }),
    thunderFocusTea = Spell(116680),
    restoral = Spell(388615, { heal = true, ranged = true, ignoreControl = true }),
    tigersLust = Spell(116841, { targeted = true, range = 30 }),
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

    -- Check if the target is casting a spell from the kickAllTable or kickHealsTable, and not immune to interrupts
    if not target.castint and targetCastingSpell and (kickAllTable[targetCastingSpell] or kickHealsTable[targetCastingSpell]) and target.castPct > randomCastPct then
        -- If so, cast Spear Hand Strike on the target to interrupt it
        spearHandStrike:Cast(target)
        awful.alert("Interrupted", 116705)    
    end
end)

-- Callback for Detox ability
detox:Callback(function(spell)
    local detoxCast = false -- Flag variable to track if Detox has been cast
    -- Loop through all friendly units
    awful.fgroup.loop(function(friend)
        -- Check if the friendly unit has a debuff from the cleanseTable
        for _, debuffName in ipairs(cleanseTable) do
            if friend.debuff(debuffName) then
                -- If so, cast Detox on the friendly unit to cleanse the debuff
                detox:Cast(friend)
                awful.alert("Cleansing", 115450) 
                detoxCast = true -- Set the flag to true
                return true -- exit the inner loop
            end
        end
        -- Exit the outer loop if Detox was cast
        return detoxCast
    end)
end)



-- Callback for Tiger's Lust ability
tigersLust:Callback(function(spell)
    -- Check if the player is rooted for more than 3 seconds and their health is below 50%
    if (player.rootRemains > 3 or player.slowed) and player.hp < 60 then
        return tigersLust:Cast(player)
        awful.alert("Casted Tiger's Lust", 116841) 
    end

    -- Loop through all friendly units
    awful.friends.loop(function(friend)
        -- Check if the friend is rooted for more than 3 seconds and their health is below 50%
        if (friend.rootRemains > 3 or player.slowed) and friend.hp < 60 then
            return tigersLust:Cast(friend)
            awful.alert("Casted Tiger's Lust", 116841) 
        end
    end)

    -- Loop through all enemy units
    awful.friends.loop(function(friend)
        -- Check if the enemy is rooted for more than 3 seconds and their health is below 50%
        if (friend.rootRemains > 3 or player.slowed) and friend.target.hp < 60 then
            return tigersLust:Cast(friend)
            awful.alert("Casted Tiger's Lust", 116841) 
        end
    end)
end)

-- Callback for Invoke Chi-Ji, the Red Crane ability
invokeChiJi:Callback(function(spell)
    -- Check if the player is rooted for more than 3 seconds and their health is below 50%
    if (player.rootRemains > 3 or player.slowed) and player.hp < 60 then
        return invokeChiJi:Cast(player)
        awful.alert("Casted Invoke Chi-Ji", 325197) 
    end

    -- Loop through all friendly units
    awful.friends.loop(function(friend)
        -- Check if the friend is rooted for more than 3 seconds and their health is below 50%
        if (friend.rootRemains > 3 or player.slowed) and friend.hp < 60 then
            return invokeChiJi:Cast(friend)
            awful.alert("Casted Invoke Chi-Ji", 325197)
        end
    end)

    -- Loop through all enemy units
    awful.friends.loop(function(friend)
        -- Check if the enemy is rooted for more than 3 seconds and their health is below 50%
        if (friend.rootRemains > 3 or player.slowed) and friend.target.hp < 60 then
            return invokeChiJi:Cast(friend)
            awful.alert("Casted Invoke Chi-Ji", 325197)
        end
    end)
end)


-- Create a callback for Thunder Focus Tea
thunderFocusTea:Callback(function(spell)
    -- Check if the player's hp is at or below 75% and the spell is castable
    if player.hp <= 75 and thunderFocusTea:Castable() then
        -- If the player's hp is at or below 75%, cast Thunder Focus Tea on the player
        return thunderFocusTea:Cast(player)
        awful.alert("Casted Thunder Focus Tea", 116680)
    else
        -- Loop through all friendly units to check their hp
        awful.fgroup.loop(function(friend)
            -- Check if the friendly unit's hp is at or below 75% and the spell is castable
            if friend.hp <= 75 and thunderFocusTea:Castable() then
                -- If the friendly unit's hp is at or below 75%, cast Thunder Focus Tea on the player
                return thunderFocusTea:Cast(player)
                awful.alert("Casted Thunder Focus Tea", 116680)
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
            awful.alert("Casted Revival", 115310)
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
            awful.alert("Casted Restoral", 388615)
        end
    end)
end)

local lastCastTimeHope = 0

sphereofHope:Callback(function(spell)
    -- Check if 30 seconds have passed since the last cast
    if GetTime() - lastCastTimeHope >= 5 then
        -- Loop through all friendly units
        awful.fgroup.loop(function(friend)
            if not friend.combat or friend.hp > 90 or friend.buff(411036) then
                return
            end
            -- If the friend meets the conditions (in combat, hp < 75%, and within range), cast Sphere of Hope on them
            sphereofHope:Cast(friend)
            awful.alert("Casted Sphere of Hope on Friendly", 410777)
            -- Update the lastCastTime variable
            lastCastTimeHope = GetTime()

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
            awful.alert("Casted Sphere of Despair on Target", 410777)
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
        awful.alert("Casted Enveloping Mist on Friendly", 124682)  
    end
end)


faelineStomp:Callback(function (spell)
    if not player.buff (388026) then
        faelineStomp:Cast(target)
        awful.alert("Casted Faeline Stomp to Rebuff", 388193)     
    end
end)

fortifyingBrew:Callback(function(spell)
    if player.hp <= 40 then
        fortifyingBrew:Cast(player)
        awful.alert("Casted Fortifying Brew! Gettin' REKT!", 115203)      
    end
end)

healingElixir:Callback(function(spell)
    if player.hp <= 55 then
        healingElixir:Cast(player)
        awful.alert("Casted Healing Elixir", 122281) 
    end
end)

-- Define an array of debuffs that we want to check for
local badStuff = {"Mindgames"}

diffuseMagic:Callback(function(spell)
    -- Check if the player has any of the debuffs listed in the "badStuff" array
    if player.debuffFrom(badStuff) or player.hp <= 34 then
        -- If the player has the bad debuff, cast Diffuse Magic on the player
        diffuseMagic:Cast(player)
        awful.alert("Casted Diffuse Magic", 122783) 
    end
end)


-- Create a callback for the Leg Sweep ability
legSweep:Callback(function(spell)
    -- Get the number of players in range
    local playersInRange = enemies.around(player, 10)   
    -- Check if the spell is castable on the target
    if legSweep:Castable(target) then
        -- If there are 2 or more enemies around the player within a range of 6 yards, cast Leg Sweep on the target
        if playersInRange > 1 then
            return legSweep:Cast(target)
            awful.alert("Casted Leg Sweep", 119381) 
        -- If the player's HP is below 45%, cast Leg Sweep on the target
        elseif player.hp < 45 and playersInRange <= 1 then
            return legSweep:Cast(target)
            awful.alert("Casted Leg Sweep to Peel!", 119381) 
        end
    end

    -- Add the new condition for Leg Sweep
    awful.fgroup.loop(function(friend)
        -- Check if at least 1 enemy is within range and friend's HP is 40% or lower
        if playersInRange >= 1 and friend.hp <= 40 then
            return legSweep:Cast(target)
            awful.alert("Casted Leg Sweep to Peel!", 119381) 
        end
    end)
end)



dampenHarm:Callback(function(spell)
    if player.hp <= 65 then -- check if the player's hp is at or below 60%
        dampenHarm:Cast(player) -- cast Dampen Harm on the player
        awful.alert("Casted Dampen Harm", 122278) 
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
        awful.alert("Casted Life Cocoon", 116849) 
    end)
end)

-- Create a callback for the Paralyze ability
paralyze:Callback(function(spell)
    -- Check if the enemy healer is valid, within paralyze.range, the target's hp is below 40%, the spell is castable on the enemy healer, and the enemy healer is not the player's target
    if enemyHealer.distance <= paralyze.range and target.hp < 70 and paralyze:Castable(enemyHealer) and not (player.target.guid == enemyHealer.guid) then
        -- If the conditions are met, cast Paralyze on the enemy healer
        paralyze:Cast(enemyHealer)
        awful.alert("Casted Paralysis on Enemy Healer", 115078) 
    elseif target.enemyHealer and target.hp < 40 then
        local closestEnemy, closestDistance = nil, math.huge

        -- Loop through all enemies within 20 yards
        awful.enemies.around(player, 20, function(enemy)
            local distance = enemy.distance

            -- Find the closest enemy
            if distance < closestDistance then
                closestEnemy = enemy
                closestDistance = distance
            end
        end)

        -- If a valid closest enemy is found and Paralyze can be cast on the enemy, cast Paralyze
        if closestEnemy and paralyze:Castable(closestEnemy) then
            paralyze:Cast(closestEnemy)
            awful.alert("Casted Paralysis on Closest Enemy!", 115078) 
        end
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


-- Create a callback for the Touch of Death ability
touchOfDeath:Callback(function(spell)
    -- Loop through all enemies within range, something arbitrary like 10 yards
    awful.enemies.within(10).loop(function(enemy)
        -- Check if spell is Castable and enemy hp is less than 15%  - LESS THAN due to the spell tooltip being "under 15% health"
        if touchOfDeath:Castable(enemy) and enemy.hp < 15 then
            -- Cast Touch of Death on the enemy
            touchOfDeath:Cast(enemy)
            awful.alert("Casted Touch of Death! RIPERINO!", 322109) 
            return true -- exit the loop after casting the spell
        end
    end)
end)

ringOfPeace:Callback(function(spell)
    awful.triggers.loop(function(trigger)
        -- Check if the trigger.id matches any of the desired spell IDs
        if trigger.id == 62618 or
           trigger.id == 196718 or
           trigger.id == 198838 or
           trigger.id == 98008 or
           trigger.id == 376079 then
            -- Retrieve the x, y, and z coordinates of the trigger's position.
            local x, y, z = trigger.position()
            -- Cast Ring of Peace at the trigger's position
            ringOfPeace:AoECast(x, y, z)
            awful.alert("Casted Ring of Peace!", 116844) 
        end
    end)
end)

-- Define a table with totem names and their respective IDs
local totemList = {
    ["Capacitor Totem"] = 59547,
    ["Tremor Totem"] = 8143,
    ["Earthbind Totem"] = 2484,
    ["Spirit Link Totem"] = 98008,
    ["Grounding Totem"] = 8177,
    ["Skyfury Totem"] = 204330,
    ["Counterstrike Totem"] = 204331,
    ["Psyfiend"] = 108366,
    ["Windfury Totem"] = 8512,
    ["Fel Obelisk"] = 255774,
    ["Static Totem"] = 301624,
    ["Void Tendril"] = 115422,
    ["War Banner"] = 246366,
    ["Earthgrab Totem"] = 51485,
    ["Healing Tide Totem"] = 108280,
    ["Static Field Totem"] = 281902
}

-- Stomp totems function
function stompTotems()
    awful.totems.loop(function(totem)
        -- Check if the totem is in the totemList
        if totemList[totem.name] then
            -- If the totem is in the list, cast Tiger Palm on the totem
            tigerPalm:Cast(totem)
        
        end
    end)
end

