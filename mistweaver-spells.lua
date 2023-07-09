local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver
local player = awful.Player
local Spell = awful.Spell
local delayLowerBound = 0.4
local delayUpperBound = 0.6
local ringOfPeaceTriggeredTime = 0
local settings = project.settings
local SpellStopCasting = awful.unlock("SpellStopCasting") or awful.call("SpellStopCasting")
local enemyHealer = awful.enemyHealer
awful.enabled = true

awful.Populate({
    transfer = Spell(119996, { ignoreMoving = true, ignoreCasting = true, ignoreChanneling = true, ignoreControl = true }),
    summonJadeSerpent = Spell(115313, { ignoreLoS = false, ignoreMoving = true, ignoreChanneling = true }),
    zenFocusTea = Spell(209584),
    manaTea = Spell(197908),
    sheilunsGift = Spell(399491, { heal = true, ignoreLoS = false }),
    invokeYulon = Spell(322118),
    vivify = Spell(116670, { heal = true, ignoreChanneling = true }),
    tigerPalm = Spell(100780, { damage = "physical", ranged = true, ignoreMoving = true }),
    blackoutKick = Spell(118166, { damage = "physical" }),
    risingSunKick = Spell(107428, { damage = "physical", targeted = false, ranged = true, range = 5 }),
    spinningCraneKick = Spell(101546, { damage = "physical" }),
    touchOfDeath = Spell(322109, { damage = "physical", ignoreMoving = true }),
    envelopingMist = Spell(124682, { heal = true, ignoreMoving = true, ignoreChanneling = true }),
    enveloping = Spell(124682, { heal = true, ignoreChanneling = true }),
    renewing = Spell(115151, { heal = true, ignoreMoving = true, ignoreChanneling = true }),
    preHot = Spell(115151, { heal = true, ignoreMoving = true, ignoreChanneling = true }),
    renewingMist = Spell(115151, { heal = true, ignoreMoving = true, ignoreChanneling = true }),
    soothingMist = Spell(115175, { heal = true, ignoreLoS = false }),
    essenceFont = Spell(191837, { heal = true, ignoreMoving = true }),
    chiWave = Spell(115098, { heal = true }),
    lifeCocoon = Spell(116849, { heal = true, ignoreCasting = true }),
    sphereofDespair = Spell(410777, { effect = "magic", ignoreMoving = true }),
    roll = Spell(109132, { ignoreMoving = true }),
    chiTorpedo = Spell(119582, { ignoreMoving = true }),
    disable = Spell(343731, { cc = true, effect = "physical", ignoreMoving = true }),
    faelineStomp = Spell(388193, { heal = true, ignoreMoving = true }),
    paralyze = Spell(115078, { cc = true, ignoreLoS = false }),
    legSweep = Spell(119381, { stun = true, ignoreMoving = true }),
    ringOfPeace = Spell(116844, { ignoreCasting = true, ignoreChanneling = true, ignoreMoving = true, effect = "magic", diameter = 15, offsetMin = 0, offsetMax = 5 }),
    flyingSerpentKick = Spell(101545),
    fortifyingBrew = Spell(115203, { heal = true, ignoreCasting = true, ignoreMoving = true, ignoreChanneling = true }),
    dampenHarm = Spell(122278,  { ignoreCasting = true, ignoreMoving = true, ignoreChanneling = true }),
    revival = Spell(115310, { heal = true, range = 40, ignoreChanneling = true }),
    diffuseMagic = Spell(122783, { ignoreCasting = true, ignoreMoving = true, ignoreChanneling = true }),
    detox = Spell(115450, { ignoreMoving = true, range = 40, ignoreChanneling = true }),
    spearHandStrike = Spell(116705,  { ignoreCasting = true, ignoreChanneling = true }),
    healingElixir = Spell(122281, { heal = true, ignoreCasting = true, ignoreMoving = true }),
    sphereofHope = Spell (410777, { ignoreMoving = true }),
    thunderFocusTea = Spell(116680,  { ignoreCasting = true, ignoreMoving = true, ignoreChanneling = true }),
    restoral = Spell(388615, { heal = true, ignoreControl = true, range = 40, ignoreChanneling = true }),
    tigersLust = Spell(116841, { targeted = true }),
    invokeChiJi = Spell(325197, { ignoreMoving = true, ignoreMoving = true }),
    bloodFury = Spell(33697),
    grappleWeapon = Spell (233759, { cc = true, effect = "physical", ignoreMoving = true }),
    provoke = Spell (115546, { ignoreMoving = true, ignoreCasting = true, ignoreChanneling = true })
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
        [210873] = true, -- Hex
        [211004] = true, -- Hex
        [211010] = true, -- Hex
        [211015] = true, -- Hex
        [269352] = true, -- Hex
        [277778] = true, -- Hex
        [277784] = true, -- Hex
        [309328] = true, -- Hex
        [117405] = true, -- Binding Shot
        [375901] = true, -- Mindgames
        [64695] = true, -- EarthGrab
        [102359] = true, -- Mass Entanglement
        [339] = true, -- Entangling Roots
        [393456] = true, -- Entrapment
        [385408] = true, -- Sepsis
        [355689] = true, -- Landslide
        [118] = true, -- Polymorph
        [61780] = true, -- Polymorph
        [126819] = true, -- Polymorph
        [161353] = true, -- Polymorph
        [161354] = true, -- Polymorph
        [161355] = true, -- Polymorph
        [28271] = true, -- Polymorph
        [28272] = true, -- Polymorph
        [61305] = true, -- Polymorph
        [61721] = true, -- Polymorph
        [161372] = true, -- Polymorph
        [277787] = true, -- Polymorph
        [277792] = true, -- Polymorph
        [321395] = true, -- Polymorph
        [391622] = true, -- Polymorph
        [118699] = true, -- Fear
        [411038] = true, -- Sphere of Despair
        [8122] = true, -- Psychic Scream
        [853] = true, -- Hammer of Justice
        [187650] = true, -- Freezing Trap
        [360806] = true, -- Sleep Walk
        [212638] = true, -- Tracker's Net
        [109248] = true, -- Binding Shot
        [113724] = true, -- Ring of Frost
        [5484] = true, -- Howl of Terror
        [122] = true -- Frost Nova

    }

    -- Define the DisarmTable
local DisarmTable = {
    [114050] = true, -- Ascendence
    [114051] = true, -- Ascendence 2
    [114052] = true, -- Ascendence 3
    [384352] = true, -- Doom Winds
    [121471] = true, -- Shadow Blades
    [360952] = true, -- Coordinated Assault
    [19574] = true, -- Bestial Wrath
    [288613] = true, -- Trueshot
    [31884] = true, -- Avenging Wrath
    [185313] = true, -- Shadow Dance
    [204361] = true, -- Bloodlust
    [107574] = true, -- Avatar
    [262161] = true, -- Warbreaker
    [216331] = true -- Avenging Crusader
}


local interruptDurations = {
    [47528] = true, -- Mind Freeze - Death Knight
    [183752] = true, -- Disrupt - Demon Hunter
    [106839] = true, -- Skull Bash - Druid
    [78675] = true, -- Solar Beam - Druid
    [351338] = true, -- Quell - Evoker
    [187707] = true, -- Muzzle - Hunter
    [147362] = true, -- Counter Shot - Hunter
    [2139] = true, -- Counterspell - Mage
    [116705] = true, -- Spear Hand Strike - Monk
    [96231] = true, -- Rebuke - Paladin
    [15487] = true, -- Silence - Priest
    [1766] = true, -- Kick - Rogue
    [57994] = true, -- Wind Shear - Shaman
    [19647] = true, -- Spell Lock - Warlock
    [119818] = true, -- Call Felhunter - Warlock
    [6552] = true -- Pummel - Warrior
}

BurstCDS = {
    [384352] = true, -- Doom Winds
    [121471] = true, -- Shadow Blades
    [406227] = true, -- Deep Breath
    [360952] = true, -- Coordinated Assault
    [370965] = true, -- The Hunt
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

local healthstone = awful.NewItem(5512)
function collectHealthstone()
    -- If player does not have either "Arena Preparation" or "Preparation" buffs, return
    if not player.buff("Arena Preparation") and not player.buff("Preparation") then
        return
    end

    -- Loop through all friendly units to check if there is a Warlock present
    local warlockPresent = false
    awful.fgroup.loop(function(friend)
        if friend.class2 == "WARLOCK" then
            warlockPresent = true
            return
        end
    end)

    -- If no Warlock is present, return
    if not warlockPresent then
        return
    end

    local soulwelled = awful.objects.within(5).find(function(obj) return obj.id == 303148 and obj.creator.friend end)
    if healthstone.count < 1 then
        if soulwelled then
            if Unlocker.type == "daemonic" then
                Interact(soulwelled.pointer)
            else
                ObjectInteract(soulwelled.pointer)
            end
            return
        end
    end
end

function healthStone()
    local healthStone = awful.NewItem(5512)
    if healthStone:Usable() and player.hp < settings.hst and healthStone.count >= 1 and healthStone.cd < 1 then
        healthStone:Use()
    end
end

preHot:Callback(function()
    awful.fgroup.loop(function(friend)
        if friend.hp == 100 and not friend.combat and not friend.buff("renewing mist") then
            if renewingMist:Castable(friend) then
                renewingMist:Cast(friend)
            end
        end
    end)
end)

-- Callback for Chi Wave
chiWave:Callback(function(spell)
    local closestEnemy
    awful.enemies.loop(function(enemy)
        if player.distanceTo(enemy) <= 5 then
            closestEnemy = enemy
        end
    end)
    
    if closestEnemy and spell:Castable(closestEnemy) then
        return spell:Cast(closestEnemy)
    end

    local lowestHpFriend
    awful.fgroup.loop(function(friend)
        if not lowestHpFriend or friend.hp < lowestHpFriend.hp then
            lowestHpFriend = friend
        end
    end)

    if lowestHpFriend and spell:Castable(lowestHpFriend) then
        return spell:Cast(lowestHpFriend)
    end
end)


roll:Callback(function(spell)
    local target = player.target

    if target and target.enemy then  -- check if target is an enemy
        local distanceToTarget = target.distance

        if distanceToTarget and distanceToTarget > 10 and distanceToTarget < 15 and player.facing(target) then
            awful.alert({
                message="Casting Roll",
                texture=109132,  -- Replace with the texture ID of the roll spell
            })
            roll:Cast()
        end
    end
end)


-- Create a callback for the Sheilun's Gift ability
sheilunsGift:Callback(function(spell)
    -- Check if the player has at least 8 stacks of the buff and Sheilun's Gift is castable
    if spell.count >= 5 and spell:Castable() then
        -- Loop through all friendly units
        awful.fgroup.loop(function(friend)
            -- Check if the friend's HP is below the Sheilun's threshold
            if friend.hp <= settings.sheiluns then
                -- Loop through interrupt cooldowns
                for guid, time in pairs(interruptCDs) do
                    -- If the interrupt is off cooldown
                    if time <= GetTime() then
                        -- Cast Zen Focus Tea
                        zenFocusTea:Cast()
                    end
                end
                -- Cast Sheilun's Gift
                awful.controlMovement(awful.tickRate * 2.5)
                spell:Cast(player)
                return
            end
        end)
    end
end)


zenFocusTea:Callback(function(spell)
    if not spell:Castable() then return end
    -- Define the HP threshold at which you want to activate Zen Focus Tea
    local hpThreshold = settings.zft  -- For example, we use 30%

    -- Initialize variables for storing the lowest HP friend and their HP
    local lowestHpFriend = nil
    local lowestHp = 101  -- Since HP is in %, we start with a number higher than 100

    -- Loop through all friendly units
    awful.fgroup.loop(function(friend)
        -- Check if the friend's HP is lower than the lowest HP we've seen so far
        if friend.hp < lowestHp then
            -- Update the lowest HP and lowest HP friend
            lowestHp = friend.hp
            lowestHpFriend = friend
        end
    end)

    -- If we found a friend with HP below the threshold, Zen Focus Tea is castable, and the player is not stunned
    if lowestHpFriend and lowestHp <= hpThreshold and not player.stunned then
        -- Loop through all enemies
        awful.enemies.loop(function(enemy)
            -- Loop through each spellID in the interruptDurations table
            for spellID in pairs(interruptDurations) do  
                -- Check if the enemy's interrupt spell is on cooldown
                if enemy.cd(spellID) > 0 then  -- If interrupt is on cooldown, cd > 0
                    -- If interrupt is on cooldown, cast spiritWalkersGrace
                    spell:Cast()
                    return
                end
            end
        end)
    end
end)


manaTea:Callback(function(spell)
    if player.manaPct <= 90 then return
    spell:Cast(player)
    end
end)


invokeYulon:Callback(function(spell)
    -- Loop through all enemy units
    awful.enemies.loop(function(enemy)
        -- Check if the enemy has any buffs from the BurstCDS table
        for spellID, _ in pairs(BurstCDS) do
            if enemy.buff(spellID) then
                -- Cast Invoke Yu'lon on the enemy
                spell:Cast()
                -- Break the loop once we've found an enemy with a buff
                return true
            end
        end
    end)
end)

soothingMist:Callback(function(spell)
    -- Initialize variables for storing the lowest HP friend and their HP
    local lowestHpFriend = nil
    local lowestHp = 101  -- Since HP is in %, we start with a number higher than 100

    -- Loop through all friendly units
    awful.fgroup.loop(function(friend)
        -- Check if the friend's HP is lower than the lowest HP we've seen so far
        if friend.hp < lowestHp then
            -- Update the lowest HP and lowest HP friend
            lowestHp = friend.hp
            lowestHpFriend = friend
        end
    end)

    -- If we found a friend with the lowest HP
    if lowestHpFriend and player.combat then
        -- Stop any ongoing casting
        awful.call("SpellStopCasting")
        -- Cast Soothing Mist on the friend
        spell:Cast(lowestHpFriend)
    end
end)


transfer:Callback(function(spell)
    -- Check if player's HP is below 60, if player is stunned and if Transfer is castable
    if player.buff(101643) and player.hp <= settings.transferJuke and player.stunned and spell:Castable() then
        -- Cast Transfer
        spell:Cast()

        -- Attempt to heal up the player using Soothing Mist and Vivify
        if soothingMist:Castable(player) then
            soothingMist:Cast(player)
        end
        if player.buff("Soothing Mist") then
            if vivify:Castable(player) then
                vivify:Cast(player)
            end
            if enveloping:Castable(player) then
                enveloping:Cast(player)
            end
        end
        
        -- Check if player has the Eminence talent
        if player.HasTalent(394110) then
            -- Initialize variable to track if any enemies are within melee range
            local enemyWithinMeleeRange = false

            -- Loop through all enemies
            awful.enemies.loop(function(enemy)
                -- If the enemy is within melee range of the player
                if enemy.meleeRangeOf(player) then
                    -- Set our variable to true and break the loop
                    enemyWithinMeleeRange = true
                    return true
                end
            end)

            -- If there's an enemy within melee range and Transfer is castable, cast Transfer
            if enemyWithinMeleeRange and spell:Castable() then
                spell:Cast()
            end
        end
    end
end)


provoke:Callback(function(spell)
    -- Initialize variables to store the closest enemy and if an enemy is casting a spell from provokeTable
    local closestEnemy = nil
    local provokingSpellBeingCasted = false

    -- First, loop through all enemies to check if any enemy is casting a spell from the provokeTable
    awful.enemies.loop(function(enemy)
        local enemyCastingSpell = enemy.casting -- Get the name of the spell being cast by the enemy

        -- If an enemy is casting a spell from the provokeTable and they're targeting the player
        if enemyCastingSpell and enemy.castTarget ~=nil and enemy.castTarget.isUnit(player) and provokeTable[enemyCastingSpell] and enemy.castRemains < 0.5 then
            provokingSpellBeingCasted = true
            return true -- Break the loop, no need to continue
        end
    end)

    -- If no provoking spell is being casted, we don't need to provoke
    if not provokingSpellBeingCasted then
        return
    end

    -- Then, loop through all enemies to find the closest enemy in combat
    awful.enemies.loop(function(enemy)
        if enemy.combat then
            -- If this is the first enemy we've found or if this enemy is closer than the current closest one
            if not closestEnemy or enemy.distance < closestEnemy.distance then
                closestEnemy = enemy
            end
        end
    end)

    -- If we've found a closest enemy
    if closestEnemy then
        awful.alert({
            message="Casting Provoke",
            texture=115546,
        })
        -- Cast Provoke on the closest enemy in combat
        awful.call("SpellStopCasting")
        spell:Cast(closestEnemy)
    end
end)


    bloodFury:Callback(function(spell)
        awful.enemies.loop(function(enemy)
            for spellID, _ in pairs(BurstCDS) do
                if enemy.buff(spellID) then
                    if bloodFury.cd < 1 then
                        bloodFury:Cast()
                        awful.alert({
                            message="Using Blood Fury",
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
            if enemy.buff(spellID) then
                local x, y, z = enemy.position()
                if not player.losCoordsLiteral(x, y, z) then return end
                if x and y and z then
                    awful.alert({
                        message="Casting Ring of Peace",
                        texture=116844,
                    })
                    ringOfPeace:AoECast(x, y, z)
                    ringOfPeaceTriggeredTime = currentTime
                end
            end
        end

        for spellID, _ in pairs(enemyBuffTable) do
            if enemy.buff(spellID) then
                local x, y, z = enemy.position()
                if not player.losCoordsLiteral(x, y, z) then return end
                if x and y and z then
                    awful.alert({
                        message="Casting Ring of Peace",
                        texture=116844,
                    })
                    ringOfPeace:AoECast(x, y, z)
                    ringOfPeaceTriggeredTime = currentTime
                end
            end
        end
    end)

    awful.fgroup.loop(function(friend)
        if friend.hp <= 40 and not friend.buff (116849) then
            awful.enemies.loop(function(enemy)
                if enemy.meleeRangeOf(friend) and lifeCocoon.cd > 1 then
                    local x, y, z = friend.position()
                    if not player.losCoordsLiteral(x, y, z) then return end
                    if x and y and z then
                        awful.alert({
                            message="Casting Ring of Peace",
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
            if enemy.buff(spellID) then
                -- Cast grappleWeapon on the enemy
                awful.alert({
                    message="Casted Disarm ",
                    texture=233759, -- Change to the appropriate texture ID for grappleWeapon
                })
                spell:Cast(enemy)
            end
        end
    end)
end)

function stompTotems()
    awful.totems.loop(function(totem)
        -- Only stomp selected totems and within range
        for _, selectedTotemId in ipairs(settings.totemsToStomp) do
            if totem.id == selectedTotemId and totem.distance <= 5 then
                awful.alert({
                    message="Stomping a totem.",  
                    texture=100780,
                })
                -- If the totem is in the list and within range, and if abilities are castable, cast Tiger Palm and Blackout Kick on the totem
                if tigerPalm:Castable(totem) then
                    tigerPalm:Cast(totem)
                end
                if blackoutKick:Castable(totem) then
                    blackoutKick:Cast(totem)
                end
                break
            end
        end
    end)
end


-- Callback for Disable ability
disable:Callback(function(spell)
    -- Check if the target does not have the Disable debuff, 
    -- is not immune to physical effects, and Disable is castable
    if not target.debuff(116095) and not target.immunePhysical and disable:Castable() then
        awful.alert({
            message="Applying Disable ",
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
            if enemy.hp < settings.spear then
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
                    message="Cast Interrupted",
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
                message="Cast Interrupted",
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
                message="Cast Interrupted",
                texture=116705,
            })
            spell:Cast(enemy)
        end
    end)
end)

local lastCastTime = 0
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
                            message="Casting Detox",
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
                message="Cleansing",
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
            message="Casted Tiger's Lust!",
            texture=324406,
        })
        return spell:Cast(player)
    end

    if player.slowed and target.distance > 5 then
        awful.alert({
            message="Casted Tiger's Lust!",
            texture=324406,
        })
        return spell:Cast(player)
    end

    -- Second condition: Check if friend is rooted and root remains >= 3 using friends loop
    awful.fgroup.loop(function(friend)
        if friend.rooted and friend.rootRemains >= 3 then
            awful.alert({
                message="Casted Tiger's Lust!",
                texture=324406,
            })
            return spell:Cast(friend)
        end
    end)
end)

-- Callback for Invoke Chi-Ji, the Red Crane ability
invokeChiJi:Callback(function(spell)
    if settings.cje then
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
end

if settings.cjf then
    -- Second condition: Check if friends cast any spells from the BurstCDS table
    awful.fgroup.loop(function(friend)
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
end
    -- Third condition: Check friend.hp and if anyone is below 70 and player.target > 5
    awful.fgroup.loop(function(friend)
        if friend.hp < settings.chiji then
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
        -- Loop through all friendly units to check their hp
        awful.fgroup.loop(function(friend)
            -- Check if the friendly unit's hp is at or below 75% and the spell is castable
            if friend.hp <= settings.tft and thunderFocusTea:Castable() then
                awful.alert({
                    message="Casted Thunder Focus Tea!", 
                    texture=116680,
                    })
                -- If the friendly unit's hp is at or below 75%, cast Thunder Focus Tea on the player
                return spell:Cast(player)
            end
        end)
end)


revival:Callback(function(spell)
    -- Loop through all friendly units
        awful.fgroup.loop(function(friend)
        -- Check if the friend's health is below 30%
        if friend.hp <= settings.revival then
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
        if friend.hp <= settings.restoral then
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
    if GetTime() - lastCastTimeHope >= 20 then
        -- Loop through all friendly units
        awful.fgroup.loop(function(friend)
            if not friend.combat or friend.hp > settings.soh or friend.buff(411036) then
                return
            end
            -- If the friend meets the conditions (in combat, hp < 75%, and within range), cast Sphere of Hope on them
            spell:Cast(friend)
            -- Update the lastCastTime variable
            lastCastTimeHope = GetTime()
            awful.alert({
                message="Casted Sphere of Hope", 
                texture=388615,
                })
            -- Exit the loop
            return true
        end)
    end
end)


local lastCastTimeDespair = 0

sphereofDespair:Callback(function(spell)
    if GetTime() - lastCastTimeDespair >= 20 then
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
                message = "Casted Sphere of Despair",
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
    if lowestHpFriend ~= nil and player.buffStacks(343820) > 3 and not player.buff(116680) then
        awful.alert({
            message="Casted Instant Enveloping Mist Instant Proc on Lowest HP Ally!", 
            texture=124682,
            })
        -- If the cooldown is 0, cast Enveloping Mist on the friendly unit with the lowest HP
        spell:Cast(lowestHpFriend)
    end
end)


enveloping:Callback(function(spell)
    local lowestHpFriend = nil
    local lowestHp = settings.emist

    awful.fgroup.loop(function(friend)
        if friend.hp < lowestHp then
            lowestHp = friend.hp
            lowestHpFriend = friend
        end
    end)

    if enveloping:Castable() and lowestHpFriend and ((lowestHpFriend.buff(115175) and player.buffStacks(388048) >= 2) or player.buff(388519)) then
        spell:Cast(lowestHpFriend)
    end
    
end)


vivify:Callback(function(spell)
    local lowestHpFriend = nil
    local lowestHp = settings.viv 

    awful.fgroup.loop(function(friend)
        if friend.hp < lowestHp then
            lowestHp = friend.hp
            lowestHpFriend = friend
        end
    end)

    if player.buff(388519) or player.buff(325209) or player.buffStacks(388048) >= 2 then
        return
    end

    if vivify:Castable() and lowestHpFriend and lowestHpFriend.buff(115175) or lowestHpFriend and player.buff(392883) then
        spell:Cast(lowestHpFriend)
    else 
        return
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
    if renewingMist.castTime == 0 and lowestHpFriend ~= nil and not lowestHpFriend.buff(119611) then
        awful.alert({
            message="Casted Instant Renewing Mist Instant Proc on Lowest HP Ally!", 
            texture=115151,
            })
        -- If the cooldown is 0, cast Renewing Mist on the friendly unit with the lowest HP
        spell:Cast(lowestHpFriend)
    end
end)

renewing:Callback(function(spell)
    -- Initialize a variable to store the friendly unit with the lowest HP
    local lowestHpFriend = nil
    local lowestHpPercentage = settings.rmist

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
    if lowestHpFriend ~= nil and not lowestHpFriend.buff(119611) then
        awful.alert({
            message="Casted Renewing Mist", 
            texture=115151,
            })
        -- If the cooldown is 0, cast Renewing Mist on the friendly unit with the lowest HP
        spell:Cast(lowestHpFriend)
    end
end)


faelineStomp:Callback(function(spell)
    -- Check if the player doesn't have the Teachings buff
    if not (player.buff(389387) or player.buff(388026)) then
        -- Get the target's position
        local x, y, z = target.position()
        -- Check if the target is within line of sight
        if not player.losCoordsLiteral(x, y, z) then return end
        -- If the target's position is available and within line of sight, cast Faeline Stomp
        if x and y and z then
            awful.alert({
                message="Casted Faeline Stomp",
                texture=388193,
            })
            spell:Cast(target)
        end
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
    if not (player.buff(122278) or player.buff(122783) or player.buff(116849)) and player.hp <= 35 then
        awful.alert({
            message="Casted Fortifying Brew! Gettin fk'n Rekt!",
            texture=115203,
        })
        -- If the player's health is at or below 40%, cast Fortifying Brew on the player
        spell:Cast(player)
    end
end)

healingElixir:Callback(function(spell)
    if player.hp <= settings.he and healingElixir.charges >= 1 then
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
    if player.debuff(badStuff) or player.hp <= settings.dm then
        awful.alert({
            message="Casted Diffuse Magic!",
            texture=122783,
        })
        -- If the player has the bad debuff or their health is at or below 34%, cast Diffuse Magic on the player
        spell:Cast(player)
    end
end)

legSweep:Callback(function(spell)
    if not spell:Castable() then return end  -- Return early if spell is not castable

    local enemiesWithBurstCDs = 0
    local enemiesInRange = 0
    local ccEnemy = nil
    local enemyHealerInRange = nil

    -- Loop through enemies just once
    awful.enemies.loop(function(enemy)
        if enemy.distanceTo(player) <= 6 and player.losOf(enemy) and not enemy.cc then
            -- Check for burst CDs
            for spellID, _ in pairs(BurstCDS) do
                if enemy.buff(spellID) then
                    enemiesWithBurstCDs = enemiesWithBurstCDs + 1
                    break
                end
            end

            -- Check for enemies in range
            enemiesInRange = enemiesInRange + 1
        end

        -- Check for CC'd enemies
        if enemy.distanceTo(player) <= 6 and player.losOf(enemy) and not enemy.buff(408557) and enemy.cc and enemy.ccRemains <= awful.buffer + awful.latency then
            ccEnemy = enemy
        end
    end)

    -- Check for enemy healer
    if enemyHealer and enemyHealer.distance <= 6 and not enemyHealer.cc then
        enemyHealerInRange = enemyHealer
    end

    -- Analyze gathered data and cast the spell accordingly
    if enemiesWithBurstCDs >= 1 then
        awful.alert({
            message="Casting Leg Sweep on enemies with burst cooldowns",
            texture=119381,
        })
        spell:Cast()
        return
    end

    if player.hp < 40 and enemiesInRange >= 1 then
        awful.alert({
            message="Casting Leg Sweep due to low player health",
            texture=119381,
        })
        spell:Cast()
        return
    end

    if ccEnemy then
        awful.alert({
            message="Casting Leg Sweep on crowd controlled enemy whose CC is about to end",
            texture=119381,
        })
        spell:Cast()
        return
    end

    if enemyHealerInRange then
        awful.alert({
            message="Casting Leg Sweep due to enemy healer in range",
            texture=119381,
        })
        spell:Cast()
        return
    end

    -- Add new condition
    if enemiesInRange >= 2 then
        awful.alert({
            message="Casting Leg Sweep due to more than 2 enemies in range",
            texture=119381,
        })
        spell:Cast()
        return
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

    if player.hp <= settings.dh and not (player.buff(122783) or player.buff(243435) or player.buff(116849)) then
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
        if not friend.combat or friend.hp > settings.lc or friend.distance > lifeCocoon.range then return end
        if friend.buff(642) or friend.buff(186265) or friend.buff(47536) or friend.buff(47585) or friend.buff(196555) or friend.buff(45438) then return end
        awful.alert({
            message="Casted Life Cocoon", 
            texture=116849,
            })
        -- If the friend meets the conditions (in combat, hp < 50%, and within range), cast Life Cocoon on them
        return spell:Cast(friend)
    end)
end)

-- Create a callback for the Paralyze ability
paralyze:Callback(function(spell)
    -- Check if the enemy healer is valid, within paralyze.range, the target's hp is below 40%, the spell is castable on the enemy healer, the enemy healer is not the player's target, and incapDR > 0.25
    if enemyHealer.distance <= paralyze.range and target.hp < settings.para and paralyze:Castable(enemyHealer) and not (player.target == enemyHealer) and enemyHealer.incapDR > 0.25 then
        -- Cast Paralyze on the enemy healer
        paralyze:Cast(enemyHealer)
        awful.alert({
            message="Paralysis on Enemy Healer!", 
            texture=115078,
        })
    end

    -- Loop through all friends
    awful.fgroup.loop(function(friend)
        -- Ensure the friend is valid
        if not friend then return end

        -- If the friend has a buff in the BurstCDS table
        for spellID, _ in pairs(BurstCDS) do
            if friend.buff(spellID) and enemyHealer.distance <= paralyze.range and paralyze:Castable(enemyHealer) and not (friend.target == enemyHealer) and enemyHealer.incapDR > 0.25 then
                -- Cast Paralyze on the enemy healer
                paralyze:Cast(enemyHealer)
                awful.alert({
                    message="Paralysis on Enemy Healer during Burst CD!", 
                    texture=115078,
                })
                return -- Stop the loop as soon as a match is found
            end
        end
    end)
end)


-- Callback for Tiger Palm
tigerPalm:Callback(function(spell)
    if settings.ssbot then
        if tigerPalm:Castable(target) and player.lastCast ~= tigerPalm.id then
            -- Cast Tiger Palm on the target.
            tigerPalm:Cast(target)
            return
        end
    end
    if not settings.ssbot then
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

    if tigerPalm:Castable(closestEnemy) and player.lastCast ~= tigerPalm.id and not closestEnemy.buff("Recently Challenged") and not closestEnemy.bcc then
        -- Cast Tiger Palm on the closest enemy.
        spell:Cast(closestEnemy)
        return
    end
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


risingSunKick:Callback(function(spell)
    if allEnemies.around(player, 5) <= 3 then
        spell:Cast(target)
    elseif player.buff(116680) then
        spell:Cast(target)
    end
end)


touchOfDeath:Callback(function(spell)
    enemies.loop(function(enemy)
        if not spell:Castable(enemy) then return end 
        spell:Cast(enemy)
        return awful.alert({
            message = "Show us on the doll where he touched you",
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
            if unit.distance < minDistance and not unit.immunePhysicalDamage and not unit.bcc then
                closestUnit = unit
                minDistance = unit.distance
            end
        end)
    end

    -- Cast abilities on the closest unit if within 5 yards and not immune to physical damage
    if closestUnit and minDistance <= 5 then
        if risingSunKick:Castable(closestUnit) then
            -- Prioritize casting Rising Sun Kick when available
            if awful.allEnemies.around(player, 5) <= 3 then
                risingSunKick:Cast(closestUnit)
                return
            end
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

