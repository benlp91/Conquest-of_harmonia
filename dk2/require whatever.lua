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

-- second function for fainted creatures

function OnGameStart()
    RegisterTimerEvent(CheckForStunDeaths, 1, true)             -- Repeat each frame
end

function CheckForStunDeaths()
    for _, creature in ipairs(GetThingsOfClass("Creature")) do  -- Get all creatures
        if creature.conscious_back_turns == 1 then              -- If one will wake up next turn
            creature:kill()                                     -- Kill it
        end
    end
end

-- third function for the hatchery

Game.AllCoops = {}
Game.AllEggs = {}

-- All 15sec
function CheckForNewCoops()
    for _, object in ipairs(GetThingsOfClass("Object")) do
        if object.model == "COOP" and not Game.AllCoops[object] then
            Game.AllCoops[object] = object.pos
        end
    end
end

-- All 0,5sec
function UpdateCoops()
    -- Check if coops were removed
    for object, _ in pairs(Game.AllCoops) do
        if not object or not object:isValid() then
            Game.AllCoops[object] = nil
        end
    end
    -- Check for eggs
    for object, pos in pairs(Game.AllCoops) do
        CheckForEggs(pos)
    end
end

function CheckForEggs(coopPos)
    for _, object in ipairs(GetThingsOfClass("Object")) do
        if object.model == "CHICKEN_GRW" and not Game.AllEggs[object] then
            if object.pos.stl_x >= coopPos.stl_x - 2 and object.pos.stl_x <= coopPos.stl_x + 2 and
               object.pos.stl_y >= coopPos.stl_y - 2 and object.pos.stl_y <= coopPos.stl_y + 2 then
                Game.AllEggs[object] = object.anim_sprite
                object.pos = coopPos
            end
        end
    end
    HideCoopEggs()
end

function HideCoopEggs()
    for sprite, object in ipairs(Game.AllEggs) do
        -- Remove from list if fully hatched
        if object.model == "CHICKEN_MAT" then
            Game.AllEggs[object] = nil
            if math.random(0,1) == 1 then
                object.orientation = 2047 * 0.25 -- EAST
            else
                object.orientation = 2047 * 0.75 -- WEST
            end
        -- Otherwise conceal
        elseif sprite ~= 971 then -- 971: "placeholder_e1", so empty sprite
            object.anim_sprite = 971
            sprite = 971
        end
    end
end