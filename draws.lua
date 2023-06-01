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

Draw(function(draw)
    -- Get the instance type every time Draw is called
    local _, instanceType = IsInInstance()
   
    -- Check if the instance type is 'arena'
    if instanceType == "arena" and settings.draws then
        -- Set the width of the lines
        draw:SetWidth(3)

        -- Loop through all friends around the player
        awful.friends.loop(function(friend)
            -- Get the friend's current position (x, y, z coordinates)
            local fx, fy, fz = friend.position()

            -- Check if the friend is within 40 yards of the player
            if isUnitInRange(friend, 40) then
                -- Get the line of sight status between the player and the friend
                local los = player.losOf(friend)

                -- Set the color of the line based on line of sight
                if los then
                    -- Bright green color when friend is in line of sight
                    draw:SetColor(0, 255, 0, 100)
                else
                    -- Red color when friend is out of line of sight
                    draw:SetColor(255, 0, 0, 100)
                end

                -- Get the player's current position (x, y, z coordinates)
                local px, py, pz = player.position()

                -- Draw the line from the player to the friend
                draw:Line(px, py, pz, fx, fy, fz)
            end
        end)
    end
end)
