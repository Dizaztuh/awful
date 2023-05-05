local Unlocker, awful, project = monk
local monk = project.monk.mistweaver

local Spell = awful.Spell

awful.Populate({
    tigerPalm = Spell(100780, { damage = "physical" }),
    blackoutKick = Spell(100784, { damage = "physical" }),
    risingSunKick = Spell(107428, { damage = "physical", targeted = true }),
    spinningCraneKick = Spell(101546, { damage = "physical" }),
    touchOfDeath = Spell(115080, { damage = "physical", targeted = true }),
    envelopingMist = Spell(124682, { heal = true, targeted = true }),
    renewingMist = Spell(119611, { heal = true, targeted = true }),
    soothingMist = Spell(115175, { heal = true }),
    essenceFont = Spell(191837, { heal = true }),
    chiWave = Spell(115098, { damage = "magical", heal = true }),
    lifeCocoon = Spell(116849, { heal = true, targeted = true }),
    zenSpheres = Spell(410777, {heal = true, targeted = true}),
    roll = Spell(109132),
    chiTorpedo = Spell(119582),
    faelineStomp = Spell(327040),
    paralyze = Spell(115078, { cc = true, targeted = true }),
    legSweep = Spell(119381, { cc = true, targeted = true }),
    ringOfPeace = Spell(116844, { cc = true, targeted = false }),
    flyingSerpentKick = Spell(101545, { damage = "magical" }),
    fortifyingBrew = Spell(115203),
    dampenHarm = Spell(122278),
    diffuseMagic = Spell(122783),
}, monk, getfenv(1))

-- offensive cooldowns

-- death knight
AbominationLimb = Spell(315443),
BreathofSindragosa = Spell(152861),

-- demon hunter
metamorphosis = Spell(187827),
chaosBlades = Spell(211048),
nemesis = Spell(206491),
theHunt = Spell(323639),

-- druid
incarnation = Spell(102543),
celestialAlignment = Spell(194223),
berserk = Spell(106951),
furyOfElune = Spell(202770),

-- hunter
trueshot = Spell(193526),
bestialWrath = Spell(19574),
aspectOfTheWild = Spell(193530),

-- mage
icyVeins = Spell(12472),
combustion = Spell(190319),

-- monk
serenity = Spell(152173),
stormEarthAndFire = Spell(137639),
invokeXuentheWhiteTiger = Spell(123904),

-- paladin
avengingWrath = Spell(31884),
crusade = Spell(231895),
holyAvenger = Spell(105809),

-- priest
voidform = Spell(194249),

-- rogue
shadowBlades = Spell(121471),
vanish = Spell(1856),
symbolsOfDeath = Spell(212283),
adrenalineRush = Spell(13750),

-- shaman
ascendance = Spell(114052),
elementalBlast = Spell(117014),
bloodlust = Spell(2825),

-- warlock
darkSoul = Spell(113858),
summonDemonicTyrant = Spell(265187),
soulRot = Spell(325640),

-- warrior
avatar = Spell(107574),
recklessness = Spell(1719),
rampage = Spell(184367),
bladestorm = Spell(227847),

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

zenSpheres:Callback(function(spell)
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
end)

diffuseMagic:Callback(function(spell)
    spell:Cast(target)
end)

fortifyingBrew:Callback(function(spell)
    spell:Cast(target)
end)