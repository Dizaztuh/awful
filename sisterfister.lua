local function rotation()
    -- Keep in mind we're only doing *anything* in this if/then statement if there is an enemy target.
    if target.enemy then
      if faelineStomp:Cooldown() == 0 and target.distance <= 8 then
        faelineStomp()
      end
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
  
      -- Check if two or more enemies are within Leg Sweep's range and if it's off cooldown
      if #target.enemies >= 2 and legSweep:Cooldown() == 0 then
        legSweep()
      end
  
      -- Check if any party member is at or below 50% health and if Life Cocoon is off cooldown
      for _, unit in ipairs(project.units.party) do
        if unit.healthPercent <= 50 and lifeCocoon:Cooldown() == 0 then
          lifeCocoon(unit)
        end
      end
  
      -- Check if target is below 40% health and if Paralysis is off cooldown
      if target.healthPercent <= 40 and paralysis:Cooldown() == 0 then
        -- Check if enemy target is a healer and Paralysis is off cooldown
        if target.isHealer then
          paralysis(target)
        end
      end
    end
  end