-- Import the necessary modules and get the mistweaver monk profile
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver
settings = project.settings
local player = awful.player
local function updateInstanceType()
    local _, instanceType = IsInInstance()
    PVP = instanceType == "pvp" or instanceType == "arena"
    PVE = instanceType == "party" or instanceType == "raid" or instanceType == "scenario" or instanceType == "none"
    INSTANCE = instanceType == "party" or instanceType == "raid" or instanceType == "scenario"
    BATTLEGROUND = instanceType == "pvp"
    ARENA = instanceType == "arena"
    DUNGEON = instanceType == "party"
    RAID = instanceType == "raid"
    SCENARIO = instanceType == "scenario"
    WORLD = instanceType == "none"
end

awful.onEvent(function(_, event)
    if event == "PLAYER_ENTERING_WORLD" then
        updateInstanceType()
    end
end)

print("Gladdy Sisterfister Loaded")

local function initFistweaver()
    touchOfDeath()
    lifeCocoon()
    ringOfPeace()
    if settings.aa then
    castOnClosestEnemy()
    end
    faelineStomp()
    risingSunKick()
    tigerPalm()
    blackoutKick()
    sphereofDespair()
    sphereofHope()
    if settings.ts then
    stompTotems()
    end
    spearHandStrike()
    grappleWeapon()
    revival()
    restoral()
    legSweep()
    provoke()
    paralyze()
    disable()
    essenceFont()
    invokeChiJi()
    tigersLust()
    detox()
    envelopingMist()
    vivify()
    renewingMist()
    thunderFocusTea()
    healingElixir()
    dampenHarm()
    fortifyingBrew()
    diffuseMagic()
    transfer()
end

local function initCasterHealer()
    touchOfDeath()
    detox()
    provoke()
    soothingMist()
    renewing()
    vivify()
    enveloping()
    sphereofDespair()
    ringOfPeace()
    healingElixir()
    dampenHarm()
    fortifyingBrew()
    diffuseMagic()
    spearHandStrike()
    paralyze()
    tigersLust()
    grappleWeapon()
    invokeYulon()
    lifeCocoon()
    thunderFocusTea()
    sphereofHope()
    revival()
    restoral()
    legSweep()
    manaTea()
    transfer()
end


-- Initialize the mistweaver monk profile
mistweaver:Init(function()
    updateInstanceType()
    if player.buff("Arena Preparation") or player.buff("Preparation") or player.buff ("Drink") or player.buff ("Food") then return end
    if not player.mounted and (ARENA or BATTLEGROUND or DUNGEON or RAID) then
        if player.hasTalent(287503) then
        initFistweaver()
        else
        initCasterHealer()
        end
    end
end)

-- Create a frame to handle the event
local eventFrame = CreateFrame("Frame")

-- Register the "COMBAT_LOG_EVENT_UNFILTERED" event, which we'll use to detect when an interrupt is used
eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

-- Create a table to keep track of the cooldowns
local interruptCooldowns = {}

-- Create a function to handle the event
eventFrame:SetScript("OnEvent", function(self, event, ...)
    -- Extract the necessary data from the event
    local timestamp, subevent, _, sourceGUID, _, _, _, _, destName, _, _, spellId = CombatLogGetCurrentEventInfo()

    -- Check if the event is an interrupt and if the source is an enemy
    if subevent == "SPELL_INTERRUPT" and UnitCanAttack("player", sourceGUID) then
        -- If so, set the cooldown for the spell
        local cooldownDuration = interruptDurations[spellId]
        if cooldownDuration then
            interruptCooldowns[spellId] = GetTime() + cooldownDuration
        end
    end
end)

