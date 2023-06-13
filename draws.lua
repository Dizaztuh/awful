local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver
local Draw = awful.Draw
local player = awful.player
settings = project.settings

local UnitNameFont = awful.createFont(12, "OUTLINE")

local function isUnitInRange(unit, maxRange)
    local distance = unit.distance
    return distance <= maxRange
end

local classColors = {
    ["WARRIOR"] = {152, 83, 34},       -- Brown
    ["PALADIN"] = {248, 109, 250},     -- Pink
    ["PRIEST"] = {255, 255, 255},      -- White
    ["ROGUE"] = {255, 255, 62},         -- Yellow
    ["HUNTER"] = {113, 231, 113},        -- Green
    ["DRUID"] = {255, 130, 0},         -- Orange
    ["SHAMAN"] = {0, 0, 255},          -- Blue
    ["MAGE"] = {0, 151, 255},        -- Light Blue
    ["WARLOCK"] = {120, 0, 255},     -- Light Purple
    ["DEMONHUNTER"] = {95, 0, 203},    -- Dark Purple
    ["EVOKER"] = {31, 203, 155},        -- Teal
    ["DEATHKNIGHT"] = {225, 0, 0},      -- Dark Red
    ["MONK"] = {0, 255, 142}  -- Brightish Green
}

Draw(function(draw)
    -- Get the instance type every time Draw is called
    local _, instanceType = IsInInstance()

    -- Check if the instance type is 'arena' and if drawing is enabled in the settings
    if instanceType == "arena" and settings.draws then
        -- Set the width of the lines
        draw:SetWidth(3)

        -- Loop through all friends around the player
        awful.friends.loop(function(friend)
            -- Get the friend's class
            local class = friend.class2

            -- Get the friend's current position (x, y, z coordinates)
            local fx, fy, fz = friend.position()

            -- Get the line of sight status between the player and the friend
            local los = player.losOf(friend)

            -- Calculate the distance between the player and the friend
            local distance = player.distanceTo(friend)

            -- Set the color of the line based on line of sight and distance
            if los and distance <= 40 then
                -- Class color when friend is in line of sight and within 40 yards
                if classColors[class] then
                    -- Get the class color
                    local r, g, b = unpack(classColors[class])
                    draw:SetColor(r, g, b, 200)
                else
                    -- Default to white if the class color is not defined
                    draw:SetColor(255, 255, 255, 200)
                end
            else
                -- Bright red for LOS / ranged friends
                draw:SetColor(255, 0, 0, 200)  -- This is an example color, adjust RGB values to your liking
                
            end

            -- Get the player's current position (x, y, z coordinates)
            local px, py, pz = player.position()

            -- Draw the line from the player to the friend
            draw:Line(px, py, pz, fx, fy, fz)
        end)
        
        -- Draw a light blue circle of radius 8 yards around the player
        local px, py, pz = player.position()  -- Get the player's current position
        draw:SetColor(0, 255, 142, 200)   -- Set the color to light blue (RGB: 173, 216, 230)
        draw:Circle(px, py, pz, 30)  -- Draw the circle
    end
end)
