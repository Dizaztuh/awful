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

print("Gladdy Sisterfister Loaded")

local function anyGroupMemberInCombat()
    if IsInRaid() then
        for i = 1, GetNumGroupMembers() do
            local unit = "raid"..i
            if UnitAffectingCombat(unit) and CheckInteractDistance(unit, 4) then
                return true
            end
        end
    elseif IsInGroup() then
        for i = 1, GetNumSubgroupMembers() do
            local unit = "party"..i
            if UnitAffectingCombat(unit) and CheckInteractDistance(unit, 4) then
                return true
            end
        end
    end
    return false
end

local function initFistweaver()
    touchOfDeath()
    faelineStomp()
    risingSunKick()
    tigerPalm()
    blackoutKick()
    lifeCocoon()
    revival()
    restoral()
    ringOfPeace()
    grappleWeapon()
    envelopingMist()
    vivify()
    renewingMist()
    detox()
    paralyze()
    legSweep()
    invokeChiJi()
    if settings.aa then
    castOnClosestEnemy()
    end
    sphereofDespair()
    sphereofHope()
    spearHandStrike()
    provoke()
    disable()
    stompTotems()
    essenceFont()
    chiWave()
    tigersLust()
    thunderFocusTea()
    healingElixir()
    dampenHarm()
    fortifyingBrew()
    diffuseMagic()
    transfer()
    sheilunsGift()
    bloodFury()
    roll()
end

local function initCasterHealer()
    touchOfDeath()
    detox()
    paralyze()
    provoke()
    sphereofHope()
    renewing()
    soothingMist()
    enveloping()
    vivify()
    sheilunsGift()
    sphereofDespair()
    ringOfPeace()
    healingElixir()
    dampenHarm()
    fortifyingBrew()
    diffuseMagic()
    spearHandStrike()
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
    stompTotems()
    bloodFury()
end


-- Initialize the mistweaver monk profile
mistweaver:Init(function()
    updateInstanceType()
    if player.buff("Arena Preparation") or player.buff("Preparation") or player.buff ("Drink") or player.buff ("Food") then return end
    if not player.mounted and (ARENA or BATTLEGROUND or INSTANCE or (WORLD and anyGroupMemberInCombat() and not BATTLEGROUND) or player.target.name == "PvP Training Dummy") then
        if player.hasTalent(287503) then
        initFistweaver()
        else
        initCasterHealer()
        end
    end
end, 0.001)

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

awful.onEvent(function(_, event)
    if event == "PLAYER_ENTERING_WORLD" then
        updateInstanceType()
    end
end)

