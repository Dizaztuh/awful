local Unlocker, awful, project = ...
local monk = project.monk.mistweaver

print("Example warrior locked and loaded!")

monk:Init(function()

	-- keep in mind we're only doing *anything* in this if/then statement if there is an enemy target.
	if target.enemy then
		StartAttack()
		faelineStomp()
		tigerPalm()
		blackoutKick()
		risingSunKick()
	end

end)
