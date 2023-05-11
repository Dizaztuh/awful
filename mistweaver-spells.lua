local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver
local player = awful.Player
local Spell = awful.Spell
awful.Populate({
    tigerPalm = Spell(100780, { damage = "physical", targeted = true, ranged = true }),
    blackoutKick = Spell(118166, { damage = "physical", targeted = true }),
    risingSunKick = Spell(107428, { damage = "physical", targeted = false, ranged = true, range = 5 }),
    spinningCraneKick = Spell(101546, { damage = "physical" }),
    touchOfDeath = Spell(322109, { targeted = true, damage = "physical" }),
    envelopingMist = Spell(124682, { heal = true, targeted = true }),
    renewingMist = Spell(115151, { heal = true, targeted = true }),
    soothingMist = Spell(115175, { heal = true, targeted = true }),
    essenceFont = Spell(191837, { heal = true, targeted = false }),
    chiWave = Spell(115098, { heal = true }),
    lifeCocoon = Spell(116849, { heal = true, targeted = true, ignoreCasting = true, ignoreFacing = true }),
    sphereofDespair = Spell(410777, { targeted = true }),
    roll = Spell(109132),
    chiTorpedo = Spell(119582),
    disable = Spell(343731),
    faelineStomp = Spell(388193, {heal = true}),
    paralyze = Spell(115078, { stun = true, targeted = true, ignoreFacing = true }),
    legSweep = Spell(119381, { targeted = false, stun = true }),
    ringOfPeace = Spell(116844, {
        effect = "magic",
        diameter = 15,
        offsetMin = 0,
        offsetMax = 5,
    }),
    ringOfPeace = Spell(116844, { ignoreCasting = true, ignoreChanneling = true, AlwaysFace = true }),
    flyingSerpentKick = Spell(101545),
    fortifyingBrew = Spell(115203, { heal = true, ignoreCasting = true }),
    dampenHarm = Spell(122278,  { ignoreCasting = true }),
    revival = Spell(115310, { heal = true, }),
    diffuseMagic = Spell(122783, { ignoreCasting = true }),
    detox = Spell(115450, { targeted = true, range = 40, alwaysFace = true }),
    spearHandStrike = Spell(116705,  { targeted = true, ignoreCasting = true }),
    healingElixir = Spell(122281, { heal = true, ignoreCasting = true }),
    sphereofHope = Spell (410777, { targeted = true }),
    thunderFocusTea = Spell(116680,  { ignoreCasting = true }),
    restoral = Spell(388615, { heal = true, ignoreControl = true }),
    tigersLust = Spell(116841, { targeted = true }),
    invokeChiJi = Spell(325197)
}, mistweaver, getfenv(1))

BurstCDS = {
    [255647] = true, -- The Hunt
    [323547] = true, -- Essence Break
    -- Feral Frenzy (ID not found)
    [102560] = true, -- Incarnation: Chosen of Elune
    [102543] = true, -- Incarnation: Avatar of Ashamane
    [19574] = true, -- Bestial Wrath
    [288613] = true, -- Trueshot
    [190319] = true, -- Combustion
    -- Arcane Surge (ID not found)
    [137639] = true, -- Storm, Earth, and Fire
    [152173] = true, -- Serenity
    [304971] = true, -- Divine Toll
    [216331] = true, -- Avenging Crusader
    [31884] = true, -- Avenging Wrath
    [280711] = true, -- Dark Ascension
    [228260] = true, -- Void Eruption
    [185313] = true, -- Shadow Dance
    -- Deathmark (ID not found)
    [191634] = true, -- Stormkeeper
    [2825] = true, -- Bloodlust
    [265187] = true, -- Summon Demonic Tyrant
    [267217] = true, -- Nether Portal
    [107574] = true, -- Avatar
    [262161] = true, -- Warbreaker
}

local ROPDROP = {
    [740] = true, -- Tranquility
    [376079] = true, -- Spear of Bastion
    [107574] = true, -- Avatar
    [262161] = true, -- Warbreaker
    [31884] = true, -- Avenging Wrath
    [216331] = true, -- Avenging Crusader
    [255647] = true, -- The Hunt
    [196718] = true, -- Darkness
    [212182] = true, -- Smokebomb
    [359053] = true, -- Smokebomb
    [145629] = true, -- Amz
    [165775] = true, -- Amz
    [51052] = true, -- Amz
    }

local kickCCTable = {
    ["Cyclone"] = true,
    ["Ring of Frost"] = true,
    ["Shadowfury"] = true,
    ["Repentance"] = true,
    ["Lightning Lasso"] = true,
    ["Hex"] = true,
    ["Fear"] = true,
    ["Polymorph"] = true,
    ["Repentance"] = true,
    ["Mind Control"] = true

}

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
    ["Drain Life"] = true,
    ["Demonfire"] = true
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
    ["Dream Breath"] = true,
    ["Spiritbloom"] = true,
    ["Living Flame"] = true
}

local cleanseTable = {
    [51514] = true, -- Hex
    [375901] = true, -- Mindgames
    [385408] = true, -- Sepsis
    [334275] = true, -- Exhaustion
    [358385] = true, -- Landslide
    [702] = true, -- Weakness
    [118] = true, -- Polymorph
    [5782] = true, -- Fear
    [8122] = true, -- Psychic Scream
    [853] = true, -- Hoj
    [187650] = true, -- Freezing Trap
    [360806] = true -- Sleep Walk
}

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
    ["Static Field Totem"] = 281902,
    ["Fel Obelisk"] = 353601
}


local enemyBuffTable = {
    [62618] = true, -- Power Word: Barrier
    [198838] = true, -- Earthen Wall
}

ringOfPeace:Callback(function(spell)
    -- Loop through all enemies
    awful.enemies.loop(function(enemy)
        -- Check if the enemy used a spell from the ROPDROP table
        for spellID, _ in pairs(ROPDROP) do
            if enemy.used(spellID, spellName) then
                -- Get the enemy's position
                local x, y, z = enemy.position()
                if not player.losCoordsLiteral(x, y, z) then return end
                -- If the enemy's position is available, cast Ring of Peace at that position
                if x and y and z then
                    awful.alert({
                        message="Casting Ring of Peace on " .. enemy.name,
                        texture=116844,
                    })
                    ringOfPeace:AoECast(x, y, z)
                end
            end
        end

        -- Check if the enemy has a buff from the enemyBuffTable
        for spellID, _ in pairs(enemyBuffTable) do
            if enemy.buff(spellID) then
                -- Get the enemy's position
                local x, y, z = enemy.position()
                if not player.losCoordsLiteral(x, y, z) then return end
                -- If the enemy's position is available, cast Ring of Peace at that position
                if x and y and z then
                    awful.alert({
                        message="Casting Ring of Peace on " .. enemy.name,
                        texture=116844,
                    })
                    ringOfPeace:AoECast(x, y, z)
                end
            end
        end
    end)
end)


-- Stomp totems function
function stompTotems()
    awful.totems.loop(function(totem)
        -- Check if the totem is in the totemList and within 5 yards
        if totemList[totem.name] and player.distanceTo(totem) <= 5 then
            awful.alert({
                message="Stomped a "..totem.name,  
                texture=100780,
                })
            -- If the totem is in the list and within range, cast Tiger Palm and Blackout Kick on the totem
            tigerPalm:Cast(totem)
            blackoutKick:Cast(totem)
        end
    end)
end

-- Callback for Disable ability
disable:Callback(function(spell)
    -- Check if the target does not have the Disable debuff
    if not target.debuff("Disable") and disable:Castable then
        awful.alert({
            message="Applying Disable on "..target.name,
            texture=116095,
        })
        -- If the target doesn't have the Disable debuff, cast Disable on the target
        spell:Cast(target)
    end
end)

-- Callback for Spear Hand Strike ability
spearHandStrike:Callback(function(spell)
    local randomCastPct = math.random(60, 80) -- Generate a random number between 60 and 80

    local function isEnemyLowHealth()
        local lowHealthFound = false
        awful.enemies.loop(function(enemy)
            if enemy.hp < 70 then
                lowHealthFound = true
                return true -- break the loop once a low health enemy is found
            end
        end)
        return lowHealthFound
    end
    
    -- Loop through all enemies
    awful.enemies.loop(function(enemy)
        local enemyCastingSpell = enemy.casting -- Get the name of the spell being cast by the enemy

        -- Check if the enemy is within 5 yards, casting a spell from the kickHealsTable, and not immune to interrupts
        if enemy.distance <= 5 and not enemy.castint and enemyCastingSpell and kickHealsTable[enemyCastingSpell] and enemy.castPct > randomCastPct then
            -- Check if any enemy within 40 yards has health below 70%
            if isEnemyLowHealth() then
                awful.alert({
                    message="Cast Interrupted: "..enemy.name,
                    texture=116705,
                })
                spell:Cast(enemy)
            end
        end
    end)

    -- Loop through all enemies again for the kickCCTable condition
    awful.enemies.loop(function(enemy)
        local enemyCastingSpell = enemy.casting -- Get the name of the spell being cast by the enemy

        -- Check if the enemy is within 5 yards, casting a spell from the kickCCTable, not immune to interrupts, and targeting the player
        if enemy.distance <= 5 and not enemy.castint and enemyCastingSpell and kickCCTable[enemyCastingSpell] and enemy.castTarget.isUnit(player) and enemy.castPct > randomCastPct then
            awful.alert({
                message="Cast Interrupted: "..enemy.name,
                texture=116705,
            })
            spell:Cast(enemy)
        end
    end)
    
    awful.enemies.loop(function(enemy)
        local enemyCastingSpell = enemy.casting -- Get the name of the spell being cast by the enemy

        -- Check if the enemy is within 5 yards, casting a spell from the kickCCTable, not immune to interrupts, and targeting the player
        if enemy.distance <= 5 and not enemy.castint and enemyCastingSpell and kickAllTable[enemyCastingSpell] and enemy.castPct > randomCastPct then
            awful.alert({
                message="Cast Interrupted: "..enemy.name,
                texture=116705,
            })
            spell:Cast(enemy)
        end
    end)
end)


-- Callback for Detox ability
detox:Callback(function(spell)
    -- Loop through all friendly units
    awful.fgroup.loop(function(friend)
        -- Check if the friendly unit has a debuff from the cleanseTable
        for debuffID, _ in pairs(cleanseTable) do
            if friend.debuff(debuffID) then
                awful.alert({
                    message="Cleansing: "..friend.name,
                    texture=115450,
                })
                -- If so, cast Detox on the friendly unit to cleanse the debuff
                spell:Cast(friend)
                return true -- exit the loop
            end
        end
    end)
end)


-- Callback for Tiger's Lust ability
tigersLust:Callback(function(spell)
    -- Check if the player is rooted for more than 3 seconds and their health is below 50%
    if (player.rootRemains > 3 and target.hp < 80 or player.slowed and target.hp < 85) then
        awful.alert({
            message="Casted Tigers Lust!", 
            texture=116841,
            })
        return tigersLust:Cast(player)
    end

    if (player.rootRemains > 3 and player.hp < 80) then
        awful.alert({
            message="Casted Tigers Lust!", 
            texture=116841,
            })
        return tigersLust:Cast(player)
    end

    -- Loop through all friendly units
    awful.friends.loop(function(friend)
        -- Check if the friend is rooted for more than 3 seconds and their health is below 50%
        if (friend.rootRemains > 3 and friend.hp < 85) then
            awful.alert({
                message="Casted Tigers Lust on: "..friend.name, 
                texture=116841,
                })
            return tigersLust:Cast(friend)
        end
    end)

    -- Loop through all enemy units
    awful.friends.loop(function(friend)
        -- Check if the enemy is rooted for more than 3 seconds and their health is below 50%
        if (friend.rootRemains > 3 and target.hp < 85) then
            awful.alert({
                message="Casted Tigers Lust on: "..friend.name, 
                texture=116841,
                })
            return tigersLust:Cast(friend)
        end
    end)
end)

-- Callback for Invoke Chi-Ji, the Red Crane ability
invokeChiJi:Callback(function(spell)
    -- Check if the player is rooted for more than 3 seconds and their health is below 50%
    if (player.rootRemains > 3 or player.slowed and player.hp < 80) then
        awful.alert({
            message="Casted Chi-Ji, the Red Crane!", 
            texture=325197,
            })
        return invokeChiJi:Cast(player)
    end

    -- Loop through all friendly units
    awful.friends.loop(function(friend)
        -- Check if the friend is rooted for more than 3 seconds and their health is below 50%
        if (friend.rootRemains > 3 and friend.hp < 80) then
            awful.alert({
                message="Casted Chi-Ji, the Red Crane!", 
                texture=325197,
                })
            return invokeChiJi:Cast(friend)
        end
    end)

    -- Loop through all enemy units
    awful.friends.loop(function(friend)
        -- Check if the enemy is rooted for more than 3 seconds and their health is below 50%
        if (friend.rootRemains > 3 and target.hp < 80) then
            awful.alert({
                message="Casted Chi-Ji, the Red Crane!", 
                texture=325197,
                })
            return invokeChiJi:Cast(friend)
        end
    end)
end)


-- Create a callback for Thunder Focus Tea
thunderFocusTea:Callback(function(spell)
    -- Check if the player's hp is at or below 75% and the spell is castable
    if player.hp <= 75 and thunderFocusTea:Castable() then
        awful.alert({
            message="Casted Thunder Focus Tea!", 
            texture=116680,
            })
        -- If the player's hp is at or below 75%, cast Thunder Focus Tea on the player
        return spell:Cast(player)
    else
        -- Loop through all friendly units to check their hp
        awful.fgroup.loop(function(friend)
            -- Check if the friendly unit's hp is at or below 75% and the spell is castable
            if friend.hp <= 75 and thunderFocusTea:Castable() then
                awful.alert({
                    message="Casted Thunder Focus Tea!", 
                    texture=116680,
                    })
                -- If the friendly unit's hp is at or below 75%, cast Thunder Focus Tea on the player
                return spell:Cast(player)
            end
        end)
    end
end)


revival:Callback(function(spell)
    -- Loop through all friendly units
        awful.fgroup.loop(function(friend)
        -- Check if the friend's health is below 30%
        if friend.hp < 35 then
            awful.alert({
                message="Casted Revival!",
                texture=115310,
                })
            -- Cast Revival
            return spell:Cast(friend)
        end
    end)
end)

restoral:Callback(function(spell)
    -- Loop through all friendly units
        awful.fgroup.loop(function(friend)
        -- Check if the friend's health is below 30%
        if friend.hp < 35 then
            awful.alert({
                message="Casted Restoral!", 
                texture=388615,
                })
            -- Cast Revival
            return spell:Cast(friend)
        end
    end)
end)

local lastCastTimeHope = 0

sphereofHope:Callback(function(spell)
    -- Check if 30 seconds have passed since the last cast
    if GetTime() - lastCastTimeHope >= 10 then
        -- Loop through all friendly units
        awful.fgroup.loop(function(friend)
            if not friend.combat or friend.hp > 90 or friend.buff(411036) then
                return
            end
            -- If the friend meets the conditions (in combat, hp < 75%, and within range), cast Sphere of Hope on them
            spell:Cast(friend)
            -- Update the lastCastTime variable
            lastCastTimeHope = GetTime()
            awful.alert({
                message="Casted Sphere of Hope on: "..friend.name, 
                texture=388615,
                })
            -- Exit the loop
            return true
        end)
    end
end)


local lastCastTimeDespair = 0

sphereofDespair:Callback(function(spell)
    if GetTime() - lastCastTimeDespair >= 10 then
        local lowestHpEnemy = nil
        local lowestHp = math.huge

        enemies.loop(function(enemy)
            if not enemy.debuff(411038) then
                local currentHp = enemy.hp
                if currentHp < lowestHp then
                    lowestHp = currentHp
                    lowestHpEnemy = enemy
                end
            end
        end)

        if lowestHpEnemy and sphereofDespair:Cast(lowestHpEnemy) then
            lastCastTimeDespair = GetTime()
            spell:Cast(enemy)
            awful.alert({
                message = "Casted Sphere of Despair on: " .. lowestHpEnemy.name,
                texture = 410777,
            })
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
        awful.alert({
            message="Casted Instant Enveloping Mist Instant Proc on Lowest HP Ally!", 
            texture=124682,
            })
        -- If the cooldown is 0, cast Enveloping Mist on the friendly unit with the lowest HP
        spell:Cast(lowestHpFriend)
    end
end)

renewingMist:Callback(function(spell)
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

    -- Check if Renewing Mist's cast time is 0 and the lowestHpFriend is found
    if renewingMist.castTime == 0 and lowestHpFriend ~= nil then
        awful.alert({
            message="Casted Instant Renewing Mist Instant Proc on Lowest HP Ally!", 
            texture=115151,
            })
        -- If the cooldown is 0, cast Renewing Mist on the friendly unit with the lowest HP
        spell:Cast(lowestHpFriend)
    end
end)


faelineStomp:Callback(function (spell)
    if not player.buff (388026) then
        awful.alert({
            message="Casted Faeline Stomp to Rebuff Teachings!", 
            texture=388193,
            })
        spell:Cast(target)    
    end
end)

fortifyingBrew:Callback(function(spell)
    if player.hp <= 40 then
        awful.alert({
            message="Casted Fortifying Brew! Gettin fk'n Rekt!", 
            texture=115203,
            })
        spell:Cast(player)      
    end
end)

healingElixir:Callback(function(spell)
    if player.hp <= 75 then
        awful.alert({
            message="Casted Healing Elixir!", 
            texture=122281,
            })
        spell:Cast(player)
    end
end)

-- Define an array of debuffs that we want to check for
local badStuff = {"Mindgames", "Soul Rot", "Touch of Karma"}

diffuseMagic:Callback(function(spell)
    -- Check if the player has any of the debuffs listed in the "badStuff" array
    if player.debuffFrom(badStuff) or player.hp <= 34 then
        awful.alert({
            message="Casted Diffuse Magic!", 
            texture=122783,
            })
        -- If the player has the bad debuff, cast Diffuse Magic on the player
        spell:Cast(player)
    end
end)

-- Create a callback for the Leg Sweep ability
legSweep:Callback(function(spell)
    -- Get the number of players in range
    local playersInRange = enemies.around(player, 6)   
    -- Check if the spell is castable on the target
    if spell:Castable() then
        -- If there are 2 or more enemies around the player within a range of 6 yards, cast Leg Sweep on the target
        if playersInRange > 1 then
            spell:Cast()
            awful.alert({
                message="Casted Leg Sweep!", 
                texture=119381,
            })
        -- If the player's HP is below 45%, cast Leg Sweep on the target
        elseif player.hp < 45 and playersInRange <= 1 then
            spell:Cast()
            awful.alert({
                message="Casted Leg Sweep!", 
                texture=119381,
            })
        -- If the target's HP is below 40%, cast Leg Sweep on the target
        elseif target.hp < 40 then
            spell:Cast()
            awful.alert({
                message="Casted Leg Sweep on low HP target!", 
                texture=119381,
            
            })
        end
    end
end)

dampenHarm:Callback(function(spell)
    if player.hp <= 70 then -- check if the player's hp is at or below 60%
        awful.alert({
            message="Casted Dampen Harm!", 
            texture=122278,
            })
        spell:Cast(player) -- cast Dampen Harm on the player
    end
end)

-- Create a callback for the Life Cocoon ability
lifeCocoon:Callback(function(spell)
    awful.fgroup.loop(function(friend)
        -- If the friend is not in combat, their hp is above 50%, or they are out of the range of Life Cocoon, we skip them
        -- This ensures that we only try to cast Life Cocoon on friends who are in combat, have less than 50% hp, and are within the range of Life Cocoon
        -- friend.dist provides the distance to the friend
        -- lifeCocoon.range provides the range of the Life Cocoon spell
        -- Comparing these values, we can determine if the friend is within range for the Life Cocoon spell
        if not friend.combat or friend.hp > 50 or friend.distance > lifeCocoon.range then return end
        awful.alert({
            message="Casted Life Cocoon on: "..friend.name, 
            texture=116849,
            })
        -- If the friend meets the conditions (in combat, hp < 50%, and within range), cast Life Cocoon on them
        return spell:Cast(friend)
    end)
end)

-- Create a callback for the Paralyze ability
paralyze:Callback(function(spell)
    -- Check if the enemy healer is valid, within paralyze.range, the target's hp is below 40%, the spell is castable on the enemy healer, and the enemy healer is not the player's target
    if enemyHealer.distance <= paralyze.range and target.hp < 70 and paralyze:Castable(enemyHealer) and not (player.target.guid == enemyHealer.guid) then
        -- If the conditions are met, cast Paralyze on the enemy healer
        paralyze:Cast(enemyHealer)
        awful.alert({
            message="Paralysis on Enemy Healer!", 
            texture=115078,
            })
    end
end)


-- Callback for Tiger Palm
tigerPalm:Callback(function(spell)
    if tigerPalm:Castable(target) and player.lastCast ~= tigerPalm.id then
        -- Cast Tiger Palm on the target.
        spell:Cast(target)
        return
    end
end)

-- Callback for Blackout Kick
blackoutKick:Callback(function(spell)
    if blackoutKick:Castable(target) and player.lastCast == tigerPalm.id then
        -- Cast Blackout Kick on the target.
        spell:Cast(target)
        return
    end
end)

-- Callback for Rising Sun Kick
risingSunKick:Callback(function(spell)
    -- Check if Rising Sun Kick is castable on the target and its cooldown is 0
        -- If so, cast Rising Sun Kick on the target.
        spell:Cast(target)
end)

touchOfDeath:Callback(function(spell)
    enemies.loop(function(enemy)
        if not spell:Castable(enemy) then return end 
        spell:Cast(enemy)
        return awful.alert({
            message = "Show us on the doll where he touched you: "..enemy.spec,
            texture = spell.id,
            duration = 4.3,
        })
    end)
end)

function castOnClosestEnemy()
    -- Check if you have a target and your target is more than 5 yards away
    if player.target and player.target.distance and player.target.distance > 5 then
        local closestEnemy = nil
        local minDistance = math.huge

        -- Loop through all enemies
        awful.enemies.loop(function(enemy)
            -- Check if the enemy is closer than the current closest enemy
            if enemy.distance < minDistance then
                closestEnemy = enemy
                minDistance = enemy.distance
            end
        end)

        -- Cast Tiger Palm and Blackout Kick on the closest enemy if within 5 yards
        if closestEnemy and minDistance <= 5 then
            if tigerPalm:Castable(closestEnemy) and player.lastCast ~= tigerPalm.id then
                -- Cast Tiger Palm on the target.
                tigerPalm:Cast(closestEnemy)
                return
            end
            if blackoutKick:Castable(closestEnemy) and player.lastCast == tigerPalm.id then
                -- Cast Blackout Kick on the target.
                blackoutKick:Cast(closestEnemy)
                return
            end
        end

        -- Loop through all pets
        awful.pets.loop(function(pet)
            -- Check if the pet is closer than the current closest pet
            if pet.distance < minDistance then
                closestEnemy = pet
                minDistance = pet.distance
            end
        end)

        -- Cast Tiger Palm and Blackout Kick on the closest pet if within 5 yards
        if closestEnemy and minDistance <= 5 then
            if tigerPalm:Castable(closestEnemy) and player.lastCast ~= tigerPalm.id then
                -- Cast Tiger Palm on the target.
                tigerPalm:Cast(closestEnemy)
                return
            end
            if blackoutKick:Castable(closestEnemy) and player.lastCast == tigerPalm.id then
                -- Cast Blackout Kick on the target.
                blackoutKick:Cast(closestEnemy)
                return
            end
            risingSunKick:Cast(closestEnemy)
        end
    end
end




