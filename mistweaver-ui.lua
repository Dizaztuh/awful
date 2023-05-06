local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver
local UI = awful.UI

-- Other mistweaver code

-- Create Mistweaver group with custom colors
local mistweaverColor = {0, 1, 0, 1}
local mistweaverGroup = UI:Group({
    name = "Mistweaver",
    title = {"Sister", "Fister"},
    colors = {
        title = {awfulCream, mistweaverColor},
        accent = mistweaverColor,
    }
})

--! SPELL TABS !--
local healingTab = mistweaverGroup:Tab("Healing")
local crowdControlTab = mistweaverGroup:Tab("Crowd Control")
local offensiveTab = mistweaverGroup:Tab("Offensive")
local defensiveTab =mistweaverGroup:Tab("Defensive")

--! HEALING TAB !--
healingTab:Slider({
    name = "Healing Elixir HP%",
    range = {1, 100},
    default = 55,
    var = "healingElixirHp",
})

healingTab:Slider({
    name = "Life Cocoon HP%",
    range = {1, 100},
    default = 50,
    var = "lifeCocoonHp",
})

defensiveTab:Slider({
    name = "Fortifying Brew HP%",
    range = {1, 100},
    default = 40,
    var = "fortifyingBrewHp",
})

--! CROWD CONTROL TAB !--
crowdControlTab:Checkbox({
    name = "Leg Sweep Enabled",
    default = true,
    var = "legSweepEnabled",
})

crowdControlTab:Checkbox({
    name = "Paralyze Enabled",
    default = true,
    var = "paralyzeEnabled",
})

--! OFFENSIVE TAB !--
offensiveTab:Checkbox({
    name = "Faeline Stomp Enabled",
    default = true,
    var = "faelineStompEnabled",
})

defensiveTab:Checkbox({
    name = "Dampen Harm Enabled",
    default = true,
    var = "dampenHarmEnabled",
})

offensiveTab:Checkbox({
    name = "Touch of Death Enabled",
    default = true,
    var = "touchOfDeathEnabled",
})
