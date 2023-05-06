local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

local function init()
    -- Your UI code goes here

    -- RGBA color scheme
local darkGreen = {0, 0.5, 0, 1}
local lightGreen = {0, 1, 0, 1}
local white = {1, 1, 1, 1}
local dark = {21, 21, 21, 0.45}

local gui, settings, cmd = awful.UI:New("mistweaver", {
    title = "Sister Fister",
    show = false,
    colors = {
        title = lightGreen,
        primary = white,
        accent = darkGreen,
        background = dark,
    }
})

local healing = gui:Tab("healing")
local defensive = gui:Tab("defensive")
local crowdControl = gui:Tab("crowdControl")
local offensive = gui:Tab("offensive")

local function createClickableText(parent, text, size, paddingBottom, onClick)
    local frame = CreateFrame("Button", nil, parent)
    frame.text = frame:CreateFontString(nil, "OVERLAY")
    frame.text:SetFont(STANDARD_TEXT_FONT, size)
    frame.text:SetText(text)
    frame.text:SetPoint("LEFT", frame)

    frame:SetWidth(frame.text:GetWidth())
    frame:SetHeight(frame.text:GetHeight())
    frame:SetPoint("TOPLEFT", 0, -paddingBottom)
    frame:SetScript("OnClick", onClick)

    return frame
end

local function onClick(self, event)
    awful.enabled = not awful.enabled
    if awful.enabled then
        awful.alert("Mistweaver Monk Enabled", 190319)
        self.text:SetText("Enabled")
        self.text:SetTextColor(0, 1, 0, 1) -- Green color when turned on
    else
        awful.alert("Mistweaver Monk Disabled", 190319)
        self.text:SetText("Disabled")
        self.text:SetTextColor(1, 1, 1, 1) -- White color when turned off
    end
end

createClickableText(healing.content, "Healing", 14, 10, onClick)
createClickableText(defensive.content, "Defensive", 14, 10, onClick)
createClickableText(crowdControl.content, "Crowd Control", 14, 10, onClick)
createClickableText(offensive.content, "Offensive", 14, 10, onClick)

end

return {
    init = init
}
