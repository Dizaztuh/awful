-- Define your addon table
local addonName, addonTable = "SisterFister", { }

-- Define a variable to keep track of whether the addon is enabled or not
local addonEnabled = false

-- Create a frame for the UI element
local frame = CreateFrame("Frame", "MyAddonFrame", UIParent)
frame:SetSize(100, 30)
frame:SetPoint("CENTER")

-- Create a button for toggling the addon on and off
local button = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
button:SetSize(100, 30)
button:SetText("Enable SisterFister")
button:SetPoint("CENTER")

-- Define a function for enabling or disabling the addon when the button is clicked
local function toggleAddon()
    if addonEnabled then
        addonEnabled = false
        button:SetText("Enable SisterFister")
        -- Disable the addon code here
    else
        addonEnabled = true
        button:SetText("Disable SisterFister")
        -- Enable the addon code here
    end
end

-- Set the OnClick handler for the button to the toggleAddon function
button:SetScript("OnClick", toggleAddon)

-- Set the addon table in the Awful API
awful:Register(addonName, addonTable)
