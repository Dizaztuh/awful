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
    show = true,
    colors = {
        title = darkGreen,           -- Title color is dark green
        primary = silver,            -- Primary text color is silver
        accent = lightGreen,         -- Accent color is light green
        background = darkGrey,       -- Background color is dark grey
        tertiary = silver,           -- Tertiary color is silver     
    }
})


project.settings = settings

-- Offensive tab
local offensive = gui:Tab("Offensive")
offensive:Slider({text = "Thunder Focus Tea", var = "tft", min = 0, max = 100, default = 75, valueType = "%", tooltip = "Use Thunder Focus Tea at % HP."})
offensive:Slider({text = "Invoke Chi-Ji", var = "chiji", min = 0, max = 100, default = 70, valueType = "%", tooltip = "Use Chi-Ji when teammate at % HP. (Will use on enemy burst as well)"})

-- Defensive tab
local defensive = gui:Tab("Defensive")
defensive:Slider({text = "Dampen Harm", var = "dh", min = 0, max = 100, default = 45, valueType = "%", tooltip = "Dampen Harm triggered at % HP."})
defensive:Slider({text = "Life Cocoon", var = "lc", min = 0, max = 100, default = 40, valueType = "%", tooltip = "Life Cocoon triggered at % HP."})
defensive:Slider({text = "Diffuse Magic", var = "dm", min = 0, max = 100, default = 30, valueType = "%", tooltip = "Diffuse Magic triggered at % HP. (Will normally save for Mindgames etc.)"})
defensive:Slider({text = "Healing Elixir", var = "he", min = 0, max = 100, default = 65, valueType = "%", tooltip = "Healing Elixir triggered at % HP."})
defensive:Slider({text = "Fortifying Brew", var = "fb", min = 0, max = 100, default = 35, valueType = "%", tooltip = "Fortifying Brew triggered at % HP. (Normally will trade on enemy Burst!)"})
defensive:Slider({text = "Transfer Juke", var = "xfer", min = 0, max = 100, default = 60, valueType = "%", tooltip = "Transfer Juke triggered on stun at % HP."})
defensive:Checkbox({text = "Ring of Peace", var = "rop", default = true, tooltip = "Enable/Disable Ring of Peace on enemy burst."})

-- Healing tab
local healing = gui:Tab("Healing")
healing:Slider({text = "Sphere of Hope", var = "soh", min = 0, max = 100, default = 90, valueType = "%", tooltip = "Sphere of Hope ally at % HP.)"})
healing:Slider({text = "Restoral", var = "restoral", min = 0, max = 100, default = 37, valueType = "%", tooltip = "Restoral at friend % HP.)"})
healing:Slider({text = "Revival", var = "revival", min = 0, max = 100, default = 37, valueType = "%", tooltip = "Restoral at friend % HP.)"})
healing:Checkbox({text = "Renewing Mist", var = "rm", default = true, tooltip = "Enable/Disable Auto Instant Proc Renewing Mists"})
healing:Checkbox({text = "Enveloping Mist", var = "em", default = true, tooltip = "Enable/Disable Auto Instant Proc Enveloping Mists."})

-- Misc tab
local misc = gui:Tab("Misc")
misc:Checkbox({text = "Closest Traget Auto Attack", var = "aa", default = true, tooltip = "Enable/Disable Auto attack closest target for continued healing."})
misc:Checkbox({text = "Arena Drawings", var = "draws", default = true, tooltip = "Enable/Disable Line / LOS drawings in Arena."})
misc:Checkbox({text = "Totem Stomp", var = "ts", default = true, tooltip = "Enable/Disable Totem Stomping."})
