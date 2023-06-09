local Unlocker, awful, project = ...

-- RGB color scheme
local black = {0, 0, 0, 1}
local darkGrey = {45, 49, 55, 1}
local silver = {192, 192, 192, 1}
local darkGreen = {0, 100, 0, 1}
local lightGreen = {144, 238, 144, 1}

-- Create GUI
local gui, settings, cmd = awful.UI:New("gladdyui", {
    title = "Gladdy SisterFister",
    width = 360,
    height = 250,
    scale = 1.0,
    show = true,
    sidebar = true,
    colors = {
        title = darkGreen,           -- Title color is dark green
        primary = silver,            -- Primary text color is silver
        accent = lightGreen,         -- Acc,       -- Background color is dark grey
        tertiary = silver,           -- Tertiary color is silver     
    }
})


-- Offensive tab
local offensive = gui:Tab("Offensive")
offensive:Slider({text = "Spear Hand Strike", var = "spear", min = 0, max = 100, default = 70, valueType = "%", tooltip = "Use Spear Hand Strike on heals when enemy at % HP."})
offensive:Slider({text = "Thunder Focus Tea", var = "tft", min = 0, max = 100, default = 75, valueType = "%", tooltip = "Use Thunder Focus Tea at % HP."})
offensive:Slider({text = "Invoke Chi-Ji", var = "chiji", min = 0, max = 100, default = 70, valueType = "%", tooltip = "Use Chi-Ji when teammate at % HP."})
offensive:Slider({text = "Paralysis", var = "para", min = 0, max = 100, default = 70, valueType = "%", tooltip = "Use Paralysis on healer if target at % HP and FULL DR."})
offensive:Checkbox({text = "Chi-Ji on Enemy Burst", var = "cje", default = true, tooltip = "Enable/Disable Chi-Ji on enemy burst."})
offensive:Checkbox({text = "Chi-Ji on Friendly Burst", var = "cjf", default = true, tooltip = "Enable/Disable Chi-Ji on friendly burst."})

-- Defensive tab
local defensive = gui:Tab("Defensive")
defensive:Slider({text = "Dampen Harm", var = "dh", min = 0, max = 100, default = 45, valueType = "%", tooltip = "Dampen Harm triggered at % HP."})
defensive:Slider({text = "Life Cocoon", var = "lc", min = 0, max = 100, default = 40, valueType = "%", tooltip = "Life Cocoon triggered at % HP."})
defensive:Slider({text = "Diffuse Magic", var = "dm", min = 0, max = 100, default = 30, valueType = "%", tooltip = "Diffuse Magic triggered at % HP."})
defensive:Slider({text = "Transfer", var = "transferJuke", min = 0, max = 100, default = 60, valueType = "%", tooltip = "Transfer Juke triggered on stun at % HP."})


-- Healing tab
local healing = gui:Tab("General Healing")
healing:Slider({text = "Sphere of Hope", var = "soh", min = 0, max = 100, default = 90, valueType = "%", tooltip = "Sphere of Hope ally at % HP. (Limited 15 second timer check.)"})
healing:Slider({text = "Restoral", var = "restoral", min = 0, max = 100, default = 37, valueType = "%", tooltip = "Restoral at friend % HP."})
healing:Slider({text = "Revival", var = "revival", min = 0, max = 100, default = 37, valueType = "%", tooltip = "Restoral at friend % HP."})
healing:Slider({text = "Healing Elixir", var = "he", min = 0, max = 100, default = 65, valueType = "%", tooltip = "Healing Elixir triggered at % HP."})


local healing2 = gui:Tab("Caster Healing")
healing2:Slider({text = "Enveloping Mist (Caster)", var = "emist", min = 0, max = 100, default = 85, valueType = "%", tooltip = "Enveloping Mist triggered at % HP while Soothing Mist"})
healing2:Slider({text = "Renewing Mist (Caster)", var = "rmist", min = 0, max = 100, default = 95, valueType = "%", tooltip = "Renewing Mist triggered at % HP."})
healing2:Slider({text = "Vivify (Caster)", var = "viv", min = 0, max = 100, default = 90, valueType = "%", tooltip = "Vivify triggered at % HP while Soothing Mist."})
healing2:Slider({text = "Zen Focus Tea", var = "zft", min = 0, max = 100, default = 60, valueType = "%", tooltip = "Use ZFT at % HP. (If interrupts are available)"})
healing2:Slider({text = "Sheiluns Gift", var = "sheiluns", min = 0, max = 100, default = 60, valueType = "%", tooltip = "Sheiluns Gift triggered at % HP. (and at 8 or more stacks)"})

-- Misc tab
local misc = gui:Tab("Misc")
misc:Dropdown({
    var = "totemsToStomp",
    multi = true,
    tooltip = "Choose the totems you want to stomp.",
    options = {
        { label = "Capacitor Totem", value = 59547 },
        { label = "Tremor Totem", value = 8143 },
        { label = "Earthbind Totem", value = 2484 },
        { label = "Spirit Link Totem", value = 98008 },
        { label = "Grounding Totem", value = 8177 },
        { label = "Skyfury Totem", value = 204330 },
        { label = "Counterstrike Totem", value = 204331 },
        { label = "Psyfiend", value = 108366 },
        { label = "Windfury Totem", value = 8512 },
        { label = "Fel Obelisk", value = 255774 },
        { label = "Static Totem", value = 301624 },
        { label = "Void Tendril", value = 115422 },
        { label = "War Banner", value = 246366 },
        { label = "Earthgrab Totem", value = 51485 },
        { label = "Healing Tide Totem", value = 108280 },
        { label = "Static Field Totem", value = 281902 },
        { label = "Fel Obelisk", value = 353601 }
    },
    placeholder = "Select totems",
    header = "Totems to stomp:",
})
misc:Checkbox({text = "Closest Target Auto Attack", var = "aa", default = true, tooltip = "Enable/Disable Auto attack closest target for continued healing."})
misc:Checkbox({text = "Arena Drawings", var = "draws", default = true, tooltip = "Enable/Disable Line / LOS drawings in Arena."})
misc:Checkbox({text = "SS Bot Mode", var = "ssbot", default = false, tooltip = "Enable/Disable Solo Shuffle Bot Mode"})

project.settings = settings