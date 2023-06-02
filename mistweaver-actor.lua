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

print("Sisterfister Loaded!")

local function initFistweaver()
    touchOfDeath()
    if settings.rop then
    ringOfPeace()
    end
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
    if settings.para then
    paralyze()
    end
    disable()
    essenceFont()
    invokeChiJi()
    tigersLust()
    detox()
    lifeCocoon()
    if settings.em then
    envelopingMist()
    end
    if settings.rm then
    renewingMist()
    end
    thunderFocusTea()
    healingElixir()
    dampenHarm()
    fortifyingBrew()
    diffuseMagic()
end

local function initCasterHealer()
    summonJadeSerpent()
    ringOfPeace()
    detox()
    provoke()
    if settings.para then
    paralyze()
    end
    tigersLust()
    grappleWeapon()
    invokeYulon()
    touchOfDeath()
    if settings.lc then
    lifeCocoon()
    end
    renewing()
    soothingMist()
    vivify()
    enveloping()
    if settings.soh then
    sphereofHope()
    end
    sphereofDespair()
    if settings.revival then
    revival()
    end
    if settings.restoral then
    restoral()
    end
    legSweep()
    if settings.he then
    healingElixir()
    end
    if settings.dh then
    dampenHarm()
    end
    fortifyingBrew()
    if settings.dm then
    diffuseMagic()
    end
    if settings.spear then
    spearHandStrike()
    end
    manaTea()
    if player.HasTalent(353584) and
     settings.transferJuke then
    transfer()
    end
    if settings.tft then
    thunderFocusTea()
    end
end


-- Initialize the mistweaver monk profile
mistweaver:Init(function()
    updateInstanceType()
    if player.buff("Arena Preparation") or player.buff("Drink") then return end
    if not player.mounted and (ARENA or BATTLEGROUND or DUNGEON or RAID or player.combat) then
        if player.hasTalent(287503) then
           initFistweaver()
        else
            initCasterHealer()
        end
    end
end)

