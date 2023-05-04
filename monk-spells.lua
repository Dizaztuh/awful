local Unlocker, awful, project = ...
local monk = project.monk.mistweaver

local Spell = awful.Spell
awful.Populate({
    tigerPalm = Spell(100780, { damage = "physical" }),
    blackoutKick = Spell(100784, { damage = "physical" }),
    risingSunKick = Spell(107428, { damage = "physical", targeted = true }),
    spinningCraneKick = Spell(101546, { damage = "physical" }),
    touchOfDeath = Spell(115080, { damage = "physical", targeted = true }),
    envelopingMist = Spell(116694, { heal = true, targeted = true }),
    renewingMist = Spell(115151, { heal = true, targeted = true }),
    soothingMist = Spell(115175, { heal = true }),
    essenceFont = Spell(191837, { heal = true }),
    chiWave = Spell(115098, { damage = "magical", heal = true }),
    lifeCocoon = Spell(116849, { heal = true, targeted = true }),
    roll = Spell(109132),
    chiTorpedo = Spell(119582),
    faelineStomp = Spell(327104, { damage = "magical", cc = true }),
    paralyze = Spell(115078, { cc = true, targeted = true }),
    legSweep = Spell(119381, { cc = true, targeted = true }),
    flyingSerpentKick = Spell(101545, { damage = "magical" }),
    fortifyingBrew = Spell(115203),
    dampenHarm = Spell(122278),
    diffuseMagic = Spell(122783),
}, monk, getfenv(1))


-- movement callbacks

roll:Callback("gapclose", function(spell)
    if target.distance > 10 and player.movingToward(target, { angle = 45, duration = 0.15 }) then
        if spell:Cast(target) then
            awful.alert("Roll (Gapclose)", spell.id)
        end
    end
end)

chiTorpedo:Callback("gapclose", function(spell)
    if target.distance > 15 and player.movingToward(target, { angle = 45, duration = 0.15 }) then
        if spell:Cast(target) then
            awful.alert("Roll (Gapclose)", spell.id)
        end
    end
end)

-- damage callbacks

tigerPalm:Callback(function(spell)
    spell:Cast(target)
end)

blackoutKick:Callback(function(spell)
    spell:Cast(target)
end)

risingSunKick:Callback(function(spell)
    spell:Cast(target)
end)

spinningCraneKick:Callback(function(spell)
    spell:Cast(target)
end)

touchOfDeath:Callback(function(spell)
    spell:Cast(target)
end)

faelineStomp:Callback(function(spell)
    spell:Cast(target)
end)

-- healing callbacks

envelopingMist:Callback(function(spell)
    spell:Cast(target)
end)

renewingMist:Callback(function(spell)
    spell:Cast(target)
end)

soothingMist:Callback(function(spell)
    spell:Cast(target)
end)

essenceFont:Callback(function(spell)
    spell:Cast(target)
end)

chiWave:Callback(function(spell)
    spell:Cast(target)
end)

lifeCocoon:Callback(function(spell)
    spell:Cast(target)
end)


-- cc callbacks

legSweep:Callback(function(spell)
    spell:Cast(target)
end)

paralyze:Callback(function(spell)
    spell:Cast(target)
end)

-- defensive callbacks

dampenHarm:Callback(function(spell)
    spell:Cast(target)
end

diffuseMagic:Callback(function(spell)
    spell:Cast(target)
end)

fortifyingBrew:Callback(function(spell)
    spell:Cast(target)
end)