local Unlocker, awful, project = monk
local monk = project.monk.mistweaver
local risingSunKickCD = 0
-- Require the GUI file
require("gui")

-- Print message to confirm addon is loaded
print("Sisterfister loaded and ready to fist!")

awful.events:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", handleCombatEvent)

local function defensiveCheck()
    -- Check if an offensive cooldown was used
    if lastCast:HasAny(
        315443, 152861, -- Death Knight
        187827, 211048, 206491, 323639, -- Demon Hunter
        102543, 194223, 106951, 202770, -- Druid
        193526, 19574, 193530, -- Hunter
        12472, 190319, -- Mage
        152173, 137639, 123904, -- Monk
        31884, 231895, 105809, -- Paladin
        194249, -- Priest
        121471, 1856, 212283, 13750, -- Rogue
        114052, 117014, 2825, -- Shaman
        113858, 265187, 325640, -- Warlock
        107574, 1719, 184367, 227847 -- Warrior
    ) then
        -- Defensive abilities will be prioritized in this order: Fortifying Brew, Dampen Harm, Diffuse Magic
        if fortifyingBrew:Cooldown() == 0 then
            fortifyingBrew()
        elseif dampenHarm:Cooldown() == 0 then
            dampenHarm()
        elseif diffuseMagic:Cooldown() == 0 then
            diffuseMagic()
        end
    end
    
    -- Check if the Ancient Teachings: of the Monastery buff is not active and Faeline Stomp is on cooldown
    if not awful.player:Buff(126890) and faelineStomp:Cooldown() > 0 then
        essenceFont()
    end
    
    -- Check if any party member is at or below 40% health and if Life Cocoon is off cooldown
    for _, unit in ipairs(project.units.party) do
        if unit.healthPercent <= 40 and lifeCocoon:Cooldown() == 0 then
            lifeCocoon(unit)
        end
        if unit.healthPercent <= 40 and ringOfPeace:Cooldown() == 0 then
            local x, y, z = unit:Position()
            ringOfPeace(x, y, z)
        end
    end
end

    -- Check if the Ancient Teachings: of the Monastery buff is not active and Faeline Stomp is on cooldown
    if not awful.player:Buff(126890) and faelineStomp:Cooldown() > 0 then
        essenceFont()
    end

local function rotation()
    -- Keep in mind we're only doing *anything* in this if/then statement if there is an enemy target.
    
    if target.enemy then
        -- Call the defensiveCheck() function
        defensiveCheck()

        if faelineStomp:Cooldown() == 0 and target.distance <= 10 then
            faelineStomp()
        end
        tigerPalm()
        blackoutKick()

        if risingSunKickCD == 0 then
            risingSunKick:Queue()
            risingSunKickCD = 10 -- Set the cooldown to 10 seconds
        end

        alphaTiger()
        blackoutKick()

        -- Check if the cooldown of Rising Sun Kick has been reset by Blackout Kick
        if risingSunKick:Cooldown() == 0 then
            risingSunKickCD = 0
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
            -- Try to find an enemy healer to use Paralysis on
            local enemyHealer = awful.search(enemyHealer, "nearest")
            if enemyHealer and enemyHealer.distance < 20 then
                paralyze(enemyHealer)
            end
        end