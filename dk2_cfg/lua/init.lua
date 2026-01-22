function RunDK2Scripts()
    RegisterTimerEvent(CheckForStunDeaths, 1, true)             -- Repeat each frame
end

-- Function that kills all creatures that are close to waking up from stun
function CheckForStunDeaths()
    for _, creature in ipairs(GetThingsOfClass("Creature")) do  -- Get all creatures
        if creature.conscious_back_turns == 1 then              -- If one will wake up next turn
            creature:kill()                                     -- Kill it
        end
    end
end

-- function to hide the health flower of horny when he collects the gem
function HideHornyFlower()
    local creatures = GetCreatures()

    for _, creature in ipairs(creatures) do

        if creature.model == "EVILLORD" then
            creature.force_health_flower_hidden = true
        end

    end
end

-- function that makes hatcheries function like DK2 Hatcheries
Game.AllEggs = {}

function CheckForEggs(coop)
    local coopPos = coop.pos
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