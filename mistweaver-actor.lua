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

awful.addEventCallback(function() 
    updateInstanceType()
end, "PLAYER_ENTERING_WORLD")

awful.addEventCallback(function()
    groupInCombat = true
end, "PLAYER_REGEN_DISABLED")

awful.addEventCallback(function()
    groupInCombat = false
end, "PLAYER_REGEN_ENABLED")

local function anyGroupMemberInCombat()
    return groupInCombat
end

local tickRate
if settings.mode == "arm" then
    tickRate = 0.001
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
    updateInstanceType()
    collectHealthstone()
    if player.mounted then return end
    if player.buff("Arena Preparation") or player.buff("Preparation") or player.buff ("Drink") or player.buff ("Food") then return end
    if (ARENA or BATTLEGROUND or INSTANCE or (WORLD and anyGroupMemberInCombat() and not BATTLEGROUND or player.target.name == "PvP Training Dummy")) then
        if player.hasTalent(287503) then
            initFistweaver()
        else
            initCasterHealer()
        end
    end
end, tickRate)
