    local Unlocker, awful, project = ...
    local UI = awful.UI
    project.settings = settings
    local mistweaverGreen = { 0.2, 0.8, 0.4, 1.0 }
    local mistweaverDarkGreen = { 0.1, 0.4, 0.2, 1.0 }

    -- Create Mistweaver group with custom colors
    local mistweaverGroup = UI:Group({
        name = "Mistweaver",
        title = {"Sister", "Fister"},
        colors = {
            title = {mistweaverGreen, mistweaverDarkGreen},
            accent = mistweaverGreen,
        }
    })

    -- Create tabs for each category
    local healingTab = mistweaverGroup:Tab("Healing")
    local offensiveTab = mistweaverGroup:Tab("Offensive")
    local crowdControlTab = mistweaverGroup:Tab("Crowd Control")
    local defensiveTab = mistweaverGroup:Tab("Defensive")

    -- Healing Tab
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

    healingTab:Checkbox({
        name = "Enveloping Mist Auto-Target",
        default = true,
        var = "envelopingMistAutoTarget",
    })

    healingTab:Checkbox({
        name = "Soothing Mist Enabled",
        default = true,
        var = "soothingMistEnabled",
    })

    healingTab:Checkbox({
        name = "Essence Font Enabled",
        default = true,
        var = "essenceFontEnabled",
    })

    healingTab:Checkbox({
        name = "Chi Wave Enabled",
        default = true,
        var = "chiWaveEnabled",
    })

    -- Offensive Tab
    offensiveTab:Checkbox({
        name = "Faeline Stomp Enabled",
        default = true,
        var = "faelineStompEnabled",
    })

    offensiveTab:Checkbox({
        name = "Touch of Death Enabled",
        default = true,
        var = "touchOfDeathEnabled",
    })

    offensiveTab:Checkbox({
        name = "Rising Sun Kick Enabled",
        default = true,
        var = "risingSunKickEnabled",
    })

    offensiveTab:Checkbox({
        name = "Tiger Palm Enabled",
        default = true,
        var = "tigerPalmEnabled",
    })

    offensiveTab:Checkbox({
        name = "Blackout Kick Enabled",
        default = true,
        var = "blackoutKickEnabled",
    })

    offensiveTab:Checkbox({
        name = "Spinning Crane Kick Enabled",
        default = true,
        var = "spinningCraneKickEnabled",
    })

    -- Crowd Control Tab
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

    crowdControlTab:Checkbox({
        name = "Ring of Peace Enabled",
        default = true,
        var = "ringOfPeaceEnabled",
    })

    -- Defensive Tab
    defensiveTab:Slider({
        name = "Fortifying Brew HP%",
        range = {1, 100},
        default = 40,
        var = "fortifyingBrewHp",
        })
        
        defensiveTab:Checkbox({
        name = "Dampen Harm Enabled",
        default = true,
        var = "dampenHarmEnabled",
        })
        
        defensiveTab:Checkbox({
        name = "Life Cocoon Enabled",
        default = true,
        var = "lifeCocoonEnabled",
        })
        
        -- Offensive Tab
        offensiveTab:Checkbox({
        name = "Tiger Palm Enabled",
        default = true,
        var = "tigerPalmEnabled",
        })
        
        offensiveTab:Checkbox({
        name = "Blackout Kick Enabled",
        default = true,
        var = "blackoutKickEnabled",
        })
        
        offensiveTab:Checkbox({
        name = "Rising Sun Kick Enabled",
        default = true,
        var = "risingSunKickEnabled",
        })
        
        offensiveTab:Checkbox({
        name = "Touch of Death Enabled",
        default = true,
        var = "touchOfDeathEnabled",
        })
        
        -- Crowd Control Tab
        crowdControlTab:Checkbox({
        name = "Paralyze Enabled",
        default = true,
        var = "paralyzeEnabled",
        })
        
        crowdControlTab:Checkbox({
        name = "Leg Sweep Enabled",
        default = true,
        var = "legSweepEnabled",
        })
        
        crowdControlTab:Checkbox({
        name = "Ring of Peace Enabled",
        default = true,
        var = "ringOfPeaceEnabled",
        })
        
        -- Healing Tab
        healingTab:Checkbox({
        name = "Enveloping Mist Enabled",
        default = true,
        var = "envelopingMistEnabled",
        })
        
        healingTab:Checkbox({
        name = "Renewing Mist Enabled",
        default = true,
        var = "renewingMistEnabled",
        })
        
        healingTab:Checkbox({
        name = "Soothing Mist Enabled",
        default = true,
        var = "soothingMistEnabled",
        })
        
        healingTab:Checkbox({
        name = "Essence Font Enabled",
        default = true,
        var = "essenceFontEnabled",
        })
        
        healingTab:Checkbox({
        name = "Chi Wave Enabled",
        default = true,
        var = "chiWaveEnabled",
        })
        
        -- Create Mistweaver group with custom colors
        local mistweaverColor = {0.38, 0.88, 0.64, 1}
        local mistweaverGroup = UI:Group({
        name = "Mistweaver",
        title = {"Sister", "Fister"},
        colors = {
        title = {mistweaverColor, mistweaverColor},
        accent = mistweaverColor,
        }
        })
        
        --! Healing Tab !--
        if healingTab:Get("envelopingMistEnabled") then
        healingTab:Slider({
        name = "Enveloping Mist HP%",
        range = {1, 100},
        default = 80,
        var = "envelopingMistHp",
        })
        end
        
        if healingTab:Get("renewingMistEnabled") then
        healingTab:Slider({
        name = "Renewing Mist HP%",
        range = {1, 100},
        default = 75,
        var = "renewingMistHp",
        })
        end
        
        if healingTab:Get("soothingMistEnabled") then
        healingTab:Slider({
        name = "Soothing Mist HP%",
        range = {1, 100},
        default = 60,
        var = "soothingMistHp",
        })
        end
        
        if healingTab:Get("essenceFontEnabled") then
        healingTab:Slider({
        name = "Essence Font HP%",
        range = {1, 100},
        default = 70,
        var = "essenceFontHp",
        })
        end
        
        -- Offensive Tab
        offensiveTab:Checkbox({
        name = "Touch of Death Enabled",
        default = true,
        var = "touchOfDeathEnabled",
        })
        
        offensiveTab:Checkbox({
        name = "Rising Sun Kick Enabled",
        default = true,
        var = "risingSunKickEnabled",
        })
        
        offensiveTab:Checkbox({
        name = "Blackout Kick Enabled",
        default = true,
        var = "blackoutKickEnabled",
        })
        
        offensiveTab:Checkbox({
        name = "Tiger Palm Enabled",
        default = true,
        var = "tigerPalmEnabled",
        })
        
        -- Crowd Control Tab
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
        
        crowdControlTab:Checkbox({
        name = "Ring of Peace Enabled",
        default = true,
        var = "ringOfPeaceEnabled",
        })
        
        -- Defensive Tab
        defensiveTab:Slider({
        name = "Fortifying Brew HP%",
        range = {1, 100},
        default = 40,
        var = "fortifyingBrewHp",
        })
        
        defensiveTab:Slider({
        name = "Dampen Harm HP%",
        range = {1, 100},
        default = 50,
        var = "dampenHarmHp",
        })
        
        defensiveTab:Slider({
        name = "Healing Elixir HP%",
        range = {1, 100},
        default = 55,
        var = "healingElixirHp",
        })
        
        -- Create Mistweaver group with custom colors
        local mistweaverColorLight = {0.38, 1, 0.46, 1}
        local mistweaverColorDark = {0.05, 0.54, 0.14, 1}
        local mistweaverGroup = UI:Group({
        name = "Mistweaver",
        title = {"Sister", "Fister"},
        colors = {
        title = {mistweaverColorLight, mistweaverColorDark},
        accent = mistweaverColorLight,
        }
        })
        
        -- SPELL TABS
        local healingTab = mistweaverGroup:Tab("Healing")
        local offensiveTab = mistweaverGroup:Tab("Offensive")
        local crowdControlTab = mistweaverGroup:Tab("Crowd Control")
        local defensiveTab = mistweaverGroup:Tab("Defensive")
        
        -- HEALING TAB
        if healingTab:Get("envelopingMistEnabled") then
        healingTab:Slider({
        name = "Enveloping Mist HP%",
        range = {1, 100},
        default = 50,
        var = "envelopingMistHp",
        })
        end
        
        if healingTab:Get("renewingMistEnabled") then
        healingTab:Slider({
        name = "Renewing Mist HP%",
        range = {1, 100},
        default = 75,
        var = "renewingMistHp",
        })
        end
        
        if healingTab:Get("soothingMistEnabled") then
        healingTab:Slider({
        name = "Soothing Mist HP%",
        range = {1, 100},
        default = 60,
        var = "soothingMistHp",
        })
        end
        
        if healingTab:Get("essenceFontEnabled") then
        healingTab:Slider({
        name = "Essence Font HP%",
        range = {1, 100},
        default = 70,
        var = "essenceFontHp",
        })
        end
        
        -- Create Offensive tab
    local offensiveTab = mistweaverGroup:Tab("Offensive")

    if offensiveTab:Get("touchOfDeathEnabled") then
    offensiveTab:Checkbox({
    name = "Touch of Death Enabled",
    default = true,
    var = "touchOfDeathEnabled",
    })
    end

    if offensiveTab:Get("faelineStompEnabled") then
    offensiveTab:Checkbox({
    name = "Faeline Stomp Enabled",
    default = true,
    var = "faelineStompEnabled",
    })
    end

    if offensiveTab:Get("chiWaveEnabled") then
    offensiveTab:Checkbox({
    name = "Chi Wave Enabled",
    default = true,
    var = "chiWaveEnabled",
    })
    end

    if offensiveTab:Get("risingSunKickEnabled") then
    offensiveTab:Checkbox({
    name = "Rising Sun Kick Enabled",
    default = true,
    var = "risingSunKickEnabled",
    })
    end

    if offensiveTab:Get("blackoutKickEnabled") then
    offensiveTab:Checkbox({
    name = "Blackout Kick Enabled",
    default = true,
    var = "blackoutKickEnabled",
    })
    end

    if offensiveTab:Get("tigerPalmEnabled") then
    offensiveTab:Checkbox({
    name = "Tiger Palm Enabled",
    default = true,
    var = "tigerPalmEnabled",
    })
    end

    -- CROWD CONTROL TAB
    local crowdControlTab = mistweaverGroup:Tab("Crowd Control")

    if crowdControlTab:Get("legSweepEnabled") then
    crowdControlTab:Checkbox({
    name = "Leg Sweep Enabled",
    default = true,
    var = "legSweepEnabled",
    })
    end

    if crowdControlTab:Get("paralyzeEnabled") then
    crowdControlTab:Checkbox({
    name = "Paralyze Enabled",
    default = true,
    var = "paralyzeEnabled",
    })
    end

    if crowdControlTab:Get("ringOfPeaceEnabled") then
    crowdControlTab:Checkbox({
    name = "Ring of Peace Enabled",
    default = true,
    var = "ringOfPeaceEnabled",
    })
    end

    -- DEFENSIVE TAB
    local defensiveTab = mistweaverGroup:Tab("Defensive")

    if defensiveTab:Get("fortifyingBrewEnabled") then
    defensiveTab:Slider({
    name = "Fortifying Brew HP%",
    range = {1, 100},
    default = 40,
    var = "fortifyingBrewHp",
    })
    end

    if defensiveTab:Get("dampenHarmEnabled") then
    defensiveTab:Checkbox({
    name = "Dampen Harm Enabled",
    default = true,
    var = "dampenHarmEnabled",
    })
    end

    if defensiveTab:Get("diffuseMagicEnabled") then
    defensiveTab:Checkbox({
    name = "Diffuse Magic Enabled",
    default = true,
    var = "diffuseMagicEnabled",
    })
    end

    if defensiveTab:Get("lifeCocoonEnabled") then
    defensiveTab:Slider({
    name = "Life Cocoon HP%",
    range = {1, 100},
    default = 50,
    var = "lifeCocoonHp",
    })
    end

    -- Return the mistweaverUI table
    return mistweaverUI




    
        
        
        
