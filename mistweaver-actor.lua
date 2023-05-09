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
        legSweep()
        paralyze()
        spearHandStrike()
        envelopingMist()
        renewingMist()
        stompTotems()
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
        touchOfDeath()
        awful.onUpdate(function()
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
    end
end)