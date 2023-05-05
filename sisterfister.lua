local Unlocker, awful, project = ...
local monk = project.monk.mistweaver
local function rotation()
  -- keep in mind we're only doing *anything* in this if/then statement if there is an enemy target.
  if target.enemy then
    faelineStomp()
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
  end
end

monk:Init(rotation)