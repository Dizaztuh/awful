local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver
settings = project.settings
local player = awful.player
local groupInCombat = false

print("Gladdy Sisterfister Loaded")

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

local tickRate
if settings.mode == "arm" then
    tickRate = 0.01
elseif settings.mode == "bgm" then
    tickRate = 0.2
else
    tickRate = 0.050  -- or some default value
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
    if not settings.ssbot then
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
    preHot()
    healthStone()
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
    healthStone()
end

mistweaver:Init(function()
    if player.mounted then return end
    if player.buff("Arena Preparation") or player.buff("Preparation") or player.buff ("Drink") or player.buff ("Food") then return end
    if (ARENA or BATTLEGROUND or INSTANCE or (WORLD and anyGroupMemberInCombat() and not BATTLEGROUND or player.target.name == "PvP Training Dummy")) then
        collectHealthstone()
        if player.hasTalent(287503) then
            initFistweaver()
        else
            initCasterHealer()
        end
    end
end, tickRate)
