local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver
local player = awful.Player
local Spell = awful.Spell
local delayLowerBound = 0.4
local delayUpperBound = 0.6
local ringOfPeaceTriggeredTime = 0
awful.enabled = true

awful.Populate({
    transfer = Spell(119996),
    tigerPalm = Spell(100780, { damage = "physical", targeted = true, ranged = true }),
    blackoutKick = Spell(118166, { damage = "physical", targeted = true }),
    risingSunKick = Spell(107428, { damage = "physical", targeted = false, ranged = true, range = 5 }),
    spinningCraneKick = Spell(101546, { damage = "physical" }),
    touchOfDeath = Spell(322109, { targeted = true, damage = "physical" }),
    envelopingMist = Spell(124682, { heal = true, targeted = true }),
    renewingMist = Spell(115151, { heal = true, targeted = true }),
    soothingMist = Spell(115175, { heal = true, targeted = true }),
    essenceFont = Spell(191837, { heal = true, channelled = true, ignoreMoving = true }),
    chiWave = Spell(115098, { heal = true }),
    lifeCocoon = Spell(116849, { heal = true, targeted = true, ignoreCasting = true, ignoreFacing = true }),
    sphereofDespair = Spell(410777, { targeted = true, effect = "magic" }),
    roll = Spell(109132),
    chiTorpedo = Spell(119582),
    disable = Spell(343731, { targeted = true, cc = true, effect = "physical" }),
    faelineStomp = Spell(388193, { heal = true, alwaysFace = true }),
    paralyze = Spell(115078, { stun = true, targeted = true, ignoreFacing = true }),
    legSweep = Spell(119381, { ignoreFacing = true, stun = true }),
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
    revival = Spell(115310, { heal = true, ignoreFacing = true, range = 40 }),
    diffuseMagic = Spell(122783, { ignoreCasting = true }),
    detox = Spell(115450, { targeted = true, range = 40 }),
    spearHandStrike = Spell(116705,  { targeted = true, ignoreCasting = true }),
    healingElixir = Spell(122281, { heal = true, ignoreCasting = true }),
    sphereofHope = Spell (410777, { targeted = true }),
    thunderFocusTea = Spell(116680,  { ignoreCasting = true }),
    restoral = Spell(388615, { heal = true, ignoreControl = true, range = 40, ignoreFacing = true }),
    tigersLust = Spell(116841, { targeted = true }),
    invokeChiJi = Spell(325197),
    bloodFury = Spell(33697),
    grappleWeapon = Spell (233759, { cc = true }),
    provoke = Spell (115546, { targeted = true })
}, mistweaver, getfenv(1))

local provokeTable = {
    ["Hex"] = true, -- Hex
    ["Polymorph"] = true, -- Polymorph
    ["Fear"] = true, -- Fear
    ["Sleep Walk"] = true,-- Sleep Walk
    ["Repentance"] = true, -- Repentance
    ["Mind Control"] = true -- Mind Control
}

local kickCCTable = {
    ["Cyclone"] = true,
    ["Ring of Frost"] = true,
    ["Shadowfury"] = true,
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
    ["Void Eruption"] = true,
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
    ["Power Word: Barrier"] = 62618, -- Power Word: Barrier
    ["Earthen Wall"] = 198838 -- Earthen Wall
}

local ROPDROP = {
    [740] = true, -- Tranquility
    [376079] = true, -- Spear of Bastion
    [107574] = true, -- Avatar
    [262161] = true, -- Warbreaker
    [31884] = true, -- Avenging Wrath
    [255647] = true, -- The Hunt
    [196718] = true, -- Darkness
    [212182] = true, -- Smokebomb
    [359053] = true, -- Smokebomb
    [145629] = true, -- Amz
    [165775] = true, -- Amz
    [51052] = true -- Amz
    }

    local cleanseTable = {
    [51514] = true, -- Hex
    [375901] = true, -- Mindgames
    [64695] = true, -- EarthGrab
    [385408] = true, -- Sepsis
    [334275] = true, -- Curse of Exhaustion
    [358385] = true, -- Landslide
    [702] = true, -- Curse of Weakness
    [118] = true, -- Polymorph
    [5782] = true, -- Fear
    [411038] = true, -- Sphere of Despair
    [8122] = true, -- Psychic Scream
    [853] = true, -- Hammer of Justice
    [187650] = true, -- Freezing Trap
    [360806] = true -- Sleep Walk
    }

    -- Define the DisarmTable
local DisarmTable = {
    [384352] = true, -- Doom Winds
    [121471] = true, -- Shadow Blades
    [360952] = true, -- Coordinated Assault
    [19574] = true, -- Bestial Wrath
    [288613] = true, -- Trueshot
    [31884] = true, -- Avenging Wrath
    [185313] = true, -- Shadow Dance
    [2825] = true, -- Bloodlust
    [107574] = true, -- Avatar
    [262161] = true, -- Warbreaker
    [216331] = true -- Avenging Crusader
}

BurstCDS = {
    [384352] = true, -- Doom Winds
    [121471] = true, -- Shadow Blades
    [406227] = true, -- Deep Breath
    [360952] = true, -- Coordinated Assault
    [255647] = true, -- The Hunt
    [323547] = true, -- Essence Break
    [274837] = true,-- Feral Frenzy (ID not found)
    [102560] = true, -- Incarnation: Chosen of Elune
    [102543] = true, -- Incarnation: Avatar of Ashamane
    [19574] = true, -- Bestial Wrath
    [288613] = true, -- Trueshot
    [190319] = true, -- Combustion
    [137639] = true, -- Storm, Earth, and Fire
    [152173] = true, -- Serenity
    [123904] = true, -- Invoke Xuen
    [31884] = true, -- Avenging Wrath
    [280711] = true, -- Dark Ascension
    [228260] = true, -- Void Eruption
    [185313] = true, -- Shadow Dance
    [360194] = true, -- Deathmark (ID not found)
    [191634] = true, -- Stormkeeper
    [204361] = true, -- Bloodlust
    [265187] = true, -- Summon Demonic Tyrant
    [267217] = true, -- Nether Portal
    [107574] = true, -- Avatar
    [315443] = true, -- Abomination Limb
    [12472] = true, -- Icy Veins
    [262161] = true -- Warbreaker
}

-- Callback for Transfer
transfer:Callback(function(spell)
    -- Check if player's HP is below 60, if player is stunned and if Transfer is castable
    if player.hp <= 60 and player.stunned and spell:Castable() and player.HasTalent(353584) then
        -- Cast Transfer
        spell:Cast()
        -- Check if player has the Eminence talent
        if player.HasTalent(394110) then
            -- Add a random delay between 1 and 3 seconds before casting Transfer again
            awful.timer(function()
                if spell:Castable() then
                    spell:Cast()
                end
            end, math.random(1, 2))
        end
    end
end)


-- Callback for Provoke ability
provoke:Callback(function(spell)
    -- Loop through all enemies
    awful.enemies.loop(function(enemy)
        local enemyCastingSpell = enemy.casting -- Get the name of the spell being cast by the enemy
        -- Check if the enemy is casting a spell from the provokeTable
        if enemyCastingSpell and enemy.castTarget.isUnit(player) and provokeTable[enemyCastingSpell] and enemy.castRemains < 0.5 then
            awful.alert({
                message="Casting Provoke on " .. enemy.name,
                texture=115546,
            })
            -- If so, cast Provoke on the enemy right before their cast ends
            spell:Cast(enemy)
        end
    end)
end)

    bloodFury:Callback(function(spell)
        awful.enemies.loop(function(enemy)
            for spellID, _ in pairs(BurstCDS) do
                if enemy.buff(spellID) then
                    if bloodFury.cd < 1 then
                        bloodFury:Cast()
                        awful.alert({
                            message="Using Blood Fury as enemy used " .. spellID,
                            texture=33697, -- Replace this with the actual textureID for the alert
                        })
                    end
                end
            end
        end)
    end)



ringOfPeace:Callback(function(spell)
    local currentTime = GetTime()

    -- If the time elapsed since the last cast is less than the delay, return
    if currentTime - ringOfPeaceTriggeredTime < math.random(delayLowerBound, delayUpperBound) then
        return
    end

    -- Otherwise, proceed with the casting actions and update the triggered time
    awful.enemies.loop(function(enemy)
        for spellID, _ in pairs(ROPDROP) do
            if enemy.buff(spellID, spellName) then
                local x, y, z = enemy.position()
                if not player.losCoordsLiteral(x, y, z) then return end
                if x and y and z then
                    awful.alert({
                        message="Casting Ring of Peace on " .. enemy.name,
                        texture=116844,
                    })
                    ringOfPeace:AoECast(x, y, z)
                    ringOfPeaceTriggeredTime = currentTime
                end
            end
        end

        for spellName, _ in pairs(enemyBuffTable) do
            if enemy.buff(spellName) then
                local x, y, z = enemy.position()
                if not player.losCoordsLiteral(x, y, z) then return end
                if x and y and z then
                    awful.alert({
                        message="Casting Ring of Peace on " .. enemy.name,
                        texture=116844,
                    })
                    ringOfPeace:AoECast(x, y, z)
                    ringOfPeaceTriggeredTime = currentTime
                end
            end
        end
    end)

    awful.friends.loop(function(friend)
        if friend.hp <= 40 then
            awful.enemies.loop(function(enemy)
                if enemy.meleeRangeOf(friend) and lifeCocoon.cd > 1 then
                    local x, y, z = friend.position()
                    if not player.losCoordsLiteral(x, y, z) then return end
                    if x and y and z then
                        awful.alert({
                            message="Casting Ring of Peace on " .. friend.name,
                            texture=116844,
                        })
                        ringOfPeace:AoECast(x, y, z)
                        ringOfPeaceTriggeredTime = currentTime
                    end
                end
            end)
        end
    end)
end)

    -- Create a callback for grappleWeapon
grappleWeapon:Callback(function(spell)
    -- Loop through all enemies
    awful.enemies.loop(function(enemy)
        -- Check if the enemy used a spell from the DisarmTable
        for spellID, _ in pairs(DisarmTable) do
            if enemy.buff(spellID, spellName) then
                -- Cast grappleWeapon on the enemy
                awful.alert({
                    message="Disarming " .. enemy.name,
                    texture=233759, -- Change to the appropriate texture ID for grappleWeapon
                })
                spell:Cast(enemy)
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
    -- Check if the target does not have the Disable debuff, 
    -- is not immune to physical effects, and Disable is castable
    if not target.debuff(116095) and not target.immunePhysical and disable:Castable() then
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

        -- Check if the enemy is within 5 yards, casting a spell from the kickAllTable, not immune to interrupts, and targeting the player
        if enemy.distance <= 5 and not enemy.castint and enemyCastingSpell and kickAllTable[enemyCastingSpell] and enemy.castPct > randomCastPct then
            awful.alert({
                message="Cast Interrupted: "..enemy.name,
                texture=116705,
            })
            spell:Cast(enemy)
        end
    end)
end)


-- Create a callback function for Purify
detox:Callback(function(spell)
    -- Loop through all friendly units
    awful.fgroup.loop(function(friend)
        -- Check if the friend has Unstable Affliction or Vampiric Touch debuff
        if friend.debuff("Unstable Affliction") or friend.debuff("Vampiric Touch") then
            return -- Skip this friend and move to the next one
        end

        -- Loop through each spellID in the cleanseTable
        for spellID, _ in pairs(cleanseTable) do
            -- Check if the friend has a debuff with the current spellID
            if friend.debuff(spellID) then
                -- If so, check if the spell is castable on the friend
                if spell:Castable(friend) then
                    -- If it is, wait for a random time between 0.4 and 0.6 seconds, then send an alert and cast the spell
                    C_Timer.After(math.random(delayLowerBound, delayUpperBound), function()
                        awful.alert({
                            message="Casting Detox on "..friend.name,
                            texture=527,  -- Please replace with the correct texture ID for Purify
                        })
                        spell:Cast(friend)
                    end)
                    return
                end
                    
    if player.rooted and not tigersLust:Castable() and not invokeChiJi:Castable() then
        -- Random delay
        local delay = math.random(300, 500) / 1000  -- Converts milliseconds to seconds

        -- Only cast if enough time has passed
        if GetTime() - lastCastTime >= delay then
            awful.alert({
                message="Cleansing: "..player.name,
                texture=115450,
            })
            -- If so, cast Detox on the player to cleanse the root
            spell:Cast(player)
            lastCastTime = GetTime()  -- Update the last cast time
                    end
                end
            end
        end
    end)
end)






-- Callback for Tiger's Lust ability
tigersLust:Callback(function(spell)

    -- First condition: Check if player is rooted and root remains >= 3
    if player.rooted and player.rootRemains >= 3 then
        awful.alert({
            message="Casted Tiger's Lust on Player!",
            texture=324406,
        })
        return spell:Cast(player)
    end

    if player.slowed and target.distance > 5 then
        awful.alert({
            message="Casted Tiger's Lust on Player!",
            texture=324406,
        })
        return spell:Cast(player)
    end

    -- Second condition: Check if friend is rooted and root remains >= 3 using friends loop
    awful.friends.loop(function(friend)
        if friend.rooted and friend.rootRemains >= 3 then
            awful.alert({
                message="Casted Tiger's Lust on " .. friend.name,
                texture=324406,
            })
            return spell:Cast(friend)
        end
    end)
end)

-- Callback for Invoke Chi-Ji, the Red Crane ability
invokeChiJi:Callback(function(spell)

    -- First condition: Check if any enemy cast any spells from the BurstCDS table
    awful.enemies.loop(function(enemy)
        for spellID, _ in pairs(BurstCDS) do
            if enemy.buff(spellID) then
                awful.alert({
                    message="Casted Chi-Ji, the Red Crane!",
                    texture=325197,
                })
                return spell:Cast(player)
            end
        end
    end)

    -- Second condition: Check if friends cast any spells from the BurstCDS table
    awful.friends.loop(function(friend)
        for spellID, _ in pairs(BurstCDS) do
            if friend.buff(spellID) then
                awful.alert({
                    message="Casted Chi-Ji, the Red Crane!",
                    texture=325197,
                })
                return spell:Cast(player)
            end
        end
    end)

    -- Third condition: Check friend.hp and if anyone is below 70 and player.target > 5
    awful.fgroup.loop(function(friend)
        if friend.hp < 70 then
            awful.alert({
                message="Casted Chi-Ji, the Red Crane!",
                texture=325197,
            })
            return spell:Cast(player)
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
        if friend.hp <= 37 then
            awful.alert({
                message="Casted Revival!",
                texture=115310,
                })
            -- Cast Revival
            return spell:Cast(player)
        end
    end)
end)

restoral:Callback(function(spell)
    -- Loop through all friendly units
        awful.fgroup.loop(function(friend)
        -- Check if the friend's health is below 30%
        if friend.hp <= 37 then
            awful.alert({
                message="Casted Restoral!", 
                texture=388615,
                })
            -- Cast Revival
            return spell:Cast(player)
        end
    end)
end)

local lastCastTimeHope = 0

sphereofHope:Callback(function(spell)
    -- Check if 30 seconds have passed since the last cast
    if GetTime() - lastCastTimeHope >= 15 then
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
    if GetTime() - lastCastTimeDespair >= 15 then
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


faelineStomp:Callback(function(spell)
    -- Check if the player doesn't have the Teachings buff
    if faelineStomp:Castable(target) and not player.buff(388026) or not player.buff(389387) then
            awful.alert({
                message="Casted Faeline Stomp",
                texture=388193,
            })
            spell:Cast(target)
    end
end)


-- Create a callback for the Essence Font ability
essenceFont:Callback(function(spell)
    -- Check if Faeline Stomp is not castable and the player doesn't have buff 388026 (Faeline Harmony)
    if not faelineStomp:Castable() and not player.buff(388026) then
        awful.alert({
            message="Casting Essence Font!",
            texture=191837,
        })
        -- If the conditions are met, cast Essence Font
        spell:Cast(player)
    end
end)


fortifyingBrew:Callback(function(spell)
    -- Loop through all enemy units
    awful.enemies.loop(function(enemy)
        -- Check if the enemy used a spell from the BurstCDS table
        for spellID, _ in pairs(BurstCDS) do
            if enemy.buff(spellID) and enemy.target == player then
                -- Check if the player doesn't have Dampen Harm or Diffuse Magic buff
                if not (player.buff(122278) or player.buff(122783) or player.buff(116849)) then
                    awful.alert({
                        message="Casted Fortifying Brew due to enemy burst!",
                        texture=115203,
                    })
                    spell:Cast(player) -- cast Fortifying Brew on the player
                    break -- exit the loop once the condition is met
                end
            end
        end
    end)

    -- Check if the player's health is at or below 40%
    if player.hp <= 35 and not (player.buff(122278) or player.buff(122783) or player.buff(116849)) then
        awful.alert({
            message="Casted Fortifying Brew! Gettin fk'n Rekt!",
            texture=115203,
        })
        -- If the player's health is at or below 40%, cast Fortifying Brew on the player
        spell:Cast(player)
    end
end)

healingElixir:Callback(function(spell)
    if player.hp <= 65 and healingElixir.charges > 1 then
        awful.alert({
            message="Casted Healing Elixir!", 
            texture=122281,
            })
        spell:Cast(player)
    end
end)

local badStuff = {"Mindgames", "Soul Rot", "Touch of Karma"}

diffuseMagic:Callback(function(spell)
    -- Loop through all enemy units
    awful.enemies.loop(function(enemy)
        -- Check if the enemy used a spell from the BurstCDS table
        for spellID, _ in pairs(BurstCDS) do
            if enemy.buff(spellID) and enemy.target == player then
                -- Check if the player doesn't have Dampen Harm or Fortifying Brew buff
                if not (player.buff(122278) or player.buff(115203) or player.buff(116849)) then
                    awful.alert({
                        message="Casted Diffuse Magic due to enemy burst!",
                        texture=122783,
                    })
                    spell:Cast(player) -- cast Diffuse Magic on the player
                    break -- exit the loop once the condition is met
                end
            end
        end
    end)

    -- Check if the player has any of the debuffs listed in the "badStuff" array
    if player.debuff(badStuff) or player.hp <= 30 then
        awful.alert({
            message="Casted Diffuse Magic!",
            texture=122783,
        })
        -- If the player has the bad debuff or their health is at or below 34%, cast Diffuse Magic on the player
        spell:Cast(player)
    end
end)

-- Create a callback for the Leg Sweep ability
legSweep:Callback(function(spell)
    -- Get the number of players in range
    local playersInRange = enemies.around(player, 5)   
    -- Check if the spell is castable on the target
    local didCastLegSweep = false
    if spell:Castable() then
        -- If there are 2 or more enemies around the player within a range of 6 yards, cast Leg Sweep on the target
        if playersInRange > 1 then
            didCastLegSweep = spell:Cast()
        -- If the player's HP is below 45%, cast Leg Sweep on the target
        elseif player.hp < 45 and playersInRange <= 1 then
            didCastLegSweep = spell:Cast()
        -- If the target's HP is below 40%, cast Leg Sweep on the target
        elseif target.hp < 40 then
            didCastLegSweep = spell:Cast()
        end
    end
    if didCastLegSweep then
        awful.alert({
            message="Casted Leg Sweep!", 
            texture=119381,
        })
    end
end)


dampenHarm:Callback(function(spell)
    -- Loop through all enemy units
    awful.enemies.loop(function(enemy)
        -- Check if the enemy used a spell from the BurstCDS table
        for spellID, _ in pairs(BurstCDS) do
            if enemy.buff(spellID) and enemy.target == player and not (player.buff(122783) or player.buff(243435) or player.buff(116849)) then
                awful.alert({
                    message="Casted Dampen Harm due to enemy burst!",
                    texture=122278,
                })
                spell:Cast(player) -- cast Dampen Harm on the player
                break -- exit the loop once the condition is met
            end
        end
    end)

    if player.hp <= 45 and not (player.buff(122783) or player.buff(243435) or player.buff(116849)) then
        -- check if the player's hp is at or below 45% and player does not have Diffuse Magic or Fortifying Brew buffs
        awful.alert({
            message="Casted Dampen Harm at low health!",
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
        if not friend.combat or friend.hp > 40 or friend.distance > lifeCocoon.range then return end
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
    -- Check if the enemy healer is valid, within paralyze.range, the target's hp is below 40%, the spell is castable on the enemy healer, the enemy healer is not the player's target, and incapDR is 1
    if enemyHealer.distance <= paralyze.range and target.hp < 70 and paralyze:Castable(enemyHealer) and not (player.target == enemyHealer) and enemyHealer.incapDR == 1 then
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
    -- Define closestEnemy as target for future checks
    local closestEnemy = target
    -- If player has Alpha Tiger buff and the buff's remaining time is more than 1 second
    if player.buff("Alpha Tiger") and player.buffRemains("Alpha Tiger") < 1 then
        -- If target has Recently Challenged debuff
        if target.buff("Recently Challenged") then
            local minDistance = math.huge
            -- Loop through all enemies
            awful.enemies.loop(function(enemy)
                -- Check if the enemy is closer than the current closest enemy
                if enemy.distance < minDistance then
                    closestEnemy = enemy
                    minDistance = enemy.distance
                end
            end)
        end
    end

    if tigerPalm:Castable(closestEnemy) and player.lastCast ~= tigerPalm.id and not closestEnemy.buff("Recently Challenged") then
        -- Cast Tiger Palm on the closest enemy.
        spell:Cast(closestEnemy)
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
        spell:Cast(target)
end)

touchOfDeath:Callback(function(spell)
    enemies.loop(function(enemy)
        if not spell:Castable(enemy) then return end 
        spell:Cast(enemy)
        return awful.alert({
            message = "Show us on the doll where he touched you: "..enemy.name,
            texture = spell.id,
            duration = 4.3,
        })
    end)
end)

function castOnClosestEnemy()
    local minDistance = math.huge
    local closestUnit = nil

    -- Combining the enemies and pets loop into one
    for _, unit in pairs({awful.enemies, awful.pets}) do
        unit.loop(function(unit)
            -- Check if the unit is closer than the current closest unit and not immune to physical damage
            if unit.distance < minDistance and not unit.immunePhysicalDamage then
                closestUnit = unit
                minDistance = unit.distance
            end
        end)
    end

    -- Cast abilities on the closest unit if within 5 yards and not immune to physical damage
    if closestUnit and minDistance <= 5 then
        if risingSunKick:Castable(closestUnit) then
            -- Prioritize casting Rising Sun Kick when available
            risingSunKick:Cast(closestUnit)
            return
        end
        if player.lastCast == tigerPalm.id and blackoutKick:Castable(closestUnit) then
            -- Cast Blackout Kick if Tiger Palm was last cast
            blackoutKick:Cast(closestUnit)
            return
        end
        if tigerPalm:Castable(closestUnit) and player.lastCast ~= tigerPalm.id then
            -- Cast Tiger Palm only if it wasn't last cast
            tigerPalm:Cast(closestUnit)
        end
    end
end

