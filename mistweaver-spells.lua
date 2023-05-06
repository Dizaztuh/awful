local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

local Spell = awful.Spell

awful.Populate({
    tigerPalm = Spell(100780, { damage = "physical" }),
    blackoutKick = Spell(118166, { damage = "physical" }),
    risingSunKick = Spell(107428, { damage = "physical" }),
    spinningCraneKick = Spell(101546, { damage = "physical" }),
    touchOfDeath = Spell(322109, { damage = "physical", targeted = true }),
    envelopingMist = Spell(124682, { heal = true, ranged = true, targeted = true }),
    renewingMist = Spell(119611, { heal = true, ranged = true, targeted = true }),
    soothingMist = Spell(115175, { heal = true }),
    essenceFont = Spell(191837, { heal = true }),
    chiWave = Spell(115098, { heal = true, ranged = true }),
    lifeCocoon = Spell(116849, { heal = true, ranged = true, targeted = true, range = 40 }),
    sphereofDespair = Spell(410777, { ranged = true, targeted = true }),
    roll = Spell(109132),
    chiTorpedo = Spell(119582),
    faelineStomp = Spell(388193, {heal = true, ranged = true}),
    paralyze = Spell(115078, { stun = true, targeted = true, range = 20 }),
    legSweep = Spell(119381, { stun = true, targeted = true, range = 6 }),
    ringOfPeace = Spell(116844, { cc = true, targeted = false }),
    flyingSerpentKick = Spell(101545),
    fortifyingBrew = Spell(115203, { heal = true }),
    dampenHarm = Spell(122278),
    revival = Spell(115310, { heal = true, ranged = true }),
    diffuseMagic = Spell(122783),
    healingElixir = Spell(122281, { heal = true }),
    sphereofHope = Spell (410777, {heal = true, ranged = true, targeted = true })
}, mistweaver, getfenv(1))


revival:Callback("prio", function(spell)
    -- Loop through all friendly units
        awful.fgroup.loop(function(friend)
        -- Check if the friend's health is below 30%
        if friend.hp < 33 then
            -- Cast Revival
            return revival:Cast(player)
        end
    end)
end)

sphereofHope:Callback(function(spell)
    -- Loop through all friendly units
        awful.fgroup.loop(function(friend)
        if not friend.combat or friend.hp > 85 or friend.buff(411036) then 
            return 
        end
        -- If the friend meets the conditions (in combat, hp < 50%, and within range), cast Life Cocoon on them
        return sphereofHope:Cast(friend)
    end)
end)


sphereofDespair:Callback(function (spell)
    -- Check if the target doesn't have the debuff (411038) and the spell is castable on the target
    if not target.debuff(411038) and spell:Castable(target) then
        sphereofDespair:Cast(target)
    end
end)


-- Callback for Enveloping Mist spell
envelopingMist:Callback(function(spell)
    -- Loop through all friendly units
    awful.fgroup.loop(function(friend)
        -- Check if the friendly unit is not in combat, has more than 70% HP, or is out of range for Enveloping Mist
        if not friend.combat or friend.hp > 75 then
            -- If any of the conditions are met, skip this friendly unit
            return
        end
        -- Check if Enveloping Mist's cooldown is 0
        if envelopingMist.castTime == 0 then
            -- If the cooldown is 0, cast Enveloping Mist on the friendly unit
            return envelopingMist:Cast(player)
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
    if player.hp <= 75 then
        healingElixir:Cast(player)
    end
end)

-- Define an array of debuffs that we want to check for
local badStuff = {"Mindgames"}

diffuseMagic:Callback(function(spell)
    -- Check if the player has any of the debuffs listed in the "badStuff" array
    if player.debuffFrom(badStuff) or player.hp <= 37 then
        -- If the player has the bad debuff, cast Diffuse Magic on the player
        diffuseMagic:Cast(player)
    end
end)


-- Create a callback for the Leg Sweep ability
legSweep:Callback("prio", function(spell)
    -- Check if the target's hp percentage is at or below 40%, the spell is castable on the target, and the target is in range
    if target.hp <= 40 and spell:Castable(target) then
        -- If the target's hp is at or below 40%, cast Leg Sweep on the target
       return legSweep:Cast(target)
    end
end)


dampenHarm:Callback("prio", function(spell)
    if player.hp <= 60 then -- check if the player's hp is at or below 60%
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
paralyze:Callback("prio", function(spell)
    -- Check if the enemy healer is valid, within paralyze.range, the target's hp is below 40%, and the spell is castable on the enemy healer
    if enemyHealer.distance <= paralyze.range and target.hp < 40 and spell:Castable(enemyHealer) then
        -- If the conditions are met, cast Paralyze on the enemy healer
        paralyze:Cast(enemyHealer)
    end
end)

-- Callback for Tiger Palm
tigerPalm:Callback(function()
    if tigerPalm:Castable(target) and player.lastCast ~= tigerPalm.id then
        -- Cast Tiger Palm on the target.
        tigerPalm:Cast(target)
        return
    end
end)

-- Callback for Blackout Kick
blackoutKick:Callback(function()
    if blackoutKick:Castable(target) and player.lastCast == tigerPalm.id then
        -- Cast Blackout Kick on the target.
        blackoutKick:Cast(target)
        return
    end
end)

-- Callback for Rising Sun Kick
risingSunKick:Callback("prio", function()
    if risingSunKick:Castable(target) then
        -- If so, cast Rising Sun Kick on the target.
        risingSunKick:Cast(target)
    end
end)


touchOfDeath:Callback(function(spell)
    -- Loop through all enemies within range, something arbitrary like 10 yards
    awful.enemies.within(10).loop(function(enemy)
        -- Check if spell is Castable and enemy hp is less than 15%  - LESS THAN due to the spell tooltip being "under 15% health"
        if spell:Castable(enemy) and enemy.hp < 15 then
            -- Cast Touch of Death on the enemy
            spell:Cast(enemy)
            return true -- exit the loop after casting the spell
        end
    end)
end)