local Unlocker, awful, project = ...
local monk = project.monk.mistweaver

local Spell = awful.Spell

awful.Populate({
-- static objects
target = awful.target,
player = awful.player,
enemy = awful.enemy,

-- damage
tigerPalm = Spell(100780, { damage = "physical" }),
blackoutKick = Spell(100784, { damage = "physical" }),
risingSunKick = Spell(107428, { damage = "physical", targeted = true }),
faelineStomp = Spell(327037, { targeted = true }),
alphaTiger = Spell(325966, { damage = "physical" }),
touchOfDeath = Spell(115080, { damage = "physical", targeted = true }),

}, monk, getfenv(1))

local function DoRotation()
if target.distance <= 8 then
faelineStomp:Cast(target)
end

if risingSunKick:Cooldown() == 0 then
    risingSunKick:Cast(target)
else
    if tigerPalm:Cooldown() == 0 then
        tigerPalm:Cast(target)
    end
    if blackoutKick:Cooldown() == 0 then
        blackoutKick:Cast(target)
    end
    if risingSunKick:Cooldown() > 0 and alphaTiger:Cooldown() == 0 and blackoutKick:Cooldown() < 2.5 then
        alphaTiger:Cast(target)
    end
end

if target.hp <= 15 then
    touchOfDeath:Cast(target)
end
end

awful.RunAction(function()
DoRotation()
end)
