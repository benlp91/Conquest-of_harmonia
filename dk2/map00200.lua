-- ********************************************
--
--           Lua 
--           by MC BIG COCK
--
-- ********************************************
-- 


-- OnGameStart() is a built-in function.
-- It happens when the level has finished loading and the map is about to start.


-- This Functions checks for a EVILLORD which is the Outro Reaper and turn off the Health Flower

function HideHornyFlower()
    local creatures = GetCreatures()

    for _, creature in ipairs(creatures) do

        if creature.model == "EVILLORD" then
            creature.force_health_flower_hidden = true
        end

    end
end

-- end of the first function

