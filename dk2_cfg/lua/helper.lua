-- helper.lua
-- Contains campaign wide helper functions

function CountAwakeHeroes()
    local count = 0
	local creatures = GetCreatures()
        
    for index, creature in ipairs(creatures) do
		if creature.owner == PLAYER_GOOD and creature.state ~= "CreatureUnconscious" then
            count = count + 1
        end
	end
    PLAYER_GOOD.FLAG0 = count;
end