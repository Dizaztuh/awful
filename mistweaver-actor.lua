-- Import the necessary modules and get the mistweaver monk profile
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

print("Sisterfister Loaded!")

-- Initialize the mistweaver monk profile
mistweaver:Init(function()
    if not player.mounted and target.enemy then
        touchOfDeath()
        ringOfPeace()
        castOnClosestEnemy()
        provoke()
        -- Check if there is an enemy target
            if target.enemy then
            sphereofDespair()
            sphereofHope()
            faelineStomp()
            risingSunKick()
            tigerPalm()
            blackoutKick()
            stompTotems()
            spearHandStrike()
            grappleWeapon()
            legSweep()
            paralyze()
            disable()
            revival()
            restoral()
            essenceFont()
            invokeChiJi()
            tigersLust()
            detox()
            lifeCocoon()
            envelopingMist()
            renewingMist()
            thunderFocusTea()
            healingElixir()
            dampenHarm()
            fortifyingBrew()
            diffuseMagic()
        end
    end
end)

-- Listen for SPELL_CAST_START events
awful.onEvent(function(eventInfo, eventType, sourceObject, destObject)
    -- Unpack the event information
    local _, subEvent, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellID, spellName, _, _, _, castTime = unpack(eventInfo)

    -- Check if the event is a spell cast start event
    if subEvent == "SPELL_CAST_START" then
        -- Check if the spell caster is an enemy and the spell is in the provokeTable
        if sourceObject.enemy and provokeTable[spellName] then
            -- Check if the cast target is the player
            if destObject.isUnit(player) then
                -- Schedule Provoke to be cast 0.5 seconds before the spell completes
                awful.timer(castTime - 0.5, function()
                    if provoke:Castable(sourceObject) then
                        -- Create an alert
                        awful.alert({
                            message = "Casting Provoke on " .. sourceName,
                            texture = 115546,
                        })
                        -- Cast Provoke on the enemy
                        provoke:Cast(sourceObject)
                    end
                end)
            end
        end
    end
end)
