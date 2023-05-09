local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver
local player = awful.Player
local Spell = awful.Spell
awful.Populate({
    tigerPalm = Spell(100780, { damage = "physical", targeted = true, ranged = true, range = 5 }),
    blackoutKick = Spell(118166, { damage = "physical", targeted = true }),
    risingSunKick = Spell(107428, { damage = "physical", targeted = false, ranged = true, range = 5 }),
    spinningCraneKick = Spell(101546, { damage = "physical" }),
    touchOfDeath = Spell(322109, { targeted = true, damage = "physical", range = 5 }),
    envelopingMist = Spell(124682, { heal = true, targeted = true }),
    renewingMist = Spell(119611, { heal = true, targeted = true }),
    soothingMist = Spell(115175, { heal = true, targeted = true }),
    essenceFont = Spell(191837, { heal = true, targeted = false }),
    chiWave = Spell(115098, { heal = true }),
    lifeCocoon = Spell(116849, { heal = true, targeted = true, range = 40, ignoreCasting = true, ignoreFacing = true }),
    sphereofDespair = Spell(410777, { targeted = true, ignoreFacing = true, range = 40 }),
    roll = Spell(109132),
    chiTorpedo = Spell(119582),
    faelineStomp = Spell(388193, {heal = true}),
    paralyze = Spell(115078, { stun = true, targeted = true, range = 25, ignoreFacing = true }),
    legSweep = Spell(119381, { targeted = false, stun = true }),
    ringOfPeace = Spell(116844, {
        effect = "magic",
        diameter = 15,
        offsetMin = 0,
        offsetMax = 5,
    }),
    ringOfPeace = Spell(116844, { ignoreCasting = true, ignoreChanneling = true, AlwaysFace = true, range = 40 }),
    flyingSerpentKick = Spell(101545),
    fortifyingBrew = Spell(115203, { heal = true, ignoreCasting = true }),
    dampenHarm = Spell(122278,  { ignoreCasting = true }),
    revival = Spell(115310, { heal = true }),
    diffuseMagic = Spell(122783, { ignoreCasting = true }),
    detox = Spell(115450, { targeted = true, range = 40, alwaysFace = true }),
    spearHandStrike = Spell(116705,  { targeted = true, ignoreCasting = true }),
    healingElixir = Spell(122281, { heal = true, ignoreCasting = true }),
    sphereofHope = Spell (410777, { targeted = true, range = 40, ignoreFacing = true}),
    thunderFocusTea = Spell(116680,  { ignoreCasting = true }),
    restoral = Spell(388615, { heal = true, ranged = true, ignoreControl = true }),
    tigersLust = Spell(116841, { targeted = true, range = 30 }),
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
    [62618] = true, -- Barrier
    [740] = true, -- Tranquility
    [198838] = true,
    [98008] = true,
    [376079] = true,
    [107574] = true, -- Avatar
    [262161] = true, -- Warbreaker
    [31884] = true, -- Avenging Wrath
    [216331] = true, -- Avenging Crusader
    [255647] = true, -- The Hunt
    [196718] = true, -- Darkness
    [76577] = true, -- Smokebomb
    [359053] = true, -- Smokebomb
    [145629] = true, -- Amz
    [165775] = true, -- Amz
    [51052] = true, -- Amz
    }

    awful.triggers.track(function(trigger, uptime)
        if player.combat then
            local id = trigger.id
            if not id then return end
            local reacts = ROPDROP[id]
            if not reacts then return end
            local x, y, z = trigger.position()
            if x and y and z then
                if uptime < 0.4 or uptime > 2.1 then return end
                if trigger.creator.friend then return end  
                if not player.losCoordsLiteral(x, y, z) then return end
                if ringOfPeace:AoECast(x,y,z) then
                    awful.alert("Ring of Peace Dropped!", 116844)
                    return true
                end
            end
        end
      end)

local kickCCTable = {
    ["Cyclone"] = true,
    ["Ring of Frost"] = true,
    ["Shadowfury"] = true,
    ["Repentance"] = true,
    ["Lightning Lasso"] = true,
    ["Hex"] = true,
    ["Fear"] = true,
    ["Polymorph"] = true,
    ["Repentance"] = True,
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
    ["Curse of Exhaustion"] = true,
    ["Landslide"] = true,
    ["Curse of Weakness"] = true,
    ["Polymorph"] = true,
    ["Fear"] = true,
    ["Psychic Scream"] = true,
    ["Hammer of Justice"] = true,
    ["Freezing Trap"] = true,
    ["Sleep Walk"] = true
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
    ["Static Field Totem"] = 281902
}

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


-- Callback for Spear Hand Strike ability
spearHandStrike:Callback(function(spell)
    local randomCastPct = math.random(60, 80) -- Generate a random number between 60 and 80

    local function isEnemyLowHealth()
        local lowHealthFound = false
        awful.enemies.loop(function(enemy)
            if enemy.hp < 50 then
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
            -- Check if any enemy within 40 yards has health below 50%
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


-- Callback for Detox ability
detox:Callback(function(spell)
    -- Loop through all friendly units
    awful.fgroup.loop(function(friend)
        -- Check if the friendly unit has a debuff from the cleanseTable
        for debuffName, _ in pairs(cleanseTable) do
            if friend.debuff(debuffName) then
                -- Attempt to cast Detox on the friendly unit to cleanse the debuff
                local castResult = spell:Cast(friend)
                
                -- If the casting was successful, show the alert
                if castResult then
                    awful.alert({
                        message="Cleansing our boy: "..friend.name,
                        texture=115450,
                    })
                end
                
                return true -- exit the loop
            end
        end
    end)
end)



-- Callback for Tiger's Lust ability
tigersLust:Callback(function(spell)
    -- Check if the player is rooted for more than 3 seconds and their health is below 50%
    if (player.rootRemains > 3 or player.slowed) and target.hp < 60 then
        awful.alert({
            message="Casted Tigers Lust!", 
            texture=116841,
            })
        return spell:Cast(player)
    end
    if (player.rootRemains > 3 or player.slowed) and player.hp < 60 then
        awful.alert({
            message="Casted Tigers Lust on self!", 
            texture=116841,
            })
        return spell:Cast(player)
    end
    -- Loop through all friendly units
    awful.friends.loop(function(friend)
        -- Check if the friend is rooted for more than 3 seconds and their health is below 50%
        if (friend.rootRemains > 3 or player.slowed) and friend.hp < 60 then
            awful.alert({
                message="Casted Tigers Lust on: "..friend.name, 
                texture=116841,
                })
            return spell:Cast(friend)
        end
    end)

    -- Loop through all enemy units
    awful.friends.loop(function(friend)
        -- Check if the enemy is rooted for more than 3 seconds and their health is below 50%
        if (friend.rootRemains > 3 or player.slowed) and friend.target.hp < 60 then
            awful.alert({
                message="Casted Tigers Lust on: "..friend.name, 
                texture=116841,
                })
            return spell:Cast(friend)
        end
    end)
end)

-- Callback for Invoke Chi-Ji, the Red Crane ability
invokeChiJi:Callback(function(spell)
    -- Check if the player is rooted for more than 3 seconds and their health is below 50%
    if (player.rootRemains > 3 or player.slowed) and player.hp < 80 then
        awful.alert({
            message="Casted Chi-Ji, the Red Crane!", 
            texture=325197,
            })
        return spell:Cast(player)
    end

    -- Loop through all friendly units
    awful.friends.loop(function(friend)
        -- Check if the friend is rooted for more than 3 seconds and their health is below 50%
        if (friend.rootRemains > 3 or player.slowed) and friend.hp < 80 then
            awful.alert({
                message="Casted Chi-Ji, the Red Crane!", 
                texture=325197,
                })
            return spell:Cast(friend)
        end
    end)

    -- Loop through all enemy units
    awful.friends.loop(function(friend)
        -- Check if the enemy is rooted for more than 3 seconds and their health is below 50%
        if (friend.rootRemains > 3 or player.slowed) and friend.target.hp < 80 then
            awful.alert({
                message="Casted Chi-Ji, the Red Crane!", 
                texture=325197,
                })
            return spell:Cast(friend)
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
        if friend.hp < 33 then
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
        if friend.hp < 33 then
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
    if GetTime() - lastCastTimeHope >= 30 then
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
local badStuff = {"Mindgames"}

diffuseMagic:Callback(function(spell)
    -- Check if the player has any of the debuffs listed in the "badStuff" array
    if player.debuffFrom(badStuff) or player.hp <= 34 then
        awful.alert({
            message="Casted Diffuse Magic! Punch SOMETHING!", 
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
    if player.hp <= 65 then -- check if the player's hp is at or below 60%
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
        spell:Cast(enemyHealer)
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
    if  risingSunKick.cd == 0 then
        -- If so, cast Rising Sun Kick on the target.
        spell:Cast(target)
    end
end)

touchOfDeath:Callback(function(spell)
    enemies.loop(function(enemy)
        if enemy.hp <= 19 then
            if spell:Cast(enemy) then
                return awful.alert({
                    message = "Touch of Death below 15%: "..enemy.name,
                    texture = spell.id,
                    duration = 2.3,
                })
            end
        end
    end)
end)