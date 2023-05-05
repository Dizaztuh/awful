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

blackoutKick:Callback(function(spell)
    if risingSunKick.cd == 0 then
    risingSunKick:Cast(target)
    else
    spell:Cast(target)
    end
end)

risingSunKick:Callback(function(spell)
    spell:Cast(target)
end)

faelineStomp:Callback(function (spell)
    spell:Cast(target)
end)

tigerPalm:Callback(function(spell)
    if player.lastcast("Tiger Palm", 1) then
        return
    else
        spell:Cast(target)
    end
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