local Unlocker, awful, project = ...
local monk = project.monk

local Spell = awful.Spell
awful.Populate({

  -- static objects [not req. but tiny perf. increase and takes care of declaration where i use them]
  target = awful.target,
  focus = awful.focus,
  player = awful.player,
  healer = awful.healer,
  pet = awful.pet,
  enemyHealer = awful.enemyHealer,

  -- damage
  tigerPalm = Spell(100780, { damage = "physical" }),
  blackoutKick = Spell(100784, { damage = "physical" }),
  risingSunKick = Spell(107428, { damage = "physical", targeted = true }),
  faelineStomp = Spell(327037, { targeted = true }),
  alphaTiger = Spell(325966, { damage = "physical" }),
  touchOfDeath = Spell(115080, { damage = "physical", targeted = true }),

}, monk, getfenv(1))

print("SisterFister loaded.")

monk:Init(function()
    if target.distance < 8 then
        faelineStomp:Cast(target)
    end
end)

awful.schedule(0.5, function()
    if not faelineStomp.isCasting then
        print("Fae Stomp not in range, stopping rotation.")
        return
    end
    print("Fae Stomp applied, starting rotation.")
    while target.alive do
        if target.enemy and target.distance < 8 then
            alphaTiger:Cast(target)
            blackoutKick:Cast(target)
            risingSunKick:Cast(target)
            if risingSunKick.cooldown > 0 then
                alphaTiger:Cast(target)
                blackoutKick:Cast(target)
            end
            if target.hpPercent < 15 then
                touchOfDeath:Cast(target)
            end
        end
        awful.Wait(0.5)
    end
end)
