local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

local Spell = awful.Spell

awful.Populate({
    target = awful.target,
    focus = awful.focus,
    player = awful.player,
    healer = awful.healer,
    pet = awful.pet,
    enemyHealer = awful.enemyHealer,
    enemy = awful.enemy,
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
    zenSpheres = Spell(410777, {heal = true, targeted = true}),
    roll = Spell(109132),
    chiTorpedo = Spell(119582),
    faelineStomp = Spell(388193),
    paralyze = Spell(115078, { charm = true, targeted = true }),
    legSweep = Spell(119381, { stun = true, targeted = true }),
    ringOfPeace = Spell(116844, { cc = true, targeted = false }),
    flyingSerpentKick = Spell(101545),
    fortifyingBrew = Spell(115203),
    dampenHarm = Spell(122278),
    diffuseMagic = Spell(122783),
    healingElixir = Spell(122281)
}, mistweaver, getfenv(1))


faelineStomp:Callback(function (spell)
    spell:Cast(target)
end)

fortifyingBrew:Callback(function(spell)
    if player.health <= 0.4 then
        spell:Cast(player)
    end
end)

healingElixir:Callback(function(spell)
    if player.health <= 0.75 then
        spell:Cast(player)
    end
end)

healingElixir:Callback(function(spell)
    if player.health <= 0.6 then
        spell:Cast(player)
    end
end)

-- Define an array of debuffs that we want to check for
local badStuff = {"Mindgames"}

-- Create a callback for the Diffuse Magic ability
diffuseMagic:Callback(function(spell)
    -- Check if the player has any of the debuffs listed in the "badStuff" array
    if player.debuffFrom(badStuff) then
        -- If the player has the bad debuff, cast Diffuse Magic on the player
        spell:Cast(player)
    elseif player.hp <= 0.35 then
        -- If player hp is 0.35 or less, cast Diffuse Magic on the player
        spell:Cast(player)
    end
end)

-- Create a callback for the Leg Sweep ability
legSweep:Callback(function(spell)
    -- Check if the target's health percentage is at or below 40%
    if target.hp <= 0.4 then
        -- If the target's health is at or below 40%, cast Leg Sweep on the target
        spell:Cast(target)
        return
    end
end)

dampenHarm:Callback(function(spell)
    if player.hp <= 0.6 then -- check if the player's health is at or below 60%
        spell:Cast(player) -- cast Dampen Harm on the player
    end
end)

-- Create a callback for the Touch of Death ability
touchOfDeath:Callback(function(spell)
    -- Loop through all enemies within range
    awful.enemies.loop(function(enemy)
        -- Check if enemy hp is less than or equal to 15%
        if enemy.hp <= 0.15 then
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
        -- If the friend is not in combat or their health is above 50%, we skip them
        -- This ensures that we only try to cast Life Cocoon on friends who are in combat and have less than 50% health
        if not friend.combat or friend.hp > 0.5 then return end

        -- If the friend meets the conditions (in combat and hp < 50%), cast Life Cocoon on them
        return spell:Cast(friend)
    end)
end)

-- Create a callback for the Paralyze ability
paralyze:Callback(function(spell)
    -- Check if the enemy healer is valid, within 20 yards range, and the target's health is below 40%
    if enemyHealer:Exists() and enemyHealer:Distance() <= 20 and target.hp < 0.4 then
        -- If the conditions are met, cast Paralyze on the enemy healer
        spell:Cast(enemyHealer)
    end
end)

-- Initialize a variable to track the time when Rising Sun Kick and Tiger Palm were last cast.
-- We subtract 10 from Rising Sun Kick because it has a 10-second cooldown.
local lastRisingSunKick = GetTime() - 10 
local lastTigerPalm = GetTime() - 1.5 -- Subtract 1.5 assuming a 1.5 second global cooldown (GCD)

-- Initialize a variable to track the last ability used.
local lastAbility

-- Define the rotation function.
function rotation()
    -- Check if 10 seconds have passed since the last Rising Sun Kick cast.
    -- If it has, or if it was reset by Blackout Kick, cast Rising Sun Kick.
    if GetTime() - lastRisingSunKick >= 10 then
        if risingSunKick:Castable(target) then
            risingSunKick:Cast(target)
            lastRisingSunKick = GetTime()
            lastAbility = "risingSunKick"
            return
        end
    end

    -- If Rising Sun Kick is on cooldown or just cast, we move to the next part of the rotation: Tiger Palm and Blackout Kick
    -- Cast Tiger Palm if it's off cooldown and if it wasn't the last ability used.
    if tigerPalm:Castable(target) and lastAbility ~= "tigerPalm" then
        tigerPalm:Cast(target)
        lastAbility = "tigerPalm"
        return
    end

    -- If Tiger Palm has just been cast, then cast Blackout Kick.
    -- This ensures that Tiger Palm is always cast before Blackout Kick.
    if blackoutKick:Castable(target) and lastAbility == "tigerPalm" then
        blackoutKick:Cast(target)

        -- After casting Blackout Kick, there is a chance to reset Rising Sun Kick's cooldown.
        -- We'll assume that this reset chance is handled elsewhere in the code,
        -- so we don't have to do anything special here.
        lastAbility = "blackoutKick"
        return
    end
end

