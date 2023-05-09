-- Import the necessary modules and get the mistweaver monk profile
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

print("Sisterfister Loaded and ready to fist!")

-- Initialize the mistweaver monk profile
mistweaver:Init(function()
    -- Check if there is an enemy target
    if target.enemy then
        risingSunKick()
        faelineStomp()
        tigerPalm()
        blackoutKick()
        touchOfDeath()
        legSweep()
        paralyze()
        stompTotems()
        spearHandStrike()
        envelopingMist()
        sphereofDespair()
        sphereofHope()
        lifeCocoon()
        revival()
        restoral()
        thunderFocusTea()
        detox()
        invokeChiJi()
        tigersLust()
        healingElixir()
        dampenHarm()
        fortifyingBrew()
        diffuseMagic()
    end

        ROPDROP = {
        [62618] = true,
        [740] = true,
        [196718] = true,
        [198838] = true,
        [98008] = true,
        [376079] = true,
        [107574] = true, -- Avatar
        [262161] = true, -- Warbreaker
        [31884] = true, -- Avenging Wrath
        [216331] = true, -- Avenging Crusader
        [255647] = true, -- The Hunt
        }
        
        awful.triggers.track(function(trigger, uptime)
            if player.combat then
                local id = trigger.id
                if not id then return end
                local reacts = ROPDROP[id]
                if not reacts then return end
                local x, y, z = trigger.position()
                if x and y and z then
                    if uptime < 0.4 or uptime > 2.1 then return end
                    if trigger.creator.friend then return end  
                    if not player.losCoordsLiteral(x, y, z) then return end
                    if ringOfPeace:AoECast(x,y,z) then
                        awful.alert("Ring of Peace Dropped!", 116844)
                        return true
                    end
                end
            end
          end)
end)