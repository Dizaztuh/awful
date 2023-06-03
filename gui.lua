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


project.settings = settings

-- Totem list for totem stomping
local totemList = {
    ["Capacitor Totem"] = 59547,
    ["Tremor Totem"] = 8143,
    ["Earthbind Totem"] = 2484,
    ["Spirit Link Totem"] = 98008,
    ["Grounding Totem"] = 8177,
    ["Skyfury Totem"] = 204330,
    ["Counterstrike Totem"] = 204331,
    ["Psyfiend"] = 108366,
    ["Windfury Totem"] = 8512,
    ["Fel Obelisk"] = 255774,
    ["Static Totem"] = 301624,
    ["Void Tendril"] = 115422,
    ["War Banner"] = 246366,
    ["Earthgrab Totem"] = 51485,
    ["Healing Tide Totem"] = 108280,
    ["Static Field Totem"] = 281902,
    ["Fel Obelisk"] = 353601
}

-- Convert your totem list into the required format for the options array and get the default list
local options = {}
local default = {}
for totemName, totemID in pairs(totemList) do
    table.insert(options, { label = totemName, value = totemID })
    table.insert(default, totemID)
end


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
defensive:Slider({text = "Fortifying Brew", var = "fBrews", min = 0, max = 100, default = 35, valueType = "%", tooltip = "Fortifying Brew triggered at % HP."})
defensive:Slider({text = "RoP", var = "ringofPeaces", min = 0, max = 100, default = 40, valueType = "%", tooltip = "Ring of Peace trigger on friendly at % HP."})
defensive:Slider({text = "Dampen Harm", var = "dh", min = 0, max = 100, default = 45, valueType = "%", tooltip = "Dampen Harm triggered at % HP."})
defensive:Slider({text = "Life Cocoon", var = "lc", min = 0, max = 100, default = 40, valueType = "%", tooltip = "Life Cocoon triggered at % HP."})
defensive:Slider({text = "Diffuse Magic", var = "dm", min = 0, max = 100, default = 30, valueType = "%", tooltip = "Diffuse Magic triggered at % HP."})
defensive:Slider({text = "Transfer", var = "transferJuke", min = 0, max = 100, default = 60, valueType = "%", tooltip = "Transfer Juke triggered on stun at % HP."})


-- Healing tab
local healing = gui:Tab("Healing")
--healing:Checkbox({text = "Renewing Mist (Fistweaver)", var = "rm", default = true, tooltip = "Enable/Disable Auto Instant Proc Renewing Mists"})
--healing:Checkbox({text = "Enveloping Mist (Fistweaver)", var = "em", default = true, tooltip = "Enable/Disable Auto Instant Proc Enveloping Mists."})
healing:Slider({text = "Enveloping Mist(Caster)", var = "emist", min = 0, max = 100, default = 90, valueType = "%", tooltip = "Enveloping Mist triggered at % HP while Soothing Mist"})
healing:Slider({text = "Renewing Mist (Caster)", var = "rmist", min = 0, max = 100, default = 95, valueType = "%", tooltip = "Renewing Mist triggered at % HP."})
healing:Slider({text = "Vivify (Caster)", var = "viv", min = 0, max = 100, default = 90, valueType = "%", tooltip = "Vivify triggered at % HP while Soothing Mist."})
healing:Slider({text = "Sphere of Hope", var = "soh", min = 0, max = 100, default = 90, valueType = "%", tooltip = "Sphere of Hope ally at % HP. (Limited 15 second timer check.)"})
healing:Slider({text = "Restoral", var = "restoral", min = 0, max = 100, default = 37, valueType = "%", tooltip = "Restoral at friend % HP."})
healing:Slider({text = "Revival", var = "revival", min = 0, max = 100, default = 37, valueType = "%", tooltip = "Restoral at friend % HP."})
healing:Slider({text = "Healing Elixir", var = "he", min = 0, max = 100, default = 65, valueType = "%", tooltip = "Healing Elixir triggered at % HP."})



-- Misc tab
local misc = gui:Tab("Misc")
misc:Dropdown({
    var = "totemStomp",
    multi = true,
    tooltip = "Choose the totems you want to stomp.",
    options = options,
    placeholder = "Select totems",
    header = "Totems to stomp:",
    default = default
})
misc:Checkbox({text = "Closest Target Auto Attack", var = "aa", default = true, tooltip = "Enable/Disable Auto attack closest target for continued healing."})
misc:Checkbox({text = "Arena Drawings", var = "draws", default = true, tooltip = "Enable/Disable Line / LOS drawings in Arena."})
misc:Checkbox({text = "Totem Stomp", var = "ts", default = true, tooltip = "Enable/Disable Totem Stomping."})