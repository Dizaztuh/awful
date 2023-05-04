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
  faelineStomp = Spell(327104),
  legSweep = Spell(119381, { cc = true, targeted = true }),
  flyingSerpentKick = Spell(101545, { damage = "magical" }),
  fortifyingBrew = Spell(115203),
  dampenHarm = Spell(122278),
  diffuseMagic = Spell(122783),
}, monk, getfenv(1))


-- rotation callbacks

local function rotation()
  -- keep in mind we're only doing *anything* in this if/then statement if there is an enemy target.
  if target.enemy then
    faelineStomp("gapclose")
    tigerPalm()
    blackoutKick()
    risingSunKick()
    alphaTiger()
    blackoutKick()
    while risingSunKick:Cooldown() > 0 do
      alphaTiger()
      blackoutKick()
    end
    if target.healthPercent <= 15 then
      touchOfDeath()
    end
    spinningCraneKick()
  end
end

monk:Init(rotation)