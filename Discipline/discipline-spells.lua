local Unlocker, awful, project = ...
local mistweaver = project.priest.discipline
local player = awful.Player
local Spell = awful.Spell

awful.Populate ({
smite = Spell(585),
schism = Spell(214621),
mindBlast = Spell(8092),
purgeTheWicked = Spell(204197),
renew = Spell(139, { heal = true }),
PwShield = Spell(17)
penance = Spell(47549, { heal = true }),
flashHeal = Spell(2061, { heal = true }),
PwLife = Spell(373481, { heal = true }),
SwDeath = Spell(32379),
fade = Spell(586),
PwBarrier = Spell(62618),
PwRadiance = Spell(194509, { heal = true }),
dispelMagic = Spell(528),
mindGames = Spell(375901),
powerInfusion = Spell(10060),
purify = Spell(527),
massDispel = Spell(32375),
painSuppression = Spell(33206),
psychicScream = Spell(8122),
LoF = Spell(73325),
angelicFeather = Spell(121536),
PwFortitude = Spell(21562),
desperatePrayer = Spell(19236),
rapture = Spell(47536),
innerLight = Spell(356085),
voidShift = Spell(108968),
shadowFiend = Spell(34433),
mindControl = Spell(605),

}, discipline, getfenv(1))

-- Define a table to store the last cast time for each unit
local lastRenewCast = {}

-- Define a max number of renew targets
local maxRenewTargets = 3

renew:Callback(function(spell)
    -- Loop through all friendly units
    awful.fgroup.loop(function(friend)
        -- Check if the unit is being attacked
        if friend.combat and friend.hp <= 95 then
            -- Check if the unit doesn't have renew and the spell is castable on the unit
            if not friend.buff(renew.id) and renew:Castable(friend) then
                -- Check the time of the last renew cast on this unit
                local lastCastTime = lastRenewCast[friend.guid] or 0
                -- Check if enough time has passed since the last renew cast
                if GetTime() - lastCastTime > 15 then
                    -- Count the number of current renew targets
                    local renewTargets = 0
                    awful.fgroup.loop(function(f)
                        if f.buff(renew.id) then
                            renewTargets = renewTargets + 1
                        end
                    end)
                    -- Only cast if there are fewer than maxRenewTargets
                    if renewTargets < maxRenewTargets then
                        -- Cast renew on the unit
                        spell:Cast(friend)
                        -- Store the cast time
                        lastRenewCast[friend.guid] = GetTime()
                    end
                end
            end
        end
    end)
end)

-- Create a callback for the Power Word: Shield ability
PwShield:Callback(function(spell)
    -- Create a variable to store the lowest HP friend and their health
    local lowestFriend = nil
    local lowestHealth = 101  -- Initialize to a value greater than 100

    -- Loop through all friendly units within 40 yards
    awful.fgroup.loop(function(friend)
        -- Check if this friend's health is lower than the current lowest and the spell is castable
        if friend.hp < lowestHealth and spell:Castable(friend) then
            -- If so, update the lowest HP friend and their health
            lowestFriend = friend
            lowestHealth = friend.hp
        end
    end)

    -- If we found a friend who needs the shield, cast it
    if lowestFriend then
        awful.alert({
            message="Casting Power Word: Shield on "..lowestFriend.name,
            texture=17,
        })
        spell:Cast(lowestFriend)
    end
end)

-- Create a callback for the Purge the Wicked ability
purgeTheWicked:Callback(function(spell)
    -- Create a variable to store the closest enemy and their distance
    local closestEnemy = nil
    local closestDistance = 41  -- Initialize to a value greater than 40 yards

    -- Loop through all enemies
    awful.enemies.loop(function(enemy)
        -- Check if this enemy is closer than the current closest, does not have the debuff, and the spell is castable on them
        if enemy.distance < closestDistance and not enemy.debuff("Purge the Wicked") and spell:Castable(enemy) then
            -- If so, update the closest enemy and their distance
            closestEnemy = enemy
            closestDistance = enemy.distance
        end
    end)

    -- If we found an enemy who needs the debuff, cast it
    if closestEnemy then
        awful.alert({
            message="Casting Purge the Wicked on "..closestEnemy.name,
            texture=204197,
        })
        spell:Cast(closestEnemy)
    end
end)

-- Create a callback for the Penance ability
penance:Callback(function(spell)
    -- Create variables to store the friend with the lowest HP and their HP
    local lowestFriend = nil
    local lowestFriendHP = 70  -- Initialize to 70% HP

    -- Loop through all friendly units
    awful.fgroup.loop(function(friend)
        -- Check if this friend has lower HP than the current lowest and the spell is castable on them
        if friend.hp < lowestFriendHP and spell:Castable(friend) then
            -- If so, update the friend with the lowest HP and their HP
            lowestFriend = friend
            lowestFriendHP = friend.hp
        end
    end)

    -- If we found a friend who needs healing, cast Penance on them
    if lowestFriend then
        awful.alert({
            message="Casting Penance on "..lowestFriend.name,
            texture=47540,
        })
        spell:Cast(lowestFriend)
        return
    end

    -- If no friendly units were found with HP less than 70%, find the closest and lowest HP enemy
    local closestEnemy = nil
    local closestEnemyDistance = 41  -- Initialize to a value greater than 40 yards
    local lowestEnemyHP = 100  -- Initialize to 100% HP

    -- Loop through all enemies
    awful.enemies.loop(function(enemy)
        -- Check if this enemy is closer than the current closest and has lower HP than the current lowest
        if enemy.distance < closestEnemyDistance and enemy.hp < lowestEnemyHP and spell:Castable(enemy) then
            -- If so, update the closest enemy, their distance, and their HP
            closestEnemy = enemy
            closestEnemyDistance = enemy.distance
            lowestEnemyHP = enemy.hp
        end
    end)

    -- If we found an enemy who should be attacked, cast Penance on them
    if closestEnemy then
        awful.alert({
            message="Casting Penance on Enemy "..closestEnemy.name,
            texture=47540,
        })
        spell:Cast(closestEnemy)
    end
end)

-- Create a callback for the Schism ability
schism:Callback(function(spell)
    -- Create variables to store the lowest HP enemy within 40 yards and their HP
    local lowestHPEnemy = nil
    local lowestHP = 100  -- Initialize to 100% HP

    -- Loop through all enemies within 40 yards
    awful.enemies.loop(function(enemy)
        -- Check if this enemy has lower HP than the current lowest,
        -- if they have the Purge the Wicked debuff,
        -- and if Power Word: Shield and Penance are on cooldown
        if enemy.hp < lowestHP and enemy.debuff(purgeTheWicked.id) and not PwS:Ready() and not penance:Ready() then
            -- If so, update the enemy with the lowest HP and their HP
            lowestHPEnemy = enemy
            lowestHP = enemy.hp
        end
    end)

    -- If we found an enemy who meets all the conditions, cast Schism on them
    if lowestHPEnemy and spell:Castable(lowestHPEnemy) then
        awful.alert({
            message="Casting Schism on "..lowestHPEnemy.name,
            texture=214621,
        })
        spell:Cast(lowestHPEnemy)
    end
end)











