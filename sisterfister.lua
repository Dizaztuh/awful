local Unlocker, awful, project = ...
local monk = project.monk.mistweaver

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
  risingSunKick = Spell(107428, { damage = "physical", targeted = true, cooldown = 10 }),
  spinningCraneKick = Spell(101546, { damage = "physical" }),
  touchOfDeath = Spell(115080, { damage = "physical", targeted = true, cooldown = 180 }),
  alphaTiger = Spell(325886, { damage = "physical" }),

  -- movement
  roll = Spell(109132),
  chiTorpedo = Spell(119582),
  faelineStomp = Spell(327037, { cooldown = 10 }),

}, monk, getfenv(1))

local function performRotation()
  if target.enemy and target.distance <= 8 then
    faelineStomp:Cast(target)
    tigerPalm:Cast(target)
    blackoutKick:Cast(target)
    risingSunKick:Cast(target)
    while risingSunKick.cooldown > 0 do
      alphaTiger:Cast(target)
      blackoutKick:Cast(target)
    end
    if target.hp <= 15 then
      touchOfDeath:Cast(target)
    end
  end
end

awful.auto({
  "target",
  "cooldown",
  "player"
})

awful.rotation(function()
  performRotation()
end)

