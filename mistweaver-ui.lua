local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver
local UI = awful.UI

-- Other mistweaver code

-- Create the UI frame and set properties
local mistweaverFrame = UI:Create("Frame")
mistweaverFrame:SetSize(400, 350)
mistweaverFrame:SetTitle("Mistweaver Settings")
mistweaverFrame:SetPoint("CENTER")
mistweaverFrame:EnableMouse(true)
mistweaverFrame:SetMovable(true)
mistweaverFrame:RegisterForDrag("LeftButton")
mistweaverFrame:SetScript("OnDragStart", mistweaverFrame.StartMoving)
mistweaverFrame:SetScript("OnDragStop", mistweaverFrame.StopMovingOrSizing)
mistweaverFrame:SetBackdropColor(0, 0, 0, 1)
mistweaverFrame:SetBackdropBorderColor(0, 1, 0, 1)

local function createLabel(parent, text, x, y)
    local label = parent:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    label:SetPoint("TOPLEFT", x, y)
    label:SetText(text)
    label:SetTextColor(0, 1, 0, 1)
    return label
end

-- Create labels and sliders
local healingElixirLabel = createLabel(mistweaverFrame, "Healing Elixir HP%:", 10, -30)
local healingElixirSlider = UI:Create("Slider", mistweaverFrame)
healingElixirSlider:SetPoint("TOPLEFT", 10, -50)
healingElixirSlider:SetRange(1, 100)
healingElixirSlider:SetValue(55)
healingElixirSlider:SetWidth(200)
healingElixirSlider:SetScript("OnValueChanged", function(self, value)
    -- Add logic to update the healingElixir.hp value
end)

local lifeCocoonLabel = createLabel(mistweaverFrame, "Life Cocoon HP%:", 10, -80)
local lifeCocoonSlider = UI:Create("Slider", mistweaverFrame)
lifeCocoonSlider:SetPoint("TOPLEFT", 10, -100)
lifeCocoonSlider:SetRange(1, 100)
lifeCocoonSlider:SetValue(50)
lifeCocoonSlider:SetWidth(200)
lifeCocoonSlider:SetScript("OnValueChanged", function(self, value)
    -- Add logic to update the lifeCocoon.hp value
end)

local fortifyingBrewLabel = createLabel(mistweaverFrame, "Fortifying Brew HP%:", 10, -130)
local fortifyingBrewSlider = UI:Create("Slider", mistweaverFrame)
fortifyingBrewSlider:SetPoint("TOPLEFT", 10, -150)
fortifyingBrewSlider:SetRange(1, 100)
fortifyingBrewSlider:SetValue(40)
fortifyingBrewSlider:SetWidth(200)
fortifyingBrewSlider:SetScript("OnValueChanged", function(self, value)
    -- Add logic to update the fortifyingBrew.hp value
end)

-- Create labels and toggles
local legSweepLabel = createLabel(mistweaverFrame, "Leg Sweep Enabled:", 220, -30)
local legSweepToggle = UI:Create("CheckButton", mistweaverFrame)
legSweepToggle:SetPoint("TOPLEFT", 220, -50)
legSweepToggle:SetScript("OnClick", function(self)
    -- Add logic to enable/disable Leg Sweep based on the toggle state
end)

local paralyzeLabel = createLabel(mistweaverFrame, "Paralyze Enabled:", 220, -80)
local paralyzeToggle = UI:Create("CheckButton", mistweaverFrame)
paralyzeToggle:SetPoint("TOPLEFT", 220, -100)
paralyzeToggle:SetScript("OnClick", function(self)
    -- Add logic to enable/disable Paralyze based on the toggle state
end)

local faelineStompLabel = createLabel(mistweaverFrame, "Faeline Stomp Enabled:", 220, -130)
local faelineStompToggle = UI:Create("CheckButton", mistweaverFrame)
faelineStompToggle:SetPoint("TOPLEFT", 220, -150)
faelineStompToggle:SetScript("OnClick", function(self)
    -- Add logic to enable/disable Faeline Stomp based on the toggle state
end)

local dampenHarmLabel = createLabel(mistweaverFrame, "Dampen Harm Enabled:", 220, -180)
local dampenHarmToggle = UI:Create("CheckButton", mistweaverFrame)
dampenHarmToggle:SetPoint("TOPLEFT", 220, -200)
dampenHarmToggle:SetScript("OnClick", function(self)
    -- Add logic to enable/disable Dampen Harm based on the toggle state
end)

local touchOfDeathLabel = createLabel(mistweaverFrame, "Touch of Death Enabled:", 220, -230)
local touchOfDeathToggle = UI:Create("CheckButton", mistweaverFrame)
touchOfDeathToggle:SetPoint("TOPLEFT", 220, -250)
touchOfDeathToggle:SetScript("OnClick", function(self)
    -- Add logic to enable/disable Touch of Death based on the toggle state
end)

-- Make the frame draggable and hide it initially
mistweaverFrame:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" and not self.isMoving then
        self:StartMoving()
        self.isMoving = true
    end
end)

mistweaverFrame:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" and self.isMoving then
        self:StopMovingOrSizing()
        self.isMoving = false
    end
end)

mistweaverFrame:Hide()

-- Create a minimap button to toggle the frame visibility
local minimapButton = UI:Create("MinimapButton")
minimapButton:SetIcon("Interface\\Icons\\ability_monk_mistweaver_spec")
minimapButton:SetScript("OnClick", function(self, button)
    if button == "LeftButton" then
        if mistweaverFrame:IsVisible() then
            mistweaverFrame:Hide()
        else
            mistweaverFrame:Show()
        end
    end
end)
