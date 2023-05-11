-- Import the necessary modules and get the mistweaver monk profile
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

print("Sisterfister Loaded and ready to fist!")

-- Initialize the mistweaver monk profile
mistweaver:Init(function()
    if not player.mounted then
        touchOfDeath()
        risingSunKick()
        ringOfPeace()
    -- Check if there is an enemy target
    if target.enemy then
        sphereofDespair()
        sphereofHope()
        faelineStomp()
        tigerPalm()
        blackoutKick()
        castOnClosestEnemy()
        stompTotems()
        spearHandStrike()
        legSweep()
        paralyze()
        disable()
        invokeChiJi()
        tigersLust()
        detox()
        lifeCocoon()
        revival()
        restoral()
        envelopingMist()
        renewingMist()
        thunderFocusTea()
        healingElixir()
        dampenHarm()
        fortifyingBrew()
        diffuseMagic()

local enemyBuffTable = {
    [62618] = true, -- Barrier
    [198838] = true, -- Earthen
}
-- Sample buff table with spell IDs
local enemyBuffTable = {
    [98765] = true, -- Power Word: Barrier
    [54321] = true, -- Earthen Wall
}

local function eventHandler(self, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local _, subEvent, _, sourceGUID, _, _, destGUID, _, _, _, _, spellID = CombatLogGetCurrentEventInfo()

        -- Check if the subEvent is SPELL_AURA_APPLIED
        if subEvent == "SPELL_AURA_APPLIED" then
            -- Check if the spell is in the enemyBuffTable
            if enemyBuffTable[spellID] then
                -- Get the enemy with the matching GUID
                local enemy = awful.enemies.getByGUID(destGUID)
                if enemy then
                    -- Get the enemy's position
                    local x, y, z = enemy.position()
                    if x and y and z then
                        awful.alert({
                            message="Casting Ring of Peace on " .. enemy.name,
                            texture=116844,
                        })
                        -- Cast Ring of Peace at the enemy's position
                        ringOfPeace:AoECast(x, y, z)
                    end
                end
            end
        end
    end
end

-- Create a frame and register the event
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", eventHandler)

        end
    end
end)
