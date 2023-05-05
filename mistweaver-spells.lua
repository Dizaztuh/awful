lua 
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

local Spell = awful.Spell

awful.Populate({
    tigerPalm = Spell(100780, { damage = "physical" }),
    blackoutKick = Spell(100784, { damage = "physical" }),
    risingSunKick = Spell(107428, { damage = "physical", targeted = true }),

}, mistweaver, getfenv(1))

local lastBlackoutKickTime = 0 -- initialize the time of the last blackout kick cast to 0

blackoutKick:Callback(function (spell)
    spell:Cast(target)
    lastBlackoutKickTime = GetTime() -- record the time of the last blackout kick cast
    if risingSunKick.cd > 0 then -- check if risingSunKick is on cooldown using the "cd" attribute
        print("dang it, gonna be a while before I can use risingSunKick again")
    end
end)

risingSunKick:Callback(function (spell)
    spell:Cast(target)
    if blackoutKick.cd == 0 and GetTime() - lastBlackoutKickTime > 10 then -- check if blackoutKick is off cooldown and if 10 seconds have passed since the last blackout kick cast
        blackoutKick:Cast(target) -- cast blackoutKick
    end
end)

tigerPalm:Callback(function (spell)
    spell:Cast(target)
end)