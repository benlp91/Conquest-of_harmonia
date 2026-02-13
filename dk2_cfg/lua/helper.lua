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

function SpawnHorny(location)
    Game.Horny = AddCreatureToLevel(PLAYER6,"EVILLORD",location,10,0,0)
    Game.Horny.party_objective = 5
    Game.Horny.party_target_player = 7
    HideHornyFlower()
end