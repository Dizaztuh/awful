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
    sphereofHope()
    renewing()
    vivify()
    enveloping()
    soothingMist()
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
    revival()
    restoral()
    legSweep()
    zenFocusTea()
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

interruptDurations = {
    [47528] = 15, -- Mind Freeze - Death Knight
    [183752] = 15, -- Disrupt - Demon Hunter
    [106839] = 15, -- Skull Bash - Druid
    [78675] = 60, -- Solar Beam - Druid
    [351338] = 15, -- Quell - Evoker
    [187707] = 15, -- Muzzle - Hunter
    [147362] = 24, -- Counter Shot - Hunter
    [2139] = 24, -- Counterspell - Mage
    [116705] = 15, -- Spear Hand Strike - Monk
    [96231] = 15, -- Rebuke - Paladin
    [15487] = 45, -- Silence - Priest
    [1766] = 15, -- Kick - Rogue
    [57994] = 12, -- Wind Shear - Shaman
    [19647] = 24, -- Spell Lock - Warlock
    [119818] = 24, -- Call Felhunter - Warlock
    [6552] = 15 -- Pummel - Warrior
}

interruptCDs = {}

awful.onEvent(function(info, event, source, dest)
    if event ~= 'SPELL_CAST_SUCCESS' then return end
    if not source.enemy then return end

    local spellID = select(12, unpack(info))
    if interruptDurations[spellID] then
        interruptCDs[source.guid] = GetTime() + interruptDurations[spellID]
    end
end)


