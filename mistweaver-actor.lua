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
    provoke()
    grappleWeapon()
    revival()
    restoral()
    legSweep()
    paralyze()
    disable()
    invokeChiJi()
    tigersLust()
    detox()
    renewingMist()
    vivify()
    envelopingMist()
    thunderFocusTea()
    healingElixir()
    dampenHarm()
    fortifyingBrew()
    diffuseMagic()
    transfer()
    spearHandStrike()
end

local function initCasterHealer()
    sphereofDespair()
    ringOfPeace()
    detox()
    provoke()
    paralyze()
    tigersLust()
    grappleWeapon()
    invokeYulon()
    touchOfDeath()
    lifeCocoon()
    soothingMist()
    renewing()
    vivify()
    enveloping()
    thunderFocusTea()
    sphereofHope()
    revival()
    restoral()
    legSweep()
    healingElixir()
    dampenHarm()
    fortifyingBrew()
    diffuseMagic()
    spearHandStrike()
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

